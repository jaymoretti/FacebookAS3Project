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
package br.com.asdevs.Facebook.friends
{
	import com.facebook.graph.Facebook;
	public dynamic class FacebookFriend
	{
		public function FacebookFriend(data:Object) {
			for(var key:String in data)
				this[key]= data[key];
				
			getData();
		}
		
		private function getData():void
		{
			Facebook.api("/"+this.id, gotUserData);
		}
		
		private function gotUserData(result:Object, fail:Object):void
		{
			for(var key:String in result)
				this[key]= result[key];
		}
		
	}
}
