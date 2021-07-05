//
//  ViewController.swift
//  CQuiz2021
//
//  Created by CuscSoftware on 6/7/21.
//

import UIKit
import SwiftyJSON
import SocketIO

class ViewController: Base_ViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var backgroundGradientView: UIView!
    @IBOutlet weak var imgAvatar: UIImageView!
    var isMale = false
    @IBOutlet weak var imgGender: UIImageView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var imgView: UIView!
    @IBOutlet weak var txtNickName: UITextField!
    @IBOutlet weak var txtPin: UITextField!
    var player_id:String = ""
    
    let sb = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
    }
    
    func design() {
        btnUpload.layer.cornerRadius = btnUpload.frame.height/2
        imgAvatar.layer.cornerRadius = imgAvatar.frame.size.width / 2
    }
    
    @IBAction func selectImage(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true)
    }
    
    @IBAction func selectGender(_ sender: UITapGestureRecognizer) {
        if(isMale == false) {
            imgGender.image = UIImage(named: "checkbox")
            isMale = true
        } else {
            imgGender.image = UIImage(named: "uncheckbox")
            isMale = false
        }
    }
    
    @IBAction func submit(_ sender: Any) {
        if(txtNickName.text == "")
        {
            self.displayAlert(title: "Thông báo", messg: "Vui lòng nhập NickName.")
        } else if (txtPin.text == "") {
            self.displayAlert(title: "Thông báo", messg: "Vui lòng nhập Mã phòng.")
        } else {
            DispatchQueue.main.async {
                let url = URL(string: AppConstant.joinUrl)
                var request = URLRequest(url: url!)
                request.httpMethod = "POST"
                
                var sData = "player_nickname=" + self.txtNickName.text!
                sData += "&setq_pin=" + self.txtPin.text!
                
                let postData = sData.data(using: .utf8)
                request.httpBody = postData
                
                let joiningTask = URLSession.shared.dataTask(with: request, completionHandler: { data , response, error in
                    guard error == nil else { print("error"); return }
                    guard let data = data else { return }
                    do{
                        guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else { return }
                        
                        if( json["result"] as! Int == 1 ){
                            self.player_id = json["player_id"] as! String
                            BaseService.uploadFile(urlStr: AppConstant.uploadAvatarUrl, dataFile: (self.imgAvatar.image?.pngData())!, fileName: "avatar")
                            DispatchQueue.main.async {
                                let nSArray = json["data"] as! NSDictionary
                                var setq_title = nSArray["setq_title"] as! String
                                self.goToPlayerScreen(title:setq_title)
                            }
                        }else{
                            let msg = json["message"] as! String
                            DispatchQueue.main.async {
                                self.displayAlert(title: "Thông báo", messg: msg)
                            }
                        }
                        
                    }catch let error { print(error.localizedDescription) }
                })
                joiningTask.resume()
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage {
            imgAvatar.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }

    func setGradientBackground() {
        let colorBottom  =  UIColor(red: 215.0/255.0, green: 236.0/255.0, blue: 217.0/255.0, alpha: 1.0).cgColor
        let colorMedium = UIColor(red: 246.0/255.0, green: 246.0/255.0, blue: 235.0/255.0, alpha: 1.0).cgColor
        let colorTop = UIColor(red: 245.0/255.0, green: 213.0/255.0, blue: 245.0/255.0, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorMedium, colorBottom]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func goToPlayerScreen(title:String){
        let vc = self.sb.instantiateViewController(withIdentifier: "PlayerStoryboardID") as! Player_ViewController
        vc.txtPin = self.txtPin.text!
        vc.txtTitle = title
        vc.player_id = self.player_id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

