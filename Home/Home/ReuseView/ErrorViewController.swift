import UIKit
import Declayout
import Components

final class ErrorViewController: UIViewController {
    
    var error: String = ""
    
    private lazy var descriptionError = UILabel.make {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 11, weight: .light)
        $0.textColor = .black
        $0.textAlignment = .justified
        $0.text = self.error
    }
    
    private lazy var containerView = UIStackView.make {
        $0.edges(to: view, Padding.double)
        $0.axis = .vertical
    }
    
    private lazy var errorView = EmptyDataView.make {
        $0.title.text = "Description"
        $0.title.font = .systemFont(ofSize: 12, weight: .bold)
        $0.title.numberOfLines = 0
        $0.title.textAlignment = .center
        $0.button.isHidden = true
        $0.image.image = UIImage(systemName: "nosign")
        $0.image.height(100)
        $0.image.tintColor = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        subViews()
    }
    
    private func subViews() {
        view.addSubviews([
            containerView.addArrangedSubviews([
                errorView,
                descriptionError
            ])
        ])
    }
}
