//
//  Request.swift
//  AlneoAPIClient
//
//  Created by  Cavidan on 15.11.24.
//

import Foundation

// MARK: - Request Models (Encodable)

// MARK: - AUTH_LOGIN

public struct LoginRequest: Encodable {
    public let phone_number: String
    public let password: String
    public let user_type: String
    
    public init(phone_number: String, password: String, user_type: String) {
        self.phone_number = phone_number
        self.password = password
        self.user_type = user_type
    }
}

// MARK: - AUTH_LOGIN_VERIFY

public struct LoginVerifyRequest: Encodable {
    public let token: String
    public let token2: String
    public let pin_code: String
    public let user_type: String
    public let remember_me: Bool
    
    init(token: String, token2: String, pin_code: String, user_type: String, remember_me: Bool) {
        self.token = token
        self.token2 = token2
        self.pin_code = pin_code
        self.user_type = user_type
        self.remember_me = remember_me
    }
}

// MARK: - AUTH_LOGOUT

public struct AuthLogoutRequest: Encodable {
    public let target_user_id: String
    public let target_user_type: String
    
    init(target_user_id: String, target_user_type: String) {
        self.target_user_id = target_user_id
        self.target_user_type = target_user_type
    }
    
//    "target_user_id": PreferenceHelper.get(key: Helper.sha256(input: "id")),
//    "target_user_type":"COMPANY"
}

// MARK: - AUTH_RECOVERY

public struct AuthRecoveryRequest: Encodable {
    public let phone_number: String
    public let user_type: String
    
    public init(phone_number: String, user_type: String) {
        self.phone_number = phone_number
        self.user_type = user_type
    }
}

// MARK: - AUTH_RECOVERY_VERIFY

public struct AuthRecoveryVerifyRequest: Encodable {
    public let token: String
    public let token2: String
    public let pin_code: String
    public let user_type: String
    
    public init(token: String, token2: String, pin_code: String, user_type: String) {
        self.token = token
        self.token2 = token2
        self.pin_code = pin_code
        self.user_type = user_type
    }
}

// MARK: - AUTH_RECOVERY_UPDATE

public struct AuthRecoveryUpdateRequest: Encodable {
    public let token: String
    public let token2: String
    public let password: String
    public let user_type: String
    
    public init(token: String, token2: String, password: String, user_type: String) {
        self.token = token
        self.token2 = token2
        self.password = password
        self.user_type = user_type
    }
}

// MARK: - PAYMENT_BY_SESSION

public struct PaymentBySessionRequest: Encodable {
    public let session_token: String
    
    public init(session_token: String) {
        self.session_token = session_token
    }
    
//    "session_token": self.sessionToken
}

// MARK: - PAYMENT_WITHOUT_REGISTERED_CARD

public struct PaymentWithoutRegisteredCardRequest: Encodable {
    public let session_token: String
    public let payment_channel: String
    public let holder_name: String
    public let card_number: String
    public let cvv: String
    public let expire_month: Int
    public let expire_year: Int
    public let phone_number: String
    public let installment: Int
    public let description: String
    
    public init(session_token: String, payment_channel: String, holder_name: String, card_number: String, cvv: String, expire_month: Int, expire_year: Int, phone_number: String, installment: Int, description: String) {
        self.session_token = session_token
        self.payment_channel = payment_channel
        self.holder_name = holder_name
        self.card_number = card_number
        self.cvv = cvv
        self.expire_month = expire_month
        self.expire_year = expire_year
        self.phone_number = phone_number
        self.installment = installment
        self.description = description
    }
    
    //    "session_token": handshakedToken,
    //    "payment_channel":"MOBILE_IOS",
    //    "holder_name":self.holderName,
    //    "card_number":self.cardNumber,
    //    "cvv":self.cvc,
    //    "expire_month":self.expireMonth,
    //    "expire_year":self.expireYear,
    //    "phone_number":self.phoneNumber,
    //    "installment":self.selectedInstallment,
    //    "description":self.paymentDescription
}


// MARK: - POS_COMMISSION

public struct PosComissionRequest: Encodable {
    public let company_id: String
    public let amount: Double
    public let bin_number: String
    
    public init(company_id: String, amount: Double, bin_number: String) {
        self.company_id = company_id
        self.amount = amount
        self.bin_number = bin_number
    }
    
//    "company_id":PreferenceHelper.get(key: Helper.sha256(input: "company_id")),
//    "amount":100,
//    "bin_number":Build.DEFAULT_BIN, String(cardNumber.prefix(6))
}

// MARK: - SESSION_DETAIL

public struct SessionDetailRequest: Encodable {
    public let session_token: String
    public let payment_type: String
    
    public init(session_token: String, payment_type: String) {
        self.session_token = session_token
        self.payment_type = payment_type
    }
//    "session_token": self.sessionToken,
//    "payment_type": "DIRECT",
}

// MARK: - SESSION_CREATE

public struct SessionCreateDirectRequest: Encodable {
    public let payment_channel: String = "MOBILE_IOS"
    public let payment_type: String = "DIRECT"
    public let price: Double
    public let currency: String = "TRY"
    public let data: String
    
    public init(price: Double, data: String) {
        self.price = price
        self.data = data
    }
//    "payment_channel": "MOBILE_IOS",
//    "payment_type":"DIRECT",
//    "price":self.price,
//    "currency":"TRY",
//    "data": String(cardNumber.prefix(6))
}

public struct SessionCreateQrRequest: Encodable {
    public let payment_channel: String = "MOBILE_IOS"
    public let payment_type: String = "QR"
    public let price: Double
    
    public init (price: Double) {
        self.price = price
    }
//    "payment_channel": "MOBILE_IOS",
//    "payment_type": "QR",
//    "price": self.price
    
}

public struct SessionCreateWebRequest: Encodable {
    public let payment_channel: String = "WEB"
    public let payment_type: String
    public let price: Double
    public let currency: String = "TRY"
    public let data: String
    public let description: String
    public let source: String = "IOS"
    
    public init(payment_type: String, price: Double, data: String, description: String) {
        self.payment_type = payment_type
        self.price = price
        self.data = data
        self.description = description
    }
//    "payment_channel": "WEB",
//    "payment_type":self.paymentType,
//    "price":self.price,
//    "currency":"TRY",
//    "data":self.data,
//    "description":self.paymentDescription,
//    "source":"IOS"
    
//    controller.price = self.price
//    controller.paymentType = "SMS"
//    controller.data = phoneNumber
//    controller.paymentDescription = description
    
//    controller.price = self.price
//    controller.paymentType = "LINK"
//    controller.data = email
//    controller.paymentDescription = description
}

// MARK: - SESSION_HANDSHAKE

public struct SessionHandshakeRequest: Encodable {
    public let session_token: String
    public let payment_type: String = "DIRECT"
    public let payment_channel: String = "MOBILE_IOS"
    public let data: String
    public let one_way: Bool
    
    public init(session_token: String, data: String, one_way: Bool) {
        self.session_token = session_token
        self.data = data
        self.one_way = one_way
    }
//    "session_token": self.sessionToken,
//    "payment_type": "DIRECT",
//    "payment_channel":"MOBILE_IOS",
//    "data":self.binNumber, Build.DEFAULT_BIN, String(cardNumber.prefix(6))
//    "one_way":true
}

// MARK: - SESSION_FINALIZE

public struct SessionFinalizeAcceptanceRequest: Encodable {
    public let session_token: String
    public let payment_type: String = "DIRECT"
    
    public init(session_token: String) {
        self.session_token = session_token
    }
//    "session_token": self.sessionToken,
//    "payment_type": "DIRECT",
}

public struct SessionFinalizeQRRequest: Encodable {
    public let session_token: String
    
    public init(session_token: String) {
        self.session_token = session_token
    }
//    "session_token": self.sessionToken,
}

// MARK: - SESSION_CHECK

public struct SessionCheck3DRequest: Encodable {
    public let session_token: String
    public let payment_type: String = "DIRECT"
    
    public init(session_token: String) {
        self.session_token = session_token
    }
//    "session_token": self.sessionToken,
//    "payment_type": "DIRECT",
}

public struct SessionCheckQrRequest: Encodable {
    public let session_token: String
    public let payment_type: String = "QR"
    
    public init(session_token: String) {
        self.session_token = session_token
    }
//    "session_token": self.availableSessionToken,
//    "payment_type":"QR"
}

// MARK: - SESSION_REJECT

public struct SessionRejectQrRequest: Encodable {
    public let session_token: String
    public let payment_type: String = "QR"
    
    public init(session_token: String) {
        self.session_token = session_token
    }
//    "session_token": self.sessionToken,
//    "payment_type":"QR"
}


// MARK: - VERSION_CHECK

//public struct VersionCheckRequest: Encodable {
//    public let platform: String = "IOS"
//    public let version: String =
//    public let build: String
//    
//    public init(session_token: String) {
//        self.session_token = session_token
//    }
////    "platform": "IOS",
////    "version":build,
////    "version_name":version,
////    "name":"pos",
////    "user_id":  PreferenceHelper.get(key: Helper.sha256(input: "id"))
////    let version : Any! = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
////    let build : Any! = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion")
//}
