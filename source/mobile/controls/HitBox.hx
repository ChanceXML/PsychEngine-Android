package mobile.controls;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.ui.FlxButton;
import openfl.ui.Keyboard;

class MobileHitbox extends FlxSpriteGroup
{
    var buttonLeft:FlxButton;
    var buttonDown:FlxButton;
    var buttonUp:FlxButton;
    var buttonRight:FlxButton;

    public function new()
    {
        super();

        var w = Std.int(FlxG.width / 4);

        buttonLeft = createZone(0 * w);
        buttonDown = createZone(1 * w);
        buttonUp = createZone(2 * w);
        buttonRight = createZone(3 * w);

        add(buttonLeft);
        add(buttonDown);
        add(buttonUp);
        add(buttonRight);

        setupCallbacks();
    }

    function createZone(x:Float):FlxButton
    {
        var btn = new FlxButton(x, 0);
        btn.makeGraphic(Std.int(FlxG.width / 4), FlxG.height, 0x00FFFFFF);
        btn.alpha = 0;
        btn.scrollFactor.set();
        return btn;
    }

    function setupCallbacks()
    {
        buttonLeft.onDown.callback = function() pressKey(Keyboard.LEFT);
        buttonLeft.onUp.callback = function() releaseKey(Keyboard.LEFT);
        buttonLeft.onOut.callback = buttonLeft.onUp.callback;

        buttonDown.onDown.callback = function() pressKey(Keyboard.DOWN);
        buttonDown.onUp.callback = function() releaseKey(Keyboard.DOWN);
        buttonDown.onOut.callback = buttonDown.onUp.callback;

        buttonUp.onDown.callback = function() pressKey(Keyboard.UP);
        buttonUp.onUp.callback = function() releaseKey(Keyboard.UP);
        buttonUp.onOut.callback = buttonUp.onUp.callback;

        buttonRight.onDown.callback = function() pressKey(Keyboard.RIGHT);
        buttonRight.onUp.callback = function() releaseKey(Keyboard.RIGHT);
        buttonRight.onOut.callback = buttonRight.onUp.callback;
    }

    function pressKey(key:Int)
    {
        FlxG.keys._keyList[key].current = 2;
    }

    function releaseKey(key:Int)
    {
        FlxG.keys._keyList[key].current = 0;
    }
}
