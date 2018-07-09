//
//  AlamofireAPIClient.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/7/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Alamofire

class AlamofireAPIClient: APIClient {
    
    let configuration: ServiceConfigurator
    
    required init(_ configuration: ServiceConfigurator = ServiceConfigurator()) {
        self.configuration = configuration
    }
    
    func execute<T: APIRequest>(_ request: T, completion: @escaping ResultHandler<T.Response>) {
        
        let urlRequest = request.urlRequest(in: self)
        
        NetworkLogger.log(request: urlRequest)
        
        handleAuthChallenge()
        
        let dataRequest = AlamofireAPIClient.manager.request(request.urlRequest(in: self))
        
        dataRequest.validate().responseJSON { response in
            
            NetworkLogger.log(data: response.data, response: response.response)
            
            if let error = response.error {
                completion(.failure(error.localizedDescription))
            } else if let data = response.data {
                do {
                    let apiError = try JSONDecoder().decode(APIError.self, from: data)
                    if let message = apiError.message {
                        completion(.failure(message))
                    }else {
                        let apiResponse = try JSONDecoder().decode(T.Response.self, from: data)
                        completion(.success(apiResponse))
                    }
                    
                } catch {
                    completion(.failure(error.localizedDescription))
                }
                
            }
            
        }
        
    }
    
    
}

//MARK: - AuthChallenge
private extension AlamofireAPIClient {
    
    static var manager: Alamofire.SessionManager = {
        return Alamofire.SessionManager(configuration: .default)
    }()
    
    func handleAuthChallenge() {
        
        let delegate = AlamofireAPIClient.manager.delegate
        
        delegate.sessionDidReceiveChallenge = { session, challenge in
            
            var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
            
            var credential: URLCredential?
            
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                disposition = URLSession.AuthChallengeDisposition.useCredential
                credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            } else {
                if challenge.previousFailureCount > 0 {
                    disposition = .cancelAuthenticationChallenge
                } else {
                    credential = AlamofireAPIClient.manager.session.configuration.urlCredentialStorage?.defaultCredential(for: challenge.protectionSpace)
                    if credential != nil {
                        disposition = .useCredential
                    }
                }
            }
            return (disposition, credential)
        }
    }
}
