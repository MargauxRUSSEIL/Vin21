//
//  vin21App.swift
//  vin21
//
//  Created by Margaux RUSSEIL on 08/02/2021.
//

import SwiftUI
import Firebase

@main
struct Vin21App: App {
    @UIApplicationDelegateAdaptor(Delegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            let model = delegate.model
            ContentView(model: model, isShowingLogin: false)
        }
    }
}


class Delegate : NSObject, UIApplicationDelegate {
    let model = Model()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        model.listenFirebase()
        return true
    }
}
