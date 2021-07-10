//
//  ResultQuestionNumberViewController.swift
//  CQuiz2021
//
//  Created by cuscsoftware on 6/28/21.
//

import UIKit
import SocketIO

class ResultQuestionNumberViewController: Base_ViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblTitlePage: UILabel!
    @IBOutlet weak var tbvDanhSachDiem: UITableView!
    @IBOutlet weak var viewBody: UIView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var lblTitleResult: UILabel!
    var isFinish:Bool = false
    var numberQuestion:String = ""
    var maPhong:String = "\(String(UserDefaults.standard.string(forKey: "MaPhong") ?? ""))"
    var resultQuestionArr:[ResultQuestion] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.tbvDanhSachDiem.delegate = self
        self.tbvDanhSachDiem.dataSource = self
        socketPlayGame()
        lblTitlePage.text = "KẾT QUẢ CÂU HỎI SỐ \(numberQuestion)"
        viewBody.layer.cornerRadius = 25
        viewBody.layer.borderColor = UIColor.darkGray.cgColor
        viewBody.layer.borderWidth = 1
        viewBody.layer.masksToBounds = true
        viewTitle.layer.cornerRadius = 25
        let gradient = getGradientLayer(bounds: viewTitle.bounds)
        viewTitle.backgroundColor = gradientColor(bounds: viewTitle.bounds, gradientLayer: gradient)
        viewTitle.layer.masksToBounds = true
        lblTitleResult.textColor = .white
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
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        return gradient
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultQuestionArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tbvDanhSachDiem.dequeueReusableCell(withIdentifier: "ResultQuestionNumberTableViewCell", for: indexPath) as! ResultQuestionNumberTableViewCell
        cell.lblThuHang.isHidden = true
        if(resultQuestionArr[indexPath.row].index == 0) {
            cell.imgMedal.image = UIImage(named: "gold-medal")
        } else if (resultQuestionArr[indexPath.row].index == 1) {
            cell.imgMedal.image = UIImage(named: "silver-medal")
        } else if(resultQuestionArr[indexPath.row].index == 2) {
            cell.imgMedal.image = UIImage(named: "bronze-medal")
        } else if(resultQuestionArr[indexPath.row].index > 2){
            cell.lblThuHang.isHidden = false
            cell.lblThuHang.text = String(resultQuestionArr[indexPath.row].index + 1)
        }
        cell.lblName.text = resultQuestionArr[indexPath.row].player_nickname
        cell.lblDiem.text = String(resultQuestionArr[indexPath.row].point)
        return cell
    }
    func socketPlayGame(){
        let socket = manager.defaultSocket
        manager.config = SocketIOClientConfiguration(
            arrayLiteral: .compress, .connectParams(["data": self.maPhong])
        )
        socket.on("S_SendResultQuestionNumberBroadCast_C") { [self] data, ack in
            self.resultQuestionArr = []
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
                resultQuestionArr.append(resultQuestion)
                index = index + 1
            }
            tbvDanhSachDiem.reloadData()
        }
        
        socket.on("CountDownStart") {data, ack in
            let number = "\(data[0] as! Int)"
            self.showModalCountStartPlayGame(number: number)
        }
        socket.on("SendResultEnd") { [self] data, ack in
            self.resultQuestionArr = []
            let nSArray = data as NSArray
            var index = 0
            for item in (nSArray[0] as! NSArray) {
                let disArray = item as! NSDictionary
                let totalPoint = disArray["totalPoint"] as! Int
                let itemArray = disArray["_id"] as! NSDictionary
                let resultQuestion = ResultQuestion(
                    itemArray["player_id"] as! String,
                    itemArray["player_nickname"] as! String,
                    totalPoint,
                    "",
                    itemArray["setq_id"] as! String,
                    index)
                resultQuestionArr.append(resultQuestion)
                index = index + 1
            }
            lblTitlePage.text = "KẾT QUẢ CHƠI"
            tbvDanhSachDiem.reloadData()
        }

        socket.connect()
    }
    
    @IBAction func onGoToRootAction(_ sender: UIButton) {
        let socket = manager.defaultSocket
        socket.disconnect()
        navigationController?.popToRootViewController(animated: true)
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
