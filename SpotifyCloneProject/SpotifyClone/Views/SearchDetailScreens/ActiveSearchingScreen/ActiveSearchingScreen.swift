//
//  ActiveSearchingScreen.swift
//  SpotifyClone
//
//  Created by Gabriel on 10/8/21.
//

import SwiftUI

struct ActiveSearchingScreen: View {
  @EnvironmentObject var searchDetailVM: SearchDetailViewModel
  @State var searchInput = ""

  var body: some View {
    ZStack(alignment: .top) {
      LinearGradient(gradient: Gradient(colors: [.spotifyLightGray, .spotifyDarkGray]),
                     startPoint: .topLeading, endPoint: .bottomTrailing)
        .ignoresSafeArea()
      // The scroll view of responses
      Rectangle()
        .foregroundColor(.clear)
        .overlay( SearchResponsesScrollView() )
      VStack {
        TopSearchSection(searchInput: $searchInput)
          .onChange(of: searchInput) { _ in
            searchDetailVM.search(for: searchInput)
          }
        BottomBar(mainVM: MainViewModel())
      }
    }
  }
}



// MARK: - Preview

struct ActiveSearchingScreen_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      ActiveSearchingScreen()
      BottomBar(mainVM: MainViewModel())
    }
  }
}
