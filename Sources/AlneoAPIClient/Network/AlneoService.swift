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
import TrustKit

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

// MARK: - API Endpointsj tbg
public enum Endpoint: String {
    case AUTH_LOGIN = "/service/auth/login"
    case AUTH_LOGIN_VERIFY = "/service/auth/login/verify"
    
    case AUTH_LOGOUT = "/service/auth/logout"
    
    case AUTH_RECOVERY = "/service/auth/recovery"
    case AUTH_RECOVERY_VERIFY = "/service/auth/recovery/verify"
    case AUTH_RECOVERY_UPDATE = "/service/auth/recovery/update"
    
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
    
    public var deviceSystemVersion: String = ""
    public var deviceModel: String = ""
    public var deviceName: String = ""
    
    public init() {
        self.configureTrustKit()
    }
    
    private func configureTrustKit() {
//       let trustKitConfig: [String: Any] = [
//           kTSKPinnedDomains: [
//               "10.195.80.22:8080": [
//                   kTSKPublicKeyHashes: [
//                       "F8XLjwmcK21/e3/kaACC5UcDhJwGUzaZef0M5GjLdms="
//                   ],
//                   kTSKEnforcePinning: true,
//                   kTSKIncludeSubdomains: true
//               ]
//           ]
//       ]
//
//       TrustKit.initSharedInstance(withConfiguration: trustKitConfig)
   }
    
    // Base URL for the API
    private let baseURL = Build.API_URL  // Replace with the actual base URL
    
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
        guard let url = URL(string: baseURL + endpoint.rawValue) else {
            completion(.failure(.invalidResponse("Invalid URL.")))
            return
        }
        
        guard var urlComponents = URLComponents(string: baseURL + endpoint.rawValue) else {
                completion(.failure(.invalidResponse("Invalid URL.")))
                return
            }
        
        let applicationVersion: String? = "1.0.0"// Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let applicationBundleVersion : String? = "81"// Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "User-Agent": "com.albaraka.alneo.pos",
            "Version": applicationVersion != nil ? applicationVersion! : "0.100",
            "Version-Code": applicationBundleVersion != nil ? applicationBundleVersion! : "1",
            "Status": String(true),
            "Application": "WALLET",
            "Client": "iOS",
            "Client-SDK": deviceSystemVersion,
            "Client-Device": deviceModel,
            "Client-Product": deviceName,
            "Client-Version": deviceSystemVersion
        ]
        
        // Step 2: If GET request, append query parameters to the URL
        if let parameters = parameters {
            var queryItems = [URLQueryItem]()

            // Reflect parameters to query items
            let mirror = Mirror(reflecting: parameters)
            for child in mirror.children {
                if let key = child.label {
                    let value = "\(child.value)"
                    queryItems.append(URLQueryItem(name: key, value: value))
                }
            }
            urlComponents.queryItems = queryItems
        }
        
        guard let url = urlComponents.url else {
               completion(.failure(.invalidResponse("Invalid URL with parameters.")))
               return
           }

        if let body = body {
            do {
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(body)
                request.httpBody = jsonData
                print("zzzz 3 ", String(data: jsonData, encoding: .utf8))
            } catch {
                completion(.failure(.invalidResponse("Failed to encode parameters.")))
                return
            }
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse("No data received.")))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse("Invalid response.")))
                return
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                do {
                    //                    let result = try JSONDecoder().decode(T.self, from: data)
                    let result = try JSON(data: data)
                    print("error: ", result)
                    completion(.success(result))
                } catch {
                    completion(.failure(.parseError("Failed to decode response.")))
                }
            default:
                do {
                    let errorResponse = try JSON(data: data)//try JSONDecoder().decode(APIErrorResponse.self, from: data)
                    print("error: ", errorResponse)
//                    completion(.failure(.serverError(message: errorResponse.message ?? "Unexpected error")))
                } catch {
                    completion(.failure(.serverError(message: "Unknown API error.")))
                }
            }
        }.resume()
    }
}
