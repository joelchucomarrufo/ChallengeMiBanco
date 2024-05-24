//
//  NetworkRequest.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}


protocol NetworkRequest {
 
    associatedtype Model
    
    var baseURL: String { get }
    var endpoint: String { get }
    var httpHeaders: [String : String] { get }
    var httpMethod: HTTPMethods { get }
    var queue: DispatchQueue { get }
    
    init(model: Model)
    
}

extension NetworkRequest {
    
    var baseURL: String { SessionManager.shared.baseURL ?? "" }
    var apiKey: String { SessionManager.shared.apiKey ?? "" }
    var queue: DispatchQueue { DispatchQueue.main }
    
}
