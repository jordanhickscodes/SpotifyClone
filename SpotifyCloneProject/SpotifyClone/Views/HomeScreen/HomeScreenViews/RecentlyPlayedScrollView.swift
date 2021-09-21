//
//  RecentlyPlayedScrollView.swift
//  SpotifyClone
//
//  Created by Gabriel on 9/3/21.
//

import SwiftUI

struct RecentlyPlayedScrollView: View {
  @State var medias: [SpotifyModel.MediaItem]
  
  var sectionTitle = "Recently Played"
  
  var body: some View {
    VStack(spacing: spacingSmallItems) {
      Text(sectionTitle)
        .spotifyTitle(withPadding: true)
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(alignment: .top, spacing: spacingBigItems) {
          ForEach(medias) { media in
            SmallSongItem(imageURL: media.imageURL,
                          title: media.title)
              .onAppear{
                if medias.count > 5 {
                  if media.id == medias[medias.count - 3].id {

                  }
                }
              }
          }
        }.padding(.horizontal, 25)
      }
    }
  }
}
