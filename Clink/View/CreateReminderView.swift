//
//  CreateReminderView.swift
//  Clink
//
//  Created by Julio Sampaio on 18/07/26.
//

import SwiftUI

struct CreateReminderView: View {
    @State private var mostrarCriadorDeLembrete = false
    

    var body: some View {
        NavigationStack {
            VStack {
            }
            .navigationTitle("Trabalho")
            .toolbar {
                EditReminderToolBar(displaySheet: $mostrarCriadorDeLembrete)
            }
            .sheet(isPresented: $mostrarCriadorDeLembrete) {
                SheetEditView()
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

#Preview {
    CreateReminderView()
}
