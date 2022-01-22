//
//  A_1_Home_Top ViewController.swift
//  dish-management
//
//  Created by 山田航輝 on 2021/11/28.
//

import UIKit

class A_1_Home_Top_ViewController: UIViewController/*, UITableViewDelegate, UITableViewDataSource*/ {
    
    
    
    //エラー
    //Type 'A_2_Dish_List_ViewController' does not conform to protocol 'UITableViewDataSource'
    //下記にあり
    
    
    @IBOutlet var todaynumber_Img: UIImageView!
    @IBOutlet var currentnumber_Img: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*要復活
        tableView.delegate = self
        tableView.dataSource = self
        */
        
        // Do any additional setup after loading the view.
        
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
        //↓スワイプ 戻る 無効化
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        //戻るボタン 削除
//        self.navigationItem.hidesBackButton = true
    }
    
    
    @IBAction func today_Button() {
        self.tabBarController?.selectedIndex = 1
    }
    
    @IBAction func current_Button() {
        self.tabBarController?.selectedIndex = 1
    }
    
    @IBAction func setting_Button() {
        
    }
    
    /*
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     <#code#> // tableViewの記載内容を記入
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     <#code#>
    }
*/
    //要復活
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
