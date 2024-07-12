//
//  SampleCellB.swift
//  DiffableCollectionView
//
//  Created by João Campos on 12/07/2024.
//

import UIKit

final class SampleCellB: UICollectionViewCell, ConfigurableCell {

	private let title = UILabel()
	private let subtitle = UILabel()
	private let imageView = UIImageView()
	private let button = UIButton(type: .custom)

	override init(frame: CGRect = .zero) {

		super.init(frame: frame)

		configureSubviews()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(with sample: Sample) {

		title.text = sample.title
		subtitle.text = sample.subtitle
		imageView.image = UIImage(systemName: sample.systemNameIcon)
	}

	override func prepareForReuse() {

		super.prepareForReuse()

		title.text = nil
		subtitle.text = nil
		imageView.image = nil
	}
}

private extension SampleCellB {

	func configureSubviews() {

		backgroundColor = .quaternarySystemFill
		layer.cornerRadius = 10

		title.font = UIFont.preferredFont(forTextStyle: .headline)
		title.textColor = .label

		subtitle.font = UIFont.preferredFont(forTextStyle: .subheadline)
		subtitle.textColor = .secondaryLabel

		imageView.contentMode = .scaleToFill
		imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)

		button.setImage(UIImage(systemName: "gamecontroller.fill"), for: .normal)
		button.setContentHuggingPriority(.defaultHigh, for: .horizontal)

		let innerStackView = UIStackView(arrangedSubviews: [title,
															subtitle])
		innerStackView.axis = .vertical
		innerStackView.alignment = .center

		let outerStackView = UIStackView(arrangedSubviews: [imageView,
															innerStackView,
															button])

		outerStackView.translatesAutoresizingMaskIntoConstraints = false
		outerStackView.alignment = .center
		outerStackView.spacing = 10
		
		contentView.addSubview(outerStackView)

		NSLayoutConstraint.activate([
			
			outerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			outerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
			outerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
			outerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
		])
	}
}
