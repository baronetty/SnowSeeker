//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Leo  on 19.03.24.
//

import SwiftUI

struct ContentView: View {
    enum SortingOption {
        case `default`, alphabetical, byCountry
    }
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var favorites = Favorites()
    @State private var searchText = ""
    @State private var sortingOption: SortingOption = .default
    
    var filteredResorts: [Resort] {
        var filtered = resorts
        
        if !searchText.isEmpty {
            filtered = filtered.filter { $0.name.localizedStandardContains(searchText) }
        }
        
        switch sortingOption {
        case .default:
            return filtered
        case .alphabetical:
            return filtered.sorted { $0.name < $1.name }
        case .byCountry:
            return filtered.sorted { $0.country < $1.country }
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List(filteredResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(.rect(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                            
                            
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort.")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort by:", selection: $sortingOption) {
                        Text("Default").tag(SortingOption.default)
                        Text("Alphabetical").tag(SortingOption.alphabetical)
                        Text("By Country").tag(SortingOption.byCountry)
                    }
                }
            }
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }
}

#Preview {
    ContentView()
}
