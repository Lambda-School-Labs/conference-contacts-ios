//
//  ViewController.swift
//  LoginHorizontalScroll
//
//  Created by Marlon Raskin on 11/12/19.
//

import UIKit
import ChevronAnimatable

class LoginViewController: UIViewController {


	@IBOutlet private weak var scrollView: UIScrollView!
	@IBOutlet private weak var stackView: UIStackView!
	@IBOutlet private weak var loginView: UIView!
	@IBOutlet private weak var chevron: ChevronView!

	override func viewDidLoad() {
		super.viewDidLoad()
		scrollView.isPagingEnabled = true
		scrollView.delegate = self
		updateChevron()
		scrollView.delaysContentTouches = false
	}

	private func updateChevron() {
		chevron.lineWidth = 2
		let startRotationAt = scrollView.frame.height * 0.25
		let endRotationAt = scrollView.frame.height * 0.75

		if scrollView.contentOffset.y < startRotationAt {
			chevron.pointHeight = -1
		} else if scrollView.contentOffset.y >= startRotationAt && scrollView.contentOffset.y <= endRotationAt {
			let range = endRotationAt - startRotationAt
			let currentValue = scrollView.contentOffset.y - startRotationAt
			let normalizedCurrentValue = ((currentValue / range) * 2) - 1
			chevron.curviness = CGFloat(1 - abs(normalizedCurrentValue) + 0.1)
			chevron.pointHeight = normalizedCurrentValue
		} else {
			chevron.pointHeight = 1
		}
	}

	@IBAction func chevronTapped(_ sender: UITapGestureRecognizer) {
		if scrollView.contentOffset.y == 0 {
			let loginRect = scrollView.convert(loginView.bounds, from: loginView)
			scrollView.scrollRectToVisible(loginRect, animated: true)
		} else {
			scrollView.setContentOffset(.zero, animated: true)
		}
	}
}

extension LoginViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		updateChevron()
	}
}