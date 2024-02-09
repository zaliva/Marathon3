
import UIKit

class ViewController: UIViewController {
    
    let width: CGFloat = 100
    let height: CGFloat = 100
    let margin: CGFloat = 20
    
    let squareView = UIView()
    let slider = UISlider()
    
    var leadingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSquareView()
        configureSliderView()
    }
    
    func configureSquareView() {
        squareView.backgroundColor = .systemBlue
        squareView.layer.cornerRadius = 10
        view.addSubview(squareView)
        squareView.translatesAutoresizingMaskIntoConstraints = false
        
        leadingConstraint = squareView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin)
        NSLayoutConstraint.activate([
            squareView.widthAnchor.constraint(equalToConstant: width),
            squareView.heightAnchor.constraint(equalToConstant: height),
            squareView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            leadingConstraint
        ])
    }
    
    func configureSliderView() {
        slider.frame = CGRect(x: margin, y: 300, width: view.frame.width - 2 * margin, height: 50)
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderReleased(_:)), for: .touchUpInside)
        view.addSubview(slider)
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        let scaleFactor = CGFloat(sender.value) * 0.5 + 1.0
        let rotationAngle = CGFloat(sender.value) * .pi / 2
        let transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor).rotated(by: rotationAngle)
        
        UIView.animate(withDuration: 0.1) {
            self.squareView.transform = transform
            
            let x = self.view.frame.width - self.width * scaleFactor - self.margin
            self.leadingConstraint.constant = x * CGFloat(sender.value) + self.margin
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func sliderReleased(_ sender: UISlider) {
        UIView.animate(withDuration: 0.3) {
            sender.setValue(1.0, animated: true)
            self.sliderValueChanged(sender)
        }
    }
}


