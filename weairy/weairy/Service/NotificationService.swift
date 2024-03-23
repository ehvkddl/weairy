//
//  NotificationService.swift
//  weairy
//
//  Created by do hee kim on 2024/03/24.
//

import Foundation
import UserNotifications

protocol NotificationService {
    func saveNotification(isEnalbed: Bool, time: Date)
}

class NotificationServiceImpl: NotificationService {
    
    private let center = UNUserNotificationCenter.current()
    
}

extension NotificationServiceImpl {
    
    func saveNotification(isEnalbed: Bool, time: Date) {
        guard isEnalbed else {
            removeNotification()
            return
        }
        
        center.requestAuthorization(options: [.alert, .sound]) { [weak self] granted, error in
            guard let `self` else { return }
            
            guard granted else { return }
            
            removeNotification()
            registNotification(for: time)
        }
    }
    
    // 알림 등록
    private func registNotification(for time: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Weairy"
        content.body = "오늘의 날씨를 확인해보세요!"
        content.sound = UNNotificationSound.default
        
        var calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.hour = calendar.component(.hour, from: time)
        dateComponents.minute = calendar.component(.minute, from: time)
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )
        
        let request = UNNotificationRequest(
            identifier: Notification.todayWeather.rawValue,
            content: content,
            trigger: trigger
        )
        
        center.add(request) { error in
            guard let error else { return }
            
            print("알림 등록 실패: \(error)")
        }
    }
    
    // 알림 삭제
    private func removeNotification() {
        center.removeAllPendingNotificationRequests()
    }
    
}
