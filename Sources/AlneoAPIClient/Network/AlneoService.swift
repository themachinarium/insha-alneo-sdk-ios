//
//  BaseService.swift
//  AlneoAPIClient
//
//  Created by  Cavidan on 15.11.24.
//

import Foundation
import CryptoKit
import SwiftyJSON
import UIKit

// MARK: - API Error Handling
public enum APIError: Error {
    case invalidResponse(String)
    case networkError(String)
    case parseError(String)
    case serverError(message: String)
}

public struct Build {

    static let API_URL: String = "https://alneomac.2sworks.com"
    
    static let DEFAULT_BIN = "52586400"
    
}

// MARK: - API Endpoints
public enum Endpoint: String {
    case PAYMENT_BY_SESSION = "/service/payment/by/session"
    case PAYMENT_WITHOUT_REGISTERED_CARD = "/service/payment/v2/non-registered"
    
    case POS_COMMISSION = "/service/pos/v2/commission"
    
    case SESSION_DETAIL = "/service/payment/session"
    case SESSION_CREATE = "/service/payment/session/create"
    case SESSION_HANDSHAKE = "/service/payment/session/handshake"
    case SESSION_FINALIZE = "/service/payment/session/finalize"
    case SESSION_CHECK = "/service/payment/session/check"
    case SESSION_REJECT = "/service/payment/session/reject"
    
    case USER_DETAIL = "/service/user/company/representative"
    
    case VERSION_CHECK = "/service/system/version/check"
}

public class AlneoService {
    
    private var apiKey: String?
    private var apiSecret: String?
    private var userCode: String?
    
    public init() {}
    
    // MARK: - Set API Keys
    public func setKeys(apiKey: String, apiSecret: String, userCode: String) {
        self.apiKey = apiKey
        self.apiSecret = apiSecret
        self.userCode = userCode
    }
    
    private let baseURL = Build.API_URL
    
    // MARK: - Request Method Enum
    enum RequestMethod: String {
        case GET
        case POST
    }
    
    // MARK: - Network Request Helper
    func performRequest(
        endpoint: Endpoint,
        method: RequestMethod,
        parameters: Encodable? = nil,
        body: Encodable? = nil,
        completion: @escaping @Sendable (Result<JSON, APIError>) -> Void
    ) {
        // Check if the API keys are set
        guard let apiKey = self.apiKey, !apiKey.isEmpty,
              let apiSecret = self.apiSecret, !apiSecret.isEmpty,
              let userCode = self.userCode, !userCode.isEmpty else {
            completion(.failure(.invalidResponse("API anahtarları veya kullanıcı kodu ayarlanmamış. Lütfen `setKeys` metodunu çağırın.")))
            return
        }
        
        guard let url = URL(string: baseURL + endpoint.rawValue) else {
            completion(.failure(.invalidResponse("Geçersiz URL.")))
            return
        }
        
        guard var urlComponents = URLComponents(string: baseURL + endpoint.rawValue) else {
            completion(.failure(.invalidResponse("Parametrelerle geçersiz URL oluşturuldu.")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "x-api-key": apiKey,
            "x-api-secret": apiSecret,
            "x-user-code": userCode
        ]
        
        if let parameters = parameters {
            var queryItems = [URLQueryItem]()
            let mirror = Mirror(reflecting: parameters)
            for child in mirror.children {
                if let key = child.label {
                    queryItems.append(URLQueryItem(name: key, value: "\(child.value)"))
                }
            }
            urlComponents.queryItems = queryItems
        }
        
        if let body = body {
            do {
                let jsonData = try JSONEncoder().encode(body)
                request.httpBody = jsonData
            } catch {
                completion(.failure(.invalidResponse("İstek gövdesi kodlanamadı.")))
                return
            }
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.networkError("Ağ hatası: \(error.localizedDescription)")))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse("Sunucudan veri alınamadı.")))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse("Geçersiz sunucu yanıtı.")))
                return
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                do {
                    let result = try JSON(data: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.parseError("Sunucu yanıtı işlenirken bir hata oluştu.")))
                }
            default:
                do {
                    let errorResponse = try JSON(data: data)
                    completion(.failure(.serverError(message: errorResponse["message"].string ?? "Bilinmeyen bir hata oluştu.")))
                } catch {
                    completion(.failure(.serverError(message: "Bilinmeyen bir sunucu hatası.")))
                }
            }
        }.resume()
    }
}
