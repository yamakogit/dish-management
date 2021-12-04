//
//  Login_2-1 ViewController.swift
//  dish-management
//
//  Created by 山田航輝 on 2021/11/28.
//

import UIKit

class Login_2_1_ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var mail_TF: UITextField!
    @IBOutlet weak var pass_TF: UITextField!
    
    var emailadress :String = ""
    var pass :String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        //TF
        mail_TF.delegate = self
        pass_TF.delegate = self
        
        mail_TF.tag = 0
        pass_TF.tag = 1
        
        // Do any additional setup after loading the view.
    }
    
    //TF
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //キーボードを閉じる
        
        if textField.tag == 0 {
        emailadress = textField.text!
        print("sharedEmailadress: \(emailadress)")
            
        } else if textField.tag == 1 {
            pass = textField.text!
            print("sharedPassword: \(pass)")
        }
        return true //戻り値
    }
    
    
    //Alert
    var alertController: UIAlertController!
    
    //Alert
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    
    @IBAction func gonext() {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
