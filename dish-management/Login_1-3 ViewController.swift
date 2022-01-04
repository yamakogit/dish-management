//
//  Login_1-3 ViewController.swift
//  dish-management
//
//  Created by 山田航輝 on 2021/11/28.
//

import UIKit
import Firebase //FB

class Login_1_3_ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var groupID_TF: UITextField!
    
    var groupID :String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        //TF
        groupID_TF.delegate = self
        groupID_TF.addTarget(self, action: #selector(Login_1_3_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    //TF
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //キーボードを閉じる
        
        groupID = textField.text!
        print("sharedEmailadress: \(groupID)")  //TF
        
        return true //戻り値
    }
    
    //TF
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        groupID = textField.text!
        print("groupID: \(groupID)")
            
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
        
        
        if groupID == "" {
            alert(title: "グループIDが\n正しく入力されていません", message: "グループIDを\nもう一度入れ直してください。")
            print("error: group ID not found")
            
        }  else {
            
        
        
            //MARK: ★navigation遷移
            //        self.performSegue(withIdentifier: "ここにidentifier書く", sender: nil)
        
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
