//
//  MyOrderKunal2App.swift
//  MyOrderKunal2
//
//  Created by Kunal Bajaj on 2024-10-11.
//

import SwiftUI

@main
struct MyOrderKunal2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
