//
//  ResultQuestion_Model.swift
//  CQuiz2021
//
//  Created by CuscSoftware on 30/06/2021.
//

import Foundation

struct ResultQuestion_Model:Decodable{
    var kq:Int
    var ResultQuestion_List:[ResultQuestion]
}

struct ResultQuestion:Decodable{
    var player_id: String
    var player_nickname: String
    var point: Int
    var question_id:String
    var setq_id:String
    var index:Int
    
    
    init(_ player_id:String, _ player_nickname:String, _ point:Int, _ question_id:String, _ setq_id:String, _ index:Int) {
        self.player_id = player_id
        self.player_nickname = player_nickname
        self.point = point
        self.question_id = question_id
        self.setq_id = setq_id
        self.index = index
    }
}
