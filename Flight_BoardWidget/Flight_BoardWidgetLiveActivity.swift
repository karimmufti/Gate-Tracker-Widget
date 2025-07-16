//
//  Flight_BoardWidgetLiveActivity.swift
//  Flight_BoardWidget
//
//  Created by Karim Mufti on 7/16/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct Flight_BoardWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct Flight_BoardWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: Flight_BoardWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension Flight_BoardWidgetAttributes {
    fileprivate static var preview: Flight_BoardWidgetAttributes {
        Flight_BoardWidgetAttributes(name: "World")
    }
}

extension Flight_BoardWidgetAttributes.ContentState {
    fileprivate static var smiley: Flight_BoardWidgetAttributes.ContentState {
        Flight_BoardWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: Flight_BoardWidgetAttributes.ContentState {
         Flight_BoardWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: Flight_BoardWidgetAttributes.preview) {
   Flight_BoardWidgetLiveActivity()
} contentStates: {
    Flight_BoardWidgetAttributes.ContentState.smiley
    Flight_BoardWidgetAttributes.ContentState.starEyes
}
