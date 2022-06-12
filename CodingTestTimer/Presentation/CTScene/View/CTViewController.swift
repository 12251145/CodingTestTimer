//
//  CTViewController.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/06/08.
//

import Combine
import UIKit
import SwiftUI

final class CTViewController: UIViewController {
    var viewModel: CTViewModel?
    var subscriptions = Set<AnyCancellable>()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        label.textColor = .black
        label.text = "00시 00분 00초"
        
        return label
    }()
    
    private(set) lazy var progressView = self.createProgressView()
    
    private lazy var endButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.filled()
        
        config.title = "종료"
        
        config.baseBackgroundColor = .red
        config.buttonSize = .large
        config.cornerStyle = .capsule
        
        button.configuration = config
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bindViewModel()
    }
}

// MARK: - Private Functions
private extension CTViewController {
    func configureUI() {
        view.backgroundColor = .white
        
        // timerLabel
        self.view.addSubview(timerLabel)
        self.timerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.timerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            self.timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // progressView
        self.view.addSubview(progressView)
        self.progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.progressView.topAnchor.constraint(equalTo: self.timerLabel.bottomAnchor, constant: 40),
            self.progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // 종료버튼
        self.view.addSubview(endButton)
        self.endButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.endButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            self.endButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            self.endButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
        ])
    }
    
    func bindViewModel() {
        let output = self.viewModel?.transform(
            from: CTViewModel.Input(viewDidLoadEvent: Just(()).eraseToAnyPublisher()),
            subscriptions: &subscriptions
        )
        
        output?.ct
            .map { $0.leftTime }
            .sink(receiveValue: { time in
                self.timerLabel.text = "\(time.hhmmss)"
            })
            .store(in: &subscriptions)
        
        output?.ct
            .map { (Float($0.timeLimit) - Float($0.leftTime)) / Float($0.timeLimit) }
            .sink(receiveValue: { [weak self] progress in
                print(progress)
                self?.progressView.setProgress( progress, animated: true)
            })
            .store(in: &subscriptions)
    }
    
    func createProgressView() -> UIProgressView {
        return CTProgressView(width: 300, color: .blue)
    }
}
