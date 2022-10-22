import Declayout
import UIKit
import Components
import Router

final class ProfileEditViewController: UIViewController {
    
    private var viewModel: ProfileEditViewModel = DefaultProfileEditViewModel()
    var state: ProfileEditState?
    weak var delegate: ProfileEditDelegate?
    
    private lazy var containerView = UIView.make {
        $0.top(to: view, Padding.double + safeAreaInset.top + Padding.half)
        $0.bottom(to: view)
        $0.horizontalPadding(to: view)
    }
    
    private lazy var vStack = ScrollViewContainer.make {
        $0.edges(to: containerView, 16)
        $0.setSpacingBetweenItems(to: 4)
    }
    
    private lazy var label = UILabel.make {
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.numberOfLines = 1
        $0.textColor = .black
        $0.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
    private lazy var textField = UITextField.make {
        $0.placeholder = "Enter text here"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.borderStyle = UITextField.BorderStyle.roundedRect
        $0.autocorrectionType = UITextAutocorrectionType.no
        $0.keyboardType = UIKeyboardType.default
        $0.returnKeyType = UIReturnKeyType.done
        $0.clearButtonMode = UITextField.ViewMode.whileEditing
        $0.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        $0.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subViews()
        bind()
    }
    
    private func subViews() {
        view.backgroundColor = .white
        view.addSubviews([
            containerView.addSubviews([
                vStack.addArrangedSubViews([
                    label,
                    textField
                ])
            ])
        ])
        setContent()
    }
    
    private func bind() {
        viewModel.state.observe(on: self) { [weak self] data in
            self?.handleState(with: data)
        }
        
        viewModel.isDonePost.observe(on: self) { [weak self] isDone in
            if isDone {
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func setContent() {
        switch state {
        case .email:
            self.label.text = "Email"
            title = "Edit Email"
        case .name:
            self.label.text = "Name"
            title = "Edit Name"
        default:
            break
        }
    }
    
    private func handleState(with state: BaseViewState) {
        switch state {
        case .loading:
            self.manageLoadingActivity(isLoading: true)
        case .normal:
            self.manageLoadingActivity(isLoading: false)
        case .empty:
            break
        }
    }
}

extension ProfileEditViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch state {
        case .email:
            self.viewModel.saveEmail(with: textField.text ?? "-")
            self.delegate?.getEmail()
        case .name:
            self.viewModel.saveName(with: textField.text ?? "-")
            self.delegate?.getName()
        default:
            break
        }
        return true
    }
}
