//
//  ViewController.swift
//  DiffableCollectionView
//
//  Created by João Campos on 11/07/2024.
//

import UIKit

enum Section: Int {
	case main
}

enum Item: Hashable {
	case sample(String, String)
}

class ViewController: UIViewController {

	typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
	typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>

	private let items: [Item] = [
		.sample("sample 1", "star.fill"),
		.sample("sample 2", "moon.stars"),
		.sample("sample 3", "star.leadinghalf.filled"),
		.sample("sample 4", "star.fill"),
		.sample("sample 5", "moon.stars"),
		.sample("sample 6", "star.leadinghalf.filled"),
		.sample("sample 7", "star.fill"),
		.sample("sample 8", "moon.stars"),
		.sample("sample 9", "star.leadinghalf.filled")
	]

	lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
	lazy var dataSource = createDataSource()

	override func viewDidLoad() {
		
		super.viewDidLoad()

		configureView()
	}
}

private extension ViewController {

	func configureView() {

		title = "Diffable Collection View"
		view.backgroundColor = .systemBackground

		view.addSubview(collectionView)

		collectionView.register(SampleCell.self,
								forCellWithReuseIdentifier: SampleCell.identifier)
		collectionView.register(SampleHeader.self,
								forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SampleHeader.identifier)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.dataSource = dataSource

		configureConstraints()
		applySnapshot()
	}

	func configureConstraints() {

		NSLayoutConstraint.activate([


			collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}

	func applySnapshot(animatingDifferences: Bool = true) {

		var snapshot = Snapshot()

		snapshot.appendSections([.main])
		snapshot.appendItems(items)

		dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
	}

	func createDataSource() -> DataSource {

		let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in

			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SampleCell.identifier, for: indexPath) as? SampleCell

			switch item {

				case .sample(let text, let icon):
					cell?.configure(text: text, systemName: icon)
			}

			return cell
		}

		return dataSource
	}

	func createLayout() -> UICollectionViewLayout {

		let sectionProvider = {(sectionIndex: Int, layout: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

			guard let sectionKind = Section(rawValue: sectionIndex) else {
				return nil
			}

			let section: NSCollectionLayoutSection

			switch sectionKind {

				case .main:
					
					let itemSize = NSCollectionLayoutSize(
						widthDimension: .fractionalWidth(1.0),
						heightDimension: .fractionalHeight(1.0)
					)

					let item = NSCollectionLayoutItem(layoutSize: itemSize)
					
					let groupSize = NSCollectionLayoutSize(
						widthDimension: .fractionalWidth(0.5),
						heightDimension: .fractionalWidth(0.2)
					)

					let group = NSCollectionLayoutGroup.horizontal(
						layoutSize: groupSize,
						subitems: [item]
					)
					
					section = NSCollectionLayoutSection(group: group)
					section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary

					//				case .list:
					//					var configution = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
					//
					//					configution.trailingSwipeActionsConfigurationProvider = { [weak self] indexPath in
					//
					//						guard let `self` = self else { return nil }
					//
					//						let selectedItem = self.dataSource.itemIdentifier(for: indexPath)
					//						return self.deleteItemOnSwipe(item: selectedItem!)
					//					}
					//
					//					section = NSCollectionLayoutSection.list(using: configution, layoutEnvironment: layout)
					//
					//				case .outline:
					//					let configution = UICollectionLayoutListConfiguration(appearance: .plain)
					//					section = NSCollectionLayoutSection.list(using: configution, layoutEnvironment: layout)

			}

			return section
		}

		return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
	}
}
