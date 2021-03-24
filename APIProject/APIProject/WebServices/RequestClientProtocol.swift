//
//  RequestClientProtocol.swift
//  APIProject
//
//  Created by Mangesh Shinde on 24/03/21.
//

import Foundation

protocol RequestClientProtocol {
    func request(method: RequestMethod, url: String, urlParameters: [String: String]?, parameters: [String: String]?, success: @escaping (Data) -> Void, failure: @escaping (RequestError) -> Void)
    func requestAnyParameters(method: RequestMethod, url: String, urlParameters: [String: String]?, parameters: [String: Any]?, success: @escaping (Data) -> Void, failure: @escaping (RequestError) -> Void)
    func requestGet(method: RequestMethod, url: String, urlParameters: [String: String]?, parameters: [String: Any]?, success: @escaping (Data) -> Void, failure: @escaping (RequestError) -> Void)
    func downloadImage(url: String, success: @escaping (Data) -> Void, failure: @escaping (RequestError) -> Void)
    func uploadImage(docTypeName : String, imageName : String, imageData : Data, url: String, parameters: [String: String]?, success: @escaping (Data) -> Void, failure: @escaping (RequestError) -> Void)
}
