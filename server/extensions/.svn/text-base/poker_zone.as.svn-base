var sweepTimer = null;
var clockTimer = null;
var zone;
var nowtime;
var fakeRoomVars = [];

function clockTicking() {
	nowtime = getTimer();
}

function killGhostRooms() {
	var allRooms = zone.getRooms();
	for (var r in allRooms) {
		var roomeach = allRooms[r];
		if(!roomeach.isGame()){
			var lobbyId = roomeach.getId();
		}
	}
	for (var r in allRooms) {
		var roomeach = allRooms[r];
		if(roomeach.isGame())
		{
			if(roomeach.getUserCount() == 0)
			{
				if(roomeach.getSpectatorCount() > 0)
				{
					var users = roomeach.getAllUsers();
					for (var u in users) {
						var user = users[u];
						_server.sendModeratorMessage("Oda boşken izleyici kabul edilmiyor, bu yüzden lobiye çıkarıldınız.", user, _server.MOD_MESSAGE_TO_ZONE);
						_server.joinRoom(user, roomeach.getId(), true, lobbyId);
					}
				}
				_server.destroyRoom(zone, roomeach.getId());
			}
/*
			if(roomeach.getUserCount() == 1)
			{
				var users = roomeach.getAllUsers();

				for (var u in users) {
					var user = users[u];
					var lasttime = user.getLastMessageTime();

					if(roomeach.getId() != lobbyId)
					{
						if(nowtime-lasttime > 60000)
						{
							trace('putting inactive player to lobby');
							_server.sendModeratorMessage("Zaman aşımından oda kapatılıyor; odalarda işlem yapmadan bekleme süresi 1 dakikadır.", user, _server.MOD_MESSAGE_TO_ZONE);
							_server.joinRoom(user, roomeach.getId(), true, lobbyId);
						}
					}
				}
				_server.destroyRoom(zone, roomeach.getId());
			}
*/
		}
	}
}

function init() {
	zone = _server.getCurrentZone();
	nowtime = getTimer();
	sweepTimer = setInterval("killGhostRooms", 10000);
	clockTimer = setInterval("clockTicking", 1000);
}
function destroy() {
	clearInterval(clockTimer);
	clockTimer = null;
	clearInterval(sweepTimer);
	sweepTimer = null;
	zone = null;
}
function handleRequest(cmd, params, user, fromRoom, protocol)
{
	var zone = _server.getCurrentZone();
	room = zone.getRoom(fromRoom);
	roomid = fromRoom;
	var uid = user.getUserId();
	var allRooms = zone.getRooms();
	for (var r in allRooms) {
		var roomeach = allRooms[r];
		if(!roomeach.isGame()){
			var lobbyId = roomeach.getId();
		}
	}
	switch(cmd){
		case 'uLs':			// userlist
			_server.sendResponse(['uLr', String(getAllUsers())], roomid, null, [user], 'str');
			break;
		case 'uMs':			// userlist
			_server.sendResponse(['uMr', String(getRoomUsers(Number(roomid)))], roomid, null, [user], 'str');
			break;
		case 'kCk':			// kick a user
			_server.sendResponse(['kCd'], -1, null, [_server.getUserById(params.uid)], 'str');
//			_server.joinRoom(_server.getUserById(params.uid), fromRoom, true, lobbyId);
//			_server.kickUser(_server.getUserById(params.uid), 3, "moderatör tarafından atıldınız!");
			break;
		case 'sRv':			// set fake RoomVars
			fakeRoomVars[Number(params.roomid)] = String(params.password) +'|'+ String(params.buy_in) +'|'+ String(params.buy_inT) +'|'+ String(params.game_type) +'|'+ String(params.room_type) +'|'+ String(params.time_limit) +'|'+ String(params.blind_inc) +'|'+ String(params.min_level) +'|'+ String(params.blind_small) +'|'+ String(params.blind_big) +'|'+ String(params.muted);
			break;
		case 'gRv':			// get fake RoomVars
			_server.sendResponse(['sRr', fakeRoomVars[Number(params.roomid)]], -1, null, [user], 'str');
			break;
	}
}

function handleInternalEvent(e) {
// nothing here...
}


function getAllUsers() {
	var zone = _server.getCurrentZone();
	var allRooms = zone.getRooms();
	var allUsers = [];
	var roomUsers = [];
	var userPack = [];
	for (var r in allRooms) {
		var roomeach = allRooms[r];
		roomUsers = roomeach.getAllUsers();
		for (var u in roomUsers) {
			var user = roomUsers[u];
			var pass = roomeach.getVariable('password');
			var pw = (pass==null) ? "" : pass.getValue();
			userPack.push( user.getName() + ':' + roomeach.getId() + ":" + pw);
		}
	}
	var uset = userPack.join(';');
	return uset;
}
function getRoomUsers(rid) {
	var zone = _server.getCurrentZone();
	var roomeach = zone.getRoom(rid);
	var userPack = [];
	if((roomeach != null)&&(roomeach.isGame())){
		var roomUsers = roomeach.getAllUsers();
		for (var u in roomUsers) {
			var user = roomUsers[u];
			var level = user.getVariable('mlevel');
			var lvl = (level==null) ? "0" : level.getValue();
			userPack.push( user.getName() + ':' + lvl + ':' + user.getUserId() );
		}
	}
	var uset = userPack.join(';');
	return uset;
}
