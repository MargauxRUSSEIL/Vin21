//
//  Model.swift
//  vin21
//
//  Created by Margaux RUSSEIL on 08/02/2021.
//

import Foundation
import SwiftUI
import Combine
import Firebase


class Model: ObservableObject {
    @Published var user: User?
    @Published var collection: CollectionReference?
    @Published var etageres = [Etagere]()
    
    // Model doit maintenir un ensemble de "plomberies" (robinet -> lavabo)
    var subscriptions = Set<AnyCancellable>()
    
    
    func listenFirebase() {
        Auth.auth().userPublisher
            .assign(to: \.user, on: self)
            .store(in: &subscriptions)

        $user
            .compactMap { $0 }
            .map { Firestore.firestore().collection($0.uid) }
            .assign(to: \.collection, on: self)
            .store(in: &subscriptions)

        $collection
            .compactMap { $0 }
            .map { $0.items(ofType: Etagere.self) }
            .switchToLatest()
            .handleEvents(receiveCompletion: handleCompletionError)
            .replaceError(with: [])
            .assign(to: \.etageres, on: self)
            .store(in: &subscriptions)
    }

    
    
    // Si user n'est pas défini, noSignedUser prend la valeur true
    // Si user est défini, noSignedUser prend la valeur false
    var noSignedUser: Bool {
        user == .none
    }
    
    
    func handleCompletionError(completion: Subscribers.Completion<Error>) {
        switch (completion) {
        case .finished: break
        case .failure(let error): print("Error: \(error.localizedDescription)")
        }
    }
    
        
    
    func signIn(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    

    func signOut() {
        try? Auth.auth().signOut()
    }
    
    
    func add(etagere: Etagere) {
        guard let collection = collection else { return }
        do {
            _ = try collection.addDocument(from: etagere)
        } catch {
            print("Add error: \(error.localizedDescription)")
        }
    }


    func deleteEtagere(id: String) {
        guard let collection = collection else { return }
        collection.document(id).delete()
    }

    
    func updateEtagere(id: String, with etagere: Etagere) {
        guard let collection = collection else { return }
        do {
            _ = try collection.document(id).setData(from: etagere)
        } catch {
            print("Update error: \(error.localizedDescription)")
        }
    }

    
//    func getWines() {
//        guard let wineCollection = wineCollection else { return }
//
//        wineCollection.addSnapshotListener { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else {
//              print("No documents")
//              return
//            }
//
//            self.wines = documents
//                .compactMap { queryDocumentSnapshot -> Wine? in
//                    return try? queryDocumentSnapshot.data(as: Wine.self)
//                }
//                .sorted { (wine0, wine1) -> Bool in
//                    wine0.title < wine1.title
//                }
//          }
//    }
    
    // Robinet qui émet un nouveau [Wine] pour chaque changement dans les documents de collection
    func winesFromCollection(
        _ collection: CollectionReference
    ) -> AnyPublisher<[Wine], Error> {
        
        let winesSubject = PassthroughSubject<[Wine], Error>()

        let registration = collection.addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                winesSubject.send(completion: .failure(error))
                return
            }
            
            guard let documents = querySnapshot?.documents else { return }
              
            let wines = documents.compactMap { queryDocumentSnapshot -> Wine? in
                try? queryDocumentSnapshot.data(as: Wine.self)
            }
            winesSubject.send(wines)
          }
        
        return winesSubject
            .handleEvents(receiveCancel: { registration.remove() })
            .eraseToAnyPublisher()
    }
    
}
