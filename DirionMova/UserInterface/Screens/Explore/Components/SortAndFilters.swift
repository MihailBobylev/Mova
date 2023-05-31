//
//  SortAndFilters.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 01.11.2022.
//

import SwiftUI

struct SortAndFilters: View {
    @ObservedObject var exploreViewModel: ExploreViewModel
    let resetAction: () -> ()
    let applyAction: () -> ()
    
    let filterRows = [GridItem(.flexible())]
    
    var body: some View {
        VStack(spacing: 0) {
            Capsule()
                .frame(width: 38.dhs, height: 3.dvs)
                .foregroundColor(.Explore.detentHandle)
                .padding(.top, 8.dvs)
            
            Text("Sort & Filter")
                .foregroundColor(.Explore.sortFilterText)
                .font(.Urbanist.Bold.size(of: 24.dfs))
                .padding([.top, .bottom], 24.dvs)
            
            Divider()
                .padding([.leading, .trailing], 24.dhs)
                .foregroundColor(.Explore.sortDevider)
            
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    Text(SectionTitle.genre.rawValue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.Urbanist.Bold.size(of: 20.dfs))
                        .padding(.leading, 24.dhs)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12.dhs) {
                            Spacer()
                                .frame(width: 12.dhs)
                            ForEach(exploreViewModel.genres, id: \.self) { genre in
                                GenreElement(exploreViewModel: exploreViewModel, genre: genre) { isSelected in
                                    if isSelected {
                                        exploreViewModel.withGenres.append(String(genre.id))
                                        exploreViewModel.selectedFilters.append(genre.name)
                                    } else {
                                        exploreViewModel.withGenres = exploreViewModel.withGenres.filter { $0 != String(genre.id) }
                                        exploreViewModel.selectedFilters = exploreViewModel.selectedFilters.filter{ $0 != genre.name }
                                    }
                                }
                            }
                            Spacer(minLength: 0)
                        }
                        .frame(height: 38.dvs)
                        .padding(.top, 24.dvs)
                    }
                }
                .padding(.top, 24.dvs)
                
                VStack(spacing: 0) {
                    Text(SectionTitle.periods.rawValue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.Urbanist.Bold.size(of: 20.dfs))
                        .padding(.leading, 24.dhs)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12.dhs) {
                            Spacer()
                                .frame(width: 12.dhs)
                            ForEach(exploreViewModel.timePeriods, id: \.self) { period in
                                YearElement(exploreViewModel: exploreViewModel, text: period) {
                                    exploreViewModel.selectedFilters = exploreViewModel.selectedFilters.filter { !exploreViewModel.timePeriods.contains($0)
                                    }

                                    if exploreViewModel.year == period {
                                        exploreViewModel.year = ""
                                    } else {
                                        exploreViewModel.year = period
                                        exploreViewModel.selectedFilters.append(period)
                                    }
                                }
                            }
                            Spacer(minLength: 0)
                        }
                        .frame(height: 38.dvs)
                        .padding(.top, 24.dvs)
                    }
                }
                .padding(.top, 24.dvs)
                
                VStack(spacing: 0) {
                    Text(SectionTitle.sort.rawValue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.Urbanist.Bold.size(of: 20.dfs))
                        .foregroundColor(.Explore.sortTitlesText)
                        .padding(.leading, 24.dhs)
                    
                    HStack(spacing: 12.dhs) {
                        SortElement(exploreViewModel: exploreViewModel, text: SortTypes.popularity.rawValue) {
                            
                            if exploreViewModel.sortBy.rawValue == SortTypes.popularity.rawValue {
                                exploreViewModel.sortBy = .empty
                                exploreViewModel.selectedFilters = exploreViewModel.selectedFilters.filter{ $0 != SortTypes.popularity.rawValue }
                            } else {
                                exploreViewModel.selectedFilters = exploreViewModel.selectedFilters.filter{ $0 != SortTypes.lastRelease.rawValue }
                                exploreViewModel.sortBy = .popularity
                                exploreViewModel.selectedFilters.append(SortTypes.popularity.rawValue)
                            }
                        }
                        
                        SortElement(exploreViewModel: exploreViewModel, text: SortTypes.lastRelease.rawValue) {
                            
                            if exploreViewModel.sortBy.rawValue == SortTypes.lastRelease.rawValue {
                                exploreViewModel.sortBy = .empty
                                exploreViewModel.selectedFilters = exploreViewModel.selectedFilters.filter{ $0 != SortTypes.lastRelease.rawValue }
                            } else {
                                exploreViewModel.selectedFilters = exploreViewModel.selectedFilters.filter{ $0 != SortTypes.popularity.rawValue }
                                exploreViewModel.sortBy = .lastRelease
                                exploreViewModel.selectedFilters.append(SortTypes.lastRelease.rawValue)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 38.dvs, alignment: .leading)
                    .padding(.leading, 24.dhs)
                    .padding(.top, 24.dvs)
                }
                .padding(.top, 24.dvs)
            }
            
            Divider()
                .padding([.leading, .trailing], 24.dhs)
                    .padding(.top, 24.dvs)
            
            HStack {
                Button("Reset") {
                    resetAction()
                }
                .buttonStyle(GrayButton())
                .padding(.leading, 24.dhs)
                .padding(.trailing, 12.dhs)
                
                
                Button("Apply") {
                    applyAction()
                }
                .buttonStyle(MovaButton())
                .padding(.trailing, 24.dhs)
            }
            .frame(height: 58.dvs)
            .padding(.top, 24.dvs)
        }
        .onDisappear {
            exploreViewModel.isReset = true
        }
        .padding(.bottom, 48.dvs)
        .background(Color(.MOVA.Greyscale100Dark2))
    }
}

struct SortAndFilters_Previews: PreviewProvider {
    static var previews: some View {
        SortAndFilters(exploreViewModel: ExploreViewModel()) {
            
        } applyAction: {}
    }
}
