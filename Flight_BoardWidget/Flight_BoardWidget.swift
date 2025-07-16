//
//  Flight_BoardWidget.swift
//  Flight_BoardWidget
//
//  Created by Karim Mufti on 7/16/25.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct Flight_BoardWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image(systemName: "airplane")
                VStack(alignment: .leading){
                    Text("BR251")
                        .foregroundStyle(.white)
                        .font(.system(size:16,weight: .bold))
                        .tracking(2.5)
                    Text("to Dubai")
                        .opacity(0.4)
                }
                Spacer()
            }
            Spacer()
            VStack(alignment: .leading, spacing: -6){
                Text("your gate is")
                    .opacity(0.4)
                    .font(.caption)
                    
                Text("B43")
                    
                    .font(.system(size: 40,weight: .bold))
                Text("Boarding: Group B")
                    .font(.caption)
            }
        }
        .padding(2)
        .foregroundStyle(.white)
    }
}


struct Flight_BoardWidget: Widget {
    let kind: String = "Flight_BoardWidget"

    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            Flight_BoardWidgetEntryView(entry: entry)
    //            .containerBackground(.fill.tertiary, for: .widget)
                .containerBackground(for: .widget){
                    Color(.white)
                        
                    ContainerRelativeShape()
                        .inset(by: 4)
                        .fill(Color.blue)
                }
            
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    Flight_BoardWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
