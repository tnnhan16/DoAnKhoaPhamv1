//
//  PlayGame_ViewController.swift
//  CQuiz2021
//
//  Created by CuscSoftware on 23/06/2021.
//

import UIKit
import SocketIO

class PlayGame_ViewController: Base_ViewController {

    @IBOutlet weak var btnTraLoi: UIButton!
    @IBOutlet weak var txtCauHoi: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var lblQuestionD: UILabel!
    @IBOutlet weak var lblQuestionC: UILabel!
    @IBOutlet weak var lblQuestionB: UILabel!
    @IBOutlet weak var lblQuestionA: UILabel!
    @IBOutlet weak var imageA: UIImageView!
    @IBOutlet weak var imageD: UIImageView!
    @IBOutlet weak var imageB: UIImageView!
    @IBOutlet weak var imageC: UIImageView!
    @IBOutlet weak var heightConstraintsImage: NSLayoutConstraint!
    
    var question:Question?
    var answerArr:[Answer] = []
    var time:Int = 0
    var dapAnChon:Int = 0
    var player_id:String = ""
    var isAnwser:Bool = false
    var  maxQuestion:Int?
    var maPhong:String = "\(String(UserDefaults.standard.string(forKey: "MaPhong") ?? ""))" 
    
    override func viewDidLoad() {
        navigationController?.navigationBar.isHidden = false
        super.viewDidLoad()
        lblQuestionD.layer.cornerRadius = 10
        lblQuestionD.layer.masksToBounds = true
        lblQuestionC.layer.cornerRadius = 10
        lblQuestionC.layer.masksToBounds = true
        lblQuestionB.layer.cornerRadius = 10
        lblQuestionB.layer.masksToBounds = true
        lblQuestionA.layer.cornerRadius = 10
        lblQuestionA.layer.masksToBounds = true
        btnTraLoi.layer.cornerRadius = 10
        imageA.isHidden = true
        imageB.isHidden = true
        imageC.isHidden = true
        imageD.isHidden = true
        design()
        UserDefaults.standard.set("Chua", forKey: "DaTraLoi")
        socketPlayGame()
    }
    
    func design(){
        self.txtCauHoi.text = question?.question_title
//        var url = URL(string: AppConstant.getUrlImageQuestionUrl + "1622778560765-6A4F09FC-5D74-4B9A-B089-5F00704FDEFA.jpg")
//        do{
//            var data = try Data(contentsOf: url!)
//            self.image.image = UIImage(data: data)
//        }catch{
//
//        }
        self.lblQuestionA.text = answerArr[0].answer_title
        self.lblQuestionB.text = answerArr[1].answer_title
        self.lblQuestionC.text = answerArr[2].answer_title
        self.lblQuestionD.text = answerArr[3].answer_title
        self.btnTraLoi.isHidden = true
    }
    
    @IBAction func tapA(_ sender: UITapGestureRecognizer) {
        imageA.isHidden = false
        imageB.isHidden = true
        imageC.isHidden = true
        imageD.isHidden = true
        self.btnTraLoi.isHidden = false
        self.dapAnChon = 0
    }
    
    @IBAction func tapB(_ sender: UITapGestureRecognizer) {
        imageA.isHidden = true
        imageB.isHidden = false
        imageC.isHidden = true
        imageD.isHidden = true
        self.btnTraLoi.isHidden = false
        self.dapAnChon = 1
    }
    
    @IBAction func tapC(_ sender: UITapGestureRecognizer) {
        imageA.isHidden = true
        imageB.isHidden = true
        imageC.isHidden = false
        imageD.isHidden = true
        self.btnTraLoi.isHidden = false
        self.dapAnChon = 2
    }
    
    @IBAction func tapD(_ sender: UITapGestureRecognizer) {
        imageA.isHidden = true
        imageB.isHidden = true
        imageC.isHidden = true
        imageD.isHidden = false
        self.btnTraLoi.isHidden = false
        self.dapAnChon = 3
    }
    
    
    @IBAction func onAnswerAction(_ sender: UIButton) {
        let answer = self.answerArr[self.dapAnChon].answer_flag == "1" ? true : false
        let socket = manager.defaultSocket
        manager.config = SocketIOClientConfiguration(
            arrayLiteral: .compress, .connectParams(["data": self.maPhong])
        )
        UserDefaults.standard.set("Xong", forKey: "DaTraLoi")
        socket.emit("ResultQuestionNumber", ["player_id":self.player_id,
                                             "question_id":self.answerArr[self.dapAnChon].question_id,
                                             "setq_id":self.question?.setq_id,
                                             "answer_flag":answer,
                                             "point":self.time,
                    "setq_pin": self.maPhong])
        self.btnTraLoi.isHidden = true
        isAnwser = true
    }
    // MARK: - Socket
    
    func socketPlayGame(){
        let socket = manager.defaultSocket
        manager.config = SocketIOClientConfiguration(
            arrayLiteral: .compress, .connectParams(["data": self.maPhong])
        )
        socket.on("S_SendResultQuestionNumber_C") { [self] data, ack in
            var resultArr:[ResultQuestion] = []
            let nSArray = data as NSArray
            var index = 0
            for item in (nSArray[0] as! NSArray) {
                let disArray = item as! NSDictionary
                let resultQuestion = ResultQuestion(
                    disArray["player_id"] as! String,
                    disArray["player_nickname"] as! String,
                    disArray["point"] as! Int,
                    disArray["question_id"] as! String,
                    disArray["setq_id"] as! String,
                    index)
                resultArr.append(resultQuestion)
                index = index + 1
            }
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "ResultQuestionNumberViewController") as! ResultQuestionNumberViewController
            vc.resultQuestionArr = resultArr
            vc.numberQuestion = "\(String(self.question!.question_flag + 1))"
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        socket.on("CountDownQuestion") {data, ack in
            let string = "\(data[0] as! Int)"
            let attributes = [NSAttributedString.Key.foregroundColor : UIColor.blue]
            let attributedString = NSAttributedString(string: string, attributes: attributes)
            self.title = "BẠN CÒN \(attributedString.string) GIÂY TRẢ LỜI"
            self.time = data[0] as! Int
        }
        socket.on("FinishQuestionNumber") {data, ack in
            let txtMessage = "\(data[0] as! String)"
            self.title = txtMessage
            print("isAnwser: \(self.isAnwser)")
            var traloi:String = "\(String(UserDefaults.standard.string(forKey: "DaTraLoi") ?? ""))"
            if traloi != "Xong" {
                socket.emit("ResultQuestionNumber", ["player_id":self.player_id,
                                                 "question_id":self.question?._id ?? "",
                                                 "setq_id":self.question?.setq_id ?? "",
                                                 "answer_flag":false,
                                                 "point":0,
                                                 "setq_pin": self.maPhong])
                
            }
            self.btnTraLoi.isHidden = true
        }
        socket.connect()
    }
}
