//
//  PlayGame_TableViewCell.swift
//  CQuiz2021
//
//  Created by CuscSoftware on 26/06/2021.
//

import UIKit

class PlayGame_TableViewCell: UITableViewCell  {

    @IBOutlet weak var lblAnswerA: UILabel!
    @IBOutlet weak var lblAnswerB: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
