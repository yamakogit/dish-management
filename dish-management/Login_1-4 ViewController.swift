//
//  Login_1-4 ViewController.swift
//  dish-management
//
//  Created by 山田航輝 on 2021/11/28.
//

import UIKit


class Login_1_4_ViewController: UIViewController {

    @IBOutlet var name_Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func gonext() {
        
        
        
        
        //MARK: ★navigation遷移
        //        self.performSegue(withIdentifier: "ここにidentifier書く", sender: nil)
        
    }
    
    @IBAction func cancel() {
        
        
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
