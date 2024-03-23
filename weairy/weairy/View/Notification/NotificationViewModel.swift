//
//  NotificationViewModel.swift
//  weairy
//
//  Created by do hee kim on 2024/03/24.
//

import Combine
import Foundation

class NotificationViewModel: ObservableObject {
    @Published var isNotificationEnabled: Bool = false
    @Published var notificationTime: Date = Date()
    
    private var services: Service
    private var subscriptions = Set<AnyCancellable>()
    
    init(services: Service) {
        self.services = services
    }
}

extension NotificationViewModel {
    
    func saveNotification() {
        services.notificationService.saveNotification(
            isEnalbed: isNotificationEnabled,
            time: notificationTime
        )
    }
    
}
