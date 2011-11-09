/******************************************************************************
 * 			DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 * 					Version 2, December 2004
 * 
 * Copyright (C) 2011 - Jay Moretti <jrmoretti@gmail.com>
 * 
 * Everyone is permitted to copy and distribute verbatim or modified
 * copies of this license document, and changing it is allowed as long
 * as the name is changed.
 * 
 *			DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 *	TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 * 
 *  0. You just DO WHAT THE FUCK YOU WANT TO. 
 *******************************************************************************/
package br.com.asdevs.Facebook.user
{
	import com.facebook.graph.Facebook;
	public dynamic class FacebookUser
	{
		private var _dataCallback : Function;
		public function init():void
		{
			
			Facebook.api("/me", gotData);
		}

		private function gotData(results:Object, fail:Object) : void
		{
			for(var key:String in results)
				this[key] = results[key];
				
			_dataCallback.call();
		}
		
		public function set dataCallback(fn:Function):void
		{
			_dataCallback = fn;
		}

		
	}
}
