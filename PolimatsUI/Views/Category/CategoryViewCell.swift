//
//  MainViewCell.swift
//  PolimatsUI
//
//  Created by Atakan Başaran on 4.02.2024.
//

import SwiftUI

struct CategoryViewCell: View {
    
    let dataPolimats: WordPressData
    
    
    @Environment(\.colorScheme) var colorScheme
 
    var body: some View {
        
        VStack(spacing: 10) {
            
            HStack {
                
                Spacer()
                
                ImageHandle(placeHolder: "grayImage", urlString: dataPolimats.featuredImageSrc)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 355, height: 200, alignment: .center)
                    .clipped()
                    .clipShape(.rect(cornerRadius: 20))
                    .padding(.horizontal, 7)
                    .overlay(alignment: .bottomLeading) {
                        CategoryRectangleNew(category: Manager.shared.getCategory(dataPolimats: dataPolimats), width: 90, height: 30)
                            .padding(.leading, 7)
                    }
                    .padding(.horizontal, 3)
                
                Spacer()
            }
            
            Text(Manager.shared.convertHtmlToPlainText(dataPolimats.title.rendered))
                .font(.custom("Roboto-Bold", size: 22))
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.horizontal, 27)
//                .padding(.horizontal, 5)

        }
        .frame(width: 355)
        
        
    }
    
}

#Preview {
    CategoryViewCell(dataPolimats: exData.exArticle)
}
