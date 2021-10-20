//
//  MyLibraryItemsScrollView.swift
//  SpotifyClone
//
//  Created by Gabriel on 10/20/21.
//

import SwiftUI

struct MyLibraryItemsScrollView: View {
  @EnvironmentObject var myLibraryVM: MyLibraryViewModel
  @EnvironmentObject var mediaDetailVM: MediaDetailViewModel
  @State var medias: [SpotifyModel.MediaItem]

  init(medias: [SpotifyModel.MediaItem]) {
    var mediasWithPinnedItems: [SpotifyModel.MediaItem]
    mediasWithPinnedItems = [FixedSectionsItems.likedSongs, FixedSectionsItems.yourEpisodes]
    mediasWithPinnedItems += medias
    self.medias = mediasWithPinnedItems
  }

  var body: some View {
    ScrollView(showsIndicators: false) {
      VStack {
        ForEach(medias) { media in
          Group {
            if media.mediaType == .artist {
              MyLibraryArtistMediaItem(name: media.title, imageURL: media.imageURL)
            } else if media.mediaType == .show {
              MyLibraryShowMediaItem(title: media.title, authorName: media.authorName.first!, imageURL: media.imageURL)
            } else {
              MyLibraryDefaultMediaItem(title: media.title, subTitle: "Playlist • \(media.authorName.first!) ", imageURL: media.imageURL, pinnedItem: media.id == "liked-songs" || media.id == "your-episodes")
            }
          }
          .frame(height: 80)
          .padding(.bottom, 10)
          .onTapGesture {
            guard media.id != "liked-songs" || media.id != "your-episodes" else {
              // Implement their screens, currently we can't navigate using them
              return
            }
            myLibraryVM.changeSubpageTo(getDetailScreen(for: media.mediaType), mediaDetailVM: mediaDetailVM, withData: media)
          }
          .onLongPressGesture { print(myLibraryVM.currentSubPage) }
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .padding(.bottom, Constants.paddingBottomSection)
      .padding(.top, 60 + Constants.paddingStandard)
    }
    .padding(.horizontal, Constants.paddingStandard)
  }

  
  // Those are items that should be fixed on top of the scroll view and cannot be fetched from API.
  fileprivate struct FixedSectionsItems {
    static let likedSongs = SpotifyModel.MediaItem(title: "Liked Songs", previewURL: "Playlist • 33 songs", imageURL: "https://i.ibb.co/w4jgnbs/liked-songs-300.png", authorName: ["Spotify"], author: nil, mediaType: .playlist, id: "liked-songs", details: SpotifyModel.DetailTypes.playlists(playlistDetails:SpotifyModel.PlaylistDetails(description: "Saved and downloaded episodes", playlistTracks: SpotifyModel.PlaylistTracks(numberOfSongs: 0, href: ""), owner: SpotifyModel.MediaOwner(displayName: "", id: "0"), id: "")))

    static let yourEpisodes = SpotifyModel.MediaItem(title: "Your Episodes", previewURL: "Saved & downloaded episodes", imageURL: "https://i.ibb.co/bbZH8pS/Screen-Shot-2021-10-20-at-12-37-06-AM.png", authorName: ["Spotify"], author: nil, mediaType: .playlist, id: "your-episodes", details: SpotifyModel.DetailTypes.playlists(playlistDetails:SpotifyModel.PlaylistDetails(description: "", playlistTracks: SpotifyModel.PlaylistTracks(numberOfSongs: 0, href: ""), owner: SpotifyModel.MediaOwner(displayName: "", id: "1"), id: "")))
  }

  private func getDetailScreen(for mediaType: SpotifyModel.MediaTypes) -> MyLibraryViewModel.MyLibrarySubpage {
    switch mediaType {
    case .show:
      return .showDetail
    case .track:
      return .trackDetail
    case .album:
      return .albumDetail
    case .playlist:
      return .playlistDetail
    case .artist:
      return .artistDetail
    case .episode:
      return .episodeDetail
    }
  }

}