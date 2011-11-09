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
	import com.jaymoretti.utils.vector.VectorUtils;
	import flash.utils.getQualifiedClassName;
	import com.facebook.graph.Facebook;

	public dynamic class FacbookFriends
	{
		private var _dataCallback : Function;
		private var _friendsList: Vector.<FacebookFriend> = new Vector.<FacebookFriend>();
		public function init():void
		{
			
			Facebook.api("/me/friends", gotData);
		}

		private function gotData(results:Object, fail:Object) : void
		{
			for(var key:String in results)
				if(getQualifiedClassName(results[key]) == "Object")
					_friendsList.push(new FacebookFriend(results[key]));
					
			_dataCallback.call();
		}
		
		public function getFriendById(id:String):FacebookFriend
		{
			var friend:FacebookFriend = _friendsList[VectorUtils.getFirstIndexOf(id, "id", Vector.<*>(_friendsList))];
			return friend;
		}
		
		public function getFriendByName(name:String):FacebookFriend
		{
			var friend:FacebookFriend = _friendsList[VectorUtils.getFirstIndexOf(name, "name", Vector.<*>(_friendsList))];
			return friend;
		}
		
		public function set dataCallback(fn:Function):void
		{
			_dataCallback = fn;
		}

		public function get friendsList() : Vector.<FacebookFriend>
		{
			return _friendsList;
		}	
	}
}
