//
//  ChangelogView.swift
//  REM
//
//  Created by Dev Seth on 1/22/24.
//

import SwiftUI

struct ChangelogView: View {
    
    var body: some View {
        Form {
            Section("A quick note")
            {
                Text("REM is a completely offline app; it never uploads your dream audio, description, or metadata anywhere.")
                    .font(.headline)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            }
            Section("Recently cooked") {
                List {
                    ChangeLogItem(date: createDate(year: 2024, month: 2, day: 4), title: "OpenAI Whisper integration!", description: "Extremely accurate, instant transcription across languages, all on-device using whisper-tiny. Express yourself freely with support for proper nouns, technical jargon, and bilingual sentences (i.e. intrasentential code-switching).")
                    ChangeLogItem(date: createDate(year: 2024, month: 2, day: 2), title: "Dream sharing", description: "Dream about something interesting? Share it with a friend using your texting app of choice!")
                }
            }
            Section("In the pipeline") {
                List {
                    Text("Custom tags: organize your dreams by topic, location, the people appearing in it; endless possibilities!")
                    Text("Backups: export your dream log to a .zip file, import it on a new device")
                    Text("DreamGPT: dream interpretation using an on-device language model")
                }
            }
        }
    }
}

#Preview {
    ChangelogView()
}
