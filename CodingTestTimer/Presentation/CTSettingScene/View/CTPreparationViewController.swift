//
//  CTPreparationViewController.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/06/08.
//

import Combine
import UIKit


final class CTPreparationViewController: UIViewController {
    var viewModel: CTPreparationViewModel?
    var subscriptions = Set<AnyCancellable>()
    
    private lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 50, weight: .semibold)
        label.text = "시작합니다"
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bindViewModel()
    }
}

// MARK: - Private Functions
private extension CTPreparationViewController {
    func configureUI() {
        view.backgroundColor = .white
        
        // greetingLabel
        self.view.addSubview(greetingLabel)
        self.greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.greetingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.greetingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func bindViewModel() {
        let _ = self.viewModel?.transform(
            form: CTPreparationViewModel.Input(viewDidLoadEvent: Just(()).eraseToAnyPublisher()),
            subscriptions: &subscriptions
        )
    }
}
