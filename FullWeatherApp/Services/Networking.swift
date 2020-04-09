//
//  Networking.swift
//  FullWeatherApp
//
//  Created by Evgeniy on 04.04.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import Foundation
import Alamofire

class ApiService {
    private func baseRequest<T>(ofType: T.Type, url: String, method: HTTPMethod, params: Parameters? = nil,
                                completion: @escaping (Swift.Result<T, Error>) -> Void) where T: Decodable {
        AF.request(url, method: method, parameters: params).responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    completion(.failure(ApiError.serverError))
                    return
                }
                
                guard case 200...206 = statusCode else {
                  completion(.failure(self.handleError(statusCode: response.response?.statusCode)))
                  return
                }
                
                let decoder = JSONDecoder()
                
                do {
                    let decodedData = try decoder.decode(T.self, from: data)
                    completion(Swift.Result.success(decodedData))
                } catch let error {
                    completion(Swift.Result.failure(error))
                }
            case .failure(let error):
                completion(Swift.Result.failure(error))
            }
        }
    }
    
    func getWeatherByCity(completion: @escaping (Swift.Result<Response, Error>) -> Void) {
        let params: [String : Any] = [
            "access_key" : Constants.API_KEY,
            "query" : Constants.city!
        ]
        
        baseRequest(ofType: Response.self, url: Constants.url, method: .get, params: params) { response in
            completion(response)
        }
    }
    
    private func handleError(statusCode: Int?) -> Error {
        guard let statusCode = statusCode else {
            return ApiError.cityNotFound
        }
        
        switch statusCode {
        case 400...499:
          return ApiError.cityNotFound
        case 500...526:
          return ApiError.serverError
        default:
            return ApiError.badCityError
        }
    }
}
