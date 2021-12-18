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
    
    var groupname: String = ""
    var groupID: String = ""
    let db = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        
        let groupNumberID: Int = Int.random(in: 1000...9999)
        let groupnameload = UserDefaults.standard.string(forKey: "groupname") ?? "デフォルト値"
        groupname = groupnameload
        
        let groupnamefirst = groupname.startIndex
        let groupnameend = groupname.endIndex
        
        groupID = "\(groupnamefirst)\(groupnameend)\(groupNumberID)"
        
        groupID_Label.text = groupID
        
        
        
        
        
        var ref: DocumentReference? = nil
        ref = db.collection("group").addDocument(data:
        ["groupID" : "\(groupID)",
         "groupName" : "\(groupname)",
         "member" : ""])
        
        
//        Auth.auth().addStateDidChangeListener{ (auth, user) in
//
//            guard let user = user else {
//                return
//            }
//
//            let ref = self.db.collection("AdaltUsers")
//
//            ref.document(user.uid).setData([
//                "name" : self.username
//            ]) { err in
//                if let err = err {
//                    //失敗
//
//                } else {
//                    //成功
//                    print("succeed")
//                    self.performSegue(withIdentifier: "1-go-L-1-2", sender: nil)
//                }
//            }
//        }
        
        
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
