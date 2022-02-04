//
//  A_2_Dish_List ViewController.swift
//  dish-management
//
//  Created by 山田航輝 on 2021/11/28.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class A_2_Dish_List_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //エラー
    //Type 'A_2_Dish_List_ViewController' does not conform to protocol 'UITableViewDataSource'
    //下記にあり
    
    @IBOutlet weak var tableView: UITableView!
    
    var userUid: String = ""
    var groupUid: String = ""
    var dishesDataSecond_Array: [[String: Any]] = []
    var dishesData_Array: Array<Any> = []
    
    let db = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    
     /*要復活
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#> // tableViewの記載内容を記入
    }
      */
    

    override func viewWillAppear(_ animated: Bool) {
        Auth.auth().addStateDidChangeListener{ (auth, user) in

            guard let user = user else {
                
                return
            }
            
            self.userUid = user.uid
            
            
            //Adultusersコレクション内の情報を取得
            let docRef1 = self.db.collection("AdultUsers").document("\(self.userUid)")
            
            docRef1.getDocument { (document, error) in
                if let document = document, document.exists {
                    let documentdata1 = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data1: \(documentdata1)")
                    
                   
                    self.groupUid = document.data()!["groupUid"] as! String
                    print("groupUid: ",self.groupUid)
                    
                    
                    
                    
                    
                    
                    
                    
                    let docRef2 = self.db.collection("Group").document("\(self.groupUid)")

                    docRef2.getDocument { (document, error) in
                        if let document = document, document.exists {
                            let documentdata2 = document.data().map(String.init(describing:)) ?? "nil"
                            print("Document data2: \(documentdata2)")
                            
                            
                            self.dishesData_Array = document.data()!["dishes"] as? Array<Any> ?? []
                            
                            print("dish_Array: \(self.dishesData_Array)")
                            self.dishesDataSecond_Array = self.dishesData_Array as! [[String: Any]]
                            self.tableView.reloadData()
                    
                        } else {
                            print("Document does not exist")
                        }
                    }
                    
                    } else {
                        print("Document does not exist")
                    }
                }
                
                
            
            }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishesDataSecond_Array.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "List") as! A_2_Dish_List_TableViewCell_VC
        let dishname = dishesDataSecond_Array[indexPath.row]["dishname"] as! String
        cell.dish_nameLabel?.text = "\(dishname)"
        let position = dishesDataSecond_Array[indexPath.row]["position"] as! String
        cell.createdDateLabel?.text = "場所: \(position)"
//        cell.accessoryType = .disclosureIndicator  //cellの横に > が表示されるように設定
        return cell  //cellの戻り値を設定
    }
    
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath){
        
        let selectedDishesData = dishesDataSecond_Array[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: selectedDishesData)
        
}
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            
            let nextVC = segue.destination as! A_2_Dish_Detail_ViewController
            nextVC.selectedDishesData = sender as! [String: Any]
            
        }
    }
    
    
    @IBAction func addDishButton() {
        self.performSegue(withIdentifier: "go-A2DA", sender: nil)
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
