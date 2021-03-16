//
//  String+Locale.swift
//  DailyScrumTestSwiftUIApp
//
//  Created by Студия on 16.03.2021.
//

import Foundation

extension String {
	var locale: String {
		NSLocalizedString(self, comment: "")
	}
}
