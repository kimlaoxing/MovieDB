import Foundation
import UIKit
import Router
import Components
import RxRelay

protocol ProfileViewInput {
    func retriveEmail(with forKey: String)
    func retriveName(with forKey: String)
    func saveImage(with image: UIImage)
    func retriveImage()
    func viewDidLoad()
    func toEditName(with delegate: ProfileEditDelegate)
    func toEditEmail(with delegate: ProfileEditDelegate)
}

protocol ProfileViewOutput {
    var state: BehaviorRelay<BaseViewState> { get }
    var name: BehaviorRelay<String> { get }
    var email: BehaviorRelay<String> { get }
    var image: BehaviorRelay<UIImage> { get }
}

protocol ProfileViewViewModel: ProfileViewInput, ProfileViewOutput {}

final class DefaultProfileViewViewModel: ProfileViewViewModel {
    
    let image: BehaviorRelay<UIImage> = BehaviorRelay.init(value: UIImage())
    let name: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    let email: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    let state: BehaviorRelay<BaseViewState> = BehaviorRelay.init(value: .loading)
    
    private let useCase: ProfileViewUseCaseProtocol
    private let router: Routes
    
    typealias Routes = ProfileTabRoute
    
    init(router: Routes,
         useCase: ProfileViewUseCaseProtocol
    ) {
        self.router = router
        self.useCase = useCase
    }
    
    func viewDidLoad() {
        self.retriveEmail(with: ProfileEditForkey.email)
        self.retriveName(with: ProfileEditForkey.name)
        self.retriveImage()
    }
    
    func retriveEmail(with forKey: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.useCase.retriveEmail(with: forKey) { email in
//                self.state.value = .normal
//                self.email.value = email
                self.state.accept(.normal)
                self.email.accept(email)
            }
        }
    }
    
    func retriveName(with forKey: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.useCase.retriveName(with: forKey) { name in
//                self.state.value = .normal
//                self.name.value = name
                self.state.accept(.normal)
                self.name.accept(name)
            }
        }
    }
    
    func saveImage(with image: UIImage) {
        self.useCase.saveImage(with: image)
    }
    
    func retriveImage() {
//        self.state.value = .loading
        self.state.accept(.loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.useCase.retriveImage { data in
//                self.state.value = .normal
                self.state.accept(.normal)
//                self.image.value = data
                self.image.accept(data)
            }
        }
    }
    
    func toEditName(with delegate: ProfileEditDelegate) {
        self.router.toEditName(delegate)
    }
    
    func toEditEmail(with delegate: ProfileEditDelegate) {
        self.router.toEditEmail(delegate)
    }
}
