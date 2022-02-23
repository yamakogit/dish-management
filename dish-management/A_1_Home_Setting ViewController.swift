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

class A_1_Home_Setting_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var username_Label: UILabel!
    @IBOutlet var groupID_Label: UILabel!
    @IBOutlet var groupName_Label: UILabel!
    @IBOutlet var mode_Label: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var activityIndicatorView = UIActivityIndicatorView()  //AIV
    
    let db = Firestore.firestore()
    var groupUid: String = ""
    var userUid: String = ""
    var username: String = ""
    var groupID: String = ""
    var groupName: String = ""
    var member: [String] = []
    var email: [String] = []
    
    
    var dictionary: Dictionary<String, String> = [:]
    
    override func viewDidLoad(){
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //AIV
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
        
    }
//    override func viewWillAppear(_ animated: Bool) {
//        <#code#>
//    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        activityIndicatorView.startAnimating()  //AIV
        
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
            
            
            //Adultusersコレクション内の情報を取得
            let docRef1 = self.db.collection("AdultUsers").document("\(self.userUid)")
            
            docRef1.getDocument { (document, error) in
                if let document = document, document.exists {
                    let documentdata1 = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data1: \(documentdata1)")
                    
                   
                    self.groupUid = document.data()!["groupUid"] as! String
                    print("groupUid: ",self.groupUid)
                    self.username = document.data()!["username"] as! String
                    print("username: ",self.username)
                    
                    
                    
                    let docRef2 = self.db.collection("Group").document("\(self.groupUid)")
                    
                    docRef2.getDocument { (document, error) in
                        if let document = document, document.exists {
                            let documentdata2 = document.data().map(String.init(describing:)) ?? "nil"
                            print("Document data2: \(documentdata2)")
                           
                            
                            self.groupID = document.data()!["groupID"] as! String
                            print("groupID: ",self.groupID)
                            self.groupName = document.data()!["groupName"] as! String
                            print("groupName: ",self.groupName)
                            
                            
                            self.member = document.data()!["membername"] as! Array
                            self.email = document.data()!["memberemail"] as! Array
                            print(self.member)
                            print("ロード開始")
                            self.tableView.reloadData()
                            print("ロード完了")
                            self.username_Label.text = self.username
                            self.groupID_Label.text = self.groupID
                            self.groupName_Label.text = self.groupName
                            
                            self.activityIndicatorView.stopAnimating()  //AIV
                            
                        } else {
                            print("Document does not exist")
                        }
                    }
                    
                    
                    
                    
                    
                } else {
                    print("Document does not exist")
                }
            }
            
        }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("行数を設定")
        print(member.count)
        return member.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        let username = member[indexPath.row]
        let useremail = email[indexPath.row]
        cell.textLabel?.text = "\(username)"
        cell.detailTextLabel?.text = "\(useremail)"
        return cell  //cellの戻り値を設定
    }
    
    
    
    //Alert
    var alertController: UIAlertController!
    
    //Alert
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
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
            
            ref1.document(userUid).updateData([ //上で作成したgroupのuidをuserのuidに保存
                "username" : "\(self.username)"
                
            ])
            
            { err in
                if let err = err {
                    //失敗

                } else {
                    //成功
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
        
        tableView.reloadData()
        
        
    }
    

    @IBAction func instruction_Button() {
        
    }
    
    @IBAction func logout_Button() {
        let firebaseAuth = Auth.auth()
       do {
         try firebaseAuth.signOut()
//           alert(title: "ログアウト", message: "ログアウト処理が完了しました。\nトップページへ戻ります。")
           print("ログアウト完了")
           
           
           
               let alert: UIAlertController = UIAlertController(title: "ログアウト完了",message: "ログアウト処理が完了しました。\nトップページへ戻ります。", preferredStyle: UIAlertController.Style.alert)
               let confilmAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                   (action: UIAlertAction!) -> Void in
                   
                   
                   guard let window = UIApplication.shared.keyWindow else { return }
                   let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                   if window.rootViewController?.presentedViewController != nil {
                       // モーダルを開いていたら閉じてから差し替え
                       window.rootViewController?.dismiss(animated: true) {
                           window.rootViewController = storyboard.instantiateInitialViewController()
                       }
                   } else {
                       // モーダルを開いていなければそのまま差し替え
                       window.rootViewController = storyboard.instantiateInitialViewController()
                   }
                   
                   
               })
               
               alert.addAction(confilmAction)
               
               //alertを表示
               present(alert, animated: true, completion: nil)
           
           
       } catch let signOutError as NSError {
         print("Error signing out: %@", signOutError)
           alert(title: "エラー", message: "ログアウトに失敗しました")
       }
    }
    
    @IBAction func close_Button() {
        self.dismiss(animated: true, completion: nil)
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
