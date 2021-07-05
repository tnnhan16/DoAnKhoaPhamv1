//
//  ResultQuestionNumberTableViewCell.swift
//  CQuiz2021
//
//  Created by cuscsoftware on 6/28/21.
//

import UIKit

class ResultQuestionNumberTableViewCell: UITableViewCell {

    @IBOutlet weak var imgMedal: UIImageView!
    @IBOutlet weak var lblDiem: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblThuHang: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
