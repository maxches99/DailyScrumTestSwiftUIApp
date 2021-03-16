//
//  EditView.swift
//  DailyScrumTestSwiftUIApp
//
//  Created by Max Chesnikov on 14.03.2021.
//

import SwiftUI

struct EditView: View {
    @Binding var scrumData: DailyScrum.Data
    @State private var newAttendee = ""
    var body: some View {
        List {
            Section(header: Text("Ебаная информация")) {
                TextField("Название", text: $scrumData.title)
                HStack {
                    Slider(value: $scrumData.lengthInMinutes, in: 5...30, step: 1.0) {
                        Text("Длина пиздилова")
                    }
                    .accessibilityValue(Text("\(Int(scrumData.lengthInMinutes)) минут"))
                    Spacer()
                    Text("\(Int(scrumData.lengthInMinutes)) минут")
                        .accessibilityHidden(true)
                }
                ColorPicker("Ебаный цвет", selection: $scrumData.color)
                    .accessibilityLabel(Text("Выбор цвета"))
            }
            Section(header: Text("Уебские участники")) {
                ForEach(scrumData.attendees, id: \.self) { attendee in
                    Text(attendee)
                }
                .onDelete { indices in
                    scrumData.attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("Новый участник", text: $newAttendee)
                    Button(action: {
                        withAnimation {
                            scrumData.attendees.append(newAttendee)
                            newAttendee = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel(Text("Добавить участника"))
                    }
                    .disabled(newAttendee.isEmpty)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}



struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(scrumData: .constant(DailyScrum.data[0].data))
    }
}
