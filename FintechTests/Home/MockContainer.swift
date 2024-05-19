//
//  MockContainer.swift
//  FintechTests
//
//  Created by Joel Martin Chuco Marrufo on 19/05/24.
//

import Foundation
import SwiftData

@MainActor
var mockContainer: ModelContainer {
    do {
        let container = try ModelContainer(for: Transaction.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        return container
    } catch {
        fatalError("Error al crear el container")
    }
}
