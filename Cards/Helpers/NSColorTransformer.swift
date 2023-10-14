
import Foundation
import UIKit

class NSColorTransformer: ValueTransformer {
    
    
    override func transformedValue(_ value: Any?) -> Any? {
        
        guard let color = value as? UIColor else { return nil}
        do{
            let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
            return data
        }
        catch {
            print("***Could not transform to data from color")
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        
        guard let data = value as? Data else { return nil}
        do{
            let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)
            return color
        }
        catch {
            print("***could not transform to color from data")
            return nil
        }
    }
}
