import Foundation
import SwiftUI

enum FetchStatus {
    case notStarted
    case fetching
    case success
    case failed(error: Error)
}


class ViewModel {
    
    private(set) var status: FetchStatus = .notStarted
    private let fetcher = FetchService();
    
    var quote: Quote
    var character: Character
    var episode: Episode
    
    init() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let quoteData = try! Data(contentsOf: Bundle.main.url(forResource: "samplequote", withExtension: "json")!)
        quote = try! decoder.decode(Quote.self, from: quoteData)
        
        let characterData = try! Data(contentsOf: Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!)
        character = try! decoder.decode(Character.self, from: characterData)
        
        let episodeData = try! Data(contentsOf: Bundle.main.url(forResource: "sampleepisode", withExtension: "json")!)
        episode = try! decoder.decode(Episode.self, from:episodeData)
        
    }

    func getQuoteData(for show: String) async {
        status = .fetching
        
        do {
            quote = try await fetcher.fetchQoute(from: show)
            
            character = try await fetcher.fetchCharacter(from: show)
            
            character.death = try await fetcher.fetchDeath(from: character.name)
            
        } catch {
            status = .failed(error: error)
        }
    }
    
    func getEpisode(for show: String) async {
        status = .fetching
        
        do {
            if let unwrapepisode = try await fetcher.fetchEpisode(from: show) {
                episode = unwrapepisode
                
                status = .success
            }
        } catch {
            status = .failed(error: error)
        }
    }
    
    
    func getData(for show: String) async {
        status = .fetching
        
        do {
            quote = try await fetcher.fetchQoute(from: show)
            
            character = try await fetcher.fetchCharacter(from: show)
            
            character.death = try await fetcher.fetchDeath(from: character.name)
            
        } catch {
            status = .failed(error: error)
        }
    }
}

