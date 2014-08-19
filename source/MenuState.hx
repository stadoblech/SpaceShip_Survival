package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
//import FlxText;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	
	 var text1:FlxText;
	 var text2:FlxText;
	 var text3:FlxText;
	 
	override public function create():Void
	{
		text1 = new FlxText(100, 100, 0, "SpaceShip Survival Extravaganza !", 20);
		text2 = new FlxText(200, 200, 0, "Controls : SPACE ! \n press space to continue.", 20);
		text3 = new FlxText(200, 300, 0, "Press space to continue.", 20);
		
		text1.alignment = "center";
		text2.alignment = "center";
		text3.alignment = "center";
		
		add(text1);
		add(text2);
		add(text2);
		
		super.create();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		if (FlxG.keys.anyPressed(["SPACE"]))
		{
			FlxG.switchState(new PlayState());
		}
		super.update();
	}	
}