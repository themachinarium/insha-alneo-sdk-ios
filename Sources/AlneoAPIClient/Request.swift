//
//  Request.swift
//  AlneoAPIClient
//
//  Created by  Cavidan on 15.11.24.
//

import Foundation

// MARK: - Request Models (Encodable)

struct LoginRequest: Encodable {
    let phone_number: String
    let password: String
    let user_type: String
}

struct CardListRequest: Encodable {
    let page: Int
}

struct SessionHandshakeRequest: Encodable {
    let paymentType: String
    let paymentChannel: String
    let sessionToken: String
    let data: String
    let oneWay: Bool
}

struct ImmediatePaymentRequest: Encodable {
    let sessionToken: String
}

struct SessionFinalizeRequest: Encodable {
    let sessionToken: String
    let paymentType: String
}

struct SessionDetailRequest: Encodable {
    let sessionToken: String
    let paymentType: String
}

struct InstallmentByBinRequest: Encodable {
    let binNumber: String
    let companyId: String
}

struct SessionCheckRequest: Encodable {
    let sessionToken: String
    let paymentType: String
}

struct PaymentBySessionRequest: Encodable {
    let sessionToken: String
}
