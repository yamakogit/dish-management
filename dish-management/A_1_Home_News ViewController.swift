//
//  A_1_Home_News ViewController.swift
//  dish-management
//
//  Created by 山田航輝 on 2022/03/03.
//

import UIKit

class A_1_Home_News_ViewController: UIViewController {

    @IBOutlet var title_Label: UILabel!
    @IBOutlet var date_Label: UILabel!
    @IBOutlet var content_textView: UITextView!
    
    @IBOutlet weak var whiteWood: UIImageView!
    
    var activityIndicatorView = UIActivityIndicatorView()  //AIV
    
    
    var selectedNewsData: [String: Any] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //AIV
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)

        
        activityIndicatorView.startAnimating()  //AIV
        
        // Do any additional setup after loading the view.
        
        whiteWood.layer.cornerRadius = 10  //角を角丸に設定
        whiteWood.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        let title = selectedNewsData["title"] as! String
        let date = selectedNewsData["date"] as! String
        let content = selectedNewsData["content"] as! String
        
        title_Label.text = title
        date_Label.text = date
        content_textView.text = content.replacingOccurrences(of: "\\n", with: "\n")
        
        content_textView.isEditable = false
        
        activityIndicatorView.stopAnimating()
        
        
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
