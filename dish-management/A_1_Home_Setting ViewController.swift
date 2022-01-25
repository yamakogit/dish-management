//
//  A_1_Home_Setting ViewController.swift
//  dish-management
//
//  Created by 山田航輝 on 2021/11/28.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class A_1_Home_Setting_ViewController: UIViewController {

    @IBOutlet var username_Label: UILabel!
    @IBOutlet var groupID_Label: UILabel!
    @IBOutlet var mode_Label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    let db = Firestore.firestore()
    var groupUid: String = ""
    var userUid: String = ""
    var username: String = ""
    var groupID: String = ""
    var dictionaly: Dictionary<String, String> = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener{ (auth, user) in

            guard let user = user else {
                
                return
            }
            
            self.userUid = user.uid
            
            /*
            self.db.collection("AdultUsers").document(self.userUid).getDocument { (document, error) in
                
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing: ))
                    print("ここまで来ました")
                    print(dataDescription)
                }
                */
            
            
            print("ここまで①")
            print(self.userUid)
            
            
            let docRef = self.db.collection("AdultUsers").document("\(self.userUid)")
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let documentdata = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data: \(documentdata)")
                    dictionaly = Dictionary<String, Any>(documentdata)
                    self.groupUid = (String(documentdata["groupUid"] ?? ""))
                    print("groupUid: \(self.groupID)")
                    
                    
                    
                    
                    
                } else {
                    print("Document does not exist")
                }
            }
            
            
            
            
            
            
            //ここでGroupコレクションを作成
//            user.uid
            
            /*ここから
            self.db.collection("AdultUsers").document(self.userUid).getDocument { (snap, error) in
                if let error = error {
                    //失敗
                    print (error)
                    print("ここまで②　")
                } else {
                    print("ここまで③")
                guard let data = snap?.data() else { return }
                    self.groupUid = data["groupUid"] as! String
                    self.username = data["username"] as! String
                    print("ここまで④")
                }
            }
             //ここまで
             */
            /*ここから
            self.db.collection("Group").document(self.groupUid).getDocument { (snap, error) in
                if let error = error {
                    //失敗
                    print (error)
                    
                } else {
                guard let data = snap?.data() else { return }
                    self.groupID = data["groupID"] as! String
                }
             
            
            }
             */
        //ここまで
            
            self.username_Label.text = self.username
            self.groupID_Label.text = self.groupID
            
            
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func changeUsername_Button() {
        let alertTitle = "ユーザー名を変更"
        let alertMessage = "新しいユーザー名を\n入力してください。"
        let alert = UIAlertController (title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let addDefaultmMessageAction = UIAlertAction(title: "更新", style: .default, handler: { [self](action:UIAlertAction!) -> Void in
            if let inputUsername = alert.textFields?[0].text {
                self.username = inputUsername
                print(username)
            }
            
            
            let ref1 = self.db.collection("AdultUsers")
            
            ref1.document(userUid).setData([ //上で作成したgroupのuidをuserのuidに保存
                "username" : "\(self.username)"
                
            ])
            
            { err in
                if let err = err {
                    //失敗

                } else {
                }
            }
        })
        
        alert.addAction(addDefaultmMessageAction)
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        alert.addTextField(configurationHandler: {(textfield:UITextField!) -> Void in
            textfield.placeholder = "新しいユーザー名を入力..."
            textfield.keyboardType = .default
        })
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func instruction_Button() {
        
    }
    
    @IBAction func logout_Button() {
    
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
