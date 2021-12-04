//
//  A_2_Dish_List ViewController.swift
//  dish-management
//
//  Created by 山田航輝 on 2021/11/28.
//

import UIKit

class A_2_Dish_List_ViewController: UIViewController/*, UITableViewDelegate, UITableViewDataSource*/ {
    //エラー
    //Type 'A_2_Dish_List_ViewController' does not conform to protocol 'UITableViewDataSource'
    //下記にあり
    
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet var dish_imageView: UIImageView!
//    @IBOutlet var desh_nameLabel: UILabel!
//    @IBOutlet var daysLeftLabel: UILabel!
//    @IBOutlet var createdDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
/*要復活
        tableView.delegate = self
        tableView.dataSource = self
        */
        
        // Do any additional setup after loading the view.
    }
    
    
     /*要復活
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#> // tableViewの記載内容を記入
    }
      */
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
