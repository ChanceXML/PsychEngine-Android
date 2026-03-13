package android.utils;

import openfl.events.UncaughtErrorEvent;
import openfl.Lib;
import haxe.CallStack;
import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;

// crash log. this gets saved in com.shadowmario.psychengine/files/logs/ 
class CrashHandler {
    public static function init():Void {
        Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onUncaughtError);
    }

    private static function onUncaughtError(e:UncaughtErrorEvent):Void {
        var errMsg:String = "";
        var path:String = "logs"; 
        
        var callStack:Array<StackItem> = CallStack.exceptionStack(true);
        for (stackItem in callStack) {
            switch (stackItem) {
                case FilePos(s, file, line, column):
                    errMsg += 'File: $file, Line: $line\n';
                default:
                    errMsg += '$stackItem\n';
            }
        }

        errMsg += '\nError: ${e.error}';

        #if sys
        try {
            if (!FileSystem.exists(path)) FileSystem.createDirectory(path);

            var fileName:String = path + "/crash_" + Date.now().getTime() + ".txt";
            File.saveContent(fileName, errMsg + "\n");
            
            trace("Crash File Saved In: " + fileName);
        } catch (e:Dynamic) {
            trace("Couldnt Save Crash Log: " + e);
        }
        #end

        Sys.exit(1);
    }
}
