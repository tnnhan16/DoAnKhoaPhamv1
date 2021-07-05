//
//  CountDownStartViewController.swift
//  CQuiz2021
//
//  Created by cuscsoftware on 7/3/21.
//

import UIKit

class CountDownStartViewController: UIViewController {

    @IBOutlet weak var viewframe: UIView!
    @IBOutlet weak var lblCountNumberStart: UILabel!
    var txtNumber:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        if txtNumber == "0"{
            txtNumber = "BẮT ĐẦU"
        }
        lblCountNumberStart.text = txtNumber
        viewframe.layer.cornerRadius = viewframe.frame.size.height/2
        self.viewframe.clipsToBounds = true
    }
}
