//
//  A_1_Home_News ViewController.swift
//  dish-management
//
//  Created by 山田航輝 on 2022/03/03.
//

import UIKit
import SafariServices

class A_1_Home_News_ViewController: UIViewController, SFSafariViewControllerDelegate {

    @IBOutlet var title_Label: UILabel!
    @IBOutlet var date_Label: UILabel!
    @IBOutlet var content_textView: UITextView!
    @IBOutlet var urlTitle_Label: UILabel!  //var. 1.0.3
    
    @IBOutlet weak var whiteWood: UIImageView!
    
    var activityIndicatorView = UIActivityIndicatorView()  //AIV
    
    
    var selectedNewsData: [String: Any] = [:]
    
    var url: String = ""
    var urlType: String = ""
    
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
        
        let urlTitle = selectedNewsData["urlTitle"] as! String  //var. 1.0.3
        url = selectedNewsData["url"] as! String  //var. 1.0.3
        urlType = selectedNewsData["urlType"] as! String  //var. 1.0.3
        
        title_Label.text = title
        date_Label.text = date
        urlTitle_Label.text = urlTitle  //var. 1.0.3
        
        content_textView.text = content.replacingOccurrences(of: "\\n", with: "\n")
        
        content_textView.isEditable = false
        
        activityIndicatorView.stopAnimating()
        
        
    }
    
    @IBAction func urlButtonTapped_Button() {  //var. 1.0.3
        
        if urlType == "inApp" {
            
            let url = NSURL(string: "\(url)")
            if let url = url {
                let safariViewController = SFSafariViewController(url: url as URL)
                safariViewController.delegate = self
                present(safariViewController, animated: true, completion: nil)
            }
            
        } else if urlType == "Safari" {
            
            let url = URL(string: "\(url)")!
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url)
            }
            
        }
        
    }  //var. 1.0.3
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
