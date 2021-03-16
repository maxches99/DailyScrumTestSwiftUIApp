//
//  CardView.swift
//  DailyScrumTestSwiftUIApp
//
//  Created by Max Chesnikov on 14.03.2021.
//

import SwiftUI
import Neumorphic

struct CardView: View {
    let scrum: DailyScrum
    var body: some View {
        VStack(alignment: .leading) {
            Text(scrum.title)
                .font(.headline)
            Spacer()
            HStack {
                Label("\(scrum.attendees.count)", systemImage: "person.3")
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(Text("Количество участников"))
                    .accessibilityValue(Text("\(scrum.attendees.count)"))
                Spacer()
                Label("\(scrum.lengthInMinutes)", systemImage: "clock")
                    .padding(.trailing, 20)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(Text("Длина пиздилова"))
                    .accessibilityValue(Text("\(scrum.lengthInMinutes) minutes"))
            }
            .font(.caption)
        }
        .padding()
		.background(
			scrum.color
				.blur(radius: 10)
		)
		.cornerRadius(30)
    }
}

struct CardView_Previews: PreviewProvider {
    static var scrum = DailyScrum.data[0]
    static var previews: some View {
        CardView(scrum: scrum)
			.previewLayout(.sizeThatFits)
    }
}
