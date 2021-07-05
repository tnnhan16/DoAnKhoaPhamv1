//
//  Player_TableViewCell.swift
//  CQuiz2021
//
//  Created by cuscsoftware on 6/21/21.
//

import UIKit

class Player_TableViewCell: UITableViewCell {

    @IBOutlet weak var viewPlayerCell: UIView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblNickName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
