import Foundation
import Components
import RxRelay

protocol ProfileEditInput {
    func saveEmail(with email: String)
    func saveName(with name: String)
}

protocol ProfileEditOutput {
    var state: BehaviorRelay<BaseViewState> { get }
    var isDonePost: BehaviorRelay<Bool> { get }
}

protocol ProfileEditViewModel: ProfileEditOutput, ProfileEditInput {}

final class DefaultProfileEditViewModel: ProfileEditViewModel {
    
    let state: BehaviorRelay<BaseViewState> = BehaviorRelay.init(value: .normal)
    let isDonePost: BehaviorRelay<Bool> = BehaviorRelay.init(value: false)
    
    private let useCase: ProfileEditUseCaseProtocol
    
    init(useCase: ProfileEditUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func saveEmail(with email: String) {
        self.state.accept(.loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let forKey = ProfileEditForkey.email
            self.useCase.saveName(with: email, forKey: forKey)
            self.state.accept(.normal)
            self.isDonePost.accept(true)
        }
    }
    
    func saveName(with name: String) {
        self.state.accept(.loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let forKey = ProfileEditForkey.name
            self.useCase.saveName(with: name, forKey: forKey)
            self.state.accept(.normal)
            self.isDonePost.accept(true)
        }
    }
}
