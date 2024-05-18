//
//  CurrencyListRequest.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation

struct CurrencyListRequest: NetworkRequest {
    
    typealias Model = CurrencyListModel
    
    var endpoint: String { baseURL + "/currency/list?api_key=\(String(describing: apiKey))&format=json" }
    var httpHeaders: [String : String]
    var httpMethod: HTTPMethods { .get }
    
    init(model: CurrencyListModel) {
        self.httpHeaders = [
            "Content-Type":"application/json",
            "Accept":"application/json"
        ]
    }
}
