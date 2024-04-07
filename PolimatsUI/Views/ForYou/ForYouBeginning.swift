//
//  ForYouBeginning.swift
//  PolimatsUI
//
//  Created by Atakan Başaran on 5.03.2024.
//

import SwiftUI

struct ForYouBeginning: View {
    
    @EnvironmentObject var mainVM: MainPageViewModel
    @Environment(\.colorScheme) var colorScheme
    @State var animate = true
    
    
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
                
                
                VStack(alignment: .center, spacing: 40) {
                    
                    
                    
                    Text("Senin için seçtiğimiz yazıyı\ngörmek için tıkla!")
                        .multilineTextAlignment(.center)
                        .font(.custom("Comfortaa-Bold", size: 20))
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                        .lineSpacing(10)
                        .padding(.horizontal, 20)
                        .opacity(animate ? 0.3 : 1)
                    
                    Button(action: {
                        mainVM.isActiveRandom = true
                        
                        
                        for i in 1...7 {
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 * Double(i)) {
                                mainVM.hapticFeedback(mode: .heavy)
                            }
                        }

                        
                        
                    }, label: {
                        
                        ZStack(alignment: .center) {
                            
                            Circle()
                                .frame(width: 110, height: 110, alignment: .center)
                                .foregroundStyle(.realRed)
                                .opacity(animate ? 0.3 : 0.9)
                            

                            
                            Image(systemName: "arrow.forward")
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                                .font(.system(size: 30))
                                .fontWeight(.medium)
                                .opacity(animate ? 0.3 : 0.9)

                                
                        }
                        
                    })
                    
                    .navigationDestination(isPresented: $mainVM.isActiveRandom) {
                        ForYou(dataPolimats: mainVM.polimatsDataRandom.first ?? exData.exArticle)
                    }
                }
                .padding(.bottom, 40)
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

//#Preview {
//    ForYouBeginning(action: {
//        print("")
//    })
//}
