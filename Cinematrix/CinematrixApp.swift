//
//  CinematrixApp.swift
//  Cinematrix
//
//  Created by Mateus on 22/03/2024.
//

import SwiftUI

@main
struct CinematrixApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                PopularMovieListView()
                    .environment(\.managedObjectContext, persistenceController.viewContext)
            }
        }
    }
}
