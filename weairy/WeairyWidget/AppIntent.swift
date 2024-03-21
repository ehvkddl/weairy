//
//  AppIntent.swift
//  WeairyWidget
//
//  Created by do hee kim on 2024/03/17.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "일기예보"
    static var description = IntentDescription("날씨 요정이 특정 위치의 현재 기상 상태와 일기예보를 알려줘요")
}

extension ConfigurationAppIntent {
    static var intent: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        return intent
    }
}
