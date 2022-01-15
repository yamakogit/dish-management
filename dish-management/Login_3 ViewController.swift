//
//  Login_3 ViewController.swift
//  dish-management
//
//  Created by 山田航輝 on 2021/11/28.
//

import UIKit

class Login_3_ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goInstruction_Button() {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AdultVC") as! A_1_Home_Top_ViewController
        self.present(nextVC, animated: true, completion: nil)
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
