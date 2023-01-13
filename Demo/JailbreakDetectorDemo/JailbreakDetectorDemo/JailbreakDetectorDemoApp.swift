//
//  JailbreakDetectorDemoApp.swift
//  JailbreakDetectorDemo
//
//  Created by Nobuhiro Takahashi on 2023/01/13.
//

import SwiftUI
import JailbreakDetector

@main
struct JailbreakDetectorDemoApp: App {
    init() {
        print(JailbreakDetector(types: [.url]).isJB)
        print(JailbreakDetector(types: [.url, .file, .sandbox]).isJB)
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
