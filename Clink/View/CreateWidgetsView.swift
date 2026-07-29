//
//  CreateWidgetsView.swift
//  Clink
//

import SwiftUI
import WidgetKit

struct CreateWidgetsView: View {
    @EnvironmentObject var viewModel: ReminderViewModel
    @State private var showWidgetInstructions = false
    
    @State private var selectedIndex: Int?
    @State private var searchText = ""
    
    let loopMultiplier = 100
    
    var filteredReminders: [Reminder] {
        if searchText.isEmpty {
            return viewModel.reminders
        } else {
            return viewModel.reminders.filter { reminder in
                reminder.title.localizedCaseInsensitiveContains(searchText) ||
                (reminder.description?.localizedCaseInsensitiveContains(searchText) == true)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Title(title: "Widgets", subtitle: "Crie widgets personalizados como lembretes!")
                    .padding(16)
                
                Spacer()
                
                if filteredReminders.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 40))
                            .foregroundColor(.gray)
                        Text("Nenhum lembrete encontrado.")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    .frame(height: 200)
                    .padding(.top, 20)
                } else {
                    GeometryReader { geometry in
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            HStack(alignment: .center, spacing: 40) {
                                
                                let totalItems = filteredReminders.count * loopMultiplier
                                
                                ForEach(0..<totalItems, id: \.self) { index in
                                    
                                    let reminder = filteredReminders[index % filteredReminders.count]
                                    let listIcon = viewModel.customLists.first(where: { $0.id == reminder.listId })?.icon ?? "list.bullet"
                                    
                                    WidgetCard(
                                        image: listIcon,
                                        mensagem: reminder.title,
                                        colorBackground: LinearGradient(
                                            colors: [reminder.color, reminder.color.opacity(0.7)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .id(index)
                                    .scrollTransition(.interactive, axis: .horizontal) { content, phase in
                                        content
                                            .scaleEffect(phase.isIdentity ? 1.0 : 0.85)
                                            .opacity(phase.isIdentity ? 1.0 : 0.5)
                                    }
                                }
                                
                            }
                            .scrollTargetLayout()
                        }
                        .scrollTargetBehavior(.viewAligned)
                        .scrollPosition(id: $selectedIndex)
                        .safeAreaPadding(.horizontal, (geometry.size.width - 165) / 2)
                    }
                    .frame(height: 200)
                    .padding(.top, 20)
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        let safeCount = filteredReminders.isEmpty ? 1 : filteredReminders.count
                        let currentRealIndex = (selectedIndex ?? 0) % safeCount
                        
                        ForEach(0..<filteredReminders.count, id: \.self) { i in
                            Circle()
                                .fill(currentRealIndex == i ? Color.primary : Color.secondary.opacity(0.3))
                                .frame(width: 8, height: 8)
                                .animation(.easeInOut, value: selectedIndex)
                        }
                    }
                }
                .frame(maxWidth: 150)
                .padding(.top, 16)
                .padding(.bottom, 30)
                
                Spacer()
                
                Button(action: {
                    showWidgetInstructions = true
                }) {
                    Label("Como adicionar à Tela Inicial?", systemImage: "questionmark.circle.fill")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .buttonStyle(.glassProminent)
                .tint(.blue)
                .padding(.horizontal, 32)
                .padding(.bottom, 20)
                .opacity(viewModel.reminders.isEmpty ? 0.0 : 1.0)
                .disabled(viewModel.reminders.isEmpty)
                .animation(.easeInOut, value: selectedIndex)
            }
            .background(Color(.background))
            .navigationBarTitleDisplayMode(.inline)
//            .toolbar { WidgetToolBar() }
            //.searchable(text: $searchText, prompt: "Buscar lembretes")
            .onChange(of: searchText) { _ in
                 centerCarousel()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    centerCarousel()
                }
            }
            .sheet(isPresented: $showWidgetInstructions) {
                WidgetInstructionsSheet()
            }
        }
    }
    
    private func centerCarousel() {
        guard !filteredReminders.isEmpty else { return }
        
        let middleIndex = (loopMultiplier / 2) * filteredReminders.count
        
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            selectedIndex = middleIndex
        }
    }
}

// MARK: - Tela de Instruções
struct WidgetInstructionsSheet: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Como usar os Widgets?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                    
                    InstructionStepView(icon: "1.circle.fill", text: "Vá para a Tela Inicial do seu iPhone.")
                    InstructionStepView(icon: "2.circle.fill", text: "Pressione e segure em qualquer espaço vazio até os apps tremerem.")
                    InstructionStepView(icon: "3.circle.fill", text: "Toque no botão '+' no canto superior da tela e busque por 'Clink'.")
                    InstructionStepView(icon: "4.circle.fill", text: "Adicione o widget. Depois, segure nele para escolher qual lembrete exibir!")
                    
                    Spacer(minLength: 30)
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Entendi!")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .background(Color.blue)
                    .cornerRadius(14)
                }
                .padding(30)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
}

struct InstructionStepView: View {
    var icon: String
    var text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 28)
            
            Text(text)
                .font(.body)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
        }
    }
}

#Preview {
    CreateWidgetsView()
        .environmentObject(ReminderViewModel())
}
