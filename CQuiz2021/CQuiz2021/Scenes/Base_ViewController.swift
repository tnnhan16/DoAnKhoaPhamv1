//
//  Base_ViewController.swift
//  CQuiz2021
//
//  Created by CuscSoftware on 09/06/2021.
//

import UIKit
import SocketIO

class Base_ViewController: UIViewController {

    let manager = SocketManager(socketURL: URL(string: AppConstant.baseHost)!, config: [.log(true), .compress])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func displayAlert(title:String, messg:String) {
        let alert = UIAlertController(title: title, message: messg, preferredStyle: .alert)
//        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel)
        let okBtn = UIAlertAction(title: "OK", style: .default, handler: nil)
        
//        alert.addAction(cancelBtn)
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }
    
}
