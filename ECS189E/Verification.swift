//
//  Verification.swift
//  ECS189E
//
//  Created by Sravya Sri Divakarla on 10/25/18.
//  Copyright © 2018 Zhiyi Xu. All rights reserved.
//

import Foundation;
import UIKit;

class verificationView: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var enterCode: UITextField!
    @IBOutlet weak var errorM: UILabel!
    var yophoneNumber: String?
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var code: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorM.isHidden = true;
        sendCode();
    }
    
    
    // Call the function that send the verification code to your phone
    func sendCode(){
        let codeSent = Api.sendVerificationCode(phoneNumber: yophoneNumber!) { response, error in
                if let resp = response?["status"]{
                    print(resp)
                }
        }
    }
    
    //When you press the login, you
    @IBAction func verifyCode(_ sender: Any) {
        verifytheCode()
    }
    
    
    func verifytheCode(){
        let ver = Api.verifyCode(phoneNumber: self.yophoneNumber!, code: self.code.text!){ response, error in
            if let resp = response?["status"]{
                print(resp)
                self.errorM.text = "Verified successfully!";
            }else{
                if let err = error?.code{
                    if err == "invalid_phone_number"{
                        self.errorM.text = "Your phone number is invalid";
                    }else if err == "incorrect_code"{
                        self.errorM.text = "Incorrect verification code";
                    }else if err == "code_expired"{
                        self.errorM.text = "Your code expired";
                    }
                }
            }
             self.errorM.isHidden = false
        }
    }

   
}
