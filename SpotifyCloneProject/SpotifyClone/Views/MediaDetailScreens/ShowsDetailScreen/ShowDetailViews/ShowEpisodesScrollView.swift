//
//  ShowEpisodesScrollView.swift
//  SpotifyClone
//
//  Created by Gabriel on 9/28/21.
//

import SwiftUI

struct ShowEpisodesScrollView: View {
  @EnvironmentObject var mediaDetailVM: MediaDetailViewModel

  var medias: [SpotifyModel.MediaItem] {
    mediaDetailVM.mediaCollection[.shows(.episodesFromShow)]!
  }

  var body: some View {
    LazyVStack {
      ForEach(medias) { media in
        Group {
          let episodeDetails = SpotifyModel.getEpisodeDetails(for: media)
          EpisodeItem(title: media.title,
                      description: episodeDetails.description!,
                      imageURL: media.imageURL)
            .onAppear { testIfShouldFetchMoreData(basedOn: media) }
        }

      }
    }
    .padding(.top, 15)
  }

  func testIfShouldFetchMoreData(basedOn media: SpotifyModel.MediaItem) {
    if medias.count > 5 {
      if media.id == medias[medias.count - 4].id {
        MediaDetailViewModel.ShowsAPICalls.getEpisodesFromShows(mediaVM: mediaDetailVM, loadMoreEnabled: true)
      }
    }
  }

  struct EpisodeItem: View {
    var title: String
    var description: String
    var imageURL: String

    var body: some View {
      VStack(alignment: .leading, spacing: 12) {
          HStack (alignment: .center, spacing: 15) {
            RoundedRectangle(cornerRadius: 10)
              .foregroundColor(.spotifyMediumGray)
              .overlay(RemoteImage(urlString: imageURL))
              .mask(RoundedRectangle(cornerRadius: 10))
              .frame(width: 50, height: 50)
            Text(title)
              .font(.avenir(.heavy, size: 18))
            Spacer()
          }

        Group {

          Text(description)
            .font(.avenir(.medium, size: 14))
            .lineLimit(2)
            .opacity(0.7)
            .padding(.bottom, 5)
        }

        Text("Yesterday • 1h 55m") // TODO: Add real data
          .font(.avenir(.medium, size: 14))
          .opacity(0.6)
          .padding(.bottom, 5)

        HStack(spacing: 25) {
          Group {
            Circle()
              .foregroundColor(.clear)
              .overlay(Image("plus-circle").resizeToFit())
              .aspectRatio(contentMode: .fit)
            Circle()
              .foregroundColor(.clear)
              .overlay(Image("download-circle").resizeToFit())
              .aspectRatio(contentMode: .fit)
            Image("three-dots")
              .resizeToFit()
              .padding(.vertical, 3)
              .opacity(0.8)
          }
          Spacer()
          Circle()
            .foregroundColor(.black)
            .overlay(Image("circle-play").resizeToFit())
            .aspectRatio(contentMode: .fit)
            .frame(height: 35)
        }
        .frame(height: 25, alignment: .leading)
        Divider()
          .padding(.top, 5)
      }
      .frame(height: 200)
    }
  }

}
