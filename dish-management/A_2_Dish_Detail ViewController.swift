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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
