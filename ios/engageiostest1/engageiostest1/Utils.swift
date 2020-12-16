//
//  Utils.swift
//  engageiostest1
//
//  Created by Shaun Botha on 10/15/20.
//

import Foundation

class Utils
{
    static func maybeNil(s: UnsafePointer<CChar>?) -> String
    {
        return maybeNil(s: s, defaultValue: "")
    }

    static func maybeNil(s: UnsafePointer<CChar>?, defaultValue: String?) -> String
    {
        if(s != nil)
        {
            return String(cString: s!)
        }
        else
        {
            return ((defaultValue == nil ? "" : "") ?? "")
        }
    }

    static func getTextFile(fileName : String, fileType: String) -> String
    {
        if let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
        {
            do
            {
                let contents = try String(contentsOfFile: filepath)
                return contents
            }
            catch
            {
                return ""
            }
        }
        else
        {
            return ""
        }
    }
}
