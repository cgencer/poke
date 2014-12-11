package com.obsesif.models.data
{
	public class gRoom
	{
		private var _title:String;
		private var _type:String;
		private var _stat:String;
		private var _name:String;
		private var _privacy:Boolean;
		private var _id:Number;
		private var _ownerid:Number;
		private var _ssid:Number;
		private var _maxbet:Number;
		private var _minbet:Number;
		private var _password:String;
		private var _minlevel:Number;
		private var _gametype:String;
		private var _maxusr:Number;
		private var _maxspc:Number;
		private var _blindbig:Number;
		private var _blindsmall:Number;
		private var _timelimit:Number;
		private var _buyin:Number;
		private var _buyinT:Number;

		public function gRoom(	title:String, type:String, id:Number, ssid:Number, oid:Number,
										minlevel:Number,
										mu:Number, ms:Number, stat:String,
										gt:String, privacy:Boolean,
										blindbig:Number, blindsmall:Number, timelimit:Number,
										buyin:Number, buyinT:Number, password:String = "") :void
		{
			this._title = title;
			this._type = type;
			this._id = id;
			this._ownerid = oid;
			this._ssid = ssid;

			this._minlevel = minlevel;

			if (mu>9) mu=9;
			this._maxusr = mu;
			this._maxspc = ms;
			this._stat = stat;

			this._gametype = gt;
			this._privacy = privacy;
			this._password = password;

			this._blindbig = blindbig;
			this._blindsmall = blindsmall;

			if (!main.debug)
				this._timelimit = timelimit;
			else
				this._timelimit = 60;

			this._buyin = buyin;
			this._buyinT = buyinT;
		}

		public function roomType(limit:Boolean = false): String
			{
			var ty:String = this._gametype;
			if (this._gametype == "No") ty = "No Limit";

			if (limit)
			{
				if (ty == "Limit")
				{
					ty = this._buyin + "-"+ this._buyinT;
				}else{
					ty = this._buyin + "-"+ this._buyinT;
				}
			}else{
				ty += ", blind:" + this._blindbig;
			}

			return(ty);
		}

		public function get title() :String		{return(this._title);}
		public function get name() :String		{return(this._title);}
		public function get type() :String		{return(this._type);}
		public function get gametype() :String	{return(this._gametype);}
		public function get id() :Number			{return(this._id);}
		public function get ssid() :Number		{return(this._ssid);}
		public function get privacy() :Boolean	{return(this._privacy);}
		public function get minlevel() :Number	{return(this._minlevel);}
		public function get password() :String	{return(this._password);}
		public function get maxusers() :Number	{return(this._maxusr);}
		public function get maxspecs() :Number	{return(this._maxspc);}
		public function get blindbig() :Number	{return(this._blindbig);}
		public function get blindsmall() :Number	{return(this._blindsmall);}
		public function get timelimit() :Number	{return(this._timelimit);}
		public function get buyin() :Number		{return(this._buyin);}
		public function get buyinT() :Number	{return(this._buyinT);}
		public function get stat() :String		{return(this._stat);}
		public function get ownerid() :Number	{return(this._ownerid);}
	}
}