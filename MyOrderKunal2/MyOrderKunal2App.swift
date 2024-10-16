//
//  MyOrderKunal2App.swift
//  MyOrderKunal2
//
//  Created by Kunal Bajaj on 2024-10-11.
//
//Kunal Bajaj 991648986


import SwiftUI

@main
struct MyOrderKunal2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
