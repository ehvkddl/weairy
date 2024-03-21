//
//  WeairyWidget.swift
//  WeairyWidget
//
//  Created by do hee kim on 2024/03/17.
//

import Combine
import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), weather: .dummyWeather, configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), weather: .dummyWeather, configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let currentDate = Date()
        let errorRefresh = Calendar.current.date(byAdding: .minute, value: 10, to: currentDate)!
        
        guard let weather = await fetchWeather() else {
            let entry = SimpleEntry(date: Date(), weather: nil, configuration: configuration)
            return Timeline(entries: [entry], policy: .after(errorRefresh))
        }
        
        let entry = SimpleEntry(date: currentDate, weather: weather, configuration: .intent)
        guard let nextRefresh = Calendar.current.nextDate(after: currentDate, matching: DateComponents(minute: 0, second: 0), matchingPolicy: .nextTime) else {
            return Timeline(entries: [entry], policy: .after(errorRefresh))
        }
        
        return Timeline(entries: [entry], policy: .after(nextRefresh))
    }
    
    func fetchWeather() async -> Weather? {
        var urlComponents = URLComponents(string: "\(Configurations.baseURL)3.0/onecall?")
        
        let query = [
            "lat": "37.5665851",
            "lon": "126.9782038",
            "appid": Configurations.weatherKey,
            "units": "metric",
            "lang": "kr",
            "exclude": "minutely,alerts"
        ]
        
        query.forEach { urlComponents?.queryItems?.append(URLQueryItem(name: $0.key, value: $0.value)) }
        
        guard let url = urlComponents?.url else {
            return nil
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                return nil
            }
            let decodeData = try JSONDecoder().decode(AllWeatherResponseDTO.self, from: data)
            return decodeData.toModel()
        } catch {
            print(error)
            return nil
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let weather: Weather?
    let configuration: ConfigurationAppIntent
}

struct WeairyWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    
    var entry: Provider.Entry
    
    var body: some View {
        if let weather = entry.weather {
            switch widgetFamily {
            case .systemSmall: SmallWidgetView(entry: entry, current: weather.current)
            case .systemMedium: MediumWidgetView(entry: entry, weather: weather)
            case .systemLarge: LargeWidgetView(entry: entry, weather: weather)
            default: EmptyView()
            }
        } else {
            ErrorView()
        }
    }
}

struct WeairyWidget: Widget {
    let kind: String = "WeairyWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            WeairyWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("일기예보")
        .description("날씨 요정이 특정 위치의 현재 기상 상태와 일기예보를 알려줘요")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
        .contentMarginsDisabled()
    }
    
}

#Preview(as: .systemSmall) {
    WeairyWidget()
} timeline: {
    SimpleEntry(date: .now, weather: .dummyWeather, configuration: .intent)
    SimpleEntry(date: .now, weather: .dummyWeather, configuration: .intent)
}
