//
//  InfoPanelView.swift
//  Pinch
//
//  Created by Kyungyun Lee on 11/02/2022.
//

import SwiftUI

struct InfoPanelView: View {
    
    var scale : CGFloat
    var offSet : CGSize
    
    @State var isInfoPanelVisible : Bool = false
    
    var body: some View {
        // MARK : -hotspot
        HStack{
            Image(systemName: "circle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width : 30, height : 30)
                .onLongPressGesture(minimumDuration: 1) {
                    withAnimation(.easeOut) {
                        isInfoPanelVisible.toggle()
                    }
                }
            //longpress제스쳐에 대한 애니메이션 먹이는 방법.
            
            Spacer()
            
            HStack{
                Image(systemName: "arrow.up.left.arrow.down.right")
                Text("\(scale)")
                
                Spacer()
                
                Image(systemName: "arrow.left.and.right")
                Text("\(offSet.width)")
                
                Spacer()
                
                Image(systemName: "arrow.up.and.down")
                Text("\(offSet.height)")
            }
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .frame(maxWidth : 420)
            .opacity(isInfoPanelVisible ? 1 : 0)
            
            Spacer()
        }
        // MARK : -info panel
    }
}

//struct InfoPanelView_Previews: PreviewProvider {
//    static var previews: some View {
//        InfoPanelView(scale: 1, offSet: .zero)
//            .preferredColorScheme(.dark)
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
