import Flutter
import UIKit
import ARKit

class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FLNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
}

class FLNativeView: NSObject, FlutterPlatformView {
    private var _view: UIView

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        super.init()
        // iOS views can be created here
        createNativeView(view: _view)
    }

    func view() -> UIView {
        return _view
    }

    func createNativeView(view _view: UIView) {
        let previewController = QLPreviewController()
        previewController.dataSource = self
        _view.backgroundColor = .black

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            _view.parentViewController?.present(previewController, animated: true) {
                if let navigationBar = previewController.view.subviews.first?.subviews[1] as? UINavigationBar {
                    navigationBar.isHidden = true
                }
            }
        }
    }
}

extension FLNativeView: QLPreviewControllerDataSource {
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let url = Bundle.main.url(forResource: "SavyonARv", withExtension: "usdz")!
        return url as QLPreviewItem
    }
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
}

extension FLNativeView: QLPreviewControllerDelegate {
    func previewControllerDidDismiss(_ controller: QLPreviewController) {
        
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self.next
        while parentResponder != nil {
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
            parentResponder = parentResponder?.next
        }
        return nil
    }
}
