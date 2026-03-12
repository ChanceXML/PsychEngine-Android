package mobile.controls;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;

import backend.ClientPrefs;

typedef HitboxCallback = {
    var callback:Void->Void;
}

class HitBox extends FlxSpriteGroup
{
    public var buttonLeft:HitboxButton;
    public var buttonDown:HitboxButton;
    public var buttonUp:HitboxButton;
    public var buttonRight:HitboxButton;

    public function new()
    {
        super();

        var w:Int = Std.int(FlxG.width / 4);
        var h:Int = Std.int(FlxG.height);

        buttonLeft = new HitboxButton(0, 0, w, h, 0xFFC24B99);
        buttonDown = new HitboxButton(w, 0, w, h, 0xFF00FFFF);
        buttonUp = new HitboxButton(w * 2, 0, w, h, 0xFF12FA05);
        buttonRight = new HitboxButton(w * 3, 0, w, h, 0xFFF9393F);

        add(buttonLeft);
        add(buttonDown);
        add(buttonUp);
        add(buttonRight);

        for (button in [buttonLeft, buttonDown, buttonUp, buttonRight])
        {
            button.scrollFactor.set();
        }

        scrollFactor.set();
    }

    public static function BACK():Bool
    {
        #if android
        return FlxG.android.justReleased.BACK;
        #else
        return false;
        #end
    }
}

class HitboxButton extends FlxSprite
{
    public var onDown:HitboxCallback = {callback: null};
    public var onUp:HitboxCallback = {callback: null};
    public var onOut:HitboxCallback = {callback: null};

    public var isPressed:Bool = false;
    private var _wasPressed:Bool = false;

    private var _touchPoint:FlxPoint = new FlxPoint();

    public function new(x:Float, y:Float, width:Int, height:Int, color:FlxColor)
    {
        super(x, y);

        makeGraphic(width, height, color);
        alpha = 0.00001;
        antialiasing = false;
    }

    override public function update(elapsed:Float)
    {
        _wasPressed = isPressed;
        isPressed = false;

        checkInputs();

        if (isPressed && !_wasPressed)
        {
            if (onDown.callback != null) onDown.callback();
        }
        else if (!isPressed && _wasPressed)
        {
            if (onUp.callback != null) onUp.callback();
            if (onOut.callback != null) onOut.callback();
        }

        if (ClientPrefs.data.hitboxHints)
            alpha = isPressed ? ClientPrefs.data.hitboxOpacity : 0.00001;
        else
            alpha = 0.00001;

        super.update(elapsed);
    }

    private function checkInputs():Void
    {
        #if FLX_TOUCH
        for (touch in FlxG.touches.list)
        {
            touch.getWorldPosition(null, _touchPoint);
            if (overlapsPoint(_touchPoint))
            {
                isPressed = true;
                return;
            }
        }
        #end

        #if FLX_MOUSE
        if (FlxG.mouse.pressed)
        {
            FlxG.mouse.getWorldPosition(null, _touchPoint);
            if (overlapsPoint(_touchPoint))
                isPressed = true;
        }
        #end
    }

    override public function destroy():Void
    {
        _touchPoint = null;
        super.destroy();
    }
}
