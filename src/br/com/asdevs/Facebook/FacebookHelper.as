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
package br.com.asdevs.Facebook
{
	import com.facebook.graph.Facebook;
	import com.facebook.graph.data.FacebookSession;

	import flash.display.Sprite;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	public class FacebookHelper
	{
		private var _callback : Function;
		private var _appid : String;
		private var _permissions : Object;
		private var loggedIn : Boolean;
		private var loginButton : Sprite;
		private var facebookSession : FacebookSession;
		private var _timer : uint;


		public function init(appid : String, permissions : Object) : void
		{
			_permissions = permissions;
			_appid = appid;
			
			Facebook.init(_appid, onInit);
		}

		private function onInit(result : Object, fail : Object) : void
		{
			log(result);
			if (result)
			{
				if(_timer)
					clearInterval(_timer);
					
				getSession(result);
			}else
			{
				loggedIn = false;
			}
			
			if(!_timer)
				_callback.call(this, loggedIn); 
		}

		public function login(/*event : MouseEvent*/) : void
		{
			if (!loggedIn)
			{
				Facebook.login(onLogin, _permissions);
				
				if(!_timer)
					startTimer();
			}
		}

		private function startTimer() : void
		{
			_timer = setInterval(checkLogin, 500);
		}

		private function checkLogin() : void
		{
			Facebook.init(_appid, onInit);
		}

		private function onLogout() : void
		{
			loggedIn = false;
		}

		private function onLogin(result : Object, fail : Object) : void
		{
			if (result)
				getSession(result);
		}

		private function getSession(result : Object) : void
		{
			loggedIn = true;
			facebookSession = result as FacebookSession;
			_callback.call(this, loggedIn);
		}

		public function set callback(fn : Function) : void
		{
			_callback = fn;
		}

		public function get _facebookSession() : FacebookSession
		{
			return facebookSession;
		}
	}
}
