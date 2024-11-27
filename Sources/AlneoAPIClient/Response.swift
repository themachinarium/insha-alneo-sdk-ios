//
//  Response.swift
//  AlneoAPIClient
//
//  Created by  Cavidan on 15.11.24.
//

import Foundation

// MARK: - Response Models (Decodable)

struct LoginResponse: Decodable {}

struct Card: Decodable {
    let id: String
    let binNumber: String
    let bankName: String
    let alias: String
    let type: String
    let status: String
    let maxLimit: Double
    let mode: String
    let expireMonth: Int
    let expireYear: Int
}

struct SessionHandshakeResponse: Decodable {
    let token: String
    let fastPayment: Bool
}

struct ImmediatePaymentResponse: Decodable {
    let sessionToken: String
}

struct SessionDetailResponse: Decodable {
    let session: [String: Any]
    let company: [String: Any]
    let category: [String: Any]
}

struct InstallmentOptions: Decodable {
    let installmentRates: [String: Double]
}

struct SessionStatusResponse: Decodable {
    let status: String
}

struct PaymentSessionResponse: Decodable {
    let company: [String: Any]
    let location: [String: Any]
    let category: [String: Any]
    let payment: [String: Any]
}

// MARK: - Error Response Models (For API Errors)

struct APIErrorResponse: Decodable {
    let message: String
}

