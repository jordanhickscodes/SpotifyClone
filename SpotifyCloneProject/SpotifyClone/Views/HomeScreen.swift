//
//  HomeScreen.swift
//  SpotifyClone
//
//  Created by Gabriel on 8/31/21.
//

import SwiftUI

struct HomeScreen: View {
  var body: some View {
    RadialGradientBackground()
    ScrollView(showsIndicators: false) {
      VStack(alignment: .leading) {
      }.padding(.vertical, 25)
    }
  }
}

struct RadialGradientBackground: View {
  let backgroundGradientColor = Color(red: 0.051, green: 0.608, blue: 0.784)

  var body: some View {
    RadialGradient(gradient: Gradient(colors: [backgroundGradientColor.opacity(0.35), backgroundGradientColor.opacity(0.0)]),
                   center: .topLeading,
                   startRadius: 10,
                   endRadius: 600)
      .ignoresSafeArea()
  }
}
