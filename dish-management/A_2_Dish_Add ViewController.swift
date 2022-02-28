//
//  A_2_Dish_Add ViewController.swift
//  dish-management
//
//  Created by 山田航輝 on 2021/11/28.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class A_2_Dish_Add_ViewController: UIViewController, UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource, UITextViewDelegate {

    @IBOutlet weak var dishname_TF: UITextField!
    @IBOutlet var createdDate_DatePicker: UIDatePicker!
    @IBOutlet var vaildDays_Picker: UIPickerView!
    @IBOutlet weak var position_TF: UITextField!
    @IBOutlet var dishImg_imageView: UIImageView!
    @IBOutlet var memo_textView: UITextView!
    
    @IBOutlet var createdDate_imageView: UIImageView!
    
    var activityIndicatorView = UIActivityIndicatorView()  //AIV
    let createdDate_Formatter = DateFormatter()  //DP
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    var photoNumber = UserDefaults.standard.integer(forKey: "photoNumber")
    
    var dishname: String = ""
    var position: String = ""
    var memoText: String = ""
    var createdDate: String = ""
    var vaildDays: String = ""
    var dishImg: UIImage?
    var dishImgURL: URL?
    
    var userUid: String = ""
    var groupUid: String = ""
    var dishesData_Array: Array<Any> = []
    
    var downloadURL: String?
    var url2: String?
    
    
    
    let vaildDays_Array = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //AIV
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
        
        

        //TF
        dishname_TF.delegate = self
        position_TF.delegate = self
        
        dishname_TF.tag = 0
        position_TF.tag = 1
        
        dishname_TF.addTarget(self, action: #selector(Login_0_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        position_TF.addTarget(self, action: #selector(Login_0_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
     
        
        //DP
        createdDate_DatePicker.maximumDate = NSDate() as Date
        createdDate_DatePicker.center = createdDate_imageView.center
        
        
        //PV
        vaildDays_Picker.delegate = self
        vaildDays_Picker.dataSource = self
        
        
        
        //TV
        let costombar = UIView(frame: CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.size.width), height: 40))
        costombar.backgroundColor = UIColor.secondarySystemBackground
        let commitBtn = UIButton(frame: CGRect(x: (UIScreen.main.bounds.size.width)-50, y: 0, width: 55, height: 40))
        commitBtn.setTitle("完了", for: .normal)
        commitBtn.setTitleColor(UIColor.systemTeal, for: .normal)
        commitBtn.addTarget(self, action: #selector(A_2_Dish_Add_ViewController.onClickCommitButton), for: .touchUpInside)
        costombar.addSubview(commitBtn)
        memo_textView.inputAccessoryView = costombar
        memo_textView.keyboardType = .default
        memo_textView.returnKeyType = .default
        memo_textView.delegate = self
        
        // Do any additional setup after loading the view.
        
        
        Auth.auth().addStateDidChangeListener{ (auth, user) in

            guard let user = user else {
                
                return
            }
            
            self.userUid = user.uid
        
        }
        
    }
    
    
    
    //Alert
    var alertController: UIAlertController!
    
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    
    
    //TF //TFが閉じられた際の処理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //キーボードを閉じる
        return true //戻り値
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.tag == 0 {
        dishname = textField.text!
        print("dishname: \(dishname)")
            
        } else if textField.tag == 1 {
            position = textField.text!
            print("position: \(position)")
            
        }
    }
    
    
    
    //DP
    @IBAction func createdDate_DP_Tapped() {
        createdDate_DatePicker.datePickerMode = UIDatePicker.Mode.date
        createdDate_DatePicker.timeZone = NSTimeZone.local
        createdDate_DatePicker.locale = Locale.current
        createdDate_DatePicker.endEditing(true)
        createdDate_Formatter.dateFormat = "yyyy/MM/dd"
        createdDate = createdDate_Formatter.string(from: createdDate_DatePicker.date)
        print("日時設定: \(createdDate)")
    }
    
    
    
    //PV
    //列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //行・リストの数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return vaildDays_Array.count
    }
    
    //最初の表示
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return vaildDays_Array[row]
    }
    
    //PickerViewのRowが選択されたときの挙動
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            vaildDays = vaildDays_Array[row]
        print(vaildDays)
        }
    
    
    
    @IBAction func addPhoto_Button_Tapped() {

        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            activityIndicatorView.startAnimating()
        let picker = UIImagePickerController()  //IV
            picker.sourceType = .photoLibrary
            picker.delegate = self
            activityIndicatorView.stopAnimating()
            present(picker, animated: true)
            
        }
    }
    
    
    
    //TV  //TVの「完了」Buttonが押された際の処理
    @objc func onClickCommitButton(sender: UIButton) {
        if(memo_textView.isFirstResponder) {
            memo_textView.resignFirstResponder()
            memoText = memo_textView.text
            print("memoText:\(memoText)")
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.memoText = self.memo_textView.text!
            print("memoText: \(self.memoText)")
        }
        return true
    }
    
    
    
    @IBAction func save_Button() {
        
        if dishname == "" {
            alert(title: "惣菜名が\n正しく入力されていません", message: "惣菜名を\nもう一度入れ直してください。")
        } else if position == "" {
            alert(title: "場所が\n正しく入力されていません", message: "場所をもう一度\n入れ直してください。")
        } else if memoText == "" {
            alert(title: "メモが\n正しく入力されていません", message: "メモをもう一度\n入れ直してください。")
        } else if createdDate == "" {
            alert(title: "作成日時が\n正しく選択されていません", message: "作成日時を\nもう一度選択し直してください。")
        } else if vaildDays == "" {
            alert(title: "有効日数が\n正しく選択されていません", message: "作成日時を\nもう一度選択し直してください。")
        } else if downloadURL == "" {
            alert(title: "写真が\n正しく選択されていません", message: "写真を\nもう一度選択し直してください。")
        } else {
        
        activityIndicatorView.startAnimating()
        
        Auth.auth().addStateDidChangeListener{ (auth, user) in

            guard let user = user else {
                
                return
            }
            
            self.userUid = user.uid
            
            
            //Adultusersコレクション内の情報を取得
            let docRef1 = self.db.collection("AdultUsers").document("\(self.userUid)")
            
            docRef1.getDocument { (document, error) in
                if let document = document, document.exists {
                    let documentdata1 = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data1: \(documentdata1)")
                    
                   
                    self.groupUid = document.data()!["groupUid"] as! String
                    print("groupUid: ",self.groupUid)
                    
                    
                    
                    
                    
                    let docRef2 = self.db.collection("Group").document("\(self.groupUid)")

                    docRef2.getDocument { (document, error) in
                        if let document = document, document.exists {
                            let documentdata2 = document.data().map(String.init(describing:)) ?? "nil"
                            print("Document data2: \(documentdata2)")


                            let dictionary: [String: Any] = [
                                "dishname": self.dishname,
                                "createddate": self.createdDate,
                                "vaildDays": self.vaildDays,
                                "position": self.position,
                                "photo": self.downloadURL,
                                "memo": self.memoText
                            ]
                            
                            
                            self.dishesData_Array = document.data()!["dishes"] as? Array<Any> ?? []
                            
                            print("dish_Array: \(self.dishesData_Array)")
                        
                            self.dishesData_Array.append(dictionary)
                            
                            
                            
                            
                            
                    let ref = self.db.collection("Group")
                    
                            ref.document(self.groupUid).updateData(
                                ["dishes" : self.dishesData_Array])
                            
                    { err in
                        if let err = err {
                            //失敗

                        } else {
                            //成功
                            print("succeed")
                            self.activityIndicatorView.stopAnimating()
                            
                            self.alert(title: "保存しました", message: "新たな惣菜を\n保存しました。")
                        }
                    }
                    
                        } else {
                            print("Document does not exist")
                        }
                    }
                    
                    } else {
                        print("Document does not exist")
                    }
                }
                
                
            
            }
            
            
            
            
            
        }
        // Do any addi
            
            
            
                
        
        
           //  ]) //userのuidをgroupコレクションに保存

    
                
            
            
    }
        }
        
        
        
        
        
        
        
        
        
        
        


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */




//IV
extension A_2_Dish_Add_ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //写真を選んだ後に呼ばれる
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        activityIndicatorView.startAnimating()  //AIV
        
        dishImg = info[.originalImage] as! UIImage
        dishImg_imageView.image = dishImg
        print("ここまで正常")
        
        print(photoNumber)
        photoNumber += 1
        print("できました ",photoNumber)
        var photonumberstring: String = "\(photoNumber)"
        
        
        
        let reference = storage.reference()
        let path = "gs://dish-management-new.appspot.com/user/\(userUid)/dishes/photo\(photonumberstring)"
        
        self.url2 = path
        
        let imageRef = reference.child(path)
        
        let url = URL(string: "\(info[.imageURL] as! URL)")
        
        print(url)
        if url == nil {
            print("失敗しました")
        } else {
            print("成功しました")
            
        let uploadTask = imageRef.putFile(from: url!)
        
            
            
            uploadTask.observe(.success) { _ in
                imageRef.downloadURL { url, error in
                    if let url = url {
                        print("ここまできている")
                        
                        let downloadUrlURL = url
                        self.downloadURL = downloadUrlURL.absoluteString
                        
                        print(self.downloadURL as Any)
                        UserDefaults.standard.set(self.photoNumber, forKey: "photoNumber")
                    }
                }
            }
            
            
            
        }
        
        
        activityIndicatorView.stopAnimating()  //AIV
        self.dismiss(animated: true)
        
//        extension UIImageView {
//            func getFileName() -> String? {
//                return self.image?.accessibilityIdentifier
//            }
//        }
        
    }
    
    
    
    //Cancelが押された際
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}

extension UIImage {
    //データサイズを変更する
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}
