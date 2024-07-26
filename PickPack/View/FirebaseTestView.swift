//
//  FirebaseTestView.swift
//  PickPack
//
//  Created by LDW on 7/24/24.
//

import SwiftUI

struct FirebaseTestView: View {

    let firebaseRdb = NetworkManager.shared
    
    @State private var textInput: String = ""
    @State private var room: Room = Room(invitationCode: "123456", constructorId: "생성자 아이디", name:  "테스트 이름", startDate1970TimeInterval: "111111", endDate1970TimeInterval: "222222")
    @State private var member: Member = Member(name: "Minsu")
    @State private var itemList: ItemList = ItemList(memberId: "memberId", roomId: "roomId")
    @State private var items: [Item] = []
    
    var body: some View {
        
        VStack{
            HStack{
                Text("Firebase Test VIew")
                    .font(.title)
                    .bold()
                Spacer()
            }
            
            VStack{
                Text("Room Info")
                    .bold()
                VStack {
                    HStack{
                        Text("ID : \(room.id)")
                        Spacer()
                    }
                    HStack{
                        Text("Code : \(room.invitationCode)")
                        Spacer()
                    }
                    HStack{
                        Text("Name: \(room.name)")
                        Spacer()
                    }
                }
                
                Text("Member Info")
                    .bold()
                VStack{
                    HStack {
                        Text("ID : \(member.id)")
                        Spacer()
                    }
                    HStack {
                        Text("Name : \(member.name)")
                        Spacer()
                    }
                    HStack {
                        Text("Color: \(member.roomColor)")
                        Spacer()
                    }
                }
                
                Text("ItemList Info")
                    .bold()
                VStack{
                    HStack {
                        Text("ID : \(itemList.id)")
                        Spacer()
                    }
                    HStack {
                        Text("Member ID : \(itemList.memberId)")
                        Spacer()
                    }

                }
                Spacer()
                
                HStack{
                    Button(action: {
                        
                    }, label: {
                        Text("Room 생성")
                    })
                    .border(Color.black)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Member 생성")
                    })
                    .border(Color.black)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Text("ItemList 생성")
                    })
                    .border(Color.black)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Item 생성")
                    })
                    .border(Color.black)
                }
                
                
                HStack{
                    Button(action: {
                        
                    }, label: {
                        Text("Button")
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Button")
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Button")
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Button")
                    })
                }
                
                Spacer()
            }
            
            
            
        }
        .padding(.horizontal, 8)
        
      
    
    }
    
    
}

#Preview {
    FirebaseTestView()
}
