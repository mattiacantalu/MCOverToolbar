import UIKit

fileprivate enum State {
  case normal
  case edit
}

class BottomBar: UIToolbar {

    private var screenHeight = UIScreen.main.bounds.height
    private var currentState = State.normal
    private var overView: UIView?

    private var toolBarYPos: CGFloat {
        if currentState == .edit {
            return screenHeight - (overView?.frame.size.height ?? self.frame.size.height)
        }
        return screenHeight
    }
    
    private init(frame: CGRect,
                 items: [UIBarButtonItem]?,
                 overView: UIView?) {
        super.init(frame: frame)
        self.items = items
        self.overView = overView
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
    }
    
    func add(item: UIBarButtonItem) -> BottomBar {
        return BottomBar(frame: self.frame,
                         items: (self.items ?? []) + [item],
                         overView: self.overView)
    }
    
    func over(view: UIView) -> BottomBar {
          return BottomBar(frame: self.frame,
                           items: self.items,
                           overView: view)
      }
    
    func constrained(_ constraints: [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
}

extension BottomBar {
    func animateUpDown(options: @escaping () -> Void) {
        if currentState == .edit {
            currentState = .normal
            
            UIView.animate(stuff: {
                options()
                self.frame.origin.y = self.toolBarYPos
            }, bool: true)
            return
        }
        
        self.frame.origin.y = screenHeight
        currentState = .edit
        UIView.animate(stuff: {
            options()
            self.frame.origin.y = self.toolBarYPos
        }, bool: true)
    }

    func fadeInOut(options: @escaping () -> Void) {
        currentState = .edit
        self.frame.origin.y = self.toolBarYPos

        UIView.animate(duration: 0.3,
                       stuff: {
                        options()
                        self.alpha = self.currentState == .edit ? 1 : 0
        }, bool: true)
    }
    
    func noAnimation(options: @escaping () -> Void) {
        currentState = .edit
         UIView.animate(duration: 0.2,
                        stuff: {
                         options()
                            self.alpha = self.currentState == .edit ? 1 : 0
         }, bool: false)
    }
    
    func reset(option: @escaping () -> Void) {
        currentState = .normal
        self.frame.origin.y = screenHeight - 83
        alpha = 1
        option()
    }
    
    @objc func sample() {}
}

private extension UIView {
    static func animate(duration: CGFloat = 0.3,
                        stuff: @escaping () -> Void,
                        bool: Bool) {
        if !bool {
            stuff()
            return
        }
        UIView.animate(withDuration: TimeInterval(duration)) {
            stuff()
        }
    }
}
