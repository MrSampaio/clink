//
//  SheetEditView.swift
//  Clink
//
//  Created by Vitor Silva Souza on 21/07/26.
//

import SwiftUI

struct SheetEditView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var newTitle = ""
    @State private var notas = ""
    @State private var Date = false

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Título", text: $newTitle)
                    
                    TextField("Escreva uma descrição", text: $notas, axis: .vertical)
                        .lineLimit(3...5)
                }
                
                Section {
                    HStack(spacing: 16) {
                        Image(systemName: "circle")
                            .foregroundColor(.gray)
                            .font(.system(size: 20))
                        
                        Text("Subtarefa 1")
                            .foregroundColor(.primary)
                        
                    }
                        HStack(spacing: 16) {
                            Text("Adicionar subtarefa")
                        }
                        .foregroundColor(.blue)
                }
                
                Section(header: Text("Alerta")) {
                    Toggle(isOn: $Date) {
                        HStack(spacing: 16) {
                            Text("Data")
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                CreateReminderToolBar(
                    actionCancel: { dismiss() },
                    actionConfirm: { dismiss() },
                    disableAdd: newTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                )
            }
        }
    }

}

#Preview {
    SheetEditView()
}
