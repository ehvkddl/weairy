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
        
        isNotificationEnabled = UserDefaultsHelper.notification.isEnabled
        notificationTime = UserDefaultsHelper.notification.scheduledTime ?? Date()
    }
}

extension NotificationViewModel {
    
    func saveNotification() {
        services.notificationService.saveNotification(
            isEnalbed: isNotificationEnabled,
            time: notificationTime
        )
        
        UserDefaultsHelper.notification.isEnabled = isNotificationEnabled
        UserDefaultsHelper.notification.scheduledTime = isNotificationEnabled ? notificationTime : nil
    }
    
}
