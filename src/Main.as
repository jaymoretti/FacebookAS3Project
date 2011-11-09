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
package
{
	import br.com.asdevs.Facebook.FacebookHelper;
	import br.com.asdevs.Facebook.friends.FacbookFriends;
	import br.com.asdevs.Facebook.friends.FacebookFriend;
	import br.com.asdevs.Facebook.user.FacebookUser;

	import com.facebook.graph.Facebook;
	import com.facebook.graph.data.FacebookSession;

	import flash.display.Sprite;
	import flash.events.Event;
	public class Main extends Sprite
	{
		private const APP_ID:String = "184541281624192";
		private const PERMISSIONS : Object = {perms:"publish_stream, user_photos, user_videos, user_online_presence"};
		private var loginButton : Sprite;
		private var loggedIn : Boolean = false;
		private var facebookSession : FacebookSession;
		private var facebookHelper : FacebookHelper;
		private var facebookUser : FacebookUser;
		private var facebookFriends : FacbookFriends;
		
		public function Main() {
			addEventListener(Event.ADDED_TO_STAGE, startApp);		
		}

		private function startApp(event : Event) : void
		{
			facebookHelper = new FacebookHelper();
			facebookHelper.callback = onSession;
			facebookHelper.init(APP_ID, PERMISSIONS);
		}

		private function onSession(status:Boolean) : void
		{
			if(status)
			{
				getUserData();
			} else {
				facebookHelper.login();
			}
		}

		private function getUserData() : void
		{
			facebookUser = new FacebookUser();
			facebookUser.dataCallback = gotUserData;
			facebookUser.init();
		}

		private function gotUserData() : void
		{
			getFriendsData();
		}

		private function getFriendsData() : void
		{
			facebookFriends = new FacbookFriends();
			facebookFriends.dataCallback = gotFriends;
			facebookFriends.init();
		}

		private function gotFriends() : void
		{
			var friend:FacebookFriend = facebookFriends.getFriendByName("Ivam Moretti");
			postToWall();			
		}

		private function postToWall() : void
		{
			var method:String = "feed";
			var data:Object = {name:"ASDevs Rocks", 
				link:"http://www.asdevs.com.br", 
				picture:"https://si0.twimg.com/profile_images/1110542390/ActionscriptIcon_400.png",
				caption:"Facebook é maisfácil que parece",
				description:"É só tratar com carinho e cachaça que vai"};
			
 			Facebook.ui(method, data, postedToWall);
		}

		private function postedToWall(result:Object) : void
		{
			if(result && result.post_id)
				log(result.id);
			else
				log("deu merda");
		}
	}
}
