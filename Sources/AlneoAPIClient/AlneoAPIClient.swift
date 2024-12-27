// The Swift Programming Language
// https://docs.swift.org/swift-book

import ObjectiveC
import Foundation
import CryptoSwift
import SwiftyJSON

@MainActor
public class AlneoAPIClient: NSObject {
    
    private var service: AlneoService
    
    public override init() {
        service = AlneoService()
        
        service.deviceSystemVersion = AppDevice.systemVersion()
        service.deviceModel = AppDevice.model()
        service.deviceName = AppDevice.name()

    }
    
    // MARK: - API Methods
    
    // MARK: - LOGIN
    
    public func login(phone_number: String, password: String, completion: @Sendable @escaping (Result<JSON, APIError>) -> Void) {
        let phone = phone_number.sha256()
        let pass = password.sha256()
        
        let parameters = LoginRequest(phone_number: phone, password: pass, user_type: "COMPANY")
        service.performRequest(endpoint: .AUTH_LOGIN_VERIFY, method: .POST, body: parameters, completion: completion)
    }
    
    public func loginVerify(token: String, token2: String, pin_code: String, remember_me: Bool, completion: @Sendable @escaping (Result<JSON, APIError>) -> Void) {
        let parameters = LoginVerifyRequest(token: token, token2: token2, pin_code: pin_code, user_type: "COMPANY", remember_me: remember_me)
        service.performRequest(endpoint: .AUTH_LOGIN_VERIFY, method: .POST, body: parameters, completion: completion)
    }
    
    // MARK: - AUTH RECOVERY
    
    public func authRecovery(phone_number: String, completion: @Sendable @escaping (Result<JSON, APIError>) -> Void) {
        let phone = phone_number.sha256()
        
        let body = AuthRecoveryRequest(phone_number: phone, user_type: "COMPANY")
        service.performRequest(endpoint: .AUTH_RECOVERY, method: .POST, body: body, completion: completion)
    }
    
    public func authRecoveryVerify(token: String, token2: String, pin_code: String, completion: @Sendable @escaping (Result<JSON, APIError>) -> Void) {
        let body = AuthRecoveryVerifyRequest(token: token, token2: token2, pin_code: pin_code, user_type: "COMPANY")
        service.performRequest(endpoint: .AUTH_RECOVERY_VERIFY, method: .POST, body: body, completion: completion)
    }
    
    public func authRecoveryUpdate(token: String, token2: String, password: String, completion: @Sendable @escaping (Result<JSON, APIError>) -> Void) {
        let pass = password.sha256()
        
        let body = AuthRecoveryUpdateRequest(token: token, token2: token2, password: pass, user_type: "COMPANY")
        service.performRequest(endpoint: .AUTH_RECOVERY_UPDATE, method: .POST, body: body, completion: completion)
    }
    
    // MARK: - PAYMENT
    
    public func paymentBySession(session_token: String, completion: @Sendable @escaping (Result<JSON, APIError>) -> Void) {
        
        let body = PaymentBySessionRequest(session_token: session_token)
        service.performRequest(endpoint: .PAYMENT_BY_SESSION, method: .POST, body: body, completion: completion)
    }
    
    public func paymentWithoutRegisteredCard(session_token: String, payment_channel: String, holder_name: String, card_number: String, cvv: String, expire_month: Int, expire_year: Int, phone_number: String, installment: Int, description: String, completion: @Sendable @escaping (Result<JSON, APIError>) -> Void) {
        let request = PaymentWithoutRegisteredCardRequest(session_token: session_token, payment_channel: payment_channel, holder_name: holder_name, card_number: card_number, cvv: cvv, expire_month: expire_month, expire_year: expire_year, phone_number: phone_number, installment: installment, description: description)
        service.performRequest(endpoint: .PAYMENT_WITHOUT_REGISTERED_CARD, method: .POST, body: request, completion: completion)
    }
    
    // MARK: - POS
    
    public func posComission(company_id: String, amount: Double, bin_number: String, completion: @Sendable @escaping (Result<JSON, APIError>) -> Void) {
        let body = PosComissionRequest(company_id: company_id, amount: amount, bin_number: bin_number)
        service.performRequest(endpoint: .POS_COMMISSION, method: .POST, body: body, completion: completion)
    }
    
    // MARK: - SESSION
    
    public func sessionDetail(session_token: String, payment_type: String, completion: @Sendable @escaping (Result<JSON, APIError>) -> Void) {
        let body = SessionDetailRequest(session_token: session_token, payment_type: payment_type)
        service.performRequest(endpoint: .SESSION_DETAIL, method: .POST, body: body, completion: completion)
    }
    
    public func sessionCreateDirect(price: Double,  data: String, completion: @Sendable @escaping (Result<JSON, APIError>) -> Void) {
        let body = SessionCreateDirectRequest(price: price, data: data)
        service.performRequest(endpoint: .SESSION_CREATE, method: .POST, body: body, completion: completion)
    }
    
    
    public func sessionCreateQr(price: Double, completion: @Sendable @escaping (Result<JSON, APIError>) -> Void) {
        let body = SessionCreateQrRequest(price: price)
        service.performRequest(endpoint: .SESSION_CREATE, method: .POST, body: body, completion: completion)
    }
    
    public func sessionCreateWeb(payment_type: String, price: Double, data: String, description: String, completion: @Sendable @escaping (Result<JSON, APIError>) -> Void) {
        let body = SessionCreateWebRequest(payment_type: payment_type, price: price, data: data, description: description)
        service.performRequest(endpoint: .SESSION_CREATE, method: .POST, body: body, completion: completion)
    }
    
    public func sessionHandshake(session_token: String, data: String, one_way: Bool, completion: @Sendable @escaping (Result<JSON, APIError>) -> Void) {
        let body = SessionHandshakeRequest(session_token: session_token, data: data, one_way: one_way)
        service.performRequest(endpoint: .SESSION_HANDSHAKE, method: .POST, body: body, completion: completion)
    }
    
    public func sessionFinalizeAcceptance(session_token: String, completion: @Sendable @escaping (Result<JSON, APIError>) -> Void) {
        let body = SessionFinalizeAcceptanceRequest(session_token: session_token)
        service.performRequest(endpoint: .SESSION_FINALIZE, method: .POST, body: body, completion: completion)
    }
    
    public func sessionFinalizeQR(session_token: String, completion: @Sendable @escaping (Result<JSON, APIError>) -> Void) {
        let body = SessionFinalizeQRRequest(session_token: session_token)
        service.performRequest(endpoint: .SESSION_FINALIZE, method: .POST, body: body, completion: completion)
    }
    
    
    public func sessionCheck3D(session_token: String, completion: @Sendable @escaping (Result<JSON, APIError>) -> Void) {
        let body = SessionCheck3DRequest(session_token: session_token)
        service.performRequest(endpoint: .SESSION_CHECK, method: .POST, body: body, completion: completion)
    }
    
    public func sessionCheckQR(session_token: String, completion: @Sendable @escaping (Result<JSON, APIError>) -> Void) {
        let body = SessionCheckQrRequest(session_token: session_token)
        service.performRequest(endpoint: .SESSION_CHECK, method: .POST, body: body, completion: completion)
    }
    
    public func sessionReject(session_token: String, completion: @Sendable @escaping (Result<JSON, APIError>) -> Void) {
        let body = SessionCheckQrRequest(session_token: session_token)
        service.performRequest(endpoint: .SESSION_REJECT, method: .POST, body: body, completion: completion)
    }
    
    // MARK: - USER_DETAIL
    
    public func userDetail(completion: @Sendable @escaping (Result<JSON, APIError>) -> Void) {
        service.performRequest(endpoint: .USER_DETAIL, method: .POST, completion: completion)
    }
    
//    // MARK: - VERSION_CHECK
//    
//    public func versionCheck(token: String, token2: String, password: String, completion: @Sendable @escaping (Result<JSON, APIError>) -> Void) {
//        let pass = password.sha256()
//        
//        let body = AuthRecoveryUpdateRequest(token: token, token2: token2, password: pass, user_type: "COMPANY")
//        service.performRequest(endpoint: .AUTH_RECOVERY_UPDATE, method: .POST, body: body, completion: completion)
//    }
}
