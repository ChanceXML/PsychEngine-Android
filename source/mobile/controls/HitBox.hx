package mobile.controls;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.ui.FlxButton;
import backend.Controls;

class MobileHitbox extends FlxSpriteGroup
{
    var buttonLeft:FlxButton;
    var buttonDown:FlxButton;
    var buttonUp:FlxButton;
    var buttonRight:FlxButton;

    public function new()
    {
        super();

        var w:Int = Std.int(FlxG.width / 4);

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
        // LEFT
        buttonLeft.onDown.callback = function()
        {
            Controls.LEFT = true;
            Controls.LEFT_JP = true;
        };

        buttonLeft.onUp.callback = function()
        {
            Controls.LEFT = false;
            Controls.LEFT_JR = true;
        };

        buttonLeft.onOut.callback = buttonLeft.onUp.callback;

        // DOWN
        buttonDown.onDown.callback = function()
        {
            Controls.DOWN = true;
            Controls.DOWN_JP = true;
        };

        buttonDown.onUp.callback = function()
        {
            Controls.DOWN = false;
            Controls.DOWN_JR = true;
        };

        buttonDown.onOut.callback = buttonDown.onUp.callback;

        // UP
        buttonUp.onDown.callback = function()
        {
            Controls.UP = true;
            Controls.UP_JP = true;
        };

        buttonUp.onUp.callback = function()
        {
            Controls.UP = false;
            Controls.UP_JR = true;
        };

        buttonUp.onOut.callback = buttonUp.onUp.callback;

        // RIGHT
        buttonRight.onDown.callback = function()
        {
            Controls.RIGHT = true;
            Controls.RIGHT_JP = true;
        };

        buttonRight.onUp.callback = function()
        {
            Controls.RIGHT = false;
            Controls.RIGHT_JR = true;
        };

        buttonRight.onOut.callback = buttonRight.onUp.callback;
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        // reset just pressed / released every frame
        Controls.LEFT_JP = false;
        Controls.DOWN_JP = false;
        Controls.UP_JP = false;
        Controls.RIGHT_JP = false;

        Controls.LEFT_JR = false;
        Controls.DOWN_JR = false;
        Controls.UP_JR = false;
        Controls.RIGHT_JR = false;
    }
}
