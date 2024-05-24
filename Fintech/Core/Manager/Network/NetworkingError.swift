//
//  NetworkingError.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation

enum NetworkingError: Error {
    case custom(String)
    case httpError(Int)
    case unknown
}
