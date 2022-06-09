//
//  CTViewController.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/06/08.
//

import Combine
import UIKit

final class CTViewController: UIViewController {
    var viewModel: CTViewModel?
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bindViewModel()
    }
}

// MARK: - Private Functions
private extension CTViewController {
    func configureUI() {
        view.backgroundColor = .tabBar
    }
    
    func bindViewModel() {
        let _ = self.viewModel?.transform(
            from: CTViewModel.Input(viewDidLoadEvent: Just(()).eraseToAnyPublisher()),
            subscriptions: &subscriptions
        )
    }
}
