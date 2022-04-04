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
    
    @IBOutlet var addPhoto_Button: UIButton!
    
    @IBOutlet weak var memo_textView_Const: NSLayoutConstraint!  //key
    
    
    //ImageView_角丸設定
    @IBOutlet weak var background_1_OrangeWood_Img: UIImageView!
    @IBOutlet weak var background_2_OrangeWood_Img: UIImageView!
    @IBOutlet weak var add_WhiteWood_Img: UIImageView!
    @IBOutlet weak var name_WhiteWood_Img: UIImageView!
    @IBOutlet weak var date_WhiteWood_Img: UIImageView!
    @IBOutlet weak var vaildDays_WhiteWood_Img: UIImageView!
    @IBOutlet weak var position_WhiteWood_Img: UIImageView!
    @IBOutlet weak var photo_WhiteWood_Img: UIImageView!
    @IBOutlet weak var memo_WhiteWood_Img: UIImageView!
    @IBOutlet weak var save_WhiteWood_Img: UIImageView!
    
    @IBOutlet weak var vaildDays_WhiteSquare_Img: UIImageView!
    
    
    
    var activityIndicatorView = UIActivityIndicatorView()  //AIV
    let createdDate_Formatter = DateFormatter()  //DP
    
    let photoDate_Formatter = DateFormatter()
    var photoDate: String = ""
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    var photoNumber = UserDefaults.standard.integer(forKey: "photoNumber")
    
    var dishname: String = ""
    var position: String = ""
    var memoText: String = ""
    var createdDate: String = ""
    var vaildDays: String = "1"
    var dishImg: UIImage?
    var dishImgURL: URL?
    
    var userUid: String = ""
    var groupUid: String = ""
    var dishesData_Array: Array<Any> = []
    
    var photoStatue: String = ""
    
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
        
        createdDate_Formatter.dateFormat = "yyyy/MM/dd"
        let today = Date()
        createdDate = createdDate_Formatter.string(from: today)
        print("日時デフォルト値: \(createdDate)")
        
        
        
        
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
        
        
        //key
        NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardWillShow),
                                                   name: UIResponder.keyboardWillShowNotification,
                                                   object: nil)
        NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardWillHide),
                                                   name: UIResponder.keyboardWillHideNotification,
                                                   object: nil)
        
        
        //ImageView_角丸
        background_1_OrangeWood_Img.layer.cornerRadius = 10  //角を角丸に設定
        background_1_OrangeWood_Img.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        background_2_OrangeWood_Img.layer.cornerRadius = 10  //角を角丸に設定
        background_2_OrangeWood_Img.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        add_WhiteWood_Img.layer.cornerRadius = 5
        name_WhiteWood_Img.layer.cornerRadius = 5
        date_WhiteWood_Img.layer.cornerRadius = 5
        vaildDays_WhiteWood_Img.layer.cornerRadius = 5
        position_WhiteWood_Img.layer.cornerRadius = 5
        photo_WhiteWood_Img.layer.cornerRadius = 5
        memo_WhiteWood_Img.layer.cornerRadius = 5
        save_WhiteWood_Img.layer.cornerRadius = 28
        
        vaildDays_WhiteSquare_Img.layer.cornerRadius = 5
        
        dishImg_imageView.layer.cornerRadius = 5
        memo_textView.layer.cornerRadius = 5
        
        
        // Do any additional setup after loading the view.
        
//        
//        Auth.auth().addStateDidChangeListener{ (auth, user) in
//
//            guard let user = user else {
//                
//                return
//            }
//            
//            self.userUid = user.uid
//        
//        }
        self.userUid = UserDefaults.standard.string(forKey: "userUid") ?? "デフォルト値"
        
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
    
    
    //key
    @objc private func keyboardWillShow(_ notification: Notification) {

        guard let keyboardHeight = notification.keyboardHeight,
              let keyboardAnimationDuration = notification.keybaordAnimationDuration,
              let KeyboardAnimationCurve = notification.keyboardAnimationCurve
        else { return }

        UIView.animate(withDuration: keyboardAnimationDuration,
                       delay: 0,
                       options: UIView.AnimationOptions(rawValue: KeyboardAnimationCurve)) {
            // アニメーションさせたい実装を行う
            self.memo_textView_Const.constant = keyboardHeight + 5
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let keyboardAnimationDuration = notification.keybaordAnimationDuration,
              let KeyboardAnimationCurve = notification.keyboardAnimationCurve
        else { return }

        UIView.animate(withDuration: keyboardAnimationDuration,
                       delay: 0,
                       options: UIView.AnimationOptions(rawValue: KeyboardAnimationCurve)) {
            self.memo_textView_Const.constant = 124
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

        let alert: UIAlertController = UIAlertController(title: "写真を設定",message: "写真の設定方法を\n選択してください。", preferredStyle: UIAlertController.Style.alert)
        let choosePhotoAction: UIAlertAction = UIAlertAction(title: "フォトライブラリから選択", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            
            self.choosePhoto()
            
        })
        
        let takePhotoAction: UIAlertAction = UIAlertAction(title: "カメラで撮影", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            
            self.takePhoto()
            
        })
        
        let deletePhotoAction: UIAlertAction = UIAlertAction(title: "写真設定を解除", style: UIAlertAction.Style.destructive, handler:{
            (action: UIAlertAction!) -> Void in
            
            self.deletePhoto()
            
        })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:nil)
        
        
        alert.addAction(choosePhotoAction)
        alert.addAction(takePhotoAction)
        alert.addAction(deletePhotoAction)
        alert.addAction(cancelAction)
        
        
        //alertを表示
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //PhotoLibralyの表示
    func choosePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            activityIndicatorView.startAnimating()
        let picker = UIImagePickerController()  //IV
            picker.sourceType = .photoLibrary
            picker.delegate = self
            activityIndicatorView.stopAnimating()
            present(picker, animated: true)
            
        }
    }
    
    func takePhoto() {
        let camera = UIImagePickerController.SourceType.camera
        
        if UIImagePickerController.isSourceTypeAvailable(camera){
            let picker = UIImagePickerController()
            picker.sourceType = camera
            picker.delegate = self
            self.present(picker, animated: true)
        }
    }
    
    func deletePhoto() {
        downloadURL = nil
        dishImg_imageView.image = UIImage(named: "Image_before")!
        addPhoto_Button.setTitle("タップして\n写真を選択してください", for: .normal)
        addPhoto_Button.titleLabel?.textAlignment = NSTextAlignment.center
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
            alert(title: "おかず名が\n正しく入力されていません", message: "おかず名を\nもう一度入れ直してください。")
        } else if position == "" {
            alert(title: "場所が\n正しく入力されていません", message: "場所をもう一度\n入れ直してください。")
        } /*else if memoText == "" {
            alert(title: "メモが\n正しく入力されていません", message: "メモをもう一度\n入れ直してください。")
        }*/ else if createdDate == "" {
            alert(title: "作成日時が\n正しく選択されていません", message: "作成日時を\nもう一度選択し直してください。")
        } /*else if vaildDays == "" {
            alert(title: "有効日数が\n正しく選択されていません", message: "作成日時を\nもう一度選択し直してください。")
        }*/ else if downloadURL == nil {
            
            if photoStatue == "loading" {
                photoStatue = "default"
                alert(title: "写真を保存中", message: "まもなく保存が完了します。\nもう一度、保存ボタンを押してください。")
                
            } else if photoStatue == "error" {
                photoStatue = "default"
                let alert: UIAlertController = UIAlertController(title: "写真の保存に失敗しました",message: "写真の保存に失敗しました。\n戻って再度写真を選択するか、写真なしで保存してください", preferredStyle: UIAlertController.Style.alert)
                let confilmAction: UIAlertAction = UIAlertAction(title: "写真なしで保存", style: UIAlertAction.Style.default, handler:{
                    (action: UIAlertAction!) -> Void in
                    
                    self.saveDish()
                    
                })
                
                let cancelAction: UIAlertAction = UIAlertAction(title: "戻る", style: UIAlertAction.Style.cancel, handler:nil)
                
                alert.addAction(confilmAction)
                alert.addAction(cancelAction)
                
                self.activityIndicatorView.stopAnimating()
                //alertを表示
                self.present(alert, animated: true, completion: nil)
                
            } else {
                
                photoStatue = "default"
                let alert: UIAlertController = UIAlertController(title: "写真なしで保存",message: "写真が選択されていません。\n写真なしで保存しますか？", preferredStyle: UIAlertController.Style.alert)
                let confilmAction: UIAlertAction = UIAlertAction(title: "写真なしで保存", style: UIAlertAction.Style.default, handler:{
                    (action: UIAlertAction!) -> Void in
                    
                    self.saveDish()
                    
                })
                
                let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:nil)
                
                alert.addAction(confilmAction)
                alert.addAction(cancelAction)
                
                self.activityIndicatorView.stopAnimating()
                //alertを表示
                self.present(alert, animated: true, completion: nil)
                
            }
            
            
            
        } else {
            
            saveDish()
            
        }
        // Do any addi
            
    }
    
    
    func saveDish() {
        
        
        activityIndicatorView.startAnimating()
        
        self.groupUid = UserDefaults.standard.string(forKey: "groupUid") ?? "デフォルト値"  //var. 1.0.2
                
                
                
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
                        
                        let alert: UIAlertController = UIAlertController(title: "保存しました",message: "新たなおかずを保存しました。\nおかずリスト一覧へ戻ります。", preferredStyle: UIAlertController.Style.alert)
                        let confilmAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                            (action: UIAlertAction!) -> Void in
                            
                            UserDefaults.standard.set("fromAdd", forKey: "loadStatue")
                            self.navigationController?.popToRootViewController(animated: true)
                            
                        })
                        
                        alert.addAction(confilmAction)
                        
                        //alertを表示
                        self.present(alert, animated: true, completion: nil)
                        
                        
                    }
                }
                
                    } else {
                        print("Document does not exist")
                        
                        self.activityIndicatorView.stopAnimating()
                        self.alert(title: "エラー", message: "おかずの保存に失敗しました")
                        
                    }
                }
        
        
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
        
        photoStatue = "loading"
        
        self.dismiss(animated: true)
        
//        activityIndicatorView.startAnimating()  //AIV
        
        dishImg = info[.originalImage] as! UIImage
        dishImg_imageView.image = dishImg
        addPhoto_Button.setTitle("", for: .normal)
        print("ここまで正常")
        
        let nowtime = Date()
        photoDate_Formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        photoDate = photoDate_Formatter.string(from: nowtime)
        print(photoDate)
        print(photoNumber)
        photoNumber += 1
        print("できました ",photoNumber)
        var photonumberstring: String = "\(photoNumber)"
        
        
        
        let reference = storage.reference()
        let path = "gs://dish-management-new.appspot.com/user/\(userUid)/dishes/photo\(photonumberstring)\(photoDate)"
        
        self.url2 = path
        
        let imageRef = reference.child(path)
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        if let uploadData = self.dishImg?.jpegData(compressionQuality: 0.0){
            imageRef.putData(uploadData, metadata: metaData) {(metadata , error) in
                
                if error != nil {
                    print("ureはこれ3")
                }
                imageRef.downloadURL(completion: {(url, error) in
                    
                    if error != nil {
                        print("urlはこれ\(url)")
                        self.photoStatue = "error"
                    }
                    print("urlはこれ2\(url)")
                    UserDefaults.standard.set(self.photoNumber, forKey: "photoNumber")
                    self.downloadURL = url?.absoluteString
                    print("url取得!!!",self.downloadURL)
                    self.photoStatue = "finish"
                })
            }
        }
        
        
//        let url = URL(string: "\(info[.imageURL] as! URL)")
//
//        print(url)
//        if url == nil {
//            print("失敗しました")
//
//         self.activityIndicatorView.stopAnimating()  //AIV
//
//            alert(title: "エラー", message: "写真の取得に失敗しました。\n再度写真を選択し直してください")
//            print("失敗しました2")
//            UserDefaults.standard.set("error", forKey: "photoStatue")
////            self.dismiss(animated: true)
//
//        } else {
//            print("成功しました")
//
//        let uploadTask = imageRef.putFile(from: url!)
//
//
//
//            uploadTask.observe(.success) { _ in
//                imageRef.downloadURL { url, error in
//                    if let url = url {
//                        print("ここまできている")
//
//                        let downloadUrlURL = url
//                        self.downloadURL = downloadUrlURL.absoluteString
//
//                        print(self.downloadURL as Any)
//                        UserDefaults.standard.set(self.photoNumber, forKey: "photoNumber")
//
//                        print ("これ大事",self.downloadURL)
//                        print("成功しました2")
//                        UserDefaults.standard.set("finish", forKey: "photoStatue")
//                        self.activityIndicatorView.stopAnimating()  //AIV
//                        self.dismiss(animated: true)
//
//                    }
//                }
//            }
//
//
//
//        }
        
        
        
        
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

//extension UIImage {
//    //データサイズを変更する
//    func resized(withPercentage percentage: CGFloat) -> UIImage? {
//        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
//        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
//            _ in draw(in: CGRect(origin: .zero, size: canvas))
//        }
//    }
//}
