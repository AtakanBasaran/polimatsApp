//
//  SearchArticleView.swift
//  PolimatsUI
//
//  Created by Atakan Başaran on 19.03.2024.
//

import SwiftUI

struct SearchArticleView: View {
    
    let dataPolimats: WordPressData
    
    @EnvironmentObject var mainVM: MainPageViewModel
    @EnvironmentObject var adVM: ViewModelAd
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss

    
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                
                VStack(spacing: 20) {
                    ArticleViewBeginning(dataPolimats: dataPolimats)
                        .padding(.horizontal, 5)

                    ArticleBody(dataPolimats: dataPolimats)
                        .padding(.horizontal, 5)
                        .padding(.top, 20)
                    
                    
                    Writer(dataPolimats: dataPolimats)
                        .padding(.top, 55)
                        .padding(.horizontal, 5)
                    
                    NativeAdView(nativeAdViewModel: adVM)
                        .padding(.top, 100)
                        .frame(width: 350, height: 400, alignment: .center)
                        .padding(.horizontal, 10)
                    
                    
                    EndArticle()
                        .padding(.top, 100)
                        .ignoresSafeArea()
                    
                }
            }
            .gesture(
                DragGesture()
                    .onChanged({ gesture in
                        if gesture.translation.width > 40 {
                            withAnimation(.smooth) {
                                dismiss()
                            }
                        }
                    })
            )
            
        }
        
        
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                        .fontWeight(.medium)
                        .font(.system(size: 18))
                    
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                
                Menu {
                    
                    VStack {
                        Button {
                            mainVM.isActiveSearch = false
                        } label: {
                            Label("Ana Sayfa", systemImage: "house")
                        }
                        
                        ShareLink(item: URL(string: dataPolimats.link)!) {
                            Label("Paylaş", systemImage: "square.and.arrow.up")
                        }
                    }
                    .frame(width: 10)
                    
                } label: {
                    
                    Image(systemName: "ellipsis.circle")
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                }
            }
            
            
        }
        .ignoresSafeArea(edges: .horizontal)
        .navigationTitle("polimats")
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden()
        
    }
}

//#Preview {
//    SearchArticleView()
//}
