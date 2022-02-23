//
//  ContentView.swift
//  Pinch
//
//  Created by Kyungyun Lee on 11/02/2022.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var vm : PageModel
    
    @State var isAnimating : Bool = false
    @State var imageScale : CGFloat = 1
    @State var imageOffset : CGSize = .zero
    @State var imageName : String = "magazine-front-cover"
    
    @State var isDrawerOpen : Bool = false
    
    // MARK : -reset function
    
    func resetImageState() {
        return withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    var body: some View {

        NavigationView{
            ZStack{
                Color.clear
                // MARK : -page image
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .animation(.linear(duration: 1), value: isAnimating)
                    .scaleEffect(imageScale)
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5
                                // 카운트에 탭하는 숫자 집어넣음. 애니메이션과 함께 확대를 시켜준다. 이미지 스케일을 먹여줌.스케일 이펙트에는 확대대상으로 들어감.
                            }
                        } else {
                            resetImageState()
                        }
                    })
                // MARK : -dragGesture
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                withAnimation(.linear(duration: 0.2)) {
                                    imageOffset = value.translation
                                }
                            }
                            .onEnded { _ in
                                if imageScale <= 1 {
                                   resetImageState()
                                }
                            }
                    )
                // MARK : -magnification
                
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                withAnimation(.linear(duration: 1)) {
                                    if imageScale >= 1 && imageScale <= 5 {
                                        imageScale = value
                                    } else if imageScale > 5 {
                                        imageScale = 5
                                    }
                                }
                            }
                            .onEnded { _ in
                                if imageScale > 5 {
                                    imageScale = 5
                                } else if imageScale <= 1 {
                                    resetImageState()
                                }
                            }
                        //이미 스위프트 유아이에서 제공하는 기능이다 매그니피케이션 제스쳐
                        //마지막에는 애니메이션 마지막에 최종 상태를 지정해준다.
                    )
            } // Zstack
            .navigationTitle("Pinch and Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                isAnimating = true
            })
            .overlay(
                InfoPanelView(scale: imageScale, offSet: imageOffset)
                    .padding(.horizontal)
                    .padding(.top, 30)
                ,alignment: .top
                
            )
            
            .overlay(
                Group {
                    HStack{
                        //SCALE DOWN
                        Button {
                            withAnimation(.spring()) {
                                if imageScale > 1 {
                                    imageScale -= 1
                                }
                                
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                            }
                        } label: {
                            ControllImageView(icon: "minus.magnifyingglass")
                        }
                        //SCALE UP
                        Button {
                            resetImageState()
                        } label: {
                            ControllImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        //RESET
                        Button {
                            withAnimation(.spring()) {
                                if imageScale < 6 {
                                    imageScale += 1
                                }
                            }
                        } label: {
                            ControllImageView(icon: "plus.magnifyingglass")
                        }
                    }
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .opacity(isAnimating ? 1 : 0)
                    .cornerRadius(10)
                }
                    .padding(.bottom, 30)
                ,alignment: .bottom
            )
            .overlay(
                HStack(spacing: 12) {
                    Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left")
                        .resizable()
                        .scaledToFit()
                        .frame(height : 40)
                        .padding(8)
                        .foregroundStyle(.secondary)
                        .onTapGesture(perform: {
                            withAnimation(.easeOut(duration: 0.3)) {
                                isDrawerOpen.toggle()
                            }
                        })
                    
                    ForEach(vm.pagesData) { item in
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width : 80)
                            .cornerRadius(10)
                            .opacity(isDrawerOpen ? 1 : 0)
                            .animation(.easeOut(duration: 0.5), value: isDrawerOpen)
                            .onTapGesture(perform:  {
                                withAnimation(.easeOut(duration: 0.4)) {
                                    self.imageName = item.imageName
                                    isAnimating = true
                                }
                    
                            })
                    }

                    Spacer()
                }
                    .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                    .frame(width : 260)
                    .padding(.top, UIScreen.main.bounds.height / 12)
                    .offset(x: isDrawerOpen ? 20 : 215)
                ,alignment:  .topTrailing
            )
            
        } // NavigationView
        .navigationViewStyle(.stack)
        //썸네일뷰는 오리지널처럼 너무 클 필요가 없다. 이미지를 용량을 줄여서 준비하는게 낫다.
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
