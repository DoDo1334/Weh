package;
import haxe.Exception;
import haxe.macro.Expr.Catch;
import haxe.Timer;
import flixel.animation.FlxAnimationController;
import flixel.animation.FlxAnimation;
import flixel.graphics.frames.FlxFramesCollection.FlxFrameCollectionType;
import flixel.util.FlxTimer;
import Character;


class AnimationHandler
{

    var character:Character;
    public var canChangeAnimation:Bool;
    var frameToHoldTo:Int = 0;
    var timedAnimation:Bool = false;
    public var timer:Float = 0;
    var timeToHoldFor:Float = 0;

    public function new(character:Character)
        {
            this.character = character;
            this.character.animation.play('idle');
        }

    public function changeAnimation(animationToUse:String, ?overrideCurrentAnimation:Bool = false, ?UseFrameStop:Bool = true, ?FrameStop:Int = 0)
    {

        if(timer >= 10)
        {
            timer = 10;
        }

        if(timer >= timeToHoldFor)
        {
            timedAnimation = false;
        }

        if(animationToUse == "idle" && frameToHoldTo <= character.animation.curAnim.curFrame && !timedAnimation)
        {
            this.character.animation.play(animationToUse);
            if (character.animOffsets.exists(animationToUse))
            {
                var OffsetList = character.animOffsets.get(animationToUse);
                character.offset.set(OffsetList[0], OffsetList[1]);
            }
        }

        else
        {
            if((overrideCurrentAnimation || frameToHoldTo <= character.animation.curAnim.curFrame) && animationToUse != "idle")
            {
                this.canChangeAnimation = true;
            }
            else 
            {
                this.canChangeAnimation = false;
            }
    
            if(canChangeAnimation)
            {
                var referenceAnimation:FlxAnimation = character.animation.curAnim;
    
                if(this.frameToHoldTo <= this.character.animation.curAnim.curFrame || overrideCurrentAnimation)
                {
                    if(FrameStop > referenceAnimation.numFrames)
                    {
                        FrameStop = referenceAnimation.numFrames - 1;
                    }

                    this.frameToHoldTo = FrameStop;
                    this.character.animation.play(animationToUse, true);
                    if (character.animOffsets.exists(animationToUse))
                    {
                        var OffsetList = character.animOffsets.get(animationToUse);
                        character.offset.set(OffsetList[0], OffsetList[1]);
                    }
                }
                
            }
        }
    }

}

