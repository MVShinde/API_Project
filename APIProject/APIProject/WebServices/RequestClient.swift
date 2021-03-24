//
//  RequestClient.swift
//  APIProject
//
//  Created by Mangesh Shinde on 24/03/21.
//

final class RequestClient {
    static let shared: RequestClientProtocol = URLSessionRequestClient()
}
