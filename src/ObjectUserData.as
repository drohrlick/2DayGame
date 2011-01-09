package 
{
	public class ObjectUserData
	{
		public function ObjectUserData( objectType:uint = 0, 
										objectState:uint = 0,
										objectEvent:uint = 0 ) 
		{
			type = objectType;
			state = objectState;
			event = objectEvent;
		}
		
		public var type:uint = GameLogic.Type_None;
		public var state:uint = GameLogic.State_None;
		
		// used
		public var event:uint = GameLogic.Event_None;	
		public var event_data1:Number = 0;
		public var event_data2:Number = 0;
	}
}