//
//  APIManager.swift
//  GCD Homework
//
//  Created by Khue on 26/07/2023.
//

import UIKit

struct APIManager {
    static let shared = APIManager()
    
    func performRequest<T: Decodable>(url: String,
                                    type: T.Type,
                                    completionHandler: @escaping (T) -> Void,
                                    failureHandler: @escaping () -> Void) {
        guard let safeURL = URL(string: url) else {
            failureHandler()
            return
        }
        let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: safeURL) { data, response, error in
            if error != nil {
                failureHandler()
                return
            }
            guard let data = data else {
                failureHandler()
                return
            }
            do {
                let result = try JSONDecoder().decode(type, from: data)
                completionHandler(result)
            } catch {
                failureHandler()
            }
        }
        task.resume()
    }
    
    func getImage(url: String, completionHandler: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: url) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    completionHandler(UIImage(data: data))
                }
            }
        }
        dataTask.resume()
    }
}
