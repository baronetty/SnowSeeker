//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Leo  on 20.03.24.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(Favorites.self) var favorites
    
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                
                HStack {
                    if horizontalSizeClass == .compact && dynamicTypeSize > .large {
                        VStack(spacing: 10) { ResortDetailsView(resort: resort) }
                        VStack(spacing: 10) { SkiDetailsView(resort: resort) }
                    } else {
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                    
                    
                }
                .padding(.vertical)
                .background(.primary.opacity(0.1))
                
                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            Button {
                                selectedFacility = facility
                                showingFacility = true
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
                
                Button(favorites.contains(resort) ? "Remove from favorites" : "Add to favorites") {
                    if favorites.contains(resort) {
                        favorites.remove(resort)
                    } else {
                        favorites.add(resort)
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .alert(selectedFacility?.name ?? "more information", isPresented: $showingFacility, presenting: selectedFacility) { _ in
        } message: { facility in
            Text(facility.description)
        }
    }
}

#Preview {
    ResortView(resort: .example)
        .environment(Favorites())
}
