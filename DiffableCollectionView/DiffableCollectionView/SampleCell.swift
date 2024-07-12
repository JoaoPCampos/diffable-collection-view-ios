//
//  SampleCell.swift
//  DiffableCollectionView
//
//  Created by João Campos on 11/07/2024.
//

import UIKit

final class SampleCell: UICollectionViewCell {

	static let identifier = String(describing: SampleCell.self)

	private let label = UILabel()
	private let icon = UIImageView()
	private let stackView = UIStackView()

	override init(frame: CGRect = .zero) {

		super.init(frame: frame)

		configureSubviews()
		configureConstraints()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(text: String, systemName: String) {

		label.text = text
		icon.image = UIImage(systemName: systemName)
	}

	override func prepareForReuse() {

		super.prepareForReuse()

		label.text = nil
		icon.image = nil
	}
}

private extension SampleCell {

	func configureSubviews() {

		backgroundColor = .lightGray
		layer.cornerRadius = 10

		label.font = UIFont.preferredFont(forTextStyle: .body)
		icon.contentMode = .scaleAspectFit

		contentView.addSubview(stackView)

		stackView.addArrangedSubview(label)
		stackView.addArrangedSubview(icon)

		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.distribution = .equalSpacing
		stackView.alignment = .center
		stackView.axis = .vertical
	}

	func configureConstraints() {

		NSLayoutConstraint.activate([

			stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
			stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
		])
	}
}
