package;

import flixel.addons.effects.FlxWaveSprite.WaveMode;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.addons.display.FlxStarField;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxTimer;
import flixel.util.FlxCollision;
import flixel.util.FlxRandom;

import openfl.Assets;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	
	var stars:FlxStarField2D;
	var player:Player;
	

	var velocityYtext:FlxText;
	var testTextCoords:Float;
	
	var trashGroup:FlxTypedGroup<Trash>;
	
	var spawnTime:Float = 1;
	
	var musicTheme:FlxSound;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		
		stars = new FlxStarField2D();
		add(stars);
		
		player = new Player();
		add(player);
		add(player.getGibs());
		
		trashGroup = new FlxTypedGroup<Trash>();
		add(trashGroup);
		
		velocityYtext = new FlxText(10,10,100);
		add(new FlxText(200, 10, 100, "" + player.getYVelocity()));
		
		add(velocityYtext);
		//FlxG.sound.play("assets/music/nebula.wav");
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
		spawnEnemy();
		velocityYtext.text = "" + player.isAlive();
		checkColision();
		super.update();
	}
	
	public function spawnEnemy():Void
	{
		spawnTime -= FlxG.elapsed;
		if (spawnTime < 0)
		{
			spawnTime = FlxRandom.floatRanged(0.1, 1);
			var trash = new Trash();
			add(trash.getGibs());
			trashGroup.add(trash);
		}
	}
	
	public function checkColision():Void
	{
		for (t in trashGroup)
		{
			if (FlxCollision.pixelPerfectCheck(player, t))
			{
				player.alive = false;
				t.alive = false;
			}
			
			for (t2 in trashGroup)
			{
				if (FlxG.collide(t, t2))
				{
					/*
					t.collided = true;
					t.visible = false;
					t2.visible = false;
					t.solid = false;
					t2.solid = false;
					trashGroup.remove(t, true);
					trashGroup.remove(t2,true);
					*/
					t.alive = false;
					t2.alive = false;
				}
			}
		}
		
		
		for (t in trashGroup)
		{
			if (t.x < -50)
			{
				trashGroup.remove(t);
			}
		}
		
	}
}