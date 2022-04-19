//
//  SettingsRow.swift
//  framework-test
//
//  Created by Benjamin Tang on 06/04/2022.
//

import SwiftUI

public struct SettingsRow: View {
  private var title: String
  private var image: String
  private var showDisclosure: Bool

  /// A generic settings row which can be customised according to your needs.
  /// - Parameters:
  ///   - title: The title of the row.
  ///   - image: The SF symbol for the row.
  ///   - showDisclosure: Show disclosure icon for action or navigation.
  public init(_ title: String, image: String, showDisclosure: Bool = false) {
    self.image = image
    self.title = title
    self.showDisclosure = showDisclosure
  }

  public var body: some View {
    HStack(spacing: 8) {
      Image(systemName: image)
        .font(.headline)
        .frame(minWidth: 25, alignment: .leading)
        .accessibility(hidden: true)

      Text(title)

      Spacer()

      if showDisclosure {
        Image(systemName: "chevron.right")
          .accessibility(hidden: true)
      }
    }
    .padding(.vertical)
    .foregroundColor(.accentColor)
  }
}
