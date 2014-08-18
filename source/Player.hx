package ;
import flixel.addons.effects.FlxWaveSprite.WaveMode;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxEmitterExt;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxAngle;
import flixel.addons.effects.FlxTrail;
import flixel.util.FlxRandom;

/**
 * ...
 * @author ...
 */
class Player extends FlxSprite
{
	var isJump:Bool = false;
	var gravity:Int = 120;
	var jumpVelocity: Float = -150;
	var jumpTime:Float;
	var maxAngle:Float = 50;
	var minAngle:Float = -45;
	
	var gibs:FlxEmitterExt;
		

	
	public function new() 
	{
		super(100,100);
		loadGraphic(Reg.playerSprite,false);
		acceleration.y = gravity;
		centerOffsets();
		createGibs();
		antialiasing = true;
	}
	
	override public function update():Void 
	{
		jump();	
		
		/*
		if (FlxG.keys.anyPressed(["C"]))
		{
			killShip();
		}
		*/
		
		if (!alive)
		{
			killShip();
		}
		
		super.update();
		
		
	}
	
	public function getYVelocity():Float
	{
		return velocity.y;
	}
	
	public function getAngle():Float
	{
		return angle;
	}
	
	
	override public function kill():Void 
	{
		solid = false;
		visible = false;
		
		super.kill();
	}
	
	private function killShip():Void
	{
		if (gibs != null)
		{
			gibs.at(this);
			gibs.start(true, 5, 0,10);
			kill();
			x = -300;
			
		}
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
	
	private inline function jump():Void
	{
		if (FlxG.keys.anyPressed(["SPACE"])&& !isJump)
		{
			isJump = true;
			velocity.y = jumpVelocity;
			angle = minAngle;
		}
		
		if (velocity.y > 0)
		{
			isJump = false;
		}
		angle += 0.5;
		
		if (angle < minAngle )
		{
			angle = minAngle;
		}
		if (angle > maxAngle)
		{
			angle = maxAngle;
		}
			
		FlxAngle.rotatePoint(0, 0, 0, 0, angle);
	}
	
	public function getGibs():FlxEmitterExt	
	{
		return gibs;
	}
}