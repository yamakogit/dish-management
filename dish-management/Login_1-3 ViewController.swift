//
//  Login_1-3 ViewController.swift
//  dish-management
//
//  Created by 山田航輝 on 2021/11/28.
//

import UIKit
import Firebase //FB
import FirebaseFirestore
import FirebaseAuth

class Login_1_3_ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var groupID_TF: UITextField!
    
    
    var groupID :String = ""
    let db = Firestore.firestore()
    var groupUid :String = ""
    
    var activityIndicatorView = UIActivityIndicatorView()  //AIV

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        //AIV
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        view.addSubview(activityIndicatorView)
        
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
        
        
        
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()  //AIV
        
        print("押された")
        
        
        if groupID == "" {
            alert(title: "グループIDが\n正しく入力されていません", message: "グループIDを\nもう一度入れ直してください。")
            print("error: groupID is none")
            
        }  else {
            print("ここまできた")
        
            db.collection("Group").whereField("groupID", isEqualTo: groupID).getDocuments() {(QuerySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    print("error: group ID not found")
                    
                    self.activityIndicatorView.stopAnimating()  //AIV
                    self.activityIndicatorView.isHidden = true
                    self.alert(title: "エラー", message: "グルーピが見つかりません。\nもう一度、groupIDを\n正しく入力してください。")
                } else {
                    for document in QuerySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        
                        let data = document.data()
                        let groupID = data["groupID"] as! String
                        let groupName = data["groupName"]  as! String
                        
                        self.groupUid = document.documentID
                        
                        UserDefaults.standard.set(groupName, forKey: "groupName1")
                        UserDefaults.standard.set(self.groupUid, forKey: "groupUid1")
                        
                        
                        print("これがデータ:\(data)")
                        print("groupID: \(groupID)")
                        print("groupName: \(groupName)")
                        print("groupUid: \(self.groupUid)")
                        
                        
                        self.activityIndicatorView.stopAnimating()  //AIV
                        self.activityIndicatorView.isHidden = true
                        print("succeed: Enter group")
                        
                        self.performSegue(withIdentifier: "go-L-1-4", sender: nil)
                        
                    }
                }
                
            }
            
            
            
            
            
        
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
