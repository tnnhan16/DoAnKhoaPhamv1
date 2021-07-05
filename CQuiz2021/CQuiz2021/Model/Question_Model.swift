//
//  Question_Model.swift
//  CQuiz2021
//
//  Created by cuscsoftware on 6/28/21.
//

import Foundation

struct Question_Model:Decodable{
    var kq:Int
    var Question_List:[Question]
}

struct Question:Decodable{
    var _id: String
    var question_flag:Int
    var question_image:String
    var question_title: String
    var setq_id: String
    var timer_id: String
    
    init(_ _id:String,_ question_flag:Int, _ question_image:String, _ question_title:String, _ setq_id:String, _ timer_id:String) {
        self._id = _id
        self.question_flag = question_flag
        self.question_image = question_image
        self.question_title = question_title
        self.setq_id = setq_id
        self.timer_id = timer_id

    }
}
