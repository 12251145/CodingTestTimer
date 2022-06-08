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
    var addTimeSubject = PassthroughSubject<Double, Never>()
    
    private lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 70, weight: .medium)
        timeLabel.textColor = .white
        timeLabel.text = ""
        
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
    
    private lazy var problemButtonsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    private lazy var scrollViewVStack: UIStackView = {
       let vStack = UIStackView()
        
        vStack.axis = .vertical
        vStack.distribution = .fillEqually
        vStack.spacing = 10
        vStack.alignment = .top
        
        return vStack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
    }
}


// MARK: - Private Functions
private extension CTSettingViewController {
    
    // MARK: - Configure UI
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
        
        // scrollView
        self.view.addSubview(problemButtonsScrollView)
        self.problemButtonsScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.problemButtonsScrollView.topAnchor.constraint(equalTo: self.devider.bottomAnchor),
            self.problemButtonsScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            self.problemButtonsScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.problemButtonsScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // start button
        self.view.addSubview(startButton)
        self.startButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.problemButtonsScrollView.addSubview(scrollViewVStack)
        self.scrollViewVStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            self.startButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            self.startButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            self.scrollViewVStack.topAnchor.constraint(equalTo: self.problemButtonsScrollView.topAnchor, constant: 16),
            self.scrollViewVStack.leadingAnchor.constraint(equalTo: self.problemButtonsScrollView.leadingAnchor, constant: 16),
            self.scrollViewVStack.trailingAnchor.constraint(equalTo: self.problemButtonsScrollView.trailingAnchor),
            self.scrollViewVStack.bottomAnchor.constraint(equalTo: self.problemButtonsScrollView.bottomAnchor)
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
    
    // MARK: - Bind Model
    func bindViewModel() {
        let output = viewModel?.transform(
            input: CTSettingViewModel.Input(
                viewDidLoadEvent: Just(()).eraseToAnyPublisher(),
                startButtonDidTap: self.startButton.publisher(for: .touchUpInside).eraseToAnyPublisher(),
                addProblemButtonEvent: self.testButton.publisher(for: .touchUpInside).eraseToAnyPublisher(),
                addTimeButtonEvent: self.addTimeSubject.eraseToAnyPublisher()
            ),
            subscriptions: &subscriptions
        )
        
        output?.ctSetting
            .map { $0.problems }
            .sink(receiveValue: { problems in
                self.drawProblemButtons(problems)
            })
            .store(in: &subscriptions)
        
        output?.ctSetting
            .map { $0.timeLimit }
            .sink(receiveValue: { time in
                self.timeLabel.text = "\(time)"
            })
            .store(in: &subscriptions)
    }
    
    // MARK: - View Logic
    func createTimeSettingButton(amount: Double) -> UIButton {
        let button = UIButton()
        
        button.publisher(for: .touchUpInside).eraseToAnyPublisher()
            .sink { _ in
                self.addTimeSubject.send(amount)
            }
            .store(in: &subscriptions)
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .buttonLight
        config.cornerStyle = .capsule
        
        switch amount {
        case 1.0:
            config.title = "+1시간"
        case 0.5:
            config.title = "+30분"
        case -1.0:
            config.title = "-1시간"
        case -0.5:
            config.title = "-30분"
        default:
            config.title = ""
        }
        
        button.configuration = config
        
        return button
    }
    
    func drawProblemButtons(_ problems: [Problem]) {
        for v in self.scrollViewVStack.arrangedSubviews {
            if let v = v as? UIStackView {
                v.removeFromSuperview()
            }
        }
        
        let hStackCount = problems.count / 4 + 1
        var currentProblem = 0
        
        for _ in 0..<(hStackCount - 1) {
            let hStack = createHStack()
            hStack.translatesAutoresizingMaskIntoConstraints = false
            
            self.scrollViewVStack.addArrangedSubview(hStack)
            

            
            for _ in 0..<4 {
                let problemButton = createProblemButton(problems[currentProblem].difficulty, problems[currentProblem].checkEfficiency)
                problemButton.translatesAutoresizingMaskIntoConstraints = false
                
                hStack.addArrangedSubview(problemButton)
                
                NSLayoutConstraint.activate([
                    problemButton.widthAnchor.constraint(equalTo: self.plusHourButton.widthAnchor),
                    problemButton.heightAnchor.constraint(equalTo: self.plusHourButton.widthAnchor),
                ])
                
                currentProblem += 1
            }
        }
        
        let hStack = createHStack()
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        self.scrollViewVStack.addArrangedSubview(hStack)
        
        for _ in 0..<(problems.count % 4) {
            let problemButton = createProblemButton(problems[currentProblem].difficulty, problems[currentProblem].checkEfficiency)
            problemButton.translatesAutoresizingMaskIntoConstraints = false
            
            hStack.addArrangedSubview(problemButton)
            
            NSLayoutConstraint.activate([
                problemButton.widthAnchor.constraint(equalTo: self.plusHourButton.widthAnchor),
                problemButton.heightAnchor.constraint(equalTo: self.plusHourButton.widthAnchor),
            ])
            
            currentProblem += 1
        }
        
        let addButton = createProblemAddButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        hStack.addArrangedSubview(addButton)
        
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalTo: self.plusHourButton.widthAnchor),
            addButton.heightAnchor.constraint(equalTo: self.plusHourButton.widthAnchor),
        ])
    }
    
    func createHStack() -> UIStackView {
        let hStack = UIStackView()
        
        hStack.axis = .horizontal
        hStack.distribution = .fillEqually
        hStack.spacing = 10
        hStack.alignment = .center
        
        return hStack
    }
    
    func createProblemButton(_ difficulty: ProblemDifficulty, _ checkEfficiency: Bool) -> UIView {
        let button = UIView()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 20
        
        return button
    }
    
    func createProblemAddButton() -> UIView {
        let button = UIView()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        
        return button
    }
}
