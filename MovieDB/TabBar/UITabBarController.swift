import UIKit
import Components

final class TabBar: UITabBarController {
    
    required init(vc: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = vc
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        draw()
    }
    
    private func draw() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath().cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        
        shapeLayer.lineWidth = 1.0
        shapeLayer.strokeColor = UIColor(red: 231 / 255, green: 231 / 255, blue: 240 / 255, alpha: 1).cgColor
        self.tabBar.layer.insertSublayer(shapeLayer, at: 1)
    }
    
    private func createPath() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        
        let screenWidth = UIScreen.main.bounds.width
        path.addLine(to: CGPoint(x: 32.6 / 100 * screenWidth, y: 0))
        path.addLine(to: CGPoint(x: screenWidth, y: 0))
        path.addLine(to: CGPoint(x: screenWidth, y: self.tabBar.bounds.height + safeAreaInset.bottom))
        path.addLine(to: CGPoint(x: 0, y: self.tabBar.bounds.height + safeAreaInset.bottom))
        path.close()
        
        return path
    }
}
