//
//  Login_2-1 ViewController.swift
//  dish-management
//
//  Created by 山田航輝 on 2021/11/28.
//

import UIKit
import Firebase //FB
import FirebaseAuth
import FirebaseFirestore

class Login_2_1_ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var mail_TF: UITextField!
    @IBOutlet weak var pass_TF: UITextField!
    
    var activityIndicatorView = UIActivityIndicatorView()  //AIV
    
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
        
        pass_TF.isSecureTextEntry = true
     
        //AIV
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        view.addSubview(activityIndicatorView)
        
        mail_TF.addTarget(self, action: #selector(Login_2_1_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        pass_TF.addTarget(self, action: #selector(Login_2_1_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        // Do any additional setup after loading the view.
    }
    
    //TF
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //キーボードを閉じる
        
        return true //戻り値
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if textField.tag == 0 {
        emailadress = textField.text!
        print("emailadress: \(emailadress)")
            
        } else if textField.tag == 1 {
            pass = textField.text!
            print("password: \(pass)")
        }
            
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
        if emailadress == "" {
            alert(title: "メールアドレスが\n正しく入力されていません", message: "メールアドレスを\nもう一度入れ直してください。")
            print("error: emailadress not found")
            
        } else if pass == "" {
            alert(title: "パスワードが\n正しく入力されていません", message: "パスワードを\nもう一度入れ直してください。")
            print("error: password not found")
            
        } else {
            
            activityIndicatorView.startAnimating()  //AIV
            
            Auth.auth().signIn (withEmail: emailadress, password: pass) {
                [weak self] authResult, error in
                
                guard let strongSelf = self else { return }
                
                
            print("succeed: login")
                //MARK: ★?,!不要？
                self?.activityIndicatorView.stopAnimating()  //AIV
                self?.activityIndicatorView.isHidden = true
                

                
                //MARK: ★navigation遷移
                self?.performSegue(withIdentifier: "go-L-2-2", sender: nil)
                
            }
        }
        
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
