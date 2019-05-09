//
//  CanvasViewController.swift
//  Tamago
//
//  Created by Andy Kim on 1/5/19.
//  Copyright © 2019 Hoodles. All rights reserved.
//

import UIKit
import Starscream

class CanvasViewController: UIViewController {
    struct MessageData: Codable {
        var time: Date
        var text: Action
        var author: String
        var color: String
    }
    
    struct Message: Codable {
        var type: String
        var data: MessageData
    }

    @IBOutlet weak var colorOptionTableView: UITableView!
    @IBOutlet weak var canvasView: CanvasView!
    
    let colorOptions: [UIColor] = [UIColor(hexString: "#000000"),
                                   UIColor(hexString: "#007AFF"),
                                   UIColor(hexString: "#4CD964"),
                                   UIColor(hexString: "#5856D6"),
                                   UIColor(hexString: "#FF3B30")]
    var currentColor: UIColor = UIColor(hexString: "#000000") {
        didSet {
            canvasView.color = currentColor
        }
    }
    
    let serveraddress = UserDefaults.standard.string(forKey: "serveraddress_preference") ?? "ws://localhost:1337/"
    var socket: WebSocket!
    let userName = UUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareColorOptionTableView()
        prepareConnection()
        prepareCanvasView()
    }
    
    private func prepareColorOptionTableView() {
        colorOptionTableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        colorOptionTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
        currentColor = colorOptions[0]
    }
    
    private func prepareConnection() {
        socket = WebSocket(url: URL(string: serveraddress)!, protocols: ["sketching"])
        socket.delegate = self
        socket.connect()
    }
    
    private func prepareCanvasView() {
        canvasView.delegate = self
    }
    
    private func sendAction(_ action: Action) {
        let result = Result { try String(data: JSONEncoder().encode(action), encoding: .utf8) }
        if let actionJSON = try? result.get() {
            socket.write(string: actionJSON)
        }
    }
}

extension CanvasViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "colorOptionCell", for: indexPath) as! ColorOptionCell
        cell.color = colorOptions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentColor = colorOptions[indexPath.row]
    }
}

extension CanvasViewController: WebSocketDelegate {
    func websocketDidConnect(socket: WebSocketClient) {
        // TODO: Get user name + device uuid
        socket.write(string: userName)
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        guard let data = text.data(using: .utf16),
            let jsonData = try? JSONSerialization.jsonObject(with: data),
            let jsonDict = jsonData as? [String: Any],
            let messageType = jsonDict["type"] as? String else {
                return
        }
        
        if messageType == "message",
            let jsonData = jsonDict["data"] as? [String: Any],
            let author = jsonData["author"] as? String,
            author != userName,
            let actionJSON = jsonData["text"] as? String,
            let actionData = actionJSON.data(using: .utf16),
            let action = try? JSONDecoder().decode(Action.self, from: actionData)
        {
            canvasView.receivedAction(author, actionType: action)
        }
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("websocketDidReceiveData: \(data)")
    }
}

extension CanvasViewController: CanvasViewDelegate {
    func began(_ point: CGPoint) {
        let param = ActionParameter(point: point, brushWidth: canvasView.brushWidth, opacity: canvasView.opacity, color: canvasView.color)
        sendAction(.begin(param: param))
    }
    
    func move(_ point: CGPoint) {
        sendAction(.move(point: point))
    }
    
    func end(_ point: CGPoint) {
        sendAction(.end(point: point))
    }
}
