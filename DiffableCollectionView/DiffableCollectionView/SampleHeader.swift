//
//  SampleHeader.swift
//  DiffableCollectionView
//
//  Created by João Campos on 11/07/2024.
//

import UIKit

final class SampleHeader: UICollectionReusableView {

	static let identifier = String(describing: SampleHeader.self)

	private let titleLabel = UILabel()

	override init(frame: CGRect = .zero) {

		super.init(frame: frame)

		configureSubviews()
		configureConstraints()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func prepareForReuse() {

		super.prepareForReuse()

		titleLabel.text = nil
	}
}

private extension SampleHeader {

	func configureSubviews() {

		titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false

		addSubview(titleLabel)
	}

	func configureConstraints() {

		NSLayoutConstraint.activate([

			titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
			titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
	}
}
