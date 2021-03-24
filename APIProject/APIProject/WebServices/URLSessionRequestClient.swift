//
//  URLSessionRequestClient.swift
//  APIProject
//
//  Created by Mangesh Shinde on 24/03/21.
//

import Foundation

final class URLSessionRequestClient: RequestClientProtocol {
    
    func requestAnyParameters(method: RequestMethod, url: String, urlParameters: [String : String]?, parameters: [String : Any]?, success: @escaping (Data) -> Void, failure: @escaping (RequestError) -> Void) {
        guard let _url = URL(string: url) else {
            failure(RequestError.invalidUrl)
            return
        }
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        let jsonString = String(data: jsonData, encoding: String.Encoding.ascii)!
        print (jsonString)
        let jsonData1 = jsonString.data(using: .utf8, allowLossyConversion: false)!
        var request = URLRequest(url: _url)
        request.httpMethod = method.value
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData1
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.global(qos: .background).async {
                guard let response = response as? HTTPURLResponse else {
                    failure(RequestError.invalidResponse)
                    return
                }
                guard 200 ... 300 ~= response.statusCode else {
                    failure(RequestError(code: response.statusCode))
                    return
                }
                guard let data = data else {
                    failure(RequestError.notMapped)
                    return
                }
                success(data)
            }
        }
        task.resume()
    }
    

    
    
    func request(method: RequestMethod, url: String, urlParameters: [String: String]?, parameters: [String: String]?, success: @escaping (Data) -> Void, failure: @escaping (RequestError) -> Void) {
        guard let _url = URL(string: url) else {
            failure(RequestError.invalidUrl)
            return
        }
        let encoder = JSONEncoder()
        guard let jsonData = try? encoder.encode(parameters) else {
            failure(RequestError.encodeError)
            return
        }
        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            failure(RequestError.encodeError)
            return
        }
        print(jsonString)
        
        let jsonData1 = jsonString.data(using: .utf8, allowLossyConversion: false)!
        var request = URLRequest(url: _url)
        request.httpMethod = method.value
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData1
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.global(qos: .background).async {
                guard let response = response as? HTTPURLResponse else {
                    failure(RequestError.invalidResponse)
                    return
                }
                guard 200 ... 300 ~= response.statusCode else {
                    failure(RequestError(code: response.statusCode))
                    return
                }
                
                guard let data = data else {
                    failure(RequestError.notMapped)
                    return
                }
                success(data)
            }
        }
        task.resume()
    }
    
    func requestGet(method: RequestMethod, url: String, urlParameters: [String: String]?, parameters: [String: Any]?, success: @escaping (Data) -> Void, failure: @escaping (RequestError) -> Void) {
        guard let _url = URL(string: url) else {
            failure(RequestError.invalidUrl)
            return
        }
        var request = URLRequest(url: _url)
        request.httpMethod = method.value
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let jsonBody = parameters, let httpBody = try? JSONSerialization.data(withJSONObject: jsonBody) {
            request.httpBody = httpBody
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.global(qos: .background).async {
                guard let response = response as? HTTPURLResponse else {
                    failure(RequestError.invalidResponse)
                    return
                }
                guard 200 ... 300 ~= response.statusCode else {
                    failure(RequestError(code: response.statusCode))
                    return
                }
                guard let data = data else {
                    failure(RequestError.notMapped)
                    return
                }
                success(data)
            }
        }
        task.resume()
    }
    
    func downloadImage(url: String, success: @escaping (Data) -> Void, failure: @escaping (RequestError) -> Void) {
        guard let _url = URL(string: url) else {
            failure(RequestError.invalidUrl)
            return
        }
        URLSession.shared.dataTask(with: _url, completionHandler: { (data, response, error)in
            DispatchQueue.global(qos: .background).async {
                guard let response = response as? HTTPURLResponse else {
                    failure(RequestError.invalidResponse)
                    return
                }
                guard 200 ... 300 ~= response.statusCode else {
                    failure(RequestError(code: response.statusCode))
                    return
                }
                guard let mimeType = response.mimeType, mimeType.hasPrefix("image") else {
                    failure(RequestError.notFound)
                    return
                }
                guard let data = data else {
                    failure(RequestError.notMapped)
                    return
                }
                success(data)
            }
        }).resume()
    }
    
    func uploadImage(docTypeName : String, imageName : String, imageData : Data, url: String, parameters: [String: String]?, success: @escaping (Data) -> Void, failure: @escaping (RequestError) -> Void) {
        let boundary = UUID().uuidString
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        var data = Data()
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        for (key, value) in parameters! {
            data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            data.append("\(value)".data(using: .utf8)!)
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        }
        data.append("Content-Disposition: form-data; name=\"\(docTypeName)\"; filename=\"\(imageName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(imageData)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            DispatchQueue.global(qos: .background).async {
                print(response)
                guard let response = response as? HTTPURLResponse else {
                    failure(RequestError.invalidResponse)
                    return
                }
                guard 200 ... 300 ~= response.statusCode else {
                    failure(RequestError(code: response.statusCode))
                    return
                }
                guard let data = responseData else {
                    failure(RequestError.notMapped)
                    return
                }
                success(data)
            }
        }).resume()
    }
    
}
