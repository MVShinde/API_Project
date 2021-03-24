//
//  RegistrationService.swift
//  Visaero
//
//  Created by Mangesh Shinde on 30/09/19.
//  Copyright © 2019 Mangesh Shinde. All rights reserved.


import Foundation

final class TestServices {
    // POST Api
    func postSignUp(parameters: [String: String] ,success: @escaping (SimpleReponse) -> Void, failure: @escaping (_ error: RequestError) -> Void) {
        let url = AppNetConst.BASE_URL + AppNetConst.TEST_API
        RequestClient.shared.request(method: .post, url: url, urlParameters: nil, parameters: parameters, success: { result in
           let response = try! JSONDecoder().decode(SimpleReponse.self, from: result)
            success(response)
        }, failure: { fail in
            failure(RequestError(code: fail.code))
        })
    }
    // Uploading Post API
    func uploadImage(imageName : String, imageData : Data, parameters : [String: String],success: @escaping (SimpleReponse) -> Void, failure: @escaping (_ error: RequestError) -> Void) {
        let url = AppNetConst.BASE_URL + AppNetConst.TEST_API
        RequestClient.shared.uploadImage(docTypeName: "qa_file", imageName: imageName, imageData: imageData, url: url, parameters: parameters, success: { result in
            let response = try! JSONDecoder().decode(SimpleReponse.self, from: result)
            success(response)
        }, failure: { fail in
            failure(RequestError(code: fail.code))
        })
    }
    // GET Api
    func getNewDocumentUrl(parameters: String ,success: @escaping (SimpleReponse) -> Void, failure: @escaping (_ error: RequestError) -> Void) {
        let url = AppNetConst.BASE_URL + AppNetConst.TEST_API + parameters
        print(url)
        RequestClient.shared.requestGet(method: .get, url: url, urlParameters: nil, parameters: nil, success: { result in
            let response = try! JSONDecoder().decode(SimpleReponse.self, from: result)
            success(response)
        }, failure: { fail in
            failure(RequestError(code: fail.code))
        })
    }
}


