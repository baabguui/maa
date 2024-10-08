//
//  maaApp.swift
//  maa
//
//  Created by baabguui on 8/16/24.
//

import FirebaseCore
import SwiftData
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct YourApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var modelContainer: ModelContainer = {
        let schema = Schema([Todo.self, Hero.self])
        let modelConfiguration = ModelConfiguration(isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    @State var mapleAPI = MapleAPI()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MaaView(mapleAPI: mapleAPI)
                    .modelContainer(modelContainer)
                    .environment(mapleAPI)
            }
        }
    }
}

