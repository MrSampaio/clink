//
//  SheetCreateList.swift
//  Clink
//
//  Created by Vitor Silva Souza on 27/07/26.
//

import SwiftUI

struct IconAndTitleList: View {
    
    @Binding var listName: String
    
    var selectedIcon: String
    var selectedGradient: LinearGradient
    
    let characterLimit = 20
    
    var body: some View {
        
        HStack(spacing: 16) {
            Image(systemName: selectedIcon)
                .font(.system(size: 40))
                .foregroundColor(.white)
                .frame(width: 82, height: 82)
                .background(selectedGradient)
                .clipShape(Circle())
            
            TextField("Insira o nome da lista", text: $listName)
                .onChange(of: listName) { oldValue, newValue in
                    if newValue.count > characterLimit {
                        listName = String(newValue.prefix(characterLimit))
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color(UIColor.secondarySystemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 28))
        }
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets())
    }
}


struct PresetsList: View {
    @State var presets: Int = 0
    var body: some View {
        
        Section(footer: Text("É possível alterar as predefinições depois que a lista for criada, acessando o menu dentro da lista.")) {
            
            Picker("Predefinições", selection: $presets) {
                Text("Nenhum").tag(0)
            }
        }
    }
}


struct ColorsList:  View {
    
    @Binding var selectedColor: Int
    
    let palette: [LinearGradient]
    let columns = Array(repeating: GridItem(.flexible()), count: 5)
    
    var body: some View {
        
        Section(footer: Text("A cor estabelece uma identidade visual nos lembretes de sua lista.")) {
            Label {
                Text("Escolha uma cor")
            } icon: {
                Image(systemName: "drop.halffull")
                    .foregroundStyle(.gray)
            }
            .listRowSeparator(.hidden)
            
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(palette.indices, id: \.self) { color in
                    Circle()
                        .fill(palette[color])
                        .frame(width: 44, height: 44)
                        .overlay(
                            Circle()
                                .stroke(palette[color], lineWidth: 3)
                                .frame(width: 52, height: 52)
                                .opacity(selectedColor == color ? 1.0 : 0.0)
                        )
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selectedColor = color
                            }
                        }
                }
            }
            .padding(.vertical, 12)
        }
    }
}


struct IconList: View {
    
    @Binding var selectedIcon: String
    
    var selectedGradient: LinearGradient
    
    let icons = [
        // Linha 1
        "list.bullet", "face.smiling.fill", "bookmark.fill", "pin.fill", "gift.fill", "birthday.cake.fill",
        // Linha 2
        "graduationcap.fill", "backpack.fill", "pencil.and.ruler.fill", "doc.fill", "book.fill", "wallet.pass.fill",
        // Linha 3
        "creditcard.fill", "banknote.fill", "dumbbell.fill", "figure.run", "fork.knife", "wineglass.fill",
        // Linha 4
        "pills.fill", "stethoscope", "chair.lounge.fill", "house.fill", "folder.fill", "building.columns.fill",
        // Linha 5
        "tent.fill", "tv.fill", "music.note", "candybarphone", "gamecontroller.fill", "headphones",
        // Linha 6
        "leaf.fill", "carrot.fill", "figure.walk", "person.2.fill", "person.3.fill", "pawprint.fill",
        // Linha 7
        "teddybear.fill", "fish.fill", "basket.fill", "cart.fill", "bag.fill", "shippingbox.fill",
        // Linha 8
        "soccerball", "baseball.fill", "basketball.fill", "football.fill", "tennis.racket", "tram.fill",
        // Linha 9
        "airplane", "sailboat.fill", "car.fill", "umbrella.fill", "sun.max.fill", "moon.fill",
        // Linha 10
        "drop.fill", "snowflake", "flame.fill", "briefcase.fill", "wrench.and.screwdriver.fill", "scissors",
        // Linha 11
        "compass.drawing", "curlybraces", "lightbulb.fill", "message.fill", "shoeprints.fill", "asterisk"
    ]
    let columns = Array(repeating: GridItem(.flexible()), count: 6)
    
    var body: some View {
        
        Section {
            
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(icons, id: \.self) { icon in
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundColor(selectedIcon == icon ? .white : .gray)
                        .frame(width: 44, height: 44)
                        .background(
                            Group {
                                if selectedIcon == icon {
                                    selectedGradient
                                } else {
                                    Color.clear
                                }
                            }
                        )
                        .clipShape(Circle())
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selectedIcon = icon
                            }
                        }
                }
            }
            .padding(.vertical, 12)
        }
        
        
    }
}
