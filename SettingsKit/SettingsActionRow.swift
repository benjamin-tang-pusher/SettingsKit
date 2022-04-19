//
//  SettingsActionRow.swift
//  framework-test
//
//  Created by Benjamin Tang on 06/04/2022.
//

import SwiftUI

public struct SettingsActionRow: View {
  private var image: String
  private var title: String
  private var action: () -> ()

  /// A generic settings row which can be customised according to your needs.
  /// - Parameters:
  ///   - title: The title of the row.
  ///   - image: The SF symbol for the row.
  ///   - action: The custom action that you want to perform on tapping the row.
  public init(_ title: String, image: String, action: @escaping () -> ()) {
    self.image = image
    self.title = title
    self.action = action
  }

  public var body: some View {
    Button(action: action) {
      SettingsRow(title, image: image, showDisclosure: true)
    }
    .buttonStyle(PlainButtonStyle())
  }
}
