//
//  Flight_BoardWidgetBundle.swift
//  Flight_BoardWidget
//
//  Created by Karim Mufti on 7/16/25.
//

import WidgetKit
import SwiftUI

@main
struct Flight_BoardWidgetBundle: WidgetBundle {
    var body: some Widget {
        Flight_BoardWidget()
        Flight_BoardWidgetControl()
        Flight_BoardWidgetLiveActivity()
    }
}
