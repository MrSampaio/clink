//
//  ClinkWidgetBundle.swift
//  ClinkWidget
//
//  Created by Julio Sampaio on 25/07/26.
//

import WidgetKit
import SwiftUI

struct ClinkWidgetBundle: WidgetBundle {
    var body: some Widget {
        ClinkWidget()
        ClinkWidgetControl()
        ClinkWidgetLiveActivity()
    }
}
