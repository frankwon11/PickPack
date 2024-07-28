//
//  FirebaseTestView.swift
//  PickPack
//
//  Created by LDW on 7/24/24.
//

import SwiftUI

struct FirebaseTestView: View {

    let shared = NetworkManager.shared
    
    @State private var textInput: String = ""
    @State private var room: Room = Room(invitationCode: "123456", constructorId: "생성자 아이디", name:  "테스트 이름", startDate: 111111, endDate: 222222, memberIdList: [], sharedItemList: [])
    @State private var member: Member = Member(name: "Minsu")
    @State private var itemList: ItemList = ItemList(memberId: "memberId", roomId: "roomId")
    @State private var item: Item = Item()
    
    let si1 = SharedItem()
    let si2 = SharedItem()
    
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
                        let rm = Room(invitationCode: "12345", constructorId: "andrew", name: "dongwook", startDate: 1234, endDate: 2345, memberIdList: ["a1234"], sharedItemList: [si1, si2])
                        shared.createNewRoom(room: rm)
                        room = rm
                        
                    }, label: {
                        Text("Room 생성")
                    })
                    .border(Color.black)
                    
                    Spacer()
                    
                    Button(action: {
                        var m = Member(name: "Shuwn")
                        m.roomIdList.append(room.id)
                        
                        shared.createNewMember(member: m)
                        member = m
                    }, label: {
                        Text("Member 생성")
                    })
                    .border(Color.black)
                    
                    Spacer()
                    
                    Button(action: {
                        let il = ItemList(memberId: member.id, roomId: room.id)
                        shared.createNewItemList(itemList: il)
                        itemList = il
                    }, label: {
                        Text("ItemList 생성")
                    })
                    .border(Color.black)
                    
                    Spacer()
                    
                    Button(action: {
                        let it = Item()
                        shared.createNewItem(itemListId: itemList.id, item: it)
                        item = it
                    }, label: {
                        Text("Item 생성")
                    })
                    .border(Color.black)
                }
                
                
                HStack{
                    Button(action: {
                        shared.deleteRoom(key: room.id)
                    }, label: {
                        Text("Room 삭제")
                    })
                    .border(Color.black)
                    
                    Button(action: {
                        shared.deleteMember(key: member.id)
                    }, label: {
                        Text("Member 삭제")
                    })
                    .border(Color.black)
                    
                    Button(action: {
                        shared.deleteItemList(key: itemList.id)
                    }, label: {
                        Text("ItemList 삭제")
                    })
                    .border(Color.black)
                    
                    Button(action: {
                        shared.deleteItem(itemListKey: itemList.id, itemKey: item.id)
                    }, label: {
                        Text("Item 삭제")
                    })
                    .border(Color.black)
                }
                
                HStack {
                    Button(action: {
                        shared.fetchRoomData(memberId: member.id) { room in
                            
                            if let r = room {
                                print(r)
                            } else {
                                print("room fetch error")
                            }
                        }
                    }, label: {
                        Text("Room 요청")
                    })
                    .border(Color.black)
                    
                    Button(action: {
                        shared.fetchMemberData(memberId: member.id) { member in
                            if let m = member {
                                print(m)
                            } else {
                                print("member fetch error")
                            }
                        }
                    }, label: {
                        Text("Member 요청")
                    })
                    .border(Color.black)
                    
                    Button(action: {
                        shared.fetchItemListData(memberId: itemList.memberId, completion: { itemLists in
                            if let i = itemLists {
                                print(i)
                            } else {
                                print("itemList fetch error")
                            }
                            
                        })
                    }, label: {
                        Text("ItemList 요청")
                    })
                    .border(Color.black)
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            shared.fetchRoomData(memberId: member.id, completion: { rooms in
                                if let rs = rooms {
                                    for r in rs {
                                        print(r)
                                    }
                                } else {
                                    print("error")
                                }
                                
                            })
                        }, label: {
                            Text("유저 id로 방요청 ")
                        })
                        .border(Color.black)
                    }
                }
            }
            
            
            
        }
        .padding(.horizontal, 8)
        
      
    
    }
    
    
}

#Preview {
    FirebaseTestView()
}
