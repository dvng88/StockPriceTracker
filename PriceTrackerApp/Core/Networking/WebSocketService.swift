//
//  WebSocketService.swift
//  PriceTrackerApp
//
//  Created by Devang Shah on 04/03/2026.
//

import Foundation
import Combine

class WebSocketService: NSObject {
    let url = URL(string: "wss://ws.postman-echo.com/raw")


    private var session: URLSession?
    private var task: URLSessionWebSocketTask?
    
    let messagePublisher = PassthroughSubject<String, Never>()

    func connect() {
        session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        task = session?.webSocketTask(with: url!)
        task?.resume()
        listen()
    }

    func disconnect() {
        task?.cancel()
        task = nil
        session = nil
    }

    func listen() {
        task?.receive { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(.string(let msg)):
                print("Success: \(msg)")
                self.messagePublisher.send(msg)
            default:
                break
                
            }
            self.listen()
        }
    }

    func send(symbol: String, price: Double) {
        let message = "\(symbol):\(price)"
        task?.send(.string(message)) { _ in }
    }
}

extension WebSocketService: URLSessionWebSocketDelegate {
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("WebSocket connected")
    }

    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("WebSocket Disconnected")
    }
}
