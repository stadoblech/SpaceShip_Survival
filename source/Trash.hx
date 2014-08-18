package ;
import flixel.FlxSprite;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;
import flixel.util.FlxAngle;
import flixel.effects.particles.FlxEmitterExt;
/**
 * ...
 * @author ...
 */
class Trash extends FlxSprite
{
	var speed:Float;
	
	var gibs:FlxEmitterExt;
	var gravity:Float = 120;
 
	public function new() 
	{
		randomizeSpawnPosition();
		
		super(x, y);
		
		//acceleration.y = 30;
		acceleration.set();
		drag.set(0, 0);
		randomizeTrashProperties();
		centerOffsets();
		
		loadGraphic(Reg.trashSprite, false);
		centerOffsets();
		antialiasing = true;
		createGibs();
		
	}
	
	override public function destroy():Void 
	{
		super.destroy();
	}
	
	private function createGibs():Void
	{
		gibs = new FlxEmitterExt();
		gibs.setXSpeed( -FlxRandom.intRanged(10,100), FlxRandom.intRanged(10,100));
		gibs.setYSpeed( -FlxRandom.intRanged(10,100), FlxRandom.intRanged(10,100));
		gibs.setRotation( -FlxRandom.intRanged(180,720), -FlxRandom.intRanged(180,720));
		gibs.gravity = gravity;
		gibs.bounce = 1;
		gibs.makeParticles(Reg.chunkSprite, 10, 10, false, 0);
		//gibs.makeParticles();
	}
	
	override public function update():Void 
	{
		
		velocity.x -= speed;
		
		if (!alive)
		{
			kill();
			x = -60;
		}
		super.update();
	}
	
	private function killTrash():Void
	{
		solid = false;
		visible = false;
	}
	
	override public function kill():Void
	{
		super.kill();
		gibs.at(this);
		gibs.start(true, 5, 0, 10);
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
	
	public function getGibs():FlxEmitterExt	
	{
		return gibs;
	}
}