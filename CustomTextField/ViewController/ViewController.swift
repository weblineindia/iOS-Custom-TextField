//
//  ViewController.swift
//  CustomTextField
//
//  Created by WeblineIndia on 14/07/20.
//  Copyright © 2020 WeblineIndia. All rights reserved.
//

import UIKit

let strAlertEnterUserName = "Enter user name"
let strAlertEnterPassword = "Enter password"
let strAlertEnterEmail = "Enter email id"
let strAlertEnterValidEmail = "Enter valid email id"
let strAlertEnterPhone = "Enter phone number"
let strAlertSubmit = "Data submited"

class ViewController: UIViewController {
    
    
    // WLITextField Properties
    @IBOutlet weak var txtUserName: WLITextField!
    @IBOutlet weak var txtPassword: WLITextField!
    @IBOutlet weak var txtEmail: WLITextField!
    @IBOutlet weak var txtPhone: WLITextField!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Set delegate method
        txtUserName.wliDelegate = self
        txtPassword.wliDelegate = self
        txtEmail.wliDelegate = self
        txtPhone.wliDelegate = self
        
        //set max character limit to allow in textField
        txtPhone.maxCharacter = 10
        
        //set specify character allow into textField
        txtPhone.allowCharacterOnly = "+0123456789"
        
        //Hide keybord when tap on view
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBord))
        view.addGestureRecognizer(tap)
        
    }
    ///Tap on view to dismiss keyboard
    @objc func dismissKeyBord(){
        self.view.endEditing(true)
    }
    
    // MARK: - Submit button action
    @IBAction func btnSubmitAction(_ sender: UIButton) {
        if txtUserName.text?.count == 0 {
            self.ShowAlert(alertmsg: strAlertEnterUserName)
        }else if txtPassword.text?.count == 0 {
            self.ShowAlert(alertmsg: strAlertEnterPassword)
        }else if txtEmail.text?.count == 0 {
            self.ShowAlert(alertmsg: strAlertEnterEmail)
        }else if txtEmail.isValid(txtEmail.text!) == false{
            self.ShowAlert(alertmsg: strAlertEnterValidEmail)
        }else if txtPhone.text?.count == 0 {
            self.ShowAlert(alertmsg:strAlertEnterPhone )
        }else{            
            txtUserName.text = ""
            txtPassword.text = ""
            txtEmail.text = ""
            txtPhone.text = ""
            self.ShowAlert(alertmsg: strAlertSubmit)
        }
    }
    
    // MARK: - Show alert controller
    func ShowAlert(alertmsg: String) {
        // create the alert
        let alert = UIAlertController(title: nil, message: alertmsg, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - set WLITextField delegate method
extension ViewController: WLITextFieldDelegate{
    
    
    func WLITextFieldDidBeginEditing(_ textField: UITextField) {
        print("WLITextFieldDidBeginEditing")
    }
    func WLITextFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print("WLITextFieldDidEndEditing")
    }
    
    func WLITextFielsShowAlertMessage(_ errorMessage: String) {
        self.ShowAlert(alertmsg: errorMessage)
    }
}
