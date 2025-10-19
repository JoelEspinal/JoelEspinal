//
//  FetchService.swift
//  BB Quotes
//
//  Created by Joel Espinal on 12/6/24.
//

import Foundation

struct FetchService {
    
    
    enum FetchError: Error {
        case badResponse
    }
    
    private let baseURL = URL(string: "https://api.breakingbadquotes.xyz/v1")!
    private let bbURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    func fetchQoute(from show: String) async throws -> Quote {
        // Fetch data
        let quoteURL = baseURL.appending(path: "/quotes/1")
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // Handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        // Decode data
        let quote = try JSONDecoder().decode([Quote].self, from: data)
        
        return quote[0]
    }
    
    func fetchCharacter(from name: String) async throws ->  Character {
        let characterURL = bbURL.appending(path: "characters")
        let fetchURL = characterURL.appending(queryItems: [URLQueryItem(name: "name", value: name)])
        
        // Fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // Handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let characters = try decoder.decode([Character].self, from: data)
        
        return characters[0]
    }
    
    func fetchDeath(from character: String) async throws -> Death? {
        let deathURL = bbURL.appending(path: "deaths")
        
        // Fetch data
        let (data, response) = try await URLSession.shared.data(from: deathURL)
        
        // Handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let deaths = try decoder.decode([Death].self, from: data)
        
        for death in deaths {
            if character == death.character {
                return death
            }
        }
        
        return nil
    }
    
    func fetchEpisode(from show: String) async throws ->  Episode? {
        let episodeURL = bbURL.appending(path: "episodes")
        let fetchURL = episodeURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        // Fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // Handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            
            throw FetchError.badResponse
        } 
        
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let episodes = try decoder.decode([Episode].self, from: data)
        
        return episodes.randomElement()
    }
}

