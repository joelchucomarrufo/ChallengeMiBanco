//
//  CurrencyConvertRequest.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation

struct CurrencyConvertRequest: NetworkRequest {
    
    typealias Model = CurrencyConvertModel
    
    var endpoint: String
    var httpHeaders: [String : String]
    var httpMethod: HTTPMethods { .get }
    
    init(model: CurrencyConvertModel) {
        self.endpoint = ""
        self.httpHeaders = [
            "Content-Type":"application/json",
            "Accept":"application/json"
        ]        
        updateRequest(model: model)
    }
    
    mutating func updateRequest(model: Model) {
        self.endpoint =  baseURL + "/currency/convert?api_key=\(String(describing: apiKey))&from=\(model.from)&to=\(model.to)&amount=\(model.amount)&format=json"
    }
}
