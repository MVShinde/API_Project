//
//  RequestMethod.swift
//  APIProject
//
//  Created by Mangesh Shinde on 24/03/21.
//

enum RequestMethod {
    case get
    case post
    case put
    case delete
    
    var value: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .put: return "PUT"
        case .delete: return "DELETE"
        }
    }
}
