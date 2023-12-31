//
//  SettingsItem.swift
//  GoParty
//
//  Created by Malo Beaugendre on 06/08/2023.
//

import SwiftUI

struct SettingsItem: View {
    var icon: String = ""
    var title: String = ""
    var selectedValue: String?
    var noChevron: Bool = false
    
    var body: some View {
        HStack{
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(Color("color_primary"))
            
            VStack(alignment: .leading, spacing: 6){
                HStack{
                    Text(title)
                        .fontWeight(.semibold)
                        .padding(.top, 3)
                    Spacer()
                    
                    selectedValue != nil ?
                    Text(selectedValue ?? "")
                        .foregroundColor(Color("color_bg_inverted").opacity(0.5))
                        .padding(.top, 3): nil
                    
                    if !noChevron {
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color("color_primary"))
                    }
                }
                
                Divider()
                    .padding(.top, 8)
            }
            .padding(.horizontal, 10)
            .padding(.top, 2)
        }
        .padding(.vertical, 10)
    }
}
