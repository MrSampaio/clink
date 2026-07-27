//
//  CreateListView.swift
//  Clink
//
//  Created by Julio Sampaio on 19/07/26.
//

import Foundation
import SwiftUI

struct CreateListView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var listName: String = ""
    @State private var selectedIcon: String = "list.bullet"
    @State private var selectedColor: Int = 0
    
    let palette: [LinearGradient] = [
        .grayGradient, .redGradient, .orangeGradient, .yellowGradient, .greenGradient, .blueGradient, .indigoGradient, .purpleGradient, .pinkGradient, .brownGradient]
    
    var body: some View {
        
        NavigationStack {
            Form {
                IconAndTitleList(
                    listName: $listName,
                    selectedIcon: selectedIcon,
                    selectedGradient: palette[selectedColor % palette.count]
                )
                
                PresetsList()
                
                ColorsList(selectedColor: $selectedColor, palette: palette)
                
                IconList(selectedIcon: $selectedIcon, selectedGradient: palette[selectedColor])
            }
        }
    }
}

#Preview {
    CreateListView()
}
