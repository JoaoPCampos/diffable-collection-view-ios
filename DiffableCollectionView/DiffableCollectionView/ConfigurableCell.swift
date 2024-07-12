//
//  ConfigurableCell.swift
//  DiffableCollectionView
//
//  Created by João Campos on 12/07/2024.
//

import Foundation

protocol ConfigurableCell {

	static var reuseIdentifier: String { get }
	func configure(with sample: Sample)
}

extension ConfigurableCell {

	static var reuseIdentifier: String {
		return String(describing: self)
	}
}
