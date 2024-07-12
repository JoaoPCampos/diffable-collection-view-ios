//
//  Section.swift
//  DiffableCollectionView
//
//  Created by João Campos on 12/07/2024.
//

struct Section: Hashable {

	enum SectionType: String {
		case A
		case B
		case C
	}

	let title: String
	let type: SectionType
	let items: [Sample]
}

extension Section {

	static func mock(_ type: SectionType) -> Section {

		Section(title: "Section \(type.rawValue)",
				type: type,
				items: [
					Sample(title: "\(type.rawValue) sample 1", systemNameIcon: "star.fill"),
					Sample(title: "\(type.rawValue) sample 2", systemNameIcon: "moon.stars"),
					Sample(title: "\(type.rawValue) sample 3", systemNameIcon: "star.leadinghalf.filled"),
					Sample(title: "\(type.rawValue) sample 4", systemNameIcon: "star.fill"),
					Sample(title: "\(type.rawValue) sample 5", systemNameIcon: "moon.stars"),
					Sample(title: "\(type.rawValue) sample 6", systemNameIcon: "star.leadinghalf.filled"),
					Sample(title: "\(type.rawValue) sample 7", systemNameIcon: "star.fill"),
					Sample(title: "\(type.rawValue) sample 8", systemNameIcon: "moon.stars"),
					Sample(title: "\(type.rawValue) sample 9", systemNameIcon: "star.leadinghalf.filled")
				])
	}
}
