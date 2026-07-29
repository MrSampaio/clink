//
//  CreateWidgetsView.swift
//  Clink
//

import SwiftUI
import WidgetKit

struct CreateWidgetsView: View {
    @EnvironmentObject var viewModel: ReminderViewModel
    
    @State private var selectedCardId: UUID?
    
    var body: some View {
        NavigationStack {
            VStack {
                Title(title: "Widgets", subtitle: "Crie widgets personalizados como lembretes!")
                    .padding(16)
                
                Spacer()
                
                GeometryReader { geometry in
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(alignment: .center, spacing: 40) {
                            
                            ForEach(viewModel.reminders) { reminder in
                                WidgetCard(
                                    image: "🐥",
                                    mensagem: reminder.title,
                                    colorBackground: LinearGradient(
                                        colors: [reminder.color, reminder.color.opacity(0.7)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .id(reminder.id)
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
                    .scrollPosition(id: $selectedCardId)
                    .safeAreaPadding(.horizontal, (geometry.size.width - 165) / 2)
                }
                .frame(height: 200)
                .padding(.top, 20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(viewModel.reminders) { reminder in
                            Circle()
                                .fill(selectedCardId == reminder.id ? Color.primary : Color.secondary.opacity(0.3))
                                .frame(width: 8, height: 8)
                                .animation(.easeInOut, value: selectedCardId)
                        }
                    }
                }
                .frame(maxWidth: 150)
                .padding(.top, 16)
                .padding(.bottom, 30)
                
                Spacer()
                
                Button(action: {
                    guard let selectedId = selectedCardId,
                          let selectedReminder = viewModel.reminders.first(where: { $0.id == selectedId }) else { return }
                    
                    if let sharedDefaults = UserDefaults.sharedWidget {
                        sharedDefaults.set(selectedReminder.title, forKey: "widgetTitle")
                        sharedDefaults.set("📌", forKey: "widgetIcon")
                        
                        let colorString = selectedReminder.color.toHex()
                        sharedDefaults.set(colorString, forKey: "widgetColorHex")
                        
                        sharedDefaults.set(selectedReminder.description ?? "", forKey: "widgetDescription")
                        
                        if let date = selectedReminder.dueDate {
                            let formatter = DateFormatter()
                            formatter.dateFormat = "dd/MM, HH:mm"
                            sharedDefaults.set(formatter.string(from: date), forKey: "widgetDate")
                        } else {
                            sharedDefaults.set("", forKey: "widgetDate")
                        }
                    }
                    
                    WidgetCenter.shared.reloadAllTimelines()
                    print("Widget atualizado para: \(selectedReminder.title)")
                    
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
                .opacity(viewModel.reminders.isEmpty ? 0.0 : 1.0)
                .disabled(viewModel.reminders.isEmpty)
                .animation(.easeInOut, value: selectedCardId)
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { WidgetToolBar() }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        selectedCardId = viewModel.reminders.first?.id
                    }
                }
            }
        }
    }
}

extension UserDefaults {
    static let sharedWidget = UserDefaults(suiteName: "group.sampaio.clink.dados")
}

#Preview {
    CreateWidgetsView()
        .environmentObject(ReminderViewModel())
}
