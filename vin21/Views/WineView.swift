//
//  WineView.swift
//  vin21
//
//  Created by Margaux RUSSEIL on 10/02/2021.
//

import Foundation
import SwiftUI

struct WineView: View {
    let model: Model
    let wine: Wine
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
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
                    
                Text("x")
                    .bold()
                Text(String(wine.number))
                    .bold()
                Text(wine.title)
            }
            
            HStack {
                if wine.producer != "" {
                    Text(wine.producer)
                }
                if wine.millesime != "" {
                    Text(" - ")
                    Text(wine.millesime)
                }
            }
        }
        
        
        
    }
}
