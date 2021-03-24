//
//  Registration.swift
//  Visaero
//
//  Created by Mangesh Shinde on 30/09/19.
//  Copyright © 2019 Mangesh Shinde. All rights reserved.
//

import Foundation


struct SimpleReponse: Codable {
    let data: String
    let _id: String?
    let error_code : String
    let msg : String
    
    enum CodingKeys: String, CodingKey {
        case data
        case _id
        case error_code
        case msg
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try (values.decodeIfPresent(String.self, forKey: .data) ?? "")
        self._id = try values.decodeIfPresent(String.self, forKey: ._id)
        self.error_code = try (values.decodeIfPresent(String.self, forKey: .error_code) ?? "")
        self.msg = try (values.decodeIfPresent(String.self, forKey: .msg) ?? "")
    }
}



