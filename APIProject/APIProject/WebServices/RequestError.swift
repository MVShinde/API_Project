//
//  RequestError.swift
//  APIProject
//
//  Created by Mangesh Shinde on 24/03/21.
//

enum RequestError {
    case noAuthorized
    case notFound
    case timeOut
    case invalidUrl
    case invalidResponse
    case notMapped
    case encodeError
    
    var code: Int {
        switch self {
        case .noAuthorized: return 403
        case .notFound: return 404
        case .timeOut: return 504
        default: return 0
        }
    }
    
    var description: String {
        switch self {
        case .noAuthorized: return "Authorized Error"
        case .notFound: return "Not Found"
        case .timeOut: return "Time Out"
        case .invalidUrl: return "URL Invalid"
        case .invalidResponse: return "Response Invalid"
        case .encodeError : return "Encoding Error"
        default: return "Default error"
        }
    }
    
    init(code: Int) {
        switch code {
        case 403: self = .noAuthorized
        case 404: self = .notFound
        case 504: self = .timeOut
        default: self = .notMapped
        }
    }
}
