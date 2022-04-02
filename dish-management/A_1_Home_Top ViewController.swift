//
//  A_1_Home_Top ViewController.swift
//  dish-management
//
//  Created by 山田航輝 on 2021/11/28.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class A_1_Home_Top_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    //エラー
    //Type 'A_2_Dish_List_ViewController' does not conform to protocol 'UITableViewDataSource'
    //下記にあり
    
    
    @IBOutlet var currentnumber_Label: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var logo_Whitewood_Img: UIImageView!
    @IBOutlet weak var background_1_OrangeWood_Img: UIImageView!
    @IBOutlet weak var background_2_OrangeWood_Img: UIImageView!
    @IBOutlet weak var current_WhiteWood_img: UIImageView!
    @IBOutlet weak var news_WhiteWood_img: UIImageView!
    @IBOutlet weak var setting_WhiteWood_img: UIImageView!
    
    
    var activityIndicatorView = UIActivityIndicatorView()
    let db = Firestore.firestore()
    
    var newsDataSecond_Array: [[String: Any]] = []
    var newsData_Array: Array<Any> = []
    
    var userUid: String = ""
    var groupUid: String = ""
    var dishesDataSecond_Array: [[String: Any]] = []
    var dishesData_Array: Array<Any> = []
    
    var launch: String = ""
    
    //Alert
    var alertController: UIAlertController!
    
    //Alert
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        launch = "first"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        //AIV
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.startAnimating()  //AIV
        
        //Imageview_角丸設定
        background_1_OrangeWood_Img.layer.cornerRadius = 10  //角を角丸に設定
        background_1_OrangeWood_Img.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        background_2_OrangeWood_Img.layer.cornerRadius = 10  //角を角丸に設定
        background_2_OrangeWood_Img.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        
        logo_Whitewood_Img.layer.cornerRadius = 5
        current_WhiteWood_img.layer.cornerRadius = 5
        news_WhiteWood_img.layer.cornerRadius = 5
        setting_WhiteWood_img.layer.cornerRadius = 5
            
            //ニュースリリース表示
            let docRef1 = self.db.collection("Host").document("News")
            
            docRef1.getDocument { (document, error) in
                if let document = document, document.exists {
                    let documentdata1 = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data1: \(documentdata1)")
                    
                    
                    self.newsData_Array = document.data()!["News_Array"] as? Array<Any> ?? []
                            
                    print("newsData_Array: \(self.newsData_Array)")
                    self.newsDataSecond_Array = self.newsData_Array as! [[String: Any]]
                    
                    self.tableView.reloadData()
                    
                    } else {
                        print("Document1 does not exist")
                        
                        self.activityIndicatorView.stopAnimating()  //AIV
                        self.alert(title: "エラー", message: "ニュースリリースの取得に失敗しました")
                        
                    }
                }
        
        self.activityIndicatorView.startAnimating()  //AIV

        //現在の料理数表示
        Auth.auth().addStateDidChangeListener{ (auth, user) in

            guard let user = user else {

                return
            }

            self.userUid = user.uid




            //Adultusersコレクション内の情報を取得
            let docRef2 = self.db.collection("AdultUsers").document("\(self.userUid)")

            docRef2.getDocument { (document, error) in
                if let document = document, document.exists {
                    let documentdata2 = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data2: \(documentdata2)")


                    self.groupUid = document.data()!["groupUid"] as! String
                    print("groupUid: ",self.groupUid)

                    UserDefaults.standard.set(self.groupUid, forKey: "groupUid")  //var. 1.0.2
                    UserDefaults.standard.set(self.userUid, forKey: "userUid")  //var. 1.0.2

                    let docRef3 = self.db.collection("Group").document("\(self.groupUid)")

                    docRef3.getDocument { (document, error) in
                        if let document = document, document.exists {
                            let documentdata3 = document.data().map(String.init(describing:)) ?? "nil"
                            print("Document data3: \(documentdata3)")


                            self.dishesData_Array = document.data()!["dishes"] as? Array<Any> ?? []

                            print("dish_Array: \(self.dishesData_Array)")
                            self.dishesDataSecond_Array = self.dishesData_Array as! [[String: Any]]

                            self.currentnumber_Label.text = "\(self.dishesData_Array.count)"

                            self.activityIndicatorView.stopAnimating()  //AIV
                            self.launch = "default"

                        } else {
                            print("Document3 does not exist")

                            self.activityIndicatorView.stopAnimating()  //AIV
                            self.alert(title: "エラー", message: "現在のおかず数の取得に失敗しました5")
                        }
                    }

                    } else {
                        print("Document2 does not exist")

                        self.activityIndicatorView.stopAnimating()  //AIV
                        self.alert(title: "エラー", message: "現在のおかず数の取得に失敗しました4")
                    }
                }

            }
        
        
        
        // Do any additional setup after loading the view.
        
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
        //↓スワイプ 戻る 無効化
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        //戻るボタン 削除
//        self.navigationItem.hidesBackButton = true
    }
    
    
    
    //var. 1.0.3
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if launch != "first" {
            
        self.activityIndicatorView.startAnimating()  //AIV
        
        self.groupUid = UserDefaults.standard.string(forKey: "groupUid") ?? "デフォルト値"
        let docRef3 = self.db.collection("Group").document("\(self.groupUid)")

        docRef3.getDocument { (document, error) in
            if let document = document, document.exists {
                let documentdata3 = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data3: \(documentdata3)")
                
                
                self.dishesData_Array = document.data()!["dishes"] as? Array<Any> ?? []
                
                print("dish_Array: \(self.dishesData_Array)")
                self.dishesDataSecond_Array = self.dishesData_Array as! [[String: Any]]
                
                self.currentnumber_Label.text = "\(self.dishesData_Array.count)"
                
                self.activityIndicatorView.stopAnimating()  //AIV
        
            } else {
                print("Document3 does not exist")
                
                self.activityIndicatorView.stopAnimating()  //AIV
                self.alert(title: "エラー", message: "現在のおかず数の取得に失敗しました3")
            }
        }
        } else {
            print("初めての起動")
        }
        
    }
    //var. 1.0.3
    
    
    
    
//    @IBAction func today_Button() {
//        self.tabBarController?.selectedIndex = 1
//    }
    
    @IBAction func current_Button() {
        self.tabBarController?.selectedIndex = 1
    }
    
    @IBAction func setting_Button() {
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsDataSecond_Array.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellNews")!
        let title = newsDataSecond_Array[indexPath.row]["title"] as! String
        cell.textLabel?.text = "\(title)"
        
        let date = newsDataSecond_Array[indexPath.row]["date"] as! String
        cell.detailTextLabel?.text = "\(date)"
        
        cell.accessoryType = .disclosureIndicator  //cellの横に > が表示されるように設定
        return cell  //cellの戻り値を設定
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        self.activityIndicatorView.startAnimating()  //AIV
        
        let selectedsewsData = newsDataSecond_Array[indexPath.row]
        
        self.activityIndicatorView.stopAnimating()  //AIV
        
        performSegue(withIdentifier: "toDetail", sender: selectedsewsData)
        
}
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            
            let nextVC = segue.destination as! A_1_Home_News_ViewController
            nextVC.selectedNewsData = sender as! [String: Any]
            
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
