//
//  Sample.swift
//  DiffableCollectionView
//
//  Created by João Campos on 12/07/2024.
//

struct Sample: Hashable {

	let title: String
	let subtitle: String
	let systemNameIcon: String

	init(title: String, systemNameIcon: String) {

		self.title = title
		self.subtitle = title + " subtitle"
		self.systemNameIcon = systemNameIcon
	}
}
