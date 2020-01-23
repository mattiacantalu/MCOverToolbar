import UIKit

class FirstViewController: UIViewController {

    private lazy var toolBar: BottomBar = {
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let item = UIBarButtonItem(title: "Delete All", style: .done, target: self, action: #selector(sample))
        let item2 = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(sample))
        let item3 = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(sample))

        item.tintColor = .red
        let toolBar = BottomBar()
            .over(view: tabBar)
            .add(item: item2)
            .add(item: space)
            .add(item: item)
            .add(item: space)
            .add(item: item3)
        return toolBar
    }()

    private lazy var tabBar: UITabBar = {
        return self.tabBarController?.tabBar ?? UITabBar()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.view.addSubview(toolBar)
        toolBar.constrained([
            toolBar.bottomAnchor.constraint(equalTo: tabBar.safeAreaLayoutGuide.bottomAnchor),
            toolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolBar.topAnchor.constraint(equalTo: tabBar.safeAreaLayoutGuide.topAnchor),
        ])
    }
    
    @objc func sample() {}

    @IBAction func animateUpDown(_ sender: Any) {
        toolBar.animateUpDown {
            self.tabBarController?.tabBar.alpha = self.tabBar.alpha == 0 ? 1 : 0
        }
    }
    
    @IBAction func fadeInOut(_ sender: Any) {
         toolBar.fadeInOut {
             self.tabBarController?.tabBar.alpha = self.tabBar.alpha == 0 ? 1 : 0
         }
     }
    
    @IBAction func noAnimation(_ sender: Any) {
        toolBar.noAnimation {
             self.tabBarController?.tabBar.alpha = self.tabBar.alpha == 0 ? 1 : 0
         }
     }
    
    @IBAction func reset(_ sender: Any) {
        toolBar.reset {
             self.tabBarController?.tabBar.alpha = 1
         }
     }
}
