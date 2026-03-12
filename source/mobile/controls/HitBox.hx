package mobile.controls;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.FlxCamera;
import flixel.math.FlxPoint;

typedef HitboxCallback =
{
    var callback:Void->Void;
}

class HitBox extends FlxSpriteGroup
{
    public var hitboxCamera:FlxCamera;

    public var buttonLeft:HitboxButton;
    public var buttonDown:HitboxButton;
    public var buttonUp:HitboxButton;
    public var buttonRight:HitboxButton;

    public function new()
    {
        super();

        var w:Int = Std.int(FlxG.width / 4);
        var h:Int = Std.int(FlxG.height);

        hitboxCamera = new FlxCamera();
        hitboxCamera.bgColor = 0;
        hitboxCamera.zoom = 1;

        FlxG.cameras.add(hitboxCamera, false);

        buttonLeft = new HitboxButton(0, 0, w, h, 0xFFC24B99);
        buttonDown = new HitboxButton(w, 0, w, h, 0xFF00FFFF);
        buttonUp = new HitboxButton(w * 2, 0, w, h, 0xFF12FA05);
        buttonRight = new HitboxButton(w * 3, 0, w, h, 0xFFF9393F);

        add(buttonLeft);
        add(buttonDown);
        add(buttonUp);
        add(buttonRight);

        cameras = [hitboxCamera];
        scrollFactor.set(0, 0);
    }

    override public function destroy():Void
    {
        super.destroy();

        if (FlxG.cameras.list.contains(hitboxCamera))
            FlxG.cameras.remove(hitboxCamera);

        hitboxCamera = null;
    }
}

class HitboxButton extends FlxSprite
{
    public var onDown:HitboxCallback = {callback: null};
    public var onUp:HitboxCallback = {callback: null};
    public var onOut:HitboxCallback = {callback: null};

    public var isPressed:Bool = false;
    private var wasPressed:Bool = false;

    private var touchPoint:FlxPoint = new FlxPoint();

    public function new(x:Float, y:Float, w:Int, h:Int, color:FlxColor)
    {
        super(x, y);

        makeGraphic(w, h, color);
        alpha = 0.00001;
        antialiasing = false;
    }

    override public function update(elapsed:Float)
    {
        wasPressed = isPressed;
        isPressed = false;

        checkInputs();

        if (isPressed && !wasPressed)
        {
            if (onDown.callback != null) onDown.callback();
        }
        else if (!isPressed && wasPressed)
        {
            if (onUp.callback != null) onUp.callback();
            if (onOut.callback != null) onOut.callback();
        }

        super.update(elapsed);
    }

    private function checkInputs():Void
    {
        #if FLX_TOUCH
        for (touch in FlxG.touches.list)
        {
            touch.getWorldPosition(cameras[0], touchPoint);

            if (overlapsPoint(touchPoint))
            {
                isPressed = true;
                return;
            }
        }
        #end

        #if FLX_MOUSE
        if (FlxG.mouse.pressed)
        {
            FlxG.mouse.getWorldPosition(cameras[0], touchPoint);

            if (overlapsPoint(touchPoint))
                isPressed = true;
        }
        #end
    }

    override public function destroy():Void
    {
        touchPoint = null;
        super.destroy();
    }
}
