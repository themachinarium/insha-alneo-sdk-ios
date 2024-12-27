//
//  AppDevice.swift
//  AlneoAPIClient
//
//  Created by  Cavidan on 15.11.24.
//

import UIKit

@MainActor
public class AppDevice {
    
    public init() {}
    
    public static func systemVersion() -> String {
        UIDevice.current.systemVersion
    }
    
    public static func model() -> String {
        UIDevice.current.model
    }
    
    public static func name() -> String {
        UIDevice.current.name
    }
}
