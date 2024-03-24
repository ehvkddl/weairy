//
//  NotificationStatus.swift
//  weairy
//
//  Created by do hee kim on 2024/03/24.
//

import Foundation

struct NotificationStatus: Codable {
    var isEnabled: Bool
    var scheduledTime: Date?
}
