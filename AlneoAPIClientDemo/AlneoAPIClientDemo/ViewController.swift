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
//        client.login(phone_number: "05374791858", password: "ejdahA1234", user_type: "COMPANY")
//        client.login(phone_number: "05417333333", password: "1234Abcd", user_type: "COMPANY")
        
//        controller.accountToken = json["content"]["token"].stringValue
//        controller.verificationToken = json["content"]["token2"].stringValue
//        controller.timestamp = json["content"]["timestamp"].int64Value
        
//        controller.accountToken = json["content"]["token"].stringValue
//        controller.verificationToken = json["content"]["token2"].stringValue
//        controller.timestamp = json["content"]["timestamp"].int64Value
        
//        switch response {
//        case .success(let data):
//            
//            print("zzzz ", data)
//        case .failure(let error):
//            print("zzzz ", error.localizedDescription)
//        }
        
//        client.authRecovery(phone_number: "05374791858", completion: <#T##(Result<JSON, APIError>) -> Void#>)
        
//        client.login(phone_number: "05417333300", password: "kinG1234") { response in
//            switch response {
//            case .success(let data):
//                print("zzzz ", data)
//            case .failure(let error):
//                print("zzzz ", error.localizedDescription)
//            }
//        }
        
        client.loginVerify(token: "2b7d9278354e03216e352ed2774747f6985c695cee7029aed41d8c53613a6090", token2: "5c08abac4ef450fd630151fc916b4506c214b2c93628e38ba049a8e5ec6c8b7c", pin_code: "123456", remember_me: false) { response in
            switch response {
            case .success(let data):
                print("zzzz ", data)
            case .failure(let error):
                print("zzzz ", error.localizedDescription)
            }
        }
        
        
//        client.authRecovery(phone_number: "05417333300") { response in
//            switch response {
//            case .success(let data):
//                print("zzzz 1 ", data)
//                
//            case .failure(let error):
//                print("zzzz ", error.localizedDescription)
//            }
//        }
        
//        client.authRecoveryVerify(token: "2b7d9278354e03216e352ed2774747f6985c695cee7029aed41d8c53613a6090", token2: "3466edb4846a0e47e2fcc4d4061b565ccf589acd4119e5c4067c5e3baa09be19", pin_code: "123456") { response in
//            switch response {
//            case .success(let data):
//                print("zzzz ", data)
//            case .failure(let error):
//                print("zzzz ", error.localizedDescription)
//            }
//        }
        
//        client.authRecoveryUpdate(token: "2b7d9278354e03216e352ed2774747f6985c695cee7029aed41d8c53613a6090", token2: "1961b20c1640053c9198a4f4fa0fe98c8063b5441291c1d4de8095aa21862275", password: "kinG1234") { response in
//            switch response {
//            case .success(let data):
//                print("zzzz ", data)
//            case .failure(let error):
//                print("zzzz ", error.localizedDescription)
//            }
//        }
    }


}

