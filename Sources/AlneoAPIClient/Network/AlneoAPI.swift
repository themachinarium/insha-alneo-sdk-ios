//
//  BaseService.swift
//  AlneoAPIClient
//
//  Created by  Cavidan on 15.11.24.
//

import Foundation
import CryptoKit

class AlneoAPI {
        
    private init() {} // Preventing initialization from outside
    
    // Base URL for the API
    private let baseURL = "https://babel-proxy.cognesive.com" // Replace with the actual base URL
    
    // MARK: - Request Method Enum
    enum RequestMethod: String {
        case GET
        case POST
    }
    
    // MARK: - Network Request Helper
    private func performRequest<T: Decodable, U: Encodable>(
        endpoint: Endpoint,
        method: RequestMethod,
        parameters: U?,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        guard let url = URL(string: baseURL + endpoint.rawValue) else {
            completion(.failure(.invalidResponse("Invalid URL.")))
            return
        }
        
        let applicationVersion: String? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String;
        let applicationBundleVersion : String? = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = {
            headers = [
                "Accept": "application/json",
                "User-Agent": "com.albaraka.alneo.cuzdan",
                "Version": applicationVersion != nil ? applicationVersion! : "0.100",
                "Version-Code": applicationBundleVersion != nil ? applicationBundleVersion! : "1",
                "Status": String(Build.DEBUG),
                "Application": "WALLET",
                "Client": "iOS",
                "Client-SDK": UIDevice.current.systemVersion,
                "Client-Device": UIDevice.current.model,
                "Client-Product": UIDevice.current.name,
                "Client-Version": UIDevice.current.systemVersion
            ]
        }
        
        if let parameters = parameters {
            do {
                let jsonData = try JSONEncoder().encode(parameters)
                request.httpBody = jsonData
            } catch {
                completion(.failure(.invalidResponse("Failed to encode parameters.")))
                return
            }
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Network error handling
            if let error = error {
                completion(.failure(.networkError(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse("No data received.")))
                return
            }
            
            // HTTP Status Code check
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse("Invalid response.")))
                return
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                // Success - Try decoding response
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.parseError("Failed to decode response.")))
                }
            default:
                // API-specific error handling (non-2xx response)
                do {
                    // Attempt to parse the error message from the response body
                    let errorResponse = try JSONDecoder().decode(APIErrorResponse.self, from: data)
                    completion(.failure(.serverError(message: errorResponse.message)))
                } catch {
                    completion(.failure(.serverError(message: "Unknown API error.")))
                }
            }
        }.resume()
    }

    // MARK: - API Error Handling
    enum APIError: Error {
        case invalidResponse(String)
        case networkError(String)
        case parseError(String)
        case serverError(message: String)
    }
    
    // MARK: - API Endpoints
    enum Endpoint: String {
        case login = "/service/auth/login"
        case cardOfUser = "/card/user"
        case sessionHandshake = "/session/handshake"
        case paymentWithRegistered = "/payment/registered"
        case sessionFinalize = "/session/finalize"
        case sessionDetail = "/session/detail"
        case installmentByBin = "/installment/bin"
        case sessionCheck = "/session/check"
        case paymentBySession = "/payment/session"
    }
    
    // MARK: - API Methods
    
    public func login(phone_number: String, password: String, user_type: String, completion: @escaping (Result<LoginResponse, APIError>) -> Void) {
        let parameters = LoginRequest(phone_number: username, password: password, user_type: )
        performRequest(endpoint: .login, method: .POST, parameters: parameters, completion: completion)
    }
    
    func getCardList(page: Int, completion: @escaping (Result<[Card], APIError>) -> Void) {
        let parameters = CardListRequest(page: page)
        performRequest(endpoint: .cardOfUser, method: .GET, parameters: parameters, completion: completion)
    }
    
    // Card List Retrieval API
    func getCardList(page: Int, completion: @escaping (Result<[Card], APIError>) -> Void) {
        let parameters = CardListRequest(page: page)
        performRequest(endpoint: .cardOfUser, method: .GET, parameters: parameters, completion: completion)
    }
    
    // QR Payment Session Handshake API
    func sessionHandshake(paymentType: String, paymentChannel: String, sessionToken: String, cardID: String, oneWay: Bool, completion: @escaping (Result<SessionHandshakeResponse, APIError>) -> Void) {
        let parameters = SessionHandshakeRequest(paymentType: paymentType, paymentChannel: paymentChannel, sessionToken: sessionToken, cardID: cardID, oneWay: oneWay)
        performRequest(endpoint: .sessionHandshake, method: .POST, parameters: parameters, completion: completion)
    }

    // Immediate Payment API
    func immediatePayment(sessionToken: String, completion: @escaping (Result<ImmediatePaymentResponse, APIError>) -> Void) {
        let parameters = ImmediatePaymentRequest(sessionToken: sessionToken)
        performRequest(endpoint: .paymentWithRegistered, method: .POST, parameters: parameters, completion: completion)
    }

    // Session Finalize API
    func sessionFinalize(sessionToken: String, paymentType: String, completion: @escaping (Result<Void, APIError>) -> Void) {
        let parameters = SessionFinalizeRequest(sessionToken: sessionToken, paymentType: paymentType)
        performRequest(endpoint: .sessionFinalize, method: .POST, parameters: parameters, completion: completion)
    }

    // Session Detail API
    func sessionDetail(sessionToken: String, paymentType: String, completion: @escaping (Result<SessionDetailResponse, APIError>) -> Void) {
        let parameters = SessionDetailRequest(sessionToken: sessionToken, paymentType: paymentType)
        performRequest(endpoint: .sessionDetail, method: .POST, parameters: parameters, completion: completion)
    }

    // Installment By BIN API
    func installmentByBin(binNumber: String, companyId: String, completion: @escaping (Result<InstallmentOptions, APIError>) -> Void) {
        let parameters = InstallmentByBinRequest(binNumber: binNumber, companyId: companyId)
        performRequest(endpoint: .installmentByBin, method: .POST, parameters: parameters, completion: completion)
    }

    // Session Check API
    func sessionCheck(sessionToken: String, paymentType: String, completion: @escaping (Result<SessionStatusResponse, APIError>) -> Void) {
        let parameters = SessionCheckRequest(sessionToken: sessionToken, paymentType: paymentType)
        performRequest(endpoint: .sessionCheck, method: .POST, parameters: parameters, completion: completion)
    }

    // Payment By Session API
    func paymentBySession(sessionToken: String, completion: @escaping (Result<PaymentSessionResponse, APIError>) -> Void) {
        let parameters = PaymentBySessionRequest(sessionToken: sessionToken)
        performRequest(endpoint: .paymentBySession, method: .POST, parameters: parameters, completion: completion)
    }
}
