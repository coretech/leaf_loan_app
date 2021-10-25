import UIKit
import Flutter
import credoappsdk

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    //TODO: remove this
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let credoChannel = FlutterMethodChannel(
        name: "com.leafglobal.loanapp/credolabs",
        binaryMessenger: controller.binaryMessenger)
    credoChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        guard call.method == "submitCredoLabsData" else{
            result(FlutterMethodNotImplemented)
            return
        }
        if let args = call.arguments as? Dictionary<String, Any>,
           let authKey = args["authKey"] as? String,
           let referenceNumber = args["referenceNumber"] as? String, 
           let url = args["url"] as? String {
            self.collectData(result: result, authKey: authKey, referenceNumber: referenceNumber, url: url)
        } else{
            result (FlutterError(code:"NO REF NUMBER", message: "No reference number is passed", details:""))
        }
    })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func collectData(result: @escaping FlutterResult, authKey: String, referenceNumber: String, url: String){
        DispatchQueue.global().async {
            do{
                NSLog("INFO: \(Date().timeIntervalSince1970); e - LOGIN_START; rn - \("rn")")
                let credoAppService = try CredoAppService(url: url, authKey: authKey)
                NSLog("INFO: \(Date().timeIntervalSince1970); e - LOGIN_END; rn - \("rn")")
                NSLog("INFO: \(Date().timeIntervalSince1970); e - COLLECT_START; rn - \("rn")")
                let recordNumber = try credoAppService.collectData(recordNumber:referenceNumber)
                NSLog("INFO: \(Date().timeIntervalSince1970); e - COLLECT_END; rn - \("rn")")
                result(recordNumber)
            } catch let error as CredoAppError{
                let errorType = error.getErrorType()
                let errorMessage = error.getErrorMessage()
                NSLog("ERROR: \(Date().timeIntervalSince1970); type - \(errorType); msg - \(String(describing: errorMessage)); rn - \(referenceNumber)")
                result(FlutterError(code: String(describing: errorType), message: errorMessage, details: ""))
            } catch let error {
                result(FlutterError(code: "UNKNOWN ERROR", message: error.localizedDescription, details: error))
            }
       }
    }
}

