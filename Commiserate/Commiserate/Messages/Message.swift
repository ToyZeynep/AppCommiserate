//
//  Message.swift
//  Commiserate
//
//  Created by Zeynep Toy on 24.03.2024.
//

import Foundation

struct Message: Hashable {
    var id = UUID()
    var fromId: String?
    var toId: String?
    var text: String?
    var timestamp: NSNumber?
}
