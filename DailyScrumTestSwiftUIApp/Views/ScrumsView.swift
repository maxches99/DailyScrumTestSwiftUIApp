//
//  ScrumsView.swift
//  DailyScrumTestSwiftUIApp
//
//  Created by Max Chesnikov on 14.03.2021.
//

import SwiftUI
import Neumorphic

struct ScrumsView: View {
    
    @Binding var scrums: [DailyScrum]
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var isPresented = false
    @State private var newScrumData = DailyScrum.Data()
    
    let saveAction: () -> Void
    
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground)
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                LazyVStack(pinnedViews: .sectionHeaders) {
                    ForEach(scrums) { scrum in
                        NavigationLink(destination: DetailView(scrum: binding(for: scrum))) {
                            CardView(scrum: scrum)
                        }
                        .accentColor(scrum.color.accessibleFontColor)
                        .padding([.top, .leading, .trailing])
                    }
                }
                .listStyle(SidebarListStyle())
                .navigationTitle("Ебаные митинги")
                .navigationBarItems(trailing: Button(action: {
                    isPresented = true
                }) {
                    Image(systemName: "plus")
                })
                .sheet(isPresented: $isPresented) {
                    NavigationView {
                        EditView(scrumData: $newScrumData)
                            .navigationBarItems(leading: Button("Закрыть") {
                                isPresented = false
                            }, trailing: Button("Добавить") {
                                let newScrum = DailyScrum(title: newScrumData.title, attendees: newScrumData.attendees,
                                                          lengthInMinutes: Int(newScrumData.lengthInMinutes), color: newScrumData.color)
                                scrums.append(newScrum)
                                isPresented = false
                            })
                    }
                }
                .onChange(of: scenePhase) { phase in
                    if phase == .inactive { saveAction() }
                }}
        }
    }
    
    private func binding(for scrum: DailyScrum) -> Binding<DailyScrum> {
        guard let scrumIndex = scrums.firstIndex(where: { $0.id == scrum.id }) else {
            fatalError("Can't find scrum in array")
        }
        return $scrums[scrumIndex]
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView(scrums: .constant(DailyScrum.data), saveAction: {})
        }
        .background(Color.Neumorphic.main)
    }
}
