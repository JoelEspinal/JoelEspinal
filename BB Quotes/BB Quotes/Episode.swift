//
//  Episode.swift
//  BB Quotes
//
//  Created by Joel Espinal on 22/8/24.
//

import Foundation

struct Episode: Decodable {
    let episode: Int    //101
    let title: String
    var image: URL
    let synopsis: String
//    var WritenBy: String
    var directedBy: String
    var airDate: String
    
    //  let imageResult = try JSONEncoder().encode(imageRecived);
    
    var seasonEpisode: String {
        var episodeString = String(episode)
        let season = episodeString.removeFirst()
        
        if episodeString.first! == "0" {
            episodeString = String(episodeString.removeLast())
        }
        
        return "Season \(season) Episode \(episodeString)"
    }
    
    mutating func imageEpisode( _ value: String) {
        let fileUrl = URL(string: value);
        image = fileUrl ?? URL(string: "https://static1.colliderimages.com/wordpress/wp-content/uploads/2023/02/breaking-bad-tv-poster.jpg?q=50&fit=crop&w=480&dpr=1.5")!;
    }
}

    
