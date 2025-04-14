//
//  DatabaseFrontendApp.swift
//  DatabaseFrontend
//
//  Created by Matei Pralea on 22/04/2024.
//

import SwiftUI
import SQLite

@main
struct Main: App {
    var connection: Connection
    init() {
        if !databaseExists() {
            createDatabaseFile()
        }
        let conn = openSQLDatabaseConnection(at: getDatabasePath())
        do {
            _ = try conn.scalar(userTable.exists)
        }
        catch {
            initializeSQLDatabase(conn)
        }
        self.connection = conn
    }

    var body: some Scene {
        WindowGroup {
            WelcomeView(connection: connection)
        }
#if os(macOS)
        .windowStyle(HiddenTitleBarWindowStyle())
#endif


    }
}
