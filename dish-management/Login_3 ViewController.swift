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
    var unwrap_title: [String] = []
//        let storyboard: UIStoryboard = self.storyboard!
//        let nextview = storyboard.instantiateViewController(withIdentifier: "AdultVC")
//        let navi = UINavigationController(rootViewController: nextview)
//        navi.modalTransitionStyle = .coverVertical
//        present(navi, animated: true, completion: nil)
//    }


//
    @IBAction func goInst_Button() {
//        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AdultVC") as! UITabBarController
//        navigationController?.pushViewController(nextVC, animated: true)・
        
        
        //ここから
//        func getMedicinesName() -> [String] {
//              var medicines = [String]()
//
//              db.collection("Group").getDocuments() { (querySnapshot, err) in
//                  if let err = err {
//                      print("Error getting documents: \(err)")
//                  } else {
//                      for document in querySnapshot!.documents {
//                         let medicineToBeAdded = document.get("syutoku") as! String
//                         medicines.append(medicineToBeAdded)
//                          if self.unwrap_title == medicines {
//                              print("完了")
//                              print(self.unwrap_title)
//                          }
//                          else {
//                              print("値が代入されていません")
//                          }
//                      }
//                  }
//              }
//              return medicines
//          }
        
        
//        getMedicinesName()
        
        //ここまで
        
        
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
