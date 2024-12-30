//
//  ViewController.swift
//  AlneoAPIClientDemo
//
//  Created by  Cavidan on 11.11.24.
//

import UIKit
import AlneoAPIClient

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let client = AlneoAPIClient()
        client.setKeys(
            apiKey: "sk_dev_1a0c24f5-d944-4612-81a0-ff1801e0e64f",
            apiSecret: "$2a$10$tfjDWpfXJ44bnJiesOMwNuqmPLCH3c0XA3UsAy5rh2OUQv5AXX7Z2",
            userCode: "f9de5a52-76ba-4911-8483-7b5f8142cc8b"
        )
        client.sessionCreateDirect(price: 1256, data: "544078") { response in
            switch response {
            case .success(let data):
                print("Result: ", data)
            case .failure(let error):
                print("Error: ", error.localizedDescription)
            }
        }
    }
}

