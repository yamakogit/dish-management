//
//  Login_1-4 ViewController.swift
//  dish-management
//
//  Created by 山田航輝 on 2021/11/28.
//

import UIKit
import Firebase
import FirebaseFirestore

class Login_1_4_ViewController: UIViewController {

    @IBOutlet var name_Label: UILabel!
    
    var activityIndicatorView = UIActivityIndicatorView()  //AIV
    
    var groupName :String = ""
    var groupUid :String = ""
    var userUid :String = ""
    var useremail :String = ""
    var username :String = ""
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        
        self.groupName = UserDefaults.standard.string(forKey: "groupName1") ?? "デフォルト値"
        
        self.groupUid = UserDefaults.standard.string(forKey: "groupUid1") ?? "デフォルト値"
        self.username = UserDefaults.standard.string(forKey: "username") ?? "デフォルト値"
        
        
        
        
        name_Label.text = groupName
        
        //AIV
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
        
    }
    
    @IBAction func gonext() {
        
        activityIndicatorView.startAnimating()  //AIV
        
        Auth.auth().addStateDidChangeListener{ (auth, user) in

            guard let user = user else {
                
                return
            }
            
            print("ここ！！！！")
            print(user.uid)
            
            self.userUid = user.uid
            self.useremail = user.email!
            
            //Adultusersコレクション内の情報を取得
                    
                    
                    let docRef2 = self.db.collection("Group").document("\(self.groupUid)")

                    docRef2.getDocument { (document, error) in
                        if let document = document, document.exists {
                            let documentdata2 = document.data().map(String.init(describing:)) ?? "nil"
                            print("Document data2: \(documentdata2)")
                            
                            
                            var memberemailArray = document.data()!["memberemail"] as? Array<String> ?? []
                            var membernameArray = document.data()!["membername"] as? Array<String> ?? []
                            
                            print("memberemail_Array: \(memberemailArray)")
                            print("membername_Array: \(membernameArray)")
                        
                            memberemailArray.append(self.useremail)
                            membernameArray.append(self.username)
                            
                    let ref = self.db.collection("Group")
                            ref.document(self.groupUid).updateData( //ここでgroupのuidをランダム作成
                                ["memberemail" : memberemailArray,
                                 "membername" : membernameArray]
                            )
                            
                    { err in
                        if let err = err {
                            //失敗

                        } else {
                            //成功
                            print("succeed")
                            
                            //ここから
                            let ref3 = self.db.collection("AdultUsers")
                            ref3.document(self.userUid).setData( //ここでgroupのuidをランダム作成
                                        ["groupUid" : self.groupUid,
                                         "username" : self.username])
                            
                            
                            { err in
                                if let err = err {
                                    //失敗
                                    print("失敗")
                                    

                                } else {
                                    
                                    //成功
                                    print("succeed22")
                                    self.activityIndicatorView.stopAnimating()  //AIV
                                    self.performSegue(withIdentifier: "go-L-3-2", sender: nil)
                                }
                            }
                            //ここから
                            
                        }
                    }
                    
                        } else {
                            print("Document does not exist")
                        }
                    }
                
                
            
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        //MARK: ★navigation遷移
        //        self.performSegue(withIdentifier: "ここにidentifier書く", sender: nil)
        
    
    @IBAction func cancel() {
        
        
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
