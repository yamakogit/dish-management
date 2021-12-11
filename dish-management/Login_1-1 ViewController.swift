//
//  Login_1-1 ViewController.swift
//  dish-management
//
//  Created by 山田航輝 on 2021/11/28.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class Login_1_1_ViewController: UIViewController {
    
    // MARK: ★
    
    var mode :Bool = true
    var username: String = ""
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        
        let usernameload = UserDefaults.standard.string(forKey: "username") ?? "デフォルト値"
        username = usernameload
    }
    
    @IBAction func adultMode() {
        mode = true
        
        
        
        db.auth().onAuthStateChanged(async (user) -> {
            if (!user) {
                
            } else {
        var ref: DocumentReference? = nil
    
        ref = db.collection("AdaltUsers").document(user.uid).setData([
            "name" : username
        ]) { err in
            if let err = err {
                //失敗
                
            } else {
            //成功
                print("ID: \(ref!.documentID)")
                self.performSegue(withIdentifier: "1-go-L-1-2", sender: nil)
            }
        }
        
        
        
        
        
        
//        //MARK: ★navigation遷移
    }
    
    @IBAction func childMode() {
        mode = false
        
        
        //MARK: ★navigation遷移
        //        self.performSegue(withIdentifier: "ここにidentifier書く", sender: nil)
    }
    
    @IBAction func instruction() {
        
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
