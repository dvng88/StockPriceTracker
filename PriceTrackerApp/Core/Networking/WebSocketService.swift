//
//  WebSocketService.swift
//  PriceTrackerApp
//
//  Created by Devang Shah on 04/03/2026.
//

import Foundation
import Combine

protocol WebSocketServiceProtocol {
    var messagePublisher: AnyPublisher<String, Never> { get }
    var connectionPublisher: AnyPublisher<Bool, Never> { get }

    func connect()
    func disconnect()
    func send(symbol: String, price: Double)
}

class WebSocketService: NSObject, WebSocketServiceProtocol {
    private var session: URLSession?
    private var task: URLSessionWebSocketTask?
    
    private let messageSubject = PassthroughSubject<String, Never>()
    private let connectionSubject = CurrentValueSubject<Bool, Never>(false)

    var messagePublisher: AnyPublisher<String, Never> {
        messageSubject.eraseToAnyPublisher()
    }

    var connectionPublisher: AnyPublisher<Bool, Never> {
        connectionSubject.eraseToAnyPublisher()
    }

    private let baseURL: URL

    init(baseURL: URL) {
        self.baseURL = baseURL
        super.init()
        session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    }

    func connect() {
        task = session?.webSocketTask(with: baseURL)
        task?.resume()
    }

    func disconnect() {
        task?.cancel(with: .goingAway, reason: nil)
        task = nil
    }

    func listen() {
        guard connectionSubject.value else { return }
        task?.receive { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(.string(let msg)):
                self.messageSubject.send(msg)
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
        connectionSubject.send(true)
        listen()
    }

    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("WebSocket Disconnected")
        connectionSubject.send(false)
    }
}
