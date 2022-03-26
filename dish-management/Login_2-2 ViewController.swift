//
//  Login_2-2 ViewController.swift
//  dish-management
//
//  Created by 山田航輝 on 2021/11/28.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class Login_2_2_ViewController: UIViewController {

    @IBOutlet var name_Label: UILabel!
    
    var activityIndicatorView = UIActivityIndicatorView()
    let db = Firestore.firestore()
    
    var userUid: String = ""
    var username: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
        
        
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
                    
                    self.username = document.data()!["username"] as! String
                    print("username: ",self.username)
                    
                    self.name_Label.text = self.username
                    self.activityIndicatorView.stopAnimating()
                } else {
                    print("Document does not exist")
                    
                    let alert: UIAlertController = UIAlertController(title: "エラー",message: "エラーが発生しました。\nログインし直してください。", preferredStyle: UIAlertController.Style.alert)
                    let confilmAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                        (action: UIAlertAction!) -> Void in
                        
                        self.navigationController?.popToRootViewController(animated: true)
                        
                    })
                    
                    alert.addAction(confilmAction)
                    
                    
                    self.activityIndicatorView.stopAnimating()
                    //alertを表示
                    self.present(alert, animated: true, completion: nil)
                    
                    
                }
            }
            
        }
        
        
    }
    
    @IBAction func gonext() {
    
        self.performSegue(withIdentifier: "go-L-3-3", sender: nil)
        
    }
    
    @IBAction func cancel() {
        self.navigationController?.popToRootViewController(animated: true)
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
