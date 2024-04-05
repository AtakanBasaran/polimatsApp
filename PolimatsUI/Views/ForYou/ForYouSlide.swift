//
//  ForYouSlide.swift
//  PolimatsUI
//
//  Created by Atakan Başaran on 4.04.2024.
//

import SwiftUI

struct ForYouSlide: View {
    
    @EnvironmentObject var mainVM: MainPageViewModel
    @Environment(\.colorScheme) var colorScheme
    @State var animate = true
    
    @State private var offset: CGFloat = .zero
    @State private var progress: CGFloat = 0.0
    
    
    var body: some View {
        
        NavigationStack {
            
            ZStack(alignment: .center) {
                
                
                Color(.systemBackground)
                    .ignoresSafeArea()
                
                Circle()
                    .frame(width: 300, height: 300)
                    .foregroundStyle(.orange)
                    .blur(radius: animate ? 30 : 100)
                    .offset(x: animate ? -50 : -130, y: animate ? -300 : -75)
                
                
                Circle()
                    .frame(width: 300, height: 300)
                    .foregroundStyle(.green)
                    .blur(radius: animate ? 30 : 100)
                    .offset(x: animate ? 100 : 130, y: animate ? 150 : 100)
                
                
                Circle()
                    .frame(width: 300, height: 300)
                    .foregroundStyle(.realRed)
                    .blur(radius: animate ? 30 : 100)
                    .offset(x: animate ? 100 : 130, y: animate ? -300 : -75)
                
                
                Circle()
                    .frame(width: 300, height: 300)
                    .foregroundStyle(.purple)
                    .blur(radius: animate ? 30 : 100)
                    .offset(x: animate ? -100 : -130, y: animate ? 150 : 100)
                
                Circle()
                    .frame(width: 300, height: 300)
                    .foregroundStyle(.yellow)
                    .blur(radius: animate ? 30 : 100)
                    .offset(x: animate ? 0 : 50, y: animate ? 350 : 200)
                
                
                VStack(alignment: .center, spacing: 50) {
                    
                    Text("Senin için seçtiğimiz yazıyı\ngörmek için kaydır!")
                        .multilineTextAlignment(.center)
                        .font(.custom("Comfortaa-Bold", size: 20))
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                        .lineSpacing(10)
                        .padding(.horizontal, 20)
                        .opacity(max(0.3, progress + 0.1))
                    
                    
                    SlideButton(offset: $offset, progress: $progress)
                    
         
                    .navigationDestination(isPresented: $mainVM.isActiveRandom) {
                        ForYou(dataPolimats: mainVM.polimatsDataRandom.first ?? exData.exArticle)
                    }
                }
                .padding(.bottom, 40)
            }
        }
        
        .onChange(of: offset) { value in
            
            mainVM.hapticFeedback(mode: .soft)
            
            if value == 180 {
            
                withAnimation(.easeInOut(duration: 0.5)){
                    mainVM.isActiveRandom = true
                }
                
                withAnimation(.easeInOut(duration: 1.5)){
                    offset = 0
                    progress = 0
                }
                
            }
        }
        
        .task {
            if mainVM.polimatsDataRandom.isEmpty {
                mainVM.getRandomData(category: Manager.shared.chooseRandomCategory())
            }
            
            withAnimation(.easeInOut(duration: 3).repeatForever()) {
                animate.toggle()
            }
        }
        

    }
}

#Preview {
    ForYouSlide()
}
