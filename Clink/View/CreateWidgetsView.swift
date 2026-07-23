//
//  CreateWidgetsView.swift
//  Clink
//
//  Created by Julio Sampaio on 19/07/26.
//

import Foundation
import SwiftUI

struct CreateWidgetsView: View {
    @State private var selectedCard: Int? = 0
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 18) {
                
                Spacer()
                
                GeometryReader { geometry in
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(alignment: .center, spacing: 40) {
                            WidgetCard(image: "⛈️", mensagem: "Tirar a roupa", colorBackground: Color.indigo)
                                .id(0)
                                .scrollTransition(.interactive, axis: .horizontal) { content, phase in
                                    content
                                        .scaleEffect(phase.isIdentity ? 1.0 : 0.85)
                                        .opacity(phase.isIdentity ? 1.0 : 0.5)
                                }
                            
                            AddWidgetCard()
                                .id(1)
                                .scrollTransition(.interactive, axis: .horizontal) { content, phase in
                                    content
                                        .scaleEffect(phase.isIdentity ? 1.0 : 0.85)
                                        .opacity(phase.isIdentity ? 1.0 : 0.5)
                                }
                            
                            
                            WidgetCard(image: "⚽️", mensagem: "Futebol hoje", colorBackground: Color.green)
                                .id(2)
                                .scrollTransition(.interactive, axis: .horizontal) { content, phase in
                                    content
                                        .scaleEffect(phase.isIdentity ? 1.0 : 0.85)
                                        .opacity(phase.isIdentity ? 1.0 : 0.5)
                                }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .scrollPosition(id: $selectedCard)
                    .safeAreaPadding(.horizontal, (geometry.size.width - 165) / 2)
                }
                .frame(height: 200)
                .padding(.top, 20)
                
                HStack(spacing: 8) {
                    ForEach(0..<3) { index in
                        Circle()
                            .fill(selectedCard == index ? Color.primary : Color.secondary.opacity(0.3))
                            .frame(width: 8, height: 8)
                            .animation(.easeInOut, value: selectedCard)
                    }
                }
                .padding(.top, 16)
                .padding(.bottom, 30)
                
                Spacer()
                
                Button(action: {
                }) {
                    Text(selectedCard == 1 ? "Criar Novo Widget" : "+ Adicionar Widget")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .clipShape(Capsule())
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 20)
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { WidgetToolBar() }
            .onAppear {
                //Atraso o GeometryReader calcular a tela
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        selectedCard = 1
                    }
                }
            }
        }
    }
}

#Preview {
    CreateWidgetsView()
}
