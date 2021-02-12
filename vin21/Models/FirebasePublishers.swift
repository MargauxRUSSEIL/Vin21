//
//  FirebasePublisher.swift
//  vin21
//
//  Created by Margaux RUSSEIL on 12/02/2021.
//

import Foundation
import Combine
import Firebase


extension Auth {
    var userPublisher: AnyPublisher<User?, Never> {
        let userSubject = PassthroughSubject<User?, Never>()
        
        let handle = addStateDidChangeListener { (auth, user) in
            userSubject.send(user)
        }
        
        func removeHandle() { removeStateDidChangeListener(handle) }
        
        return userSubject
            .handleEvents(receiveCancel: removeHandle)
            .eraseToAnyPublisher()
    }
}


extension CollectionReference {
    func items<T: Decodable>(ofType type: T.Type) -> AnyPublisher<[T], Error> {
        
        let itemsSubject = PassthroughSubject<[T], Error>()
        
        let registration = addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                itemsSubject.send(completion: .failure(error))
                return
            }
            
            if let querySnapshot = querySnapshot {
                let documents = querySnapshot.documents
                let items = documents.compactMap { queryDocumentSnapshot -> T? in
                    try? queryDocumentSnapshot.data(as: T.self)
                }
                itemsSubject.send(items)
            }
          }
        
        return itemsSubject
            .handleEvents(receiveCancel: { registration.remove() })
            .eraseToAnyPublisher()
    }
    
    func itemsNoError<T: Decodable>(ofType type: T.Type) -> AnyPublisher<[T], Never> {
        items(ofType: type)
            .handleEvents(receiveCompletion: handleCompletionError)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
    func handleCompletionError(completion: Subscribers.Completion<Error>) {
        switch (completion) {
        case .finished: break
        case .failure(let error): print("Error: \(error.localizedDescription)")
        }
    }

}
