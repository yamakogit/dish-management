//
//  Login_3 ViewController.swift
//  dish-management
//
//  Created by 山田航輝 on 2021/11/28.
//

import UIKit
import Firebase
import FirebaseFirestore

class Login_3_ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }
    
    let db = Firestore.firestore()
//    var unwrap_title: [String] = []
    
    
    @IBAction func goInst_Button() {
        
        
        performSegue(withIdentifier: "toAdultVC", sender: nil)
    }
    
    @IBAction func use_Button() {
        
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
