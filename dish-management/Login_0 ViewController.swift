//
//  Login_0 ViewController.swift
//  dish-management
//
//  Created by 山田航輝 on 2021/11/28.
//

import UIKit
import Firebase //FB
import FirebaseAuth
import FirebaseFirestore

class Login_0_ViewController: UIViewController, UITextFieldDelegate {

    //FB
    @IBOutlet var mail_TF :UITextField!
    @IBOutlet var user_TF :UITextField!
    @IBOutlet var pass_TF :UITextField!
    
    @IBOutlet weak var pass_TF_Const: NSLayoutConstraint!  //key
    
    var activityIndicatorView = UIActivityIndicatorView()  //AIV
    
    var emailadress :String = ""
    var username :String = ""
    var pass :String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        //TF
        mail_TF.delegate = self
        user_TF.delegate = self
        pass_TF.delegate = self
        
        mail_TF.tag = 0
        user_TF.tag = 1
        pass_TF.tag = 2
        
        pass_TF.isSecureTextEntry = true
     
        //AIV
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
        
        mail_TF.addTarget(self, action: #selector(Login_0_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        user_TF.addTarget(self, action: #selector(Login_0_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        pass_TF.addTarget(self, action: #selector(Login_0_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        //key
        NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardWillShow),
                                                   name: UIResponder.keyboardWillShowNotification,
                                                   object: nil)
        NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardWillHide),
                                                   name: UIResponder.keyboardWillHideNotification,
                                                   object: nil)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.configureObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.removeObserver()
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
            username = textField.text!
            print("username: \(username)")
            
        } else if textField.tag == 2 {
            pass = textField.text!
            print("password: \(pass)")
        }
    }
    
    /*
    //ここから: キーボードずらす
    // Notificationを設定
        @objc func configureObserver() {

            let notification = NotificationCenter.default
            notification.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIResponder.keyboardWillShowNotification, object: nil)
            notification.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIResponder.keyboardWillHideNotification, object: nil)
        }

        // Notificationを削除
        func removeObserver() {

            let notification = NotificationCenter.default
            notification.removeObserver(self)
        }

        // キーボードが現れた時に、画面全体をずらす。
        func keyboardWillShow(notification: Notification?) {

            let rect = (notification?.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
            let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
            UIView.animate(withDuration: duration!, animations: { () in
                let transform = CGAffineTransform(translationX: 0, y: -(rect?.size.height)!)
                self.view.transform = transform

            })
        }

        // キーボードが消えたときに、画面を戻す
        func keyboardWillHide(notification: Notification?) {

            let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Double
            UIView.animate(withDuration: duration!, animations: { () in

                self.view.transform = CGAffineTransform.identity
            })
        }
    //ここまで: キーボードずらす
    */
    
    
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
            self.pass_TF_Const.constant = keyboardHeight + 10
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let keyboardAnimationDuration = notification.keybaordAnimationDuration,
              let KeyboardAnimationCurve = notification.keyboardAnimationCurve
        else { return }

        UIView.animate(withDuration: keyboardAnimationDuration,
                       delay: 0,
                       options: UIView.AnimationOptions(rawValue: KeyboardAnimationCurve)) {
            self.pass_TF_Const.constant = 205
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
            
        } else if username == "" {
            alert(title: "ユーザー名が\n正しく入力されていません", message: "ユーザー名を\nもう一度入れ直してください。")
            print("error: username not found")
            
        } else if pass == "" {
            alert(title: "パスワードが\n正しく入力されていません", message: "パスワードを\nもう一度入れ直してください。")
            print("error: password not found")
            
        } else {
            
            activityIndicatorView.startAnimating()  //AIV
            
            Auth.auth().createUser (withEmail: emailadress, password: pass) {
                authResult, error in
            print("succeed: signup_createUser")
                
                
                UserDefaults.standard.set(self.username, forKey: "username")
                self.activityIndicatorView.stopAnimating()  //AIV
                
                //MARK: ★navigation遷移
                self.performSegue(withIdentifier: "go-L-1-1", sender: nil)

                
            }
        }
    }
    
    
    
    @IBAction func signin() {
        self.performSegue(withIdentifier: "go-L-2-1", sender: nil)
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

extension Notification {

    // キーボードの高さ
    var keyboardHeight: CGFloat? {
        return (self.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
    }

    // キーボードのアニメーション時間
    var keybaordAnimationDuration: TimeInterval? {
        return self.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
    }

    // キーボードのアニメーション曲線
    var keyboardAnimationCurve: UInt? {
        return self.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
    }
}


