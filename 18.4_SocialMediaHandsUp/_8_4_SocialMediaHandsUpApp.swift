//
//  _8_4_SocialMediaHandsUpApp.swift
//  18.4_SocialMediaHandsUp
//
//  Created by Apple  on 27/02/23.
//

import SwiftUI
import Firebase

@main
struct _8_4_SocialMediaHandsUpApp: App {
    @StateObject var firestoreManager = FirestoreManager()
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(firestoreManager)
        }
    }
}
