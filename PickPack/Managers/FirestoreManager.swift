//
//  FirestoreManager.swift
//  MaDang
//
//  Created by LDW on 8/21/24.
//

import Foundation
import FirebaseFirestore

final class FirestoreManager: ObservableObject {
    @Published var reviews: [Room] = []
    
    private var db = Firestore.firestore()
    
    static let shared = FirestoreManager()
    private init() {}
    
    // MARK: - 유저 등록

    func addUser(id: String, name: String) {
           let usersCollection = db.collection("users")
           
           // 같은 ID가 있는지 확인하는 쿼리
           usersCollection.whereField("id", isEqualTo: id).getDocuments { (querySnapshot, error) in
               if let error = error {
                   print("Error checking for existing user: \(error)")
                   return
               }
               
               if let documents = querySnapshot?.documents, !documents.isEmpty {
                   // 이미 같은 ID를 가진 유저가 있는 경우, 상태 메세지 출력
                   print("User with id \(id) already exists.")
               } else {
                   // 같은 ID를 가진 유저가 없는 경우, 새로 추가
                   let newUser = User(id: id, name: name)
                   
                   do {
                       let _ = try usersCollection.addDocument(from: newUser)
                       print("User added with id \(id)")
                   } catch {
                       print("Error adding user: \(error)")
                   }
               }
           }
       }
    
}

