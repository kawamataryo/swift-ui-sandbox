//
//  sampleApp.swift
//  sample WatchKit Extension
//
//  Created by 川俣涼 on 2020/11/19.
//

import SwiftUI

@main
struct sampleApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
