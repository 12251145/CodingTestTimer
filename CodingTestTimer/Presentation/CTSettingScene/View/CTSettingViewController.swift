//
//  TimerViewController.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/05/14.
//

import Combine
import UIKit

class CTSettingViewController: UIViewController {
    var viewModel: CTSettingViewModel?
    var subscriptions = Set<AnyCancellable>()
    
    private lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 60, weight: .semibold)
        timeLabel.textColor = .white
        timeLabel.text = "5시간"
        
        return timeLabel
    }()
    
    private lazy var timeSettingButtonsStack: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }()
    
    private lazy var plusHalfHourButton: UIButton = createTimeSettingButton(amount: 0.5)
    private lazy var plusHourButton: UIButton = createTimeSettingButton(amount: 1.0)
    private lazy var substractHalfHourButton: UIButton = createTimeSettingButton(amount: -0.5)
    private lazy var substractHourButton: UIButton = createTimeSettingButton(amount: -1.0)
    
    private lazy var devider: UIView = {
        let rect = UIView()
        
        rect.backgroundColor = .buttonLight
        
        return rect
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        
        config.title = "시작"
        
        config.baseBackgroundColor = .buttonBlue
        config.buttonSize = .large
        config.cornerStyle = .capsule
        
        button.configuration = config
        
        return button
    }()
    
    private lazy var testButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        
        config.title = "문제 추가 테스트"
        
        config.baseBackgroundColor = .lightText
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
private extension CTSettingViewController {
    func configureUI() {
        self.navigationController?.navigationBar.isHidden = true
        
        // timeLabel
        self.view.addSubview(timeLabel)
        self.timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.timeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            self.timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // timeSettingStack
        self.view.addSubview(timeSettingButtonsStack)
        self.timeSettingButtonsStack.translatesAutoresizingMaskIntoConstraints = false
        
        let _ = [substractHourButton, substractHalfHourButton, plusHalfHourButton, plusHourButton].map {
            self.timeSettingButtonsStack.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            self.timeSettingButtonsStack.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: 50),
            self.timeSettingButtonsStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            self.timeSettingButtonsStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
        
        //devider
        self.view.addSubview(devider)
        self.devider.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.devider.topAnchor.constraint(equalTo: self.timeSettingButtonsStack.bottomAnchor, constant: 15),
            self.devider.leftAnchor.constraint(equalTo: view.leftAnchor),
            self.devider.rightAnchor.constraint(equalTo: view.rightAnchor),
            self.devider.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        // start button
        self.view.addSubview(startButton)
        self.startButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            self.startButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            self.startButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
        
        // testButton
        self.view.addSubview(testButton)
        self.testButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.testButton.bottomAnchor.constraint(equalTo: self.startButton.topAnchor, constant: -16),
            self.testButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            self.testButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
    }
    
    func bindViewModel() {
        let output = viewModel?.transform(
            input: CTSettingViewModel.Input(
                viewDidLoadEvent: Just(()).eraseToAnyPublisher(),
                testButtonEvent: self.testButton.publisher(for: .touchUpInside).eraseToAnyPublisher()
            ),
            subscriptions: &subscriptions
        )
        
        output?.problems
            .sink(receiveValue: { problems in
                print(problems.count)
            })
            .store(in: &subscriptions)
    }
    
    func createTimeSettingButton(amount: Double) -> UIButton {
        let button = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .buttonLight
        config.cornerStyle = .capsule
        
        if amount < 0 {
            config.title = "\(Int(amount))시간"
        } else {
            config.title = "+\(Int(amount))시간"
        }
        
        button.configuration = config
        
        return button
    }
}
