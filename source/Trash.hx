package ;
import flixel.FlxSprite;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;

/**
 * ...
 * @author ...
 */
class Trash extends FlxSprite
{
	var speed:Float;
	
	public function new() 
	{
		randomizeSpawnPosition();
		
		super(x, y);
		
		//acceleration.y = 30;
		acceleration.set();
		drag.set(0, 0);
		randomizeTrashProperties();
		
		loadGraphic(Reg.trashSprite, false);
		centerOffsets();
		antialiasing = true;
		
		
	}
	
	override public function update():Void 
	{
		velocity.x -= speed;
		super.update();
	}
	
	private function randomizeSpawnPosition():Void
	{
		x = FlxRandom.intRanged(640, 1500);
		y = FlxRandom.intRanged(0, 480);
	}
	
	private function randomizeTrashProperties():Void
	{
		angularVelocity = FlxRandom.floatRanged( -180, 180);
		speed = FlxRandom.floatRanged(0.1,3);
		
	}
}