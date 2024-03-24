//
//  UserDefaultsHelper.swift
//  weairy
//
//  Created by do hee kim on 2024/03/24.
//

import Foundation

@propertyWrapper
struct UserDefault<T: Codable> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.data(forKey: key),
                  let value = try? JSONDecoder().decode(T.self, from: data) else {
                
                return defaultValue
            }
            
            return value
        }
        set {
            guard let encoded = try? JSONEncoder().encode(newValue) else { return }
            
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}

enum UserDefaultsHelper {
    
    enum Key: String {
        case notification
    }
    
    @UserDefault(key: Key.notification.rawValue,
                 defaultValue: NotificationStatus(isEnabled: false, scheduledTime: nil))
    static var notification
    
}
