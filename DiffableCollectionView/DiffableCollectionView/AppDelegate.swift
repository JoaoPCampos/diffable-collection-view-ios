//
//  AppDelegate.swift
//  DiffableCollectionView
//
//  Created by João Campos on 11/07/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication,
					 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		self.window = UIWindow()

		let navigationController = UINavigationController()
		self.window?.rootViewController = navigationController
		self.window?.makeKeyAndVisible()

		let viewController = ViewController()

		navigationController.pushViewController(viewController, animated: false)

		return true
	}
}

