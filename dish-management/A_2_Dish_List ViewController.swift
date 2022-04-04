//
//  A_2_Dish_List ViewController.swift
//  dish-management
//
//  Created by 山田航輝 on 2021/11/28.
//

import UIKit
import os
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class A_2_Dish_List_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //エラー
    //Type 'A_2_Dish_List_ViewController' does not conform to protocol 'UITableViewDataSource'
    //下記にあり
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var background_WhiteWood_Img: UIImageView!
    
    @IBOutlet weak var charactor_Img: UIImageView!
    @IBOutlet weak var noDish_Label: UILabel!
    
    var activityIndicatorView = UIActivityIndicatorView()  //AIV
    
    var loadStatue: String = ""
    var groupUid: String = ""
    
    var daysLeftLabel_Text: String = ""
    
    var dishesDataSecond_Array: [[String: Any]] = []
    var dishesData_Array: Array<Any> = []
    
    let vaildDate_Formatter = DateFormatter()
    
    var request: UNNotificationRequest!
    
    let storage = Storage.storage()
    let db = Firestore.firestore()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        //AIV
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
        
        background_WhiteWood_Img.layer.cornerRadius = 10  //角を角丸に設定
        background_WhiteWood_Img.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        getList()
        
        
//        let targetDate = Calendar.current.dateComponents(
//                    [.year, .month, .day, .hour, .minute],
//                    from: date2)
//
//        // 直接日時を設定
//                let triggerDate = DateComponents(month:4, day:4, hour:18, minute:28, second: 30)
//                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
//
//                // 通知コンテンツの作成
//                let content = UNMutableNotificationContent()
//                content.title = "Calendar Notification"
//                content.body = "2020/4/26 21:06:10"
//                content.sound = UNNotificationSound.default
//
//                // 通知リクエストの作成
//                request = UNNotificationRequest.init(
//                        identifier: "CalendarNotification",
//                        content: content,
//                        trigger: trigger)
//
//        os_log("setButton")
//
//                // 通知リクエストの登録
//                let center = UNUserNotificationCenter.current()
//                center.add(request)
        
        // Do any additional setup after loading the view.
    }

    

    override func viewWillAppear(_ animated: Bool) {
        
        self.loadStatue = UserDefaults.standard.string(forKey: "loadStatue") ?? "NoData"
        
        if loadStatue == "fromAdd" {
            getList()
            UserDefaults.standard.set("default", forKey: "loadStatue")
        } else if loadStatue == "fromDetail" {
            activityIndicatorView.stopAnimating()
            UserDefaults.standard.set("default", forKey: "loadStatue")
        } else {
            UserDefaults.standard.set("default", forKey: "loadStatue")
        }
    }
    
    
    //Alert
    var alertController: UIAlertController!
    
    //Alert
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.dishesDataSecond_Array.count == 0 {
            let charactor_randomInt: Int = Int.random(in: 1...4)
            self.charactor_Img.image = UIImage(named: "charactor_\(charactor_randomInt)")!
            
            self.charactor_Img.isHidden = false
            self.noDish_Label.isHidden = false
        } else {
            self.charactor_Img.isHidden = true
            self.noDish_Label.isHidden = true
        }
        
        
        return dishesDataSecond_Array.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "List") as! A_2_Dish_List_TableViewCell_VC
        let dishname = dishesDataSecond_Array[indexPath.row]["dishname"] as! String
        cell.dish_nameLabel?.text = "\(dishname)"
        let position = dishesDataSecond_Array[indexPath.row]["position"] as! String
        cell.createdDateLabel?.text = "場所: \(position)"
        
        let vaildDate_String = dishesDataSecond_Array[indexPath.row]["vaildDate"] as? String
        vaildDate_Formatter.dateFormat = "yyyy/MM/dd"
        
        if vaildDate_String == nil {
            
            let vaildDays = dishesDataSecond_Array[indexPath.row]["vaildDays"] as! String
            cell.daysLeftLabel?.text = "\(vaildDays)日間有効"
            print("nilである")
            
        } else {
            
            let vaildDate_DateType = vaildDate_Formatter.date(from: vaildDate_String!)!
        print(vaildDate_DateType)
        
        let today = Date()
        let today_String = vaildDate_Formatter.string(from: today)
        let today_DateType = vaildDate_Formatter.date(from: today_String)!
        
        let elapsedDays = Calendar.current.dateComponents([.day], from: today_DateType, to: vaildDate_DateType).day!
            
        print("vaildDate_String: ",vaildDate_String)
        print("today_DateType: ",today_DateType)
        print("vaildDate_DateType: ",vaildDate_DateType)
            
            let dishID = dishesDataSecond_Array[indexPath.row]["dishID"] as? String
            
            var targetDate = Calendar.current.dateComponents(
                [.year, .month, .day, .hour, .minute],
                        from: vaildDate_DateType)
//            targetDate.hour = 23
//            targetDate.minute = 00
//            targetDate.second = 00
            // 直接日時を設定
//                    let triggerDate = DateComponents(hour:18, minute:28, second: 30)
                    let trigger = UNCalendarNotificationTrigger(dateMatching: targetDate, repeats: false)
                    
                    // 通知コンテンツの作成
                    let content = UNMutableNotificationContent()
                    content.title = "「\(dishname)」は今日が期限です"
                    content.body = "タップして詳細を確認してください。"
                    content.sound = UNNotificationSound.default
             
                    // 通知リクエストの作成
                    request = UNNotificationRequest.init(
                            identifier: "\(dishID)",
                            content: content,
                            trigger: trigger)
            
                    os_log("setButton")
             
                    // 通知リクエストの登録
                    let center = UNUserNotificationCenter.current()
                    center.add(request)
            
            
            
            if elapsedDays == 1 {
                //明日まで
                daysLeftLabel_Text = "明日まで"
                
            } else if elapsedDays == 0 {
                //今日まで
                daysLeftLabel_Text = "今日まで"
                
            } else if elapsedDays <= 0 {
                //期限超過
                daysLeftLabel_Text = "期限超過"
                cell.daysLeftLabel?.textColor = UIColor.systemPurple
                
            } else {
                let elapsedDays_String = String(elapsedDays)
                daysLeftLabel_Text = "あと\(elapsedDays_String)日"
            }
            
            cell.daysLeftLabel?.text = daysLeftLabel_Text
            
            }
        
        let photourl1 = dishesDataSecond_Array[indexPath.row]["photo"]
        
        
        if photourl1 is NSNull == true {
            cell.dish_imageView.image = UIImage(named: "Image_before")!
        } else {
            let photourl = dishesDataSecond_Array[indexPath.row]["photo"] as! String
        let imageUrl:URL = URL(string:photourl)!
                // URL型からData型に変換
                let imageData:Data = try! Data(contentsOf: imageUrl)
        
                // 画像をセットする
            cell.dish_imageView.image = UIImage(data: imageData)!
            
        }
        cell.dish_imageView.layer.cornerRadius = 5  //角を角丸に設定
        
        
        
//        cell.accessoryType = .disclosureIndicator  //cellの横に > が表示されるように設定
        return cell  //cellの戻り値を設定
    }
    
    //var. 1.0.2
    func getList() {
        
        activityIndicatorView.startAnimating()  //AIV
        
                    self.groupUid = UserDefaults.standard.string(forKey: "groupUid") ?? "デフォルト値"  //var. 1.0.2
                    
                    let docRef2 = self.db.collection("Group").document("\(self.groupUid)")

                    docRef2.getDocument { (document, error) in
                        if let document = document, document.exists {
                            let documentdata2 = document.data().map(String.init(describing:)) ?? "nil"
                            print("Document data2: \(documentdata2)")
                            
                            
                            self.dishesData_Array = document.data()!["dishes"] as? Array<Any> ?? []
                            
                            print("dish_Array: \(self.dishesData_Array)")
                            self.dishesDataSecond_Array = self.dishesData_Array as! [[String: Any]]
                            self.tableView.reloadData()
                            
                            
                            
                            
                            self.activityIndicatorView.stopAnimating()  //AIV
                    
                        } else {
                            print("Document does not exist")
                            
                            self.activityIndicatorView.stopAnimating()  //AIV
                            self.alert(title: "エラー", message: "おかず一覧を取得できませんでした")
                            
                        }
                    }
        
    }
    
    
    //S_infoボタン(accessoryButton)タップ時の挙動
    /*
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        self.activityIndicatorView.startAnimating()  //AIV
        
        let selectedDishesData = dishesDataSecond_Array[indexPath.row]
        
        performSegue(withIdentifier: "toDetail", sender: selectedDishesData)
        
}
     */
    //E_infoボタン(accessoryButton)タップ時の挙動
    
    //S_セルタップ時の挙動
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.activityIndicatorView.startAnimating()  //AIV
        
        let selectedDishesData = dishesDataSecond_Array[indexPath.row]
        
        performSegue(withIdentifier: "toDetail", sender: selectedDishesData)
        
}
    //E_セルタップ時の挙動
    
    
    //セル削除機能↓
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            activityIndicatorView.startAnimating()
            
            dishesDataSecond_Array.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
            
            let ref = self.db.collection("Group")
            
                    ref.document(self.groupUid).updateData(
                        ["dishes" : self.dishesDataSecond_Array])
            
            { err in
                if let err = err {
                    //失敗
                    
                    self.activityIndicatorView.stopAnimating()
                    self.alert(title: "エラー", message: "おかずの削除に失敗しました。")
                    print("削除失敗")
                } else {
                    //成功
                    self.activityIndicatorView.stopAnimating()
                    print("削除成功")
                    
                }
            }
            
            
            
            tableView.reloadData()  //tableViewを読み込み直している
        }
        
    }
    //セル削除機能↑
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            
            let nextVC = segue.destination as! A_2_Dish_Detail_ViewController
            nextVC.selectedDishesData = sender as! [String: Any]
            
        }
    }
    
    
    @IBAction func addDishButton() {
        self.performSegue(withIdentifier: "go-A2DA", sender: nil)
    }
    
    @IBAction func reloadList() {
        getList()
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
