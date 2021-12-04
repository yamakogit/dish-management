//
//  Login_1-1 ViewController.swift
//  dish-management
//
//  Created by 山田航輝 on 2021/11/28.
//

import UIKit

class Login_1_1_ViewController: UIViewController {
    
    // MARK: ★
    
    var mode :Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func adultMode() {
        mode = true
    }
    
    @IBAction func childMode() {
        mode = false
    }
    
    @IBAction func instruction() {
        //MARK: ★navigation遷移
        func pushViewController(_ viewcontroller: UIViewController, animated: Bool) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let viewcontroller = storyboard.instantiateInitialViewController() as? Login_1_2_ViewController else { return }
            
            self.navigationController?.pushViewController(viewcontroller, animated: true)
        }
        //navigation遷移
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
