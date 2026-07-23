//
//  ListView.swift
//  Clink
//
//  Created by Julio Sampaio on 19/07/26.
//

import Foundation
import SwiftUI

struct ListView: View {
    @State private var showSheetReminder = false
    var title: String

    var body: some View {
        NavigationStack {
            VStack {
            }
            .navigationTitle("Trabalho")
            .toolbar {
                SelectedListToolBar(displaySheet: $showSheetReminder)
            }
            .sheet(isPresented: $showSheetReminder) {
                SheetEditView()
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

#Preview {
    ListView(title: "exemplo de titulo")
}
