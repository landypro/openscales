﻿/*** GTweeny by Grant Skinner. Aug 15, 2008* Visit www.gskinner.com/blog for documentation, updates and more free code.*** Copyright (c) 2008 Grant Skinner* * Permission is hereby granted, free of charge, to any person* obtaining a copy of this software and associated documentation* files (the "Software"), to deal in the Software without* restriction, including without limitation the rights to use,* copy, modify, merge, publish, distribute, sublicense, and/or sell* copies of the Software, and to permit persons to whom the* Software is furnished to do so, subject to the following* conditions:* * The above copyright notice and this permission notice shall be* included in all copies or substantial portions of the Software.* * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES* OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT* HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR* OTHER DEALINGS IN THE SOFTWARE.**/package com.gskinner.motion {		import flash.events.Event;	import flash.events.EventDispatcher;	import flash.events.IEventDispatcher;	import flash.utils.Dictionary;			/**	* This event is dispatched each time the tween updates properties on its target.	* It will be dispatched each "tick" during the TWEEN.	*	* @eventType flash.events.Event	**/	[Event(name="change", type="flash.events.Event")]	/**	* Dispatched when a tween copies its initial properties and starts tweening. In tweens with a delay of 0, this event will	* fire immediately when it starts playing. In tweens with a delay set, this will fire when the delay state is ended, and the tween state is entered.	*	* @eventType flash.events.Event	**/	[Event(name="init", type="flash.events.Event")]	/**	* Dispatched when a tween ends (its position equals its duration).	*	* @eventType flash.events.Event	**/	[Event(name="complete", type="flash.events.Event")]		/**	* <b>GTweeny ©2008 Grant Skinner, gskinner.com. Visit www.gskinner.com/libraries/gtween/ for documentation, updates and more free code. Licensed under the MIT license - see the source file header for more information.</b>	* <hr>	* GTweeny is the ultra lightweight younger sibling of GTween. It strips out secondary features	* to deliver a robust tweening engine in less than 3kb.	* <br/><br/>	* It retains events, deterministic positioning, repeat counts, reflect, reverse, autoRotation, autoVisible, pausing, pausing all, jumping to the start or end, sequencing,	* snapping, jumping to an arbitrary point in the tween, basic sequencing, delays, and interrupt handling.	*	* Specifically, the following is not part of GTweeny:<UL>	* <li> all constants (START, DELAY, TWEEN, END, TIME, FRAME, HYBRID)	* <li> timingMode (always uses HYBRID)	* <li> timeInterval	* <li> setAssignment	* <li> proxy	* <li> state	* <li> getProperties	* <li> setStartProperties	* <li> getStartProperties	* <li> lockStartProperties	* <li> propertyTarget	* </UL>	**/		public class GTweeny extends EventDispatcher {			// static interface:		/** @private **/		protected static var activeTweens:Dictionary = new Dictionary(); // keeps active tweens in memory				/** @private **/		protected static var _ticker:HybridTicker;				/** Setting this to true pauses all tween instances. This does not affect individual tweens' .paused property. **/		public static var pauseAll:Boolean=false;				/** Specifies the default easing function to use with new tweens. If null, GTween.linearEase will be used. **/		public static var defaultEase:Function;				/** A hash table specifying properties that should be affected by autoRotation. **/		public static var rotationProperties:Object = {rotation:true,rotationX:true,rotationY:true,rotationZ:true};				/** A hash table specifying properties that should have their value rounded (snapped) before being applied. This can be toggled for each tween instance basis with the .snapping property. **/		public static var snappingProperties:Object = {x:true,y:true};				/** The currently active Ticker object. **/		public static function get ticker():HybridTicker {			if (_ticker) { return _ticker; }			return _ticker = new HybridTicker();		}				/** The default easing function used by GTween. **/		public static function linearEase(t:Number, b:Number, c:Number, d:Number):Number {			return t;		}	// END static interface.			// public properties:		/**		* Indicates whether the tween should automatically play when an end value is changed.		**/		public var autoPlay:Boolean = true;				/**		* When true, the tween will always rotate in the shortest direction to reach the destination rotation.		* For example, rotating from 355 degress to 5 degrees will rotate 10 degrees clockwise with .autoRotation set to true.		* It would rotate 350 degrees counter-clockwise with .autoRotation set to false. This affects all properties specified		* in the static .rotationProperties hash table.		**/		public var autoRotation:Boolean = false;				/**		* Indicates whether the target's visible property should automatically be set to false when its alpha value is tweened to 0 or less.		* Only affects objects with a visible property.		**/		public var autoVisible:Boolean = true;				/**		* Allows you to associate arbitrary data with your tween. For example, you might use this to reference specific data when handling events from tweens.		**/		public var data:*;				/**		* The length of the tween in frames or seconds (depending on the timingMode). Setting this will also update any child transitions		* that have synchDuration set to true.		**/		public var duration:Number=1;				/**		* The easing function to use for calculating the tween. This can be any standard tween function, such as the tween functions in fl.motion.easing.* that come with Flash CS3.		* New tweens will have this set to the defaultTween. Setting this to null will cause GTween to throw null reference errors.		**/		public var ease:Function=linearEase;				/**		* Specifies another GTween instance that will have paused=false called on it when this tween completes.		**/		public var nextTween:GTweeny;				/**		* Indicates whether the tween should use the reflect mode when repeating. If reflect is set to true, then the tween will play backwards on every other repeat.		* This has similar effects to reversed, but the properties are exclusive of one another.		* For instance, with reversed set to false, reflected set to true, and a repeat of 1, the tween will play from start to end, then repeat and reflect to play from end to start.		* If in the previous example reversed was instead set to true, the tween would play from end to start, then repeat and reflect to play from start to end.		* Finally, with reversed set to false, reflected set to false, and a repeat of 1, the tween will play from start to end, then repeat from start to end		**/		public var reflect:Boolean=false;				/**		* The number of times this tween will repeat. If 0, the tween will only run once. If 1 or more, the tween will repeat that many times. If -1, the tween will repeat forever.		**/		public var repeat:int=0;				/**		* If set to true, tweened values specified by snappingProperties will be rounded (snapped) before they are assigned to the target.		**/		public var snapping:Boolean = false;					// private properties:		/** @private **/		protected var startValues:Object;		/** @private **/		protected var endValues:Object;		/** @private **/		protected var inited:Boolean;		/** @private **/		protected var inTick:Boolean;		/** @private **/		protected var positionOffset:Number;		/** @private **/		protected var _position:Number=0;		/** @private **/		protected var _previousPosition:Number;		/** @private **/		protected var _tweenPosition:Number=0;		/** @private **/		protected var _previousTweenPosition:Number;		/** @private **/		protected var _target:Object;		/** @private **/		protected var _paused:Boolean=true;		/** @private **/		protected var _delay:Number=0;		/** @private **/		protected var _reversed:Boolean;			// constructor:		/**		* Constructs a new GTween instance.		*		* @param target The object whose properties will be tweened. Defaults to null.		* @param duration The length of the tween in frames or seconds depending on the timingMode. Defaults to 10.		* @param properties An object containing destination property values. For example, to tween to x=100, y=100, you could pass {x:100, y:100} as the props object.		* @param tweenProperties An object containing properties to set on this tween. For example, you could pass {ease:myEase} to set the ease property of the new instance. This also provides a shortcut for setting up event listeners. See .setTweenProperties() for more information.		**/		public function GTweeny(target:Object=null, duration:Number=10, properties:Object=null, tweenProperties:Object=null) {			this.target = target;			this.duration = duration;			ease = defaultEase || linearEase;			setProperties(properties);			setTweenProperties(tweenProperties);		}			// public getter / setters:				/**		* Gets and sets the position in the tween in frames or seconds (depending on the timingMode). This value can be any number, and will be resolved to a tweenPosition value		* prior to being applied to the tweened values. See tweenPosition for more information.		* <br/><br/>		* <b>Negative values</b><br/>		* Values below 0 will always resolve to a tweenPosition of 0. Negative values can be used to set up a delay on the tween, as the tween will have to count up to 0 before initing.		* <br/><br/>		* <b>Positive values</b><br/>		* Positive values are resolved based on the duration, repeat, reflect, and reversed properties.		**/		public function get position():Number {			return _position;		}		public function set position(value:Number):void {			setPosition(value,true);		}				/**		* Indicates whether the tween is currently paused. See play() and pause() for more information.		**/		public function get paused():Boolean {			return _paused;		}		public function set paused(value:Boolean):void {			if (value == _paused) { return; }			_paused = value;			if (value) {				ticker.removeEventListener("tick",handleTick);			} else {				ticker.addEventListener("tick",handleTick,false,0,true);				if (repeat != -1 && _position >= duration*(repeat+1)) { position = 0; }				else { updatePositionOffset(); }			}			setGCLock(!value);		}				/**		* Returns the calculated absolute position in the tween. This is a deterministic value between 0 and duration calculated		* from the current position based on the duration, repeat, reflect, and reversed properties.		* <br/><br/>		* For example, a tween with a position		* of 5 on a tween with a duration of 3, and repeat set to true would have a tweenPosition of 2 (2 seconds into the first repeat).		* The same tween with reflect set to true would have a tweenPosition of 1 (because it would be 2 seconds into the first repeat which is		* playing backwards). With reflect and reversed set to true it would have a tweenPosition of 2.		* <br/><br/>		* Tweens with a position less than 0 will have a tweenPosition of 0. Tweens with a position greater than <code>duration*(repeat+1)</code>		* (the total length of the tween) will have a tweenPosition equal to duration.		**/		public function get tweenPosition():Number {			return _tweenPosition;		}				/**		* The target object to tween. This can be any kind of object.		**/		public function get target():Object {			return _target;		}		public function set target(value:Object):void {			_target = (value === null) ? {} : value;			inited = false;		}				/**		* Indicates whether a tween should run in reverse. In the simplest examples this means that the tween will play from its end values to its start values.		* See "reflect" for more information on how these two related properties interact. Also see reverse().		**/		public function get reversed():Boolean {			return _reversed;		}		public function set reversed(value:Boolean):void {			if (value == _reversed) { return; }			_reversed = value;			// we force an init so that it jumps to the proper position immediately without flicker.			if (!inited) { init(); }			setPosition(_position,true);		}				/**		* The length of the delay in frames or seconds (depending on the timingMode). The delay occurs before a tween reads initial values or starts playing.		**/		public function get delay():Number {			return _delay;		}		public function set delay(value:Number):void {			_delay = value;			if (_position == -_delay) {				_position = -_delay;			}		}			// public methods:				/**		* Shorthand method for making multiple setProperty calls quickly. This removes any existing target property values on the tween.		* <br/><br/>		* <b>Example:</b> set x and y end values:<br/>		* <code>myGTween.setProperties({x:200, y:400});</code>		*		* @param properties An object containing end property values.		**/		public function setProperties(properties:Object):void {			endValues = {};			for (var n:String in properties) {				setProperty(n, properties[n]);			}		}				/**		* Sets the numeric end value for a property on the target object that you would like to tween.		* For example, if you wanted to tween to a new x position, you could use: myGTween.setProperty("x",400). Non-numeric values are ignored.		*		* @param name The name of the property to tween.		* @param value The numeric end value (the value to tween to).		**/		public function setProperty(name:String, value:Number):void {			if (isNaN(value)) { return; }			endValues[name] = value;			invalidate();		}				/**		* Returns the destination value for the specified property if one exists.		*		* @param name The name of the property to return a destination value for.		**/		public function getProperty(name:String):Number {			return endValues[name];		}				/**		* Removes a end value from the tween. This prevents the GTween instance from tweening the property.		*		* @param name The name of the end property to delete.		**/		public function deleteProperty(name:String):Boolean {			return delete(endValues[name]);		}				/**		* Shortcut method for setting multiple properties on the tween instance quickly. This does not set destination values (ie. the value to tween to).		* This method also provides you with a quick method for adding listeners to specific events, using the special properties:		* initListener, completeListener, changeListener.		* <br/><br/>		* <b>Example:</b> This will set the duration, reflect, and nextTween properties of a tween, and add a listener for the complete event:<br/>		* <code>myTween.setTweenProperties({duration:4, reflect:true, nextTween:anotherTween, completeListener:completeHandlerFunction});</code>		**/		public function setTweenProperties(properties:Object):void {			if (!properties) { return; }						var positionValue:Number;			if ("position" in properties) { positionValue = properties.position; delete(properties.position); }			if ("initListener" in properties) { addEventListener(Event.INIT,properties.initListener,false,0,true); delete(properties.initListener); }			if ("completeListener" in properties) { addEventListener(Event.COMPLETE,properties.completeListener,false,0,true); delete(properties.completeListener); }			if ("changeListener" in properties) { addEventListener(Event.CHANGE,properties.changeListener,false,0,true); delete(properties.changeListener); }						for (var n:String in properties) {				this[n] = properties[n];			}						if (!isNaN(positionValue)) { position = positionValue; }		}				/**		* Toggles the reversed property and inverts the current tween position.		* This will cause a tween to reverse playing visually.		* There is currently an issue with this functionality for tweens with a repeat of -1		*		* @param suppressEvents Indicates whether to suppress any events or callbacks that are generated as a result of the position change.		**/		public function reverse(suppressEvents:Boolean=true):void {			var pos:Number = repeat == -1 ? duration-_position%duration : (repeat+1)*duration-_position;			if (reflect) {				_reversed = ((position/duration%2>=1) == (pos/duration%2>=1)) != _reversed;			} else {				_reversed = !_reversed;			}			setPosition(pos,suppressEvents);		}				/**		* Invalidate forces the tween to repopulate all of the initial properties from the target object, and start playing if autoplay is set to true.		* If the tween is currently playing, then it will also set the position to 0. For example, if you changed the x and y position of a the target		* object while the tween was playing, you could call invalidate on it to force it to resume the tween with the new property values.		**/		public function invalidate():void {			inited = false;			if (_position > 0) {				_position = 0;				updatePositionOffset();			}			if (autoPlay) { paused = false; }		}				/**		* Pauses the tween by stopping tick from being automatically called. This also releases the tween for garbage collection if		* it is not referenced externally.		**/		public function pause():void {			paused = true;		}				/**		* Plays a tween by incrementing the position property each frame. This also prevents the tween from being garbage collected while it is active.		* This is achieved by way of two methods:<br/>		* 1. If the target object is an IEventDispatcher, then the tween will subscribe to a dummy event using a hard reference. This allows		* the tween to be garbage collected if its target is also collected, and there are no other external references to it.<br/>		* 2. If the target object is not an IEventDispatcher, then the tween is placed in the activeTweens list, to prevent collection until it is paused or reaches the end of the transition).		* Note that pausing all tweens via the GTween.pauseAll static property will not free the tweens for collection.		**/		public function play():void {			paused = false;		}				/**		* Jumps the tween to its beginning. This is the same as setting <code>position=-delay</code>.		**/		public function beginning():void {			setPosition(-_delay);		}				/**		* Jumps the tween to its end. This is the same as setting <code>position=(repeat+1)*duration</code>.		**/		public function end():void {			setPosition( (repeat == -1) ? duration : (repeat+1)*duration );		}				/**		* Sets the position of the tween. Using the position property will always suppress events and callbacks, whereas the		* setPosition method allows you to manually set the position and specify whether to suppress events or not.		*		* @param value The position to jump to in seconds or frames (depending on the timingMode).		* @param suppressEvents Indicates whether to suppress events and callbacks generated from the change in position.		**/		public function setPosition(position:Number,suppressEvents:Boolean=true):void {			_previousPosition = _position;			_position = position;			if (!inTick && !paused) { updatePositionOffset(); }			var maxPos:Number = (repeat+1)*duration;			var tp:Number;			if (position < 0) {				tp = _reversed ? duration : 0;			} else if (repeat == -1 || position < maxPos) {				tp = position%duration;				if ((reflect && position/duration%2>=1) != _reversed) { tp = duration-tp; }			} else {				tp = ((reflect && repeat%2>=1) != _reversed) ? 0 : duration;			}			if (tp == _tweenPosition) { return; }			_previousTweenPosition = _tweenPosition;			_tweenPosition = tp;						if (!suppressEvents && hasEventListener(Event.CHANGE)) { dispatchEvent(new Event(Event.CHANGE)); }									if (!inited && _previousPosition <= 0 && _position >= 0) {				init();				if (!suppressEvents && hasEventListener(Event.INIT)) { dispatchEvent(new Event(Event.INIT)); }			}						updateProperties();						if (repeat != -1 && _previousPosition < maxPos && position >= maxPos) {				if (!suppressEvents && hasEventListener(Event.COMPLETE)) { dispatchEvent(new Event(Event.COMPLETE)); }				paused = true;				if (nextTween) { nextTween.paused = false; }			}		}			// private methods		// copies the initial target properties into the local startValues store.		/** @private **/		protected function init():void {			inited = true;			startValues = {};			for (var n:String in endValues) {				if (autoRotation && rotationProperties[n]) {					var r:Number = endValues[n] = endValues[n] %360;					var tr:Number = _target[n] %360;					startValues[n] = tr + ((Math.abs(tr-r) < 180) ? 0 : (tr>r) ? -360 : 360);				} else {					startValues[n] = _target[n];				}			}		}				// logic that runs each frame. Calculates eased position, updates properties, and reassigns the target if an assignmentTarget was set.		/** @private **/		protected function updateProperties():void {			var ratio:Number = ease(_tweenPosition/duration, 0, 1, 1);			for (var n:String in endValues) {				updateProperty(n,startValues[n],endValues[n],ratio);			}			if (autoVisible && "alpha" in endValues && "alpha" in _target && "visible" in _target) { _target.visible = _target.alpha > 0; }		}				// updates a single property. Mostly for overriding.		/** @private **/		protected function updateProperty(property:String, startValue:Number, endValue:Number, tweenRatio:Number):void {			var value:Number = startValue+(endValue-startValue)*tweenRatio;			if (snapping && snappingProperties[property]) { value = Math.round(value); }			if (property == "currentFrame") { _target.gotoAndStop(value<<0); }			else { _target[property] = value; }		}				// locks or unlocks the tween in memory.		/** @private **/		protected function setGCLock(value:Boolean):void {			if (value) {				if (_target is IEventDispatcher) { _target.addEventListener("GDS__NONEXISTENT_EVENT", nullListener,false,0,false); }				else { activeTweens[this] = true; }			} else {				if (_target is IEventDispatcher) { _target.removeEventListener("GDS__NONEXISTENT_EVENT", nullListener); }				delete(activeTweens[this]);			}		}				// updates the current positionOffset based on the current ticker position.		/** @private **/		protected function updatePositionOffset():void {			positionOffset = ticker.position-_position;		}				// empty listener used by setGCLock.		/** @private **/		protected function nullListener(evt:Event):void {}				// handles tick events while playing.		/** @private **/		protected function handleTick(evt:Event):void {			inTick = true;			if (pauseAll) { updatePositionOffset(); }			else { setPosition(ticker.position - positionOffset, false); }			inTick = false;		}					}	}import flash.events.EventDispatcher;import flash.events.Event;import flash.display.Shape;import flash.utils.getTimer;class HybridTicker extends EventDispatcher {		protected var shape:Shape;		public function HybridTicker():void {		shape = new Shape();		shape.addEventListener(Event.ENTER_FRAME,tick);	}		public function get position():Number {		return getTimer()/1000;	}		protected function tick(evt:Event):void {		dispatchEvent(new Event("tick"));	}}