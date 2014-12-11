package com.obsesif.models.data
{
	public class Slider
	{
		private var image_id :String;

		public function Slider () :void
		{
		}

		public function getId() :String
		{
			return image_id;
		}

		public function setImgId(imgid:String) :void
		{
			image_id = imgid;
		}
	}
}