package;

import flixel.addons.effects.FlxWaveSprite.WaveMode;
import flixel.addons.plugin.FlxScrollingText;
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

import flixel.addons.api.FlxGameJolt;
/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	
	var stars:FlxStarField2D;
	var player:Player;
	
	var againText:FlxText;
	var testText:FlxText;
	var scoreText:FlxText;
	//var screenScoreText:FlxText;
	//var highScoreText:FlxText;
	
	var trashGroup:FlxTypedGroup<Trash>;
	
	var spawnTime:Float = 1;
	
	var musicTheme:FlxSound;
	
	var score:Int;
	
	var highScore:Int;
	
	var numberOfDeaths:Int;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		score = 0;
		highScore = 0;
		stars = new FlxStarField2D();
		add(stars);
		
		player = new Player();
		add(player);
		add(player.getGibs());
		
		trashGroup = new FlxTypedGroup<Trash>();
		trashGroup.set_maxSize(17);
		add(trashGroup);
		
		initTexts();
		FlxG.sound.play("assets/music/nebula.wav", 1, true);
	
		gamejoltTrophiesInit();
		super.create();

	}
	
	
	private function initTexts():Void
	{
		againText = new FlxText(200,200,0,"",20);
		againText.visible = false;
		againText.text = "Press SPACE for restart";
		//add(new FlxText(200, 10, 100, "" + player.getYVelocity()));
		add(againText);
		
		scoreText = new FlxText(200, 100, 0, "", 20);
		scoreText.visible = false;
		add(scoreText);
		
		
		
		testText = new FlxText(0, 0, 0, "", 8);
		add(testText);
	}
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}
	
	
	private function checkHighScore():Void
	{
		if (score > highScore)
		{
			highScore = score;
		}
	}
	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		if (player.alive)
		{
			againText.visible = false;
			checkColision();
			checkforGamejoltTrophies();
		} else
		{
			checkHighScore();
			againText.visible = true;
			scoreText.visible = true;
			scoreText.text = "Your score is : " +score+"\nHigh score :" + highScore;
			numberOfDeaths++;
			
			if (FlxG.keys.anyPressed(["SPACE"]))
			{
				FlxGameJolt.addTrophy(10549);
				restartGame();
				againText.visible = false;
				scoreText.visible = false;
				player.alive = true;
				player.visible = true;
				player.revive();
				score = 0;
			}
		}
		
		
		
		spawnEnemy();
		
		super.update();
		
	}
	
	private function gamejoltTrophiesInit() : Void
	{
		FlxGameJolt.init(32383, "44951526d06717ae57e88607b56be2b7",true);
	}
	
	private function checkforGamejoltTrophies() : Void
	{
		if (score > 100)
		{
			FlxGameJolt.openSession();
			FlxGameJolt.addTrophy(10544);
			FlxGameJolt.closeSession();
		}
		
		if (score > 200)
		{
			FlxGameJolt.addTrophy(10545);
		}
		
		if (score > 300)
		{
			FlxGameJolt.addTrophy(10546);
		}
		
		if (score > 500)
		{
			FlxGameJolt.addTrophy(10457);
		}
		
		if (numberOfDeaths > 20)
		{
			FlxGameJolt.addTrophy(10548);
		}
		
		testText.text = "" + score;
		
		
	}
	public function spawnEnemy():Void
	{

		spawnTime -= FlxG.elapsed;
		if (spawnTime < 0)
		{
			spawnTime = FlxRandom.floatRanged(0.1,0.5);
			var trash = new Trash();
			add(trash.getGibs());
			trashGroup.add(trash);
		}

	}
	
	private function restartGame():Void
	{
		//trashGroup.clear();
		player.x = 100;
		player.y = 100;
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
					t.alive = false;
					t2.alive = false;
					score = score + 3;
				}
			}
		}
		
		
		for (t in trashGroup)
		{
			if (t.x < -50)
			{
				trashGroup.remove(t);
				score++;
			}
		}
		
		if (player.y < -35)
		{
			player.alive = false;
		}
		
		if (player.y > 480)
		{
			player.alive = false;
		}
		
	}
}