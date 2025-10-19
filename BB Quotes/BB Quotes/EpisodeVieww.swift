//
//  EpisodeVieww.swift
//  BB Quotes
//
//  Created by Joel Espinal on 16/9/24.
//

import SwiftUI


struct EpisodeVieww: View {
    
    let episode: Episode

    init(episode: Episode) {
        self.episode = episode
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(episode.title)
                .font(.largeTitle)
            
            Text(episode.seasonEpisode)
                .font(.title2)
            
            AsyncImage(url: episode.image){image in
                image.resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 15))
            } placeholder: {
                ProgressView()
            }
            
            Text(episode.synopsis)
                .font(.title3)
                .minimumScaleFactor(0.5)
                .padding(.bottom)
            
//            Text("Written By: \(episode.writterBy)")
            
            Text("Directed By: \(episode.directedBy)")
            Text("Aired: \(episode.airDate)")
            
        }
        .padding()
        .foregroundStyle(.white)
        .background(.opacity(0.6))
        .clipShape(.rect(cornerRadius: 25))
        .padding(.horizontal)
    }
}

#Preview {
    EpisodeVieww(episode: ViewModel().episode)
}
