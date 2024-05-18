//
//  ErrorResponse.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation

struct ErrorResponse : Decodable {
    let status: String
    let error: ErrorModel
}

struct ErrorModel : Decodable {
    let message: String
    let code: String
}

