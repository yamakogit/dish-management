//
//  Login_1-6 ViewController.swift
//  dish-management
//
//  Created by 山田航輝 on 2021/12/11.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class Login_1_6_ViewController: UIViewController {
    @IBOutlet var groupID_Label: UILabel!
    
    var activityIndicatorView = UIActivityIndicatorView()
    
    var groupname: String = ""
    var groupID: String = ""
    var username: String = ""
    var mode: String = ""
    let db = Firestore.firestore()
    var checkNumber: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()  //AIV
        
        
        
        let groupIDNumber: Int = Int.random(in: 100000...999999)
        
        let groupIDLetterArray = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        let groupIDLetter1 = groupIDLetterArray [Int.random(in: 0...51)]
        let groupIDLetter2 = groupIDLetterArray [Int.random(in: 0...51)]
        let groupnameload = UserDefaults.standard.string(forKey: "groupname") ?? "デフォルト値"
        let usernameload = UserDefaults.standard.string(forKey: "username") ?? "デフォルト値"
        let modeload = UserDefaults.standard.string(forKey: "mode") ?? "デフォルト値"
        groupname = groupnameload
        username = usernameload
        mode = modeload
        
        groupID = "\(groupIDLetter1)\(groupIDLetter2)\(groupIDNumber)"
        
        groupID_Label.text = groupID
        
        print ("groupID: \(groupID)")
        
        
        
        
        
        
        Auth.auth().addStateDidChangeListener{ (auth, user) in

            guard let user = user else {
                return
            }
            
            //ここでGroupコレクションを作成
            let ref = self.db.collection("Group")
            
            let createduid = self.db.collection("Group").document().documentID
            print("createduid: \(createduid)")
            ref.document(createduid).setData( //ここでgroupのuidをランダム作成
                                                            ["groupID" : "\(self.groupID)", //groupIDを保存
                                                             "groupName" : "\(self.groupname)", //group名を保存
                                                             "membername" : ["\(self.username)"],
                                                             "memberemail": ["\(user.email as! String)"]]) //userのuidをgroupコレクションに保存
            
            
            
            let ref2 = self.db.collection("\(self.mode)")
            
            ref2.document(user.uid).setData([  //作成済のAdultUsersコレクションのAuthのuidに...
                "groupUid" : "\(createduid)",  //上で作成したgroupのuidをuserのuidに保存
                "username" : "\(self.username)"
            ])
            
            
            { err in
                if let err = err {
                    //失敗

                } else {
                    //成功
                    print("succeed")
                    self.checkNumber = 1
                }
            }
        }
        
        activityIndicatorView.stopAnimating()  //AIV
        activityIndicatorView.isHidden = true
        
    }
    

    
    
    
    
    
    
    
    
    @IBAction func gonext() {
        if checkNumber == 1 {
            self.performSegue(withIdentifier: "go-L-3-1", sender: nil)
        } else {
            //失敗している
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
