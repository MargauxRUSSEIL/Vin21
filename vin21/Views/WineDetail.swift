//
//  WineDetail.swift
//  vin21
//
//  Created by Margaux RUSSEIL on 11/02/2021.
//

import SwiftUI

struct WineDetail: View {
    var wine: Wine
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack(alignment: .bottom) {
                if wine.color == "rouge" {
                    Image("wine-bottle-rouge")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 50, alignment: .center)
                } else if wine.color == "blanc" {
                    Image("wine-bottle-blanc")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 50, alignment: .center)
                } else if wine.color == "rose" {
                    Image("wine-bottle-rose")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 50, alignment: .center)
                }
                Text(wine.title.uppercased())
                    .font(.title)
                Spacer()
            }
            .padding()

            VStack(alignment: .leading) {
                
                HStack {
                    Text("Producteur : ")
                        .bold()
                    Text(wine.producer)
                }
                .padding(.bottom)
                
                HStack {
                    Text("Localisation : ")
                        .bold()
                    Text(wine.region)
                }
                .padding(.bottom)
                
                HStack {
                    Text("Cépage : ")
                        .bold()
                    Text(wine.cepage)
                }
                .padding(.bottom)
                
                HStack {
                    Text("Millésime : ")
                        .bold()
                    Text(wine.millesime)
                }
                .padding(.bottom)
                
                HStack {
                    Text("Quantité : ")
                        .bold()
                    Text(String(wine.number))
                }
                .padding(.bottom)
                
                HStack {
                    Text("Etagère : ")
                        .bold()
                    Text(wine.place)
                }
                .padding(.bottom)
                
                HStack {
                    Text("Commentaire : ")
                        .bold()
                    Text(wine.comment)
                }
                .padding(.bottom)
                
                HStack {
                    Text("A boire : ")
                        .bold()
                    Text(wine.when)
                }
                .padding(.bottom)
                
                HStack {
                    Text("A boire avant : ")
                        .bold()
                    Text(wine.before)
                }
                .padding(.bottom)
                
            }
            
            Spacer()

        }
        .padding()
        // Enlever l'espace en trop entre la bar tool et le contenu de la page
        .navigationBarTitleDisplayMode(.inline)
        
        
    }
    
}
