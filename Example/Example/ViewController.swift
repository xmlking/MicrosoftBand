import UIKit
import MicrosoftBand

class ViewController: UIViewController, ConnectionDelegate {

    var mband: MicrosoftBand!
    let tileId      = UUID(uuidString: "be2066df-306f-438e-860c-f82a8bc0bd6a")!
    let tileName    = "Wearable Hub"
    let tileIcon    = "A"
    let smallIcon   = "Aa"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let mband = MicrosoftBand()
        self.mband = mband;
        self.mband.connectDelegate = self
       
        do {
             _ = try  mband.connect()
        } catch ConnectionError.BluetoothUnavailable {
            print("BluetoothUnavailable...")
        } catch ConnectionError.DeviceUnavailable {
            print("DeviceUnavailable...")
        } catch {
            print("any Error")
        }
    
    
        print("isBluetoothOn \(self.mband.isBluetoothOn())")
        print("name \(self.mband.name)")
        print("deviceIdentifier \(self.mband.deviceIdentifier)")

        DispatchQueue.main.asyncAfter(deadline: .now() + 80.0) {
            do {
                try self.mband.stopAccelerometerUpdates()
                try self.mband.stopHeartRateUpdates()
            } catch {
                print("stop error...\(error)")
            }
            
            print("Disconnecteing...")
            self.mband.disconnect()
        }
        print("userConsent...\(self.mband.userConsent.rawValue)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func onConnecte(){
        print("onConnecte...")
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            print("hardwareVersion \(self.mband.hardwareVersion)")
            print("firmwareVersion \(self.mband.firmwareVersion)")
        }
        self.mband.requestUserConsent() { result in
            if(result) {
                print("requestUserConsent...\(result), calling HR")
                try! self.mband.startHeartRateUpdates() {  (data, error) in
                    if ((error) != nil) {
                        print("heartRate error \(error)")
                    } else {
                        print("heartRate data \(data) \(data?.heartRate) \(data?.quality)")
                    }
                }
                
            }
        }
        self.mband.sendHaptic()
        
        self.mband.sendHaptic() { error in
            print("[MSB] Error sendHaptic: \(error)")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
        self.mband.addTile(tileId: self.tileId, tileName: self.tileName, tileIcon: self.tileIcon, smallIcon: self.smallIcon) {  error in
            print("[MSB] Error addTile: \(error)")
        }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
        self.mband.sendBandNotification(tileId: self.tileId, title: "sumo", body: "good work 123 3333 3333 ") { error in
            print("[MSB] Error sendBandNotification: \(error)")
        }
        }

    }
    
    func onDisconnecte(){
        print("onDisconnecte...")
    }
    
    func onError(error: Error) {
        print("error111 \(error)")
    }

}

