//
//  ViewController.swift
//  ECS189E
//
//  Created by Zhiyi Xu on 9/22/18.
//  Copyright © 2018 Zhiyi Xu. All rights reserved.
//

import UIKit
import libPhoneNumber_iOS

class LoginView1: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var errorInfo: UILabel!
    
    let phoneNumberPrefix = "+1"
    var asYouTypeFormatter = NBAsYouTypeFormatter(regionCode: "US")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewInit()
    }

    func viewInit() {
        nextButton.layer.cornerRadius = nextButton.frame.height / 2
        errorInfo.isHidden = true
    }
    
    // Close the key board if user tapped elsewhere
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func nextOnTap(_ sender: UIButton) {
        self.view.endEditing(true)
        
        let phoneNumber = inputField.text?.filter { $0 >= "0" && $0 <= "9" } ?? ""
        if phoneNumber.count == 0 {
            errorInfo.text = "Please enter your phone number."
            errorInfo.textColor = UIColor.red
        } else if phoneNumber.count != 10 {
            errorInfo.text = "The phone number should be 10 digits."
            errorInfo.textColor = UIColor.red
        } else {
            errorInfo.text = phoneNumberPrefix + phoneNumber
            errorInfo.textColor = UIColor.init(red: 0.0, green: 200/255, blue: 0.0, alpha: 1.0)
            if let numb = errorInfo?.text {
                toEnterCode(phoneNumber: numb)
            } else {
                print("error")
            }
            
        }
        
        errorInfo.isHidden = false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length == 0 {
            inputField.text = asYouTypeFormatter?.inputDigit(string)
        } else {
            inputField.text = asYouTypeFormatter?.removeLastDigit()
        }
        return false
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        asYouTypeFormatter = NBAsYouTypeFormatter(regionCode: "US")
        return true
    }
    
    
    func toEnterCode(phoneNumber: String) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "verificationView") as! verificationView
        vc.yophoneNumber = phoneNumber
        if (navigationController != nil) {
            navigationController?.pushViewController(vc, animated: true)
        } else {
            print("Cannot find navigation controller.")
        }
    }
    
    
}
