package options;

class AndroidSettingsSubState extends BaseOptionsMenu
{
    public function new()
    {
        title = 'Android Settings';
        rpcTitle = 'Android Settings Menu';

        var option:Option = new Option(
            'Hitbox Press Opacity',
            "Controls how visible the mobile hitboxes are\nwhen you press them.",
            'hitboxOpacity',
            FLOAT
        );

        option.minValue = 0;
        option.maxValue = 1;
        option.changeValue = 0.05;
        option.decimals = 2;
        option.displayFormat = '%v';

        addOption(option);

        super();
    }
}
