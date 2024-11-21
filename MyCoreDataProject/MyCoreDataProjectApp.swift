//
//  MyCoreDataProjectApp.swift
//  MyCoreDataProject
//
//  Created by Kahina Lounis on 20/11/2024.
//

import SwiftUI

@main
struct MyCoreDataProjectApp: App {
    
    let persistenceController = PersistenceController.shared

        var body: some Scene {
            WindowGroup {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.context)
            }
        }
}
