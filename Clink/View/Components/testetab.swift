import Foundation
import SwiftUI

// MARK: Tab Items
enum CustomTab: String, CaseIterable {
    case home = "Home"
    case discover = "Descobrir"
    case profile = "Perfil"
    
    var icone: String {
        switch self {
        case .home:
            return "house"
        case .discover:
            return "magnifyingglass"
        case .profile:
            return "person.crop.circle"
        }
    }
    
    var acaoIcone: String {
        switch self {
        case .home:
            return "house.fill"
        case .discover:
            return "magnifyingglass.circlepath.fill"
        case .profile:
            return "person.crop.circle.fill"
        }
    }
    
    var index: Int {
        Self.allCases.firstIndex(of: self) ?? 0
    }
}

struct ContentView2: View {
    @State private var ativoTab: CustomTab = .home
    
    var body: some View {
        // Usando a estrutura padrão do TabView compatível com a remoção da barra nativa
        TabView(selection: $ativoTab) {
            Text("Página Home")
                .tag(CustomTab.home)
                .toolbar(.hidden, for: .tabBar)
            
            Text("Página Descobrir")
                .tag(CustomTab.discover)
                .toolbar(.hidden, for: .tabBar)
            
            Text("Página de Perfil")
                .tag(CustomTab.profile)
                .toolbar(.hidden, for: .tabBar)
        }
        // safeAreaInset garante que a tab bar fique presa no fundo sem sobrepor o conteúdo
        .safeAreaInset(edge: .bottom, spacing: 0) {
            CustomTabView()
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
        }
    }
    
    @ViewBuilder
    func CustomTabView() -> some View {
        HStack(spacing: 10) {
            // Container Principal das Abas
            GeometryReader { proxy in
                let size = proxy.size
                let tabWidth = size.width / CGFloat(CustomTab.allCases.count)
                
                ZStack(alignment: .leading) {
                    // Indicador de fundo animado (Substitui o seu componente TabBar ausente)
                    Capsule()
                        .fill(Color.blue.opacity(0.15))
                        .frame(width: tabWidth)
                        .offset(x: tabWidth * CGFloat(ativoTab.index))
                        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: ativoTab)
                    
                    // Ícones e Textos
                    HStack(spacing: 0) {
                        ForEach(CustomTab.allCases, id: \.rawValue) { tab in
                            VStack(spacing: 3) {
                                Image(systemName: tab.icone)
                                    .font(.title3)
                                    .symbolVariant(ativoTab == tab ? .fill : .none)
                                Text(tab.rawValue)
                                    .font(.system(size: 10))
                                    .fontWeight(.medium)
                            }
                            .foregroundStyle(ativoTab == tab ? .blue : .primary)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .contentShape(Rectangle()) // Torna a área inteira clicável
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    ativoTab = tab
                                }
                            }
                        }
                    }
                }
            }
            .frame(height: 55)
            .background(.regularMaterial, in: Capsule()) // Efeito de vidro nativo do SwiftUI
            
            // Botão/Ícone lateral flutuante
            ZStack {
                ForEach(CustomTab.allCases, id: \.rawValue) { tab in
                    Image(systemName: tab.acaoIcone)
                        .font(.system(size: 22, weight: .medium))
                        .foregroundStyle(.blue)
                        .blurFade(ativoTab == tab)
                }
            }
            .frame(width: 55, height: 55)
            .background(.regularMaterial, in: Capsule())
            .animation(.smooth(duration: 0.55, extraBounce: 0), value: ativoTab)
        }
    }
}

// MARK: Blur Fade In/Out
extension View {
    @ViewBuilder
    func blurFade(_ status: Bool) -> some View {
        self
            .compositingGroup()
            .blur(radius: status ? 0 : 10)
            .opacity(status ? 1 : 0)
    }
}

#Preview {
    ContentView2()
}
