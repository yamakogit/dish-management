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
    
    @IBOutlet weak var passTF_Const: NSLayoutConstraint!  //key
    
    @IBOutlet weak var Logo_Whitewood_Img: UIImageView!
    
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
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
        
        mail_TF.addTarget(self, action: #selector(Login_2_1_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        pass_TF.addTarget(self, action: #selector(Login_2_1_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        // Do any additional setup after loading the view.
        
        //key
        NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardWillShow),
                                                   name: UIResponder.keyboardWillShowNotification,
                                                   object: nil)
        NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardWillHide),
                                                   name: UIResponder.keyboardWillHideNotification,
                                                   object: nil)
        
        //ImageView_角丸設定
        Logo_Whitewood_Img.layer.cornerRadius = 10
        
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
    
    
    //key
    @objc private func keyboardWillShow(_ notification: Notification) {

        guard let keyboardHeight = notification.keyboardHeight,
              let keyboardAnimationDuration = notification.keybaordAnimationDuration,
              let KeyboardAnimationCurve = notification.keyboardAnimationCurve
        else { return }

        UIView.animate(withDuration: keyboardAnimationDuration,
                       delay: 0,
                       options: UIView.AnimationOptions(rawValue: KeyboardAnimationCurve)) {
            // アニメーションさせたい実装を行う
            self.passTF_Const.constant = keyboardHeight + 10
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let keyboardAnimationDuration = notification.keybaordAnimationDuration,
              let KeyboardAnimationCurve = notification.keyboardAnimationCurve
        else { return }

        UIView.animate(withDuration: keyboardAnimationDuration,
                       delay: 0,
                       options: UIView.AnimationOptions(rawValue: KeyboardAnimationCurve)) {
            self.passTF_Const.constant = 230
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
                
                if let user = authResult?.user {
                //成功
                    print("succeed: login")
                        //MARK: ★?,!不要？
                        self?.activityIndicatorView.stopAnimating()  //AIV
                        
                        //MARK: ★navigation遷移
                        self?.performSegue(withIdentifier: "go-L-2-2", sender: nil)
                    
                } else {
                    self?.activityIndicatorView.stopAnimating()  //AIV
                //失敗
                self?.alert(title: "エラー", message: "ログインに失敗しました。\n正しい情報を入力してください。")
                print("error: password not found")
           
                }
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
