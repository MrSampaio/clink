//
//  CreateWidgetsView.swift
//  Clink
//
//  Created by Julio Sampaio on 19/07/26.
//

import SwiftUI

struct CreateWidgetsView: View {
    @State private var selectedCard: Int? = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                Title(title: "Widgets", subtitle: "Crie widgets personalizados como lembretes!")
                    .padding(16)
                
                Spacer()
                
                GeometryReader { geometry in
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(alignment: .center, spacing: 40) {
                            
                            Group {
                                WidgetCard(image: "⛈️", mensagem: "Tirar a roupa do varal", colorBackground: .indigoGradient)
                                    .id(0)
                                
                                AddWidgetCard()
                                    .id(1)
                                
                                WidgetCard(image: "⚽️", mensagem: "Futebol hoje", colorBackground: .greenGradient)
                                    .id(2)
                            }
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
                    
                    guard selectedCard == 1 else { return }
                    
                    print ("Adicionar Widget")
                    
                }) {
                    Label("Adicionar Widget", systemImage: "plus.circle.fill")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .buttonStyle(.glassProminent)
                .tint(.blue)
                .padding(.horizontal, 32)
                .padding(.bottom, 20)
                .opacity(selectedCard == 1 ? 0.0 : 1.0)
                .disabled(selectedCard == 1)
                .animation(.easeInOut, value: selectedCard)
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { WidgetToolBar() }
            .onAppear {
                // Atraso para o GeometryReader calcular a tela
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
