//
//  NetworkManager.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation
import Alamofire
import Combine

protocol NetworkManagerProtocol: AnyObject {
    
    func requestGeneric<R: NetworkRequest, T: Decodable>(request: R, entity: T.Type) -> AnyPublisher<T, NetworkingError>
    
}

class NetworkManager: NetworkManagerProtocol {
    
    let session: Session
    
    init() {
        let configuration = URLSessionConfiguration.default, remittanceConfig = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 25
        configuration.timeoutIntervalForResource = 25
        remittanceConfig.timeoutIntervalForRequest = 60
        remittanceConfig.timeoutIntervalForResource = 60
        session = Session(configuration: configuration)
    }
            
    internal func requestGeneric<R, T>(request: R, entity: T.Type) -> AnyPublisher<T, NetworkingError> where R : NetworkRequest, T : Decodable {
        var method: HTTPMethod = .get
        if request.httpMethod == .post { method = .post }
        if request.httpMethod == .delete { method = .delete }
                
        let headers = HTTPHeaders(request.httpHeaders)
        print(request.httpMethod, request.endpoint)
        return session.request(request.endpoint, method: method, encoding: URLEncoding.default, headers: headers)
            .validate()
            .publishData()
            .tryMap { response in
                guard let httpResponse = response.response else {
                    throw NetworkingError.unknown
                }
                if (200...299).contains(httpResponse.statusCode) {
                    let value = try JSONDecoder().decode(T.self, from: response.data ?? Data())
                    return value
                } else if (400...499).contains(httpResponse.statusCode) {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: response.data ?? Data())
                    throw NetworkingError.custom(errorResponse.error.message)
                } else {
                    throw NetworkingError.httpError(httpResponse.statusCode)
                }
            }
            .mapError { error in
                self.evaluateError(error: error)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
    
    private func evaluateError(error: Error) -> NetworkingError {
        if let networkingError = error as? NetworkingError {
            return networkingError
        }
        if let afError = error as? AFError {
            switch afError {
            case .responseValidationFailed(let reason):
                switch reason {
                case .unacceptableStatusCode(let code):
                    return .httpError(code)
                default:
                    return .unknown
                }
            default:
                return .unknown
            }
        }
        return .unknown
    }
          
}
