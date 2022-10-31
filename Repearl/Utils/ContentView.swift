//
//  ContentView.swift
//  Repearl
//
//  Created by Abhinav Kolli on 8/13/22.
//

import Foundation
import SwiftUI
 
struct ContentView: View {
    var body: some View {
        VStack {
            ZStack (alignment: .leading) {
                VStack (alignment: .leading) {
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "line.3.horizontal")
                                .resizable()
                                .foregroundColor(.primary)
                                .frame(width: 24, height: 24)
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "magnifyingglass").resizable()
                                .frame(width: 24, height: 24)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.secondary)
                                .clipShape(Circle())
                                .shadow(radius: 8)
                        }
                    }
                    Text("Restaurants").font(.title).foregroundColor(.secondary)
                    Text("6 Results").font(.title).foregroundColor(.primary)
                     
                    ScrollView(.vertical, showsIndicators: false) {
                        HStack (spacing: 10) {
                            //Button(action: {
                                
                            //}) {
                            //    FoodItem()
                            }
                            //Button(action: {}) {
                            //    FoodItem()
                            }
                        }
                    }
                }
 
            //}.padding().edgesIgnoringSafeArea(.bottom)
             
            Button(action: {}) {
                Image(systemName: "cart").resizable().frame(width: 12, height: 12).padding().background(Color.yellow).clipShape(Circle()).padding()
                Text("0 items").foregroundColor(.white).padding(.horizontal)
            }.background(Color.black.opacity(0.8)).clipShape(Capsule())
                .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 20)
            
        }
//    }
//}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
