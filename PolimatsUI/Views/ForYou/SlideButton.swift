//
//  SlideButton.swift
//  PolimatsUI
//
//  Created by Atakan Başaran on 4.04.2024.
//

import SwiftUI

struct SlideButton: View {
    
    @Binding var offset: CGFloat
    @Binding var progress: CGFloat
    
    var body: some View {
        
        VStack(spacing: 170) {
            
            ZStack {
                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                    .frame(width: 70, height: 70)
                    .rotationEffect(.degrees(-90))
                    .foregroundStyle(.black)
                    .background(
                    
                        Circle()
                            .stroke(lineWidth: 8)
                            .foregroundStyle(.gray)
                            
                    )
                
                Image(systemName: "checkmark")
                    .foregroundStyle(.black)
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .opacity( offset > 120 ? 1 : 0)
            }
            
            
            ZStack(alignment: .leading) {
                
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 250, height: 55)
                    .opacity(0.4)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 60, height: 45)
                        .padding(.leading, 5)
                        .foregroundStyle(.white)
                    
                    Image(systemName: "arrow.right")
                        .foregroundStyle(.gray)
                        .font(.system(size: 30))
                }
                .offset(x: max(0, offset))
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            let dragDistance = value.translation.width
                            offset = min(dragDistance, 180)
                            withAnimation(.easeInOut) {
                                progress = min(1, dragDistance / 180)
                            }
                        })
                    
                        .onEnded({ value in
                            withAnimation(.easeInOut) {
                                offset = .zero
                                progress = 0
                            }
                        })
                )
            }
            .padding(.bottom, 20)
        }
        
    }
}

#Preview {
    SlideButton(offset: .constant(0), progress: .constant(0.1))
}
