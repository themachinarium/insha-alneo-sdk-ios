//
//  Response.swift
//  AlneoAPIClient
//
//  Created by  Cavidan on 16.11.24.
//

import Foundation

struct APIErrorResponse: Decodable {
    let code: String?
    let message: String?
}
