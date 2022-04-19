//
//  SettingsNavigationView.swift
//  framework-test
//
//  Created by Benjamin Tang on 06/04/2022.
//

import SwiftUI
import PusherSwift

public struct SettingsNavigationRow<Destination: View>: View {
    private var title: String
    private var image: String
    private var destination: Destination
    
    /// A generic settings row which can be customised according to your needs.
    /// - Parameters:
    ///   - title: The title of the row.
    ///   - image: The SF symbol for the row.
    ///   - destination: The view to navigate to, after tapping the row.
    public init(_ title: String, image: String, destination: Destination) {
        self.image = image
        self.title = title
        self.destination = destination
    }
    
    @ObservedObject private var data = MessageModel()

    public var body: some View {
        VStack {
            Text(data.message)
                .padding()
        }
        Button("Disconnect") {
            data.pusher.disconnect()
        }.padding()
        
        NavigationLink(destination: destination) {
            SettingsRow(title, image: image, showDisclosure: true)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

class MessageModel: ObservableObject, PusherDelegate {
    let pusher: Pusher
    @Published var message = "Received Pusher message will show here"
    
    func debugLog(message: String) {
        print(message)
    }

    func changedConnectionState(from old: ConnectionState, to new: ConnectionState) {
        print("State changed from \(old.stringValue()) to \(new.stringValue())")
    }
    
    init() {
        let options = PusherClientOptions(
            // authMethod: .endpoint(authEndpoint: "https://51b3-89-242-85-145.ngrok.io/pusher/auth"),
            host: .cluster("eu")
        )
        
        pusher = Pusher(key: "6a04f84dabb6327de605", options: options)

        pusher.connect()
        // logging part
        pusher.connection.delegate = self
        let channel = pusher.subscribe("my-channel")
        channel.bind(eventName: "pusher:subscription_succeeded", eventCallback: { _ in
            print("Subscribed!")
        })
        channel.bind(eventName: "test", eventCallback: { (event: PusherEvent) -> Void in
            if let data: String = event.data {
                self.message = data
            }
        })
    }
}


public extension View {
  func settingsBackground(cornerRadius: CGFloat = 16,
                          innerPadding: CGFloat = 8,
                          outerPadding: CGFloat = 16) -> some View {
    self
      .padding(.horizontal, 16)
      .padding(.vertical, innerPadding)
      .background(RoundedRectangle(cornerRadius: cornerRadius,
                                   style: .continuous)
                    .fill(Color(.secondarySystemBackground)))
      .padding(outerPadding)
  }
}
