import Foundation
import Components

protocol ProfileEditInput {
    func saveEmail(with email: String)
    func saveName(with name: String)
}

protocol ProfileEditOutput {
    var state: Observable<BaseViewState> { get }
    var isDonePost: Observable<Bool> { get }
}

protocol ProfileEditViewModel: ProfileEditOutput, ProfileEditInput {}

final class DefaultProfileEditViewModel: ProfileEditViewModel {
    
    let state: Observable<BaseViewState> = Observable(.normal)
    let isDonePost: Observable<Bool> = Observable(false)
    
    private let useCase = ProfileEditUseCase()
    
    func saveEmail(with email: String) {
        self.state.value = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let forKey = ProfileEditForkey.email
            self.useCase.saveName(with: email, forKey: forKey)
            self.state.value = .normal
            self.isDonePost.value = true
        }
    }
    
    func saveName(with name: String) {
        self.state.value = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let forKey = ProfileEditForkey.name
            self.useCase.saveName(with: name, forKey: forKey)
            self.state.value = .normal
            self.isDonePost.value = true
        }
    }
}
