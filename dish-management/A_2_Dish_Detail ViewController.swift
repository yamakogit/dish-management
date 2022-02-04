//
//  A_2_Dish_Detail ViewController.swift
//  dish-management
//
//  Created by 山田航輝 on 2021/11/28.
//

import UIKit

class A_2_Dish_Detail_ViewController: UIViewController {

    @IBOutlet var dish_nameLabel: UILabel!
    @IBOutlet var dishImg_imageView: UIImageView!
    @IBOutlet var createDateLabel: UILabel!
    @IBOutlet var daysLeftLabel: UILabel!
    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var memo_textView: UITextView!
    
    var selectedDishesData: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let dishname = selectedDishesData["dishname"] as! String
        let createddate = selectedDishesData["createddate"] as! String
        let vaildDays = selectedDishesData["vaildDays"] as! String
        let position = selectedDishesData["position"] as! String
        let photo = selectedDishesData["photo"] as! String
        let memo = selectedDishesData["memo"] as! String
        
        dish_nameLabel.text = dishname
        createDateLabel.text = createddate
        daysLeftLabel.text = vaildDays
        positionLabel.text = position
        memo_textView.text = memo
        
    }
    
    
    
    @IBAction func edit_Button() {
        
    }
    
    @IBAction func trash_Button() {
        
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
