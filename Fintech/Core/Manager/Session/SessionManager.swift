//
//  SessionManager.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation

class SessionManager: Codable {
    
    static var shared = SessionManager()
    private static let  sessionTime: Double? = 300.0
    var baseURL: String?
    var apiKey: String?
        
    private init() {
        baseURL = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String
        apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String
    }
}
