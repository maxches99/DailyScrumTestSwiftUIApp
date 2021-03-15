//
//  DailyScrumTestSwiftUIAppApp.swift
//  DailyScrumTestSwiftUIApp
//
//  Created by Max Chesnikov on 14.03.2021.
//

import SwiftUI

@main
struct DailyScrumTestSwiftUIAppApp: App {
    @ObservedObject private var data = ScrumData()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $data.scrums) {
                    data.save()
                }
            }
            .onAppear {
                data.load()
            }
        }
    }
}
