//
//  TestView.swift
//  18.4_SocialMediaHandsUp
//
//  Created by Apple  on 01/03/23.
//


import SwiftUI

//step 1 -- Create a shape view which can give shape
struct CornerRadiusShape: Shape {
    var radius = CGFloat.infinity
    var corners = UIRectCorner.allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

//step 2 - embed shape in viewModifier to help use with ease
struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}
//step 3 - crate a polymorphic view with same name as swiftUI's cornerRadius
extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}

//use any way you want
struct TestView: View {
    var body: some View {
        VStack {
//            Rectangle()
//                .frame(width: 100, height: 100, alignment: .center)
//                .cornerRadius(radius: 20.0, corners: [.topLeft])
//
//            Rectangle()
//                .frame(width: 100, height: 100, alignment: .center)
//                .cornerRadius(radius: 20.0, corners: [.topLeft, .bottomLeft])
//
//            Rectangle()
//                .frame(width: 100, height: 100, alignment: .center)
//                .cornerRadius(radius: 20.0, corners: [.allCorners])
            Rectangle()
                .frame(width: 100, height: 100, alignment: .center)
                .cornerRadius(radius: 20.0, corners: [.topLeft,.topRight,.bottomRight])
            
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//
////        CornerRadiusShape.init(radius: 10, corners: [.allCorners])
////            .frame(width: 100, height: 100, alignment: .center)
//    }
//}
