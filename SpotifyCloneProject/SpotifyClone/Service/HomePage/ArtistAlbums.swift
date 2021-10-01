//
//  ArtistAlbums.swift
//  SpotifyClone
//
//  Created by Gabriel on 9/29/21.
//

import SwiftUI

struct ArtistAlbums: View {
  let medias: [SpotifyModel.MediaItem]

  var body: some View {
    VStack {
      ForEach(medias) { media in
        HStack(spacing: 12) {
          VStack(alignment: .leading) {
            Text(media.title)
              .font(.avenir(.medium, size: 18))
              .lineLimit(1)
              .padding(.trailing, 40)
            Text("Album • 2020") // TODO: Add real data
              .font(.avenir(.medium, size: 14))
              .lineLimit(1)
              .opacity(0.7)
          }
          Spacer()
        }
        .padding(.top, 5)
      }
      SeeMoreButton()
        .padding(.top, 10)
        .opacity(0.7)
    }
  }
}