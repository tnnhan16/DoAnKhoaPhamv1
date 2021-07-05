//
//  Player_Model1.swift
//  CQuiz2021
//
//  Created by cuscsoftware on 6/18/21.
//

import Foundation

struct Player_Model:Decodable{
    var kq:Int
    var Player_List:[Player]
}

struct Player:Decodable{
    var player_nickname: String
    var setq_id:String
    var player_avatar:String
    var player_flag: Int
    
    init(_ player_nickname:String,_ setq_id:String, _ player_avatar:String, _ player_flag:Int) {
        self.player_nickname = player_nickname
        self.setq_id = setq_id
        self.player_avatar = player_avatar
        self.player_flag = player_flag
    }
}

