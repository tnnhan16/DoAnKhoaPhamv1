//
//  Answer_Model.swift
//  CQuiz2021
//
//  Created by cuscsoftware on 6/28/21.
//

import Foundation
struct Answer_Model:Decodable{
    var kq:Int
    var Answer_List:[Answer]
}

struct Answer:Decodable{
    var _id: String
    var answer_flag:String
    var answer_title:String
    var question_id: String
    
    init(_ _id:String,_ answer_flag:String, _ answer_title:String, _ question_id:String) {
        self._id = _id
        self.answer_flag = answer_flag
        self.answer_title = answer_title
        self.question_id = question_id
    }
}
