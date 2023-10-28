//
//  APIClient.swift
//  ToDo
//
//  Created by Goodwasp on 26.10.2023.
//

import Foundation

enum NetworkError: Error {
    case emptyData
}

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {
}

class APIClient {
    lazy var urlSession: URLSessionProtocol = URLSession.shared
    
    func login(withName name: String, password: String, completionHandler: @escaping(String?, Error?) -> Void ) {
        let allowedCharacters = CharacterSet.urlQueryAllowed
        guard
            let name = name.addingPercentEncoding(withAllowedCharacters: allowedCharacters),
            let password = password.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else {
            fatalError()
        }
        
        
        let query = "name=\(name)&password=\(password)"
        guard let url = URL(string: "https://todoapp.com/login?\(query)") else { fatalError() }
        
        urlSession.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            do {
                guard let data = data else {
                    completionHandler(nil, NetworkError.emptyData)
                    return
                }
                let dictionary = try JSONSerialization.jsonObject(with: data)
                
                guard let dictionary = dictionary as? [String: String] else {
                    return
                }
                let token = dictionary["token"]
                completionHandler(token, nil)
            } catch let error {
                print(error.localizedDescription)
                completionHandler(nil, error)
            }
            
        }.resume()
    }
}
