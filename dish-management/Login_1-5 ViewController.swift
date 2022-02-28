//
//  Login_1-5 ViewController.swift
//  dish-management
//
//  Created by 山田航輝 on 2021/12/11.
//

import UIKit
import Firebase //FB
import FirebaseAuth
import FirebaseFirestore

class Login_1_5_ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var groupName_TF: UITextField!
    @IBOutlet weak var groupName_TF_Const: NSLayoutConstraint!  //key
    
    var groupName : String = ""
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        
        groupName_TF.delegate = self
        
        groupName_TF.addTarget(self, action: #selector(Login_1_5_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
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
    
    //TF
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //キーボードを閉じる
        
        return true //戻り値
    }
    
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        groupName = textField.text!
        print("groupName: \(groupName)")
        
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
            self.groupName_TF_Const.constant = keyboardHeight + 10
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let keyboardAnimationDuration = notification.keybaordAnimationDuration,
              let KeyboardAnimationCurve = notification.keyboardAnimationCurve
        else { return }

        UIView.animate(withDuration: keyboardAnimationDuration,
                       delay: 0,
                       options: UIView.AnimationOptions(rawValue: KeyboardAnimationCurve)) {
            self.groupName_TF_Const.constant = 200
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
        if groupName == "" {
            alert(title: "グループ名が\n正しく入力されていません", message: "グループ名を\nもう一度入れ直してください。")
            print("error: groupName not found")
            
        } else {
            UserDefaults.standard.set(self.groupName, forKey: "groupname")
            //MARK: ★navigation遷移
            self.performSegue(withIdentifier: "go-L-1-6", sender: nil)
            
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
