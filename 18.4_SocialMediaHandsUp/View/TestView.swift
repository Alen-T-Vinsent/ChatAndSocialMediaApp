//
//  TestView.swift
//  18.4_SocialMediaHandsUp
//
//  Created by Apple  on 01/03/23.
//

import SwiftUI




//struct TestView1: View {
//
//    @GestureState var isDetectingLongPress = false
//    @State var completedLongPress = false
//
//    var longPress: some Gesture {
//        LongPressGesture(minimumDuration: 3)
//            .updating($isDetectingLongPress) { currentState, gestureState,
//                transaction in
//                gestureState = currentState
//                transaction.animation = Animation.easeIn(duration: 2.0)
//            }
//            .onEnded { finished in
//                self.completedLongPress = finished
//            }
//    }
//
//    var body: some View {
//
//        HStack {
//
//            Spacer()
//            ZStack {
//                // Three button array to fan out when main button is being held
//                Button(action: {
//                    // ToDo
//                }) {
//                    Image(systemName: "circle.fill")
//                        .frame(width: 70, height: 70)
//                        .foregroundColor(.red)
//                }
//                .offset(x: self.isDetectingLongPress ? -90 : 0, y: self.isDetectingLongPress ? -90 : 0)
//                Button(action: {
//                    // ToDo
//                }) {
//                    Image(systemName: "circle.fill")
//                        .frame(width: 70, height: 70)
//                        .foregroundColor(.green)
//                }
//                .offset(x: 0, y: self.isDetectingLongPress ? -120 : 0)
//                Button(action: {
//                    // ToDo
//                }) {
//                    Image(systemName: "circle.fill")
//                        .frame(width: 70, height: 70)
//                        .foregroundColor(.blue)
//                }
//                .offset(x: self.isDetectingLongPress ? 90 : 0, y: self.isDetectingLongPress ? -90 : 0)
//
//                // Main button
//                Image(systemName: "largecircle.fill.circle")
//                    .gesture(longPress)
//
//            }
//            Spacer()
//        }
//    }
//}


//MARK: need to study
//struct TestView1: View {
//
//    @State var items: [Todo] =  [
//        Todo(title: "$300", completed: false),
//        Todo(title: "$550", completed: false),
//        Todo(title: "$450", completed: false)
//    ]
//
//    var body: some View {
//        List($items) { $item in
//            Row(item: item) {
//                item.completed.toggle()
//            }
//        }
//    }
//}
//struct Row: View {
//    let item: Todo
//    let onTap: (() -> Void)?
//
//    var body: some View {
//        HStack {
//            Image(systemName: item.completed ? "checkmark.square.fill" :  "squareshape" )
//                .foregroundColor(item.completed ? .green : .gray)
//            Text(item.title).font(.headline).foregroundColor(.secondary)
//        }.onTapGesture {
//            onTap?()
//        }
//    }
//}
//struct Todo: Hashable, Identifiable {
//    let id = UUID()
//    var title: String
//    var completed: Bool
//
//    init(title: String, completed: Bool) {
//        self.title = title
//        self.completed = completed
//    }
//}

//MARK: Test
struct Model{
    var  id:Int
    var name:String
    
}

struct TestView1:View{
    
    @State var array = [Model]()
    @State var count = 0
    
    var body: some View{
        Text("+")
        
            .onTapGesture {
                count+=1
                array.append(Model(id: count, name: String(count)))
            }
        
        List{
            
            ForEach(Array(array.enumerated()), id: \.offset) { index, element in
             
                HStack{
                    Text(element.name)
                }
                .onTapGesture {
                    print(element)
                    array.remove(at: index)
                }
            }
            
        }
    }
}
