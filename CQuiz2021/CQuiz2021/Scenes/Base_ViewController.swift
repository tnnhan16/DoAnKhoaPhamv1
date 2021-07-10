//
//  Base_ViewController.swift
//  CQuiz2021
//
//  Created by CuscSoftware on 09/06/2021.
//

import UIKit
import SocketIO

class Base_ViewController: UIViewController {

    let manager = SocketManager(socketURL: URL(string: AppConstant.baseHost)!, config: [.log(true), .compress])
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func displayAlert(title:String, messg:String) {
        let alert = UIAlertController(title: title, message: messg, preferredStyle: .alert)
//        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel)
        let okBtn = UIAlertAction(title: "OK", style: .default, handler: nil)
        
//        alert.addAction(cancelBtn)
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }
    
}
//import SocketIO
//
//
//class SocketIOManager: NSObject {
//
//    open class SocketConnection {
//
//        public static let default_ = SocketConnection()
//        let manager: SocketManager
//        private init() {
//            let param:[String:Any] = [:]
//            let route = "YOUR_ROUTE"
//            let socketURL: URL = Utility.URLforRoute(route: route, params: param)! as URL
//            manager = SocketManager(socketURL: socketURL, config: [.log(true), .compress])
//            manager.config = SocketIOClientConfiguration(arrayLiteral: .connectParams(param), .secure(true))
//        }
//    }
//    private func connectSocket(){
//        let socket = SocketConnection.default_.manager.defaultSocket
//        if socket.status != .connected{
//            socket.connect()
//        }
//        socket.on(clientEvent: .connect) {data, ack in
//
//            print(data)
//            print(ack)
//            print("socket connected")
//            self.getFinishAcknowledgement()
//        }
//        socket.on(clientEvent: .disconnect) {data, ack in
//
//        }
//        socket.on("unauthorized") { (data, ack) in
//            print(data)
//            print(ack)
//            print("unauthorized user")
//        }
//    }
//    private func disconnectSocket(){
//        let socket = SocketConnection.default_.manager.defaultSocket
//        socket.disconnect()
//    }
//    private func emitLatLng(){
//        let socket = SocketConnection.default_.manager.defaultSocket
//        if socket.status != .connected{return}
//        let params:[String:Any] = ["lat":"lat","lng":"lng","rideId":"rideId"] as Dictionary
//        print(params)
//        socket.emitWithAck("Acknowledgement", params).timingOut(after: 5) {data in
//            print(data)
//        }
//    }
//    private func emitEndRide(){
//        let socket = SocketConnection.default_.manager.defaultSocket
//        let param:[String:Any] = ["rideId":"rideId"] as Dictionary
//        socket.emitWithAck("Acknowledgement", param).timingOut(after: 5) {data in
//            print(data)
//        }
//    }
//    private func getFinishAcknowledgement(){
//        let socket = SocketConnection.default_.manager.defaultSocket
//        socket.on("Acknowledgement") {data, ack in
//            print(data)
//            socket.disconnect()
//        }
//    }
//}
