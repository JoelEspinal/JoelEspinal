//
//  QuoteView.swift
//  BB Quotes
//
//  Created by Joel Espinal on 13/6/24.
//

import SwiftUI

struct FetchView: View {
    let viewModel = ViewModel()
    let show: String
    
    @State var showCharacterInfo = false
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack {
                Image(show.removeCaseAndSpaces())
                .resizable()
                .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)
                
                VStack(alignment: .center, content: {
                    switch viewModel.status {
                    case FetchStatus.notStarted:
                        EmptyView() 
                    case FetchStatus.fetching:
                        ProgressView()
                    case FetchStatus.success:
                        
                        Text("\"\(viewModel.quote.quote)\"")
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding()
                            .background(.black.opacity(0.5))
                            .clipShape(.rect(cornerRadius: 25))
                            .padding(.horizontal)
                        
                        ZStack(alignment: .bottom) {
                            AsyncImage(url: viewModel.character.images[0]) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()                         }
                            .frame(width: geo.size.width / 1.1, height: geo.size.height / 1.2)
                            
                            Text(viewModel.quote.author)
                                .foregroundStyle(.white)
                                .padding(10)
                                .frame(maxWidth: .infinity)
                                .background(.ultraThinMaterial)
                        }
                        .frame(width: geo.size.width / 1.1, height: geo.size.height / 1.2)
                        .clipShape(.rect(cornerRadius: 50))
                        .onTapGesture {
                            showCharacterInfo.toggle()
                        }
                        
                    case FetchStatus.failed(let error):
                        Text(error.localizedDescription)
                        
                    case FetchStatus.success:
                        EpisodeVieww(episode: viewModel.episode)
                    }
                   
                })
            
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .safeAreaInset(edge: VerticalEdge.bottom) {
            let episode = viewModel.episode // =  await viewModel.getEpisode(for: show)
             EpisodeVieww(episode: episode)
            HStack {
                
             Button("Show Sheet") {
                let episode = viewModel.episode // =  await viewModel.getEpisode(for: show)
                 EpisodeVieww(episode: episode)
                }
                .font(.title3)
                .foregroundColor(.white)
                .padding()
                .background(Color("\(show.removeSpaces())Button"))
                .clipShape(.rect(cornerRadius: 7))
                            
                
              Spacer()
//
                Button {
                    Task {
                        
                        await viewModel.getQuoteData(for: show)
                    }
                } label: {
                    Text("Get Random Quote")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color("\(show.removeSpaces())Button"))
                        .clipShape(.rect(cornerRadius: 7))
                    
                    //                    .shadow("\(show.removeSpaces(), .shadow, radius2)")
                    
                    
                }
            }
                .padding()
        }
        .sheet(isPresented: $showCharacterInfo, content: {
            CharacterView(character: viewModel.character, show: show)
        })
    }
}

#Preview {
    FetchView(show: Constants.bbName)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
