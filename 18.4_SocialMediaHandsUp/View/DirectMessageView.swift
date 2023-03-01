//
//  DirectMessageView.swift
//  18.4_SocialMediaHandsUp
//
//  Created by Apple  on 27/02/23.
//

import SwiftUI

struct DirectMessageView: View {
    
    //MARK: PROPERTIES
    @Binding var showDMView:Bool
    @State private var messageTxtField = ""
    @State private var showLockRecord = false
    @State private var showEnlargedMic = false
    @State private var showTime = false
    @State private var isRotating:Double = 0.0
    @State var messageOwner:MessageOwner = .me
    
    let screenWidth = UIScreen.main.bounds.width
    
     @ObservedObject var  stopWatchManager = StopWatchManager()
    

    
    let messageList:[MessageModel] = [
        MessageModel(owner: .me, time: "11.00 AM", sender: "Alen", reciever: "Alena", messageType: .textMessage, message: "hello"),
        MessageModel(owner: .otherPerson, time: "11.00 AM", sender: "Alena", reciever: "Alen", messageType: .textMessage,message:"hai"),
        MessageModel(owner: .otherPerson, time: "11.01 AM", sender: "Alena", reciever: "Alen", messageType: .textMessage,message:"How are you"),
        MessageModel(owner: .otherPerson, time: "11.02 AM", sender: "Alena", reciever: "Alen", messageType: .textMessage,message:"where are now"),
        MessageModel(owner: .me, time: "11.03 AM", sender: "Alen", reciever: "Alena", messageType: .textMessage,message:"i am at Delhi"),
        MessageModel(owner: .me, time: "11.14 AM", sender: "Alen", reciever: "Alena", messageType: .textMessage,message:"where are you now"),
        MessageModel(owner: .otherPerson, time: "11.18 AM", sender: "Alena", reciever: "Alen", messageType: .textMessage,message:"i am at Kerala"),
        MessageModel(owner: .me, time: "12.29 AM", sender: "Alen", reciever: "Alena", messageType: .textMessage,message:"ok see you later")
                                     ]


    
    var body: some View {
        
        //MARK: HEADER
        HStack(spacing:10){
            Image(systemName: "arrow.left")
                .padding(.leading,10)
                .onTapGesture {
                    showDMView = false
                }
            Image(systemName: "person.fill")
            Text("Your friends Name")
                .font(.subheadline)
                .bold()
            Spacer()
            
            Menu {
                Text("View Profile")
                    .foregroundColor(.mint)
                Text("Block ")
                    .foregroundColor(.teal)
            } label: {
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(-90))
                    .padding()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .foregroundColor(Color("darkBlue"))
        .background(Color("skyBlue"))
        .navigationTitle("Your Friends Name")
        
        Spacer()
        
        //MARK: Content Area
        VStack(spacing:10){
            
            ScrollView{
                
                ForEach(messageList,id:\.self){ eachPerson in
                    if eachPerson.owner == .me{
                        //Message of me
                        HStack{
                            
                            Spacer()
                            Text(eachPerson.message)
                                .padding()
                                .background(content: {
                                    Rectangle()
                                        .fill(.red)
                                        .cornerRadius(radius: 20.0, corners: [.topLeft,.topRight,.bottomLeft])
                                })
                                .padding(.horizontal)
                        }
                        .padding(.top,1)
                        .padding(.trailing)

                       
                    }else{
                        //Message of other
                        HStack{
                           
                            Text(eachPerson.message)
                                .padding()
                                .background(content: {
                                    Rectangle()
                                        .fill(.green)
                                        .cornerRadius(radius: 20.0, corners: [.topLeft,.topRight,.bottomRight])
                                })
                                .padding(.horizontal)
                            
                            Spacer()
                                
                        }
                        .padding(.top,1)
                        .padding(.trailing)
                        
                    }
                }
                
               
                Text(String(format:"%.1f",stopWatchManager.secondsElapsed))

            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(Color.yellow)
            //MARK: stopwatch timer area
            .overlay(alignment:.bottomTrailing){
                HStack{
                    Image(systemName: "timelapse")
                        .resizable()
                        .frame(width: 60,height: 60)
                        .foregroundColor(Color("darkBlue"))
                        .padding(8)
                        .isHidden(!showEnlargedMic,remove:!showEnlargedMic)
                        .rotationEffect(.degrees(isRotating))
                        .onAppear {
                            if showEnlargedMic{
                                withAnimation(.linear(duration: 1)
                                    .speed(0.02).repeatForever(autoreverses: false)) {
                                        isRotating = 360.0
                                    }
                            }
                        }
                        .overlay(content: {
                                Text("X")
                                .foregroundColor(Color.red)
                        })
                }
                .onTapGesture {
                    print("closing record")
                    withAnimation{
                        showEnlargedMic = false
                    }
                }
                    
            }
            
        }
        
        Spacer()
        
        
        //MARK: FOOTER
        HStack {
            if showEnlargedMic{
                HStack{
                    HStack{
                        Image(systemName: "")
                        Text("Recording Audio")
                            .animation(Animation.easeInOut(duration:2).repeatForever(autoreverses:true))
                    }
                    
                    HStack{
                        Text(String(format: "%.2f",stopWatchManager.secondsElapsed))
                            .frame(width: 40,height: 40)
                            .background(Color.clear)
                        .foregroundColor(Color.red)
                        .shadow(radius: 2)
                    }
                }
                .frame(width: screenWidth - screenWidth/5-10 ,height: 45)
                .background(Color.teal)
                .cornerRadius(20)
            }else{
                HStack {
                    TextField("Message", text: $messageTxtField)
                }
                .frame(maxWidth: .infinity)
                .textFieldStyle(OvalTextFieldStyle())
            }
            HStack{
                Image(messageTxtField == "" ? "mic-icon" : "sent-icon2")
                    .shadow(color: .black, radius:messageTxtField == "" ? 1 : 0.1)
                    .bold()
                    .frame(width:20,height: 20)
                    .scaleEffect(showEnlargedMic ? 1.5 : 1)
                    .padding()
                    .onTapGesture {
                        if messageTxtField == "" {
                            print("enlarge audio button")
                            withAnimation {
                                showEnlargedMic.toggle()
                            }
                            
                            if stopWatchManager.mode == .running{
                                print("stop watch stoping")
                                stopWatchManager.stop()
                            }else{
                                    print("stop watch starting")
                                    stopWatchManager.start()
                            }
                            
                        }else{
                            print("send message")
                            
                        }
                    }
                    .onLongPressGesture(minimumDuration: 0.1){
                        print("long press button")
                        print("enlarge audio button")
                        withAnimation {
                            showEnlargedMic.toggle()
                        }
                    }
            }
            .foregroundColor(Color.mint)
            
        }
        .padding()
        .background(Color.cyan)
        
        
    }
    
}

//MARK: struct OvalTextFieldStyle
struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(LinearGradient(gradient: Gradient(colors: [Color("simpleWhite"), Color("simpleWhite")]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(20)
            .shadow(color: .black, radius: 0.8)
            .foregroundColor(Color("darkBlue"))
    }
    
}


//MARK: Stop watch for record
class StopWatchManager:ObservableObject{
    enum stopWatchMode{
        case running
        case stopped
        case paused
    }
    
    @Published var mode:stopWatchMode = .stopped
    @Published var secondsElapsed:Double = 0.0
    var timer = Timer()
    
    func start(){
        mode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 0.1 , repeats: true){ timer in
            self.secondsElapsed += 0.1
        }
    }
    
    func pause(){
        timer.invalidate()
        mode = .paused
    }
    
    func stop(){
        timer.invalidate()
        secondsElapsed = 0
        mode = .stopped
    }
}


struct DirectMessageView_Previews: PreviewProvider {
    static var previews: some View {
        FloatingTabBarView()
    }
}


struct RoundedCorners:Shape{
    var radius:CGFloat = .infinity
    var corners:UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners,cornerRadii:CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}


//MARK: Message Models
enum MessageOwner{
    case me
    case otherPerson
}

enum MessageType{
    case textMessage
    case voiceMessage
}

struct MessageModel:Hashable{
    init(owner:MessageOwner,time:String,sender:String, reciever:String,  messageType:MessageType,message:String){
        self.owner = owner
        self.time = time
        self.sender = sender
        self.reciever = reciever
        self.messageType = messageType
        self.message = message
    }
    let owner:MessageOwner
    let time:String
    let sender:String
    let reciever:String
    let messageType:MessageType
    let message:String
    
}

