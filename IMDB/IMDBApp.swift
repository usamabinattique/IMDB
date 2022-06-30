//
//  IMDBApp.swift
//  IMDB
//
//  Created by Usama on 29/06/2022.
//

import SwiftUI

@main
struct IMDBApp: App {
    
    @UIApplicationDelegateAdaptor var delegate: AppDelegate
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
            
        }
    }
}
