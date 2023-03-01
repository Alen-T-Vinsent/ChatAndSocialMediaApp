//
//  FloatingTabBarView.swift
//  18.4_SocialMediaHandsUp
//
//  Created by Apple  on 27/02/23.
//

import SwiftUI
import Firebase

struct FloatingTabBarView: View {
    
    var tabs = ["house.fill", "rectangle.stack", "basket", "person"]
    
    @State var selectedTab = "house.fill"
    @AppStorage("userName") var userName = "user1"
    @State var usersArrayList:[String] = []
    
    // Location of each curve
    @State var xAxis: CGFloat = 0
    @Namespace var animation
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selectedTab) {
                ChatView()
                    .foregroundColor(Color.white)
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("house.fill")
                
                
                Text("Online post")
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("rectangle.stack")
                
                Text("Status ")
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("basket")
                
               AccountView()
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("person")
            }
            
            // custom tab bar
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) { image in
                    GeometryReader { reader in
                        Button(action: {
                            withAnimation {
                                selectedTab = image
                                xAxis = reader.frame(in: .global).minX
                            }
                        }, label: {
                            Image(systemName:image)
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 22.0, height: 22.0)
                                .foregroundColor(Color("lightBlue"))
                                .padding(selectedTab == image ? 15 : 0)
                                .background(Color("darkBlue").opacity(selectedTab == image ? 1 : 0).clipShape(Circle()))
                                .matchedGeometryEffect(id: image, in: animation)
                                .offset(x: selectedTab == image ? -10 : 0, y: selectedTab == image ? -50 : 0)
                        })
                        .onAppear(perform: {
                            if image == tabs.first {
                                xAxis = reader.frame(in: .global).minX
                            }
                        })
                    }
                    .frame(width: 25.0, height: 30.0)
                    if image != tabs.last { Spacer() }
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical)
            .background(Color("skyBlue").clipShape(CustomShape(xAxis: xAxis)).cornerRadius(12.0))
            .padding(.horizontal)
            // Bottom edge....
            .padding(.bottom , UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            //MARK: fetching all users
            
        }
        .ignoresSafeArea(.all, edges: .all)
    }

}

struct FloatingTabBar_Previews: PreviewProvider {
    static var previews: some View {
        FloatingTabBarView()
            .preferredColorScheme(.dark)
    }
}

struct CustomShape: Shape {
    
    var xAxis: CGFloat
    
    // Animate Path
    var animatableData: CGFloat {
        get { return xAxis }
        set { xAxis = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let center = xAxis
            
            path.move(to: CGPoint(x: center - 50, y: 0))
            
            let to1 = CGPoint(x: center, y: 35)
            let control1 = CGPoint(x: center - 25, y: 0)
            let control2 = CGPoint(x: center - 25, y: 35)
            
            let to2 = CGPoint(x: center + 50, y: 0)
            let control3 = CGPoint(x: center + 25, y: 35)
            let control4 = CGPoint(x: center + 25, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}
