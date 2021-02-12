//
//  ContentView.swift
//  vin21
//
//  Created by Margaux RUSSEIL on 08/02/2021.
//


import SwiftUI
import Firebase

struct ContentView: View {
    @ObservedObject var model: Model
    
    // Etat définissant l'affichage de la vue de login
    @State var isShowingLogin: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 50, alignment: .center)
                    .padding(.leading)
                Spacer()
                if (model.user?.email == .none) {
                    Text("Hello, world!")
                        .padding()
                } else {
    //                Text("Hello, \(model.user!.email!)")
    //                    .padding()
                    Button("Sign Out") {
                        model.signOut()
                        
                        // Sign Out sans Future
        //                do {
        //                    try Auth.auth().signOut()
        //                    model.user = .none
        //                } catch {
        //                    print("Sign Out Error: \(error.localizedDescription)")
        //                }
                    }.padding()
                }
            }
//            Button("Add Wine") {
//                model.add(wine: Wine.test())
//            }.padding()
            
//            List(model.wines) { wine in
//                WineView(model: model, wine: wine)
//            }

            
            
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                WineCellar(model: model)
                    .tabItem {
                        Image("wine-shelf")
                        Text("Wine Cellar")
                    }
                MyWines()
                    .tabItem {
                        Image("glass-with-wine")
                        Text("My Wines")
                    }
                SearchView()
                    .tabItem {
                        Image("loupe")
                        Text("Search")
                    }
            }
            .accentColor(.black)
            .onAppear() {
                UITabBar.appearance().barTintColor = .white
            }
            
        }
        
        // Observation de la valeur de model.user
        // Si user est défini, isShowingLogin prend la valeur false
        // Si user n'est pas défini, isShowingLogin prend la valeur true
        .onChange(of: model.user) { (user) in
            isShowingLogin = model.noSignedUser
        }
        
        // La vue LoginView est affichée par dessus VStack lorsque isShowingLogin est vrai
        .sheet(isPresented: $isShowingLogin) {
            LoginView(model: model)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model = Model()
        return ContentView(model: model, isShowingLogin: model.noSignedUser)
    }
}
