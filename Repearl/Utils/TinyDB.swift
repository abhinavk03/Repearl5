import Foundation
import UIKit;
import AppFolder;

class TinyDB{
    var nsd: UserDefaults;
    var jsonEncoder: JSONEncoder;
    var jsonDecoder: JSONDecoder;
    init() {
      nsd = UserDefaults.standard;
      jsonEncoder = JSONEncoder();
      jsonDecoder = JSONDecoder();
    }
    func getInt(_ key: String) -> Int {
        return nsd.integer(forKey: key);
    }
    func getFloat(_ key: String) -> Float {
        return nsd.float(forKey: key);
    }
    func getDouble(_ key: String) -> Double {
           return nsd.double(forKey: key);
    }
   
    func getBoolean(_ key: String) -> Bool {
        return nsd.bool(forKey: key);
    }
    func getString(_ key: String) -> String {
        
        return nsd.string(forKey: key) ?? "";
    }
    func getObject<T: Codable>(_ key:String, _ objType: T.Type) -> T{
        let jsonString = getString(key);
        let jsonData = jsonString.data(using: .utf8)!
        let jsonDecoder = JSONDecoder();
        do {
            let object = try jsonDecoder.decode(T.self, from: jsonData);
            return object;
        } catch {
            let typeWrapper = try! jsonDecoder.decode(TypeWrapper<T>.self, from: jsonData);
            return typeWrapper.object;
        }
    }
    func putInt(_ key: String, _ value: Int){
        nsd.set(value, forKey: key);
    }
    func putFLoat(_ key: String, _ value: Float){
        nsd.set(value, forKey: key);
    }
    func putDouble(_ key: String, _ value: Double){
        nsd.set(value, forKey: key);
    }
    func putBoolean(_ key: String, _ value: Bool){
        nsd.set(value, forKey: key);
    }
    func putString(_ key: String, _ value: String){
        nsd.set(value, forKey: key);
    }
    func putObject<T : Encodable>(_ key: String, _ value: T){
        let jsonEncoder = JSONEncoder();
        let jsonData = try! jsonEncoder.encode(value );
        let jsonString: String! = String(data: jsonData, encoding: String.Encoding.utf8)
        nsd.set(jsonString, forKey: key)
    }
    func putListInt(_ key: String, _ value: [Int]){
        nsd.set(value, forKey: key);
    }
    func putListFLoat(_ key: String, _ value: [Float]){
        nsd.set(value, forKey: key);
    }
    func putListDouble(_ key: String, _ value: [Double]){
           nsd.set(value, forKey: key);
    }
    func putListBoolean(_ key: String, _ value: [Bool]){
        nsd.set(value, forKey: key);
    }
    func putListString(_ key: String, _ value: [String]){
           nsd.set(value, forKey: key);
    }
    func putlistObject<T : Encodable>(_ key: String, _ objects: [T]){
        var objStrings: [String] = [];
        for obj in objects {
            let jsonData = try! jsonEncoder.encode(obj );
            let jsonString: String! = String(data: jsonData, encoding: String.Encoding.utf8);
            
            objStrings.append(jsonString);
        }
        putListString(key, objStrings);
        
    }
    func getListInt(_ key: String) -> [Int] {
        let value = nsd.object(forKey: key);
        if value != nil {
            return  value as! [Int];
        }else{
            return [Int]();
        }
    }
    func getListFloat(_ key: String) -> [Float] {
        let value = nsd.object(forKey: key);
        if value != nil {
            return  value as! [Float];
        }else{
            return [Float]();
        }
    }
    func getListDouble(_ key: String) -> [Double] {
        let value = nsd.object(forKey: key);
        if value != nil {
            return  value as! [Double];
        }else{
            return [Double]();
        }
    }
    func getListBoolean(_ key: String) -> [Bool] {
        let value = nsd.object(forKey: key);
        if value != nil {
            return  value as! [Bool];
        }else{
            return [Bool]();
        }
    }
    func getListString(_ key: String) -> [String] {

        let value = nsd.object(forKey: key);
        if value != nil {
            return  value as! [String];
        }else{
            return [String]();
        }
    }
    func getListObject<T: Codable>(_ key: String, _ objType: T.Type) -> [T]{
        let jsonStrings: [String] = getListString(key);
        var objects: [T] = [];
        for jString in jsonStrings {
            let jsonData = jString.data(using: .utf8)!
            var gottenObject: T;
            do {
               gottenObject = try jsonDecoder.decode(T.self, from: jsonData);
               
           } catch {
               let typeWrapper = try! jsonDecoder.decode(TypeWrapper<T>.self, from: jsonData);
               gottenObject =  typeWrapper.object;
           }
            objects.append(gottenObject);
        }
        return objects;
    }
    func putImage(_ uiImage: UIImage, _ folder: String, _ imageName: String) -> String {
        let fullPath = AppFolder.Documents.url.path + "/" + folder + "/" + imageName;
        return putImageWithFullPath(uiImage, fullPath);
    }
    func putImageWithFullPath(_ uiImage: UIImage, _ path: String) -> String {
        let choppedPath = path.replacingOccurrences(of: AppFolder.Documents.url.path, with: "")
        let data: Data! = uiImage.pngData();
        var folder: Folder;
        folder = try! Folder(path: AppFolder.Documents.url.path);
        let file: File = try! folder.createFile(at: choppedPath, contents: data)
        return file.path;
    }
    func setupFile(_ folderS: String, _ imageName: String) -> String {
        var folder: Folder;
        folder = try! Folder(path: AppFolder.Documents.url.path).createSubfolderIfNeeded(at: folderS)
        let file: File = try! folder.createFile(at: imageName);
        return file.path;
    }
    func getImage(_ imagePath: String) -> UIImage {
        let file: File = try! File.init(path: imagePath);
        let imageData: Data = try! file.read();
        return UIImage(data: imageData)!;
    }
    func imageExists(_ imagePath: String) -> Bool {
        var exists: Bool!;
        do {
            try File.init(path: imagePath);
            exists = true;
        } catch is LocationError {
            exists = false
        } catch {
            exists = false
        }
        return exists
    }
    func deleteImage(_ path: String){
        let file: File = try! File.init(path: path)
        try! file.delete();
    }
    func objectExists(_ key:String) -> Bool{
        let gottenString = getString(key);
        if gottenString.isEmpty{
            return false;
        }else{
             return true;
        }
    }
    func remove(_ key: String){
        nsd.removeObject(forKey: key);
    }
}
public struct TypeWrapper<T: Codable>: Codable {
    enum CodingKeys: String, CodingKey {
        case object
    }
    public let object: T
    public init(object: T) {
        self.object = object
    }
}
