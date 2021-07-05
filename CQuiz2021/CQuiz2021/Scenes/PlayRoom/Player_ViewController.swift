//
//  Player_ViewController.swift
//  CQuiz2021
//
//  Created by cuscsoftware on 6/23/21.
//

import UIKit

class Player_ViewController: Base_ViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbvPlayer: UITableView!
    @IBOutlet weak var lblRoomTitle: UILabel!
    @IBOutlet weak var lblPlayers: UILabel!
    @IBOutlet weak var viewSoNguoiChoi: UIView!
    @IBOutlet weak var viewPhong: UIView!
    
    var playerArr:[Player] = []
    var question:Question?
    var answer:Answer?
    var answerArr:[Answer] = []
    var txtPin:String?
    var txtTitle:String?
    var player_id:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        self.tbvPlayer.delegate = self
        self.tbvPlayer.dataSource = self
        lblRoomTitle.text = self.txtTitle
        viewPhong.layer.cornerRadius = 10
        viewSoNguoiChoi.layer.cornerRadius = 10
        let gradient = getGradientLayer(bounds: lblRoomTitle.bounds)
        lblRoomTitle.textColor = gradientColor(bounds: lblRoomTitle.bounds, gradientLayer: gradient)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.goToConnectServer()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tbvPlayer.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! Player_TableViewCell
        cell.lblNickName.text = playerArr[indexPath.row].player_nickname
        cell.imgAvatar.image = UIImage(named: "user")
        cell.backgroundColor = UIColor(red: 241/255, green: 242/255, blue: 243/255, alpha: 1)
        return cell
    }
    
    // MARK: - Socket
    
    func goToConnectServer(){
        let socket = manager.defaultSocket
        socket.on("connect") { data, ack in
            socket.emit("C_AddGroup_S", ["setq_pin":self.txtPin])
        }
        socket.on("S_SendPlayerList_C") { [self] data, ack in
            self.playerArr = []
            let nSArray = data as NSArray
            for item in (nSArray[0] as! NSArray) {
                let disArray = item as! NSDictionary
                let player =  Player(disArray["player_nickname"] as! String,disArray["setq_id"] as! String,disArray["player_avatar"] as! String,disArray["player_flag"] as! Int)
                playerArr.append(player)
            }
            lblPlayers.text = String(playerArr.count)
            let gradient = getGradientLayer(bounds: lblPlayers.bounds)
            lblPlayers.textColor = gradientColor(bounds: lblPlayers.bounds, gradientLayer: gradient)
            //prevent flickers
            UIView.performWithoutAnimation {
                self.tbvPlayer.reloadData()
                self.tbvPlayer.beginUpdates()
                self.tbvPlayer.endUpdates()
            }
        }
        socket.on("PlayGame") {data, ack in
            self.answerArr.removeAll()
            let nSArray = data as NSArray
                let resultArray = nSArray[0] as! NSArray
                let disArray = resultArray[0] as! NSDictionary
                self.question = Question(disArray["_id"] as! String, disArray["question_flag"] as! Int, disArray["question_image"] as! String, disArray["question_title"] as! String, disArray["setq_id"] as! String, disArray["timer_id"] as! String)
                
            
            for item in (resultArray[1] as! NSArray) {
                let answerArray = item as! NSDictionary
                self.answer = Answer(answerArray["_id"] as! String, String(answerArray["answer_flag"] as! Int), answerArray["answer_title"] as! String, answerArray["question_id"] as! String)
                if self.answer != nil{
                    self.answerArr.append(self.answer!)
                }
            }
            let maxQuestion = resultArray[2] as! Int
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "PLAYGAME") as! PlayGame_ViewController
            vc.question = self.question
            vc.answerArr = self.answerArr
            vc.player_id = self.player_id!
            vc.maxQuestion = maxQuestion
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        socket.on("CountDownStart") {data, ack in
            let number = "\(data[0] as! Int)"
            self.showModalCountStartPlayGame(number: number)
        }
        socket.connect()
    }
    
    func gradientColor(bounds: CGRect, gradientLayer :CAGradientLayer) -> UIColor? {
          UIGraphicsBeginImageContext(gradientLayer.bounds.size)
          gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
          let image = UIGraphicsGetImageFromCurrentImageContext()
          UIGraphicsEndImageContext()
          return UIColor(patternImage: image!)
    }
    
    func getGradientLayer(bounds : CGRect) -> CAGradientLayer{
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor.systemPink.cgColor,UIColor.purple.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradient
    }
    
    func showModalCountStartPlayGame(number:String){
        if self.children.count > 0{
            let viewControllers:[UIViewController] = self.children
            for viewContoller in viewControllers{
                viewContoller.willMove(toParent: nil)
                viewContoller.view.removeFromSuperview()
                viewContoller.removeFromParent()
            }
        }
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let profilePopupVC = storyboard.instantiateViewController(withIdentifier: "CountDownStartViewController") as! CountDownStartViewController
        profilePopupVC.txtNumber = number
        addChild(profilePopupVC)
        profilePopupVC.view.frame = self.view.bounds
        self.view.addSubview(profilePopupVC.view)
        profilePopupVC.didMove(toParent: self)
    }
}

extension UIColor {
    static var random: UIColor {
        srand48(Int(arc4random()))
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
    }
}
