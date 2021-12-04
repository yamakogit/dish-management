//
//  A_2_Dish_Add ViewController.swift
//  dish-management
//
//  Created by 山田航輝 on 2021/11/28.
//

import UIKit

class A_2_Dish_Add_ViewController: UIViewController {

    @IBOutlet weak var dishname_TF: UITextField!
    @IBOutlet var createdDate_Picker: UIDatePicker!
    @IBOutlet var vaildDays_Picker: UIPickerView!
    @IBOutlet weak var position_TF: UITextField!
    @IBOutlet var dishImg_imageView: UIImageView!
    @IBOutlet var memo_textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addPhoto_Button() {
        
    }
    
    @IBAction func save_Button() {
        
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
