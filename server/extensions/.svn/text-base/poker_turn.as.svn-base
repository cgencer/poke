var minPlayers = 2;
var db;
var zone;
var room;
var roomid;
var cmd;
var turnProgress = 0;
var shuffledDeck = [];
var cardTable = [];
var cardTurn;
var cardRiver;
var rotatingUsers = [];
var packets = [];
var usedPackets = [];
var tableAmount = 0;
var potsByTurn = [];
var lastToBidReq = -1;
var bidTimer = null;
var lastToCall = -1;
var totalBet = 0; //bir user'in en fazla bid ettigi ne kadar
var roundBet = 0; //o round icinde en cok raise edilen (toCall dahil degil)
var game = {
	blindBig: 0,
	blindSmall: 0,
	type: -1,  //0:nolimit 1:potlimit 2:limit
	timelimit: 30
	};

var lastActingUser = -1;

var blankDeck = new Array("2c", "2d", "2h", "2s", "3c", "3d", "3h", "3s", "4c", "4d", "4h", "4s", "5c", "5d", "5h", "5s", "6c", "6d", "6h", "6s", "7c", "7d", "7h", "7s", "8c", "8d", "8h", "8s", "9c", "9d", "9h", "9s", "Tc", "Td", "Th", "Ts", "Jc", "Jd", "Jh", "Js", "Qc", "Qd", "Qh", "Qs", "Kc", "Kd", "Kh", "Ks", "Ac", "Ad", "Ah", "As");
var newGameTimer = null;
var lastHandWinnerCount = 0;
var joinOrd = 0;
var actCounter = 0;
var movedVars = false;
var bidReqCounter = 0;

var logfile = "";

var owner = { sfid:0, dbid:0 };

var users = {
	data: [],

	set: function(sfid, props, freshen) {
		try{
		var tmp;
		if (freshen === true)
			tmp = {};
		else
		 	tmp = this.data[sfid] || {};

		for(var prp in props) {
			tmp[prp] = props[prp];
			}
		this.data[sfid] = tmp;
		}catch(e){trace('users.set: '+e);}
		},

	get: function(sfid, prop) {
		if (typeof this.data[sfid] != 'object') return(null);

		if (prop == undefined) return(this.data[sfid]);
		return(this.data[sfid][prop]);
		},

	setAll: function(props, _list) {
		var list;
		if (_list) list = _list;
				else list = this.data;

		for(var sfid in list) {
			for(var prp in props) {
				if (this.data[sfid]) this.data[sfid][prp] = props[prp];
				}
			}
		},

	getAllMatch: function(propList, _param1, _param2) {
		var from = this.data, assoced = true;
		if (typeof _param1 == 'boolean')
			assoced = _param1;
		else if (_param1)
			from = _param1;
		if (typeof _param2 == 'boolean')
			assoced = _param2; //assoced: Array.push ile mi yoksa sfid set ile mi
		else if (_param2)
			from = _param2;

		var filtered = [];
		for(var sfid in from) {
			var inc = true;
			for (var prop in propList) {
/*
				trace ("prop: "+prop+" should be "+propList[prop]);
				if (from[sfid][prop] === undefined)
					{
					trace ("undefined for "+sfid+"!!!");
					}
*/
				if (from[sfid][prop] != propList[prop]) {
					inc = false;
					break;
					}
				}
			if (inc === true)
				{
				if (assoced) filtered[sfid] = from[sfid];
							else filtered.push(from[sfid]);
				}
			}
		return(filtered);
		},

	getList: function(prop, _list) {
		var list;
		if (_list) list = _list;
				else list = this.data;
		var arr = [];
		for(var sfid in list) {
			if (prop == '')
				arr.push(sfid);
			else
				arr.push(list[sfid][prop]);
			}
		return(arr);
		},

	flatten: function(_list) {
		var list;
		if (_list) list = _list;
				else list = this.data;
		var newList = [];
		for(var i in list) {
			newList.push(list[i]);
			}
		return(newList);
		},

	unflatten: function(_list) {
		var list;
		if (_list) list = _list;
				else list = this.data;
		var newList = [];
		for(var i in list) {
			newList[list[i].sfid] = list[i];
			}
		return(newList);
		},

	debug: function(_str, _list, _member) {
		var list, str;
		if (typeof _str != 'string')
			{
			list = _str.slice();
			str = 'debug';
			}
		else
			{
			list = _list;
			str = _str;
			}
		trace(str+': '+users.getList(_member?_member:'', list).join(', '));
		},

	lastElement: undefined
	};

function calcRotatingUsers(reset, _startUid)
{
try{
var startUid, nonFolded;
if (_startUid==undefined)
	startUid = -1;
else
	startUid = _startUid;

var currentDealer = users.getAllMatch({'dealer':true}, false);
var useToBeLast = lastActingUser;
if (useToBeLast<0 && currentDealer.length==1) useToBeLast = currentDealer[0].sfid;

if (reset==true)
	{
	trace("resetting rotatingUsers:");
	nonFolded = users.getAllMatch({'inSeat':true, 'sitOut':false, 'folded':false, 'allIn':false, 'deleted':false}); //non-flat
users.debug('seated+nonFolded', nonFolded, 'sfid');

	var sorted = [];
	var sortComplete = false;

	if (useToBeLast>-1)
		{
		var tmp = users.getList('sfid');
		var sira = tmp.indexOf(useToBeLast); //tum userlar icinde dealer'in sirasi ne
		if (sira>-1 && sira < tmp.length) //bulduk mu, dealer'i en sona alalim bulduysak
			{
			for (var i=sira+1;i<tmp.length;i++)
				{
				var sfid = tmp[i];
				if (nonFolded[sfid]) sorted.push(nonFolded[sfid]);
				}
			for (var i=0;i<sira+1;i++)
				{
				var sfid = tmp[i];
				if (nonFolded[sfid]) sorted.push(nonFolded[sfid]);
				}

			sortComplete = true;
			}
		}

	rotatingUsers = users.getList('user', sortComplete?sorted:nonFolded);
	dumpRot("--");
	return;
	}

nonFolded = users.getAllMatch({'inSeat':true, 'sitOut':false, 'folded':false, 'allIn':false, 'deleted':false}); //non-flat
users.debug('seated+nonFolded', nonFolded, 'sfid');

var newRot = [];
for(var i in nonFolded)
	{
	if (!nonFolded[i]) continue;
	var u = nonFolded[i];
	var uid = u.sfid;

	if (u.totalBet < totalBet)
		{
		trace("user to newRot: "+uid);
		newRot[uid] = u;
		}
	}

if (startUid>-1) useToBeLast = startUid;
if (useToBeLast>-1)
	{
	var tmp = users.getList('sfid');

	var sira = tmp.indexOf(useToBeLast); //tum userlar icinde dealer'in sirasi ne
	if (sira>-1 && sira < tmp.length) //bulduk mu, dealer'i en sona alalim bulduysak
		{
		var sorted = [];
		for (var i=sira+1;i<tmp.length;i++)
			{
			var sfid = tmp[i];
			if (newRot[sfid]) sorted.push(newRot[sfid]);
			}
		for (var i=0;i<sira+1;i++)
			{
			var sfid = tmp[i];
			if (newRot[sfid]) sorted.push(newRot[sfid]);
			}

		newRot = sorted;
		}
	}

rotatingUsers = users.getList('user', newRot);
dumpRot("++");
}catch(e){trace("calcRotatingUsers: "+e);}
}

function timeToStr(sep)
{
	var currDate = new Date(getTimer());
	var tmpm = currDate.getMonth() + 1;
	if (tmpm<10) tmpm = "0"+tmpm;
	var tmpd = currDate.getDate();
	if (tmpd<10) tmpd = "0"+tmpd;
	var tmph = currDate.getHours();
	if (tmph<10) tmph = "0"+tmph;
	var tmpi = currDate.getMinutes();
	if (tmpi<10) tmpi = "0"+tmpi;
	var tmps = currDate.getSeconds();
	if (tmps<10) tmps = "0"+tmps;
	var tmp = "";
	if (sep)
		tmp = ""+currDate.getFullYear()+"-"+tmpm+"-"+tmpd+" "+tmph+":"+tmpi+":"+tmps;
	else
		tmp = ""+currDate.getFullYear()+""+tmpm+""+tmpd+"_"+tmph+""+tmpi+""+tmps;
	return(tmp);
}

function dateToStr(sep)
{
	var currDate = new Date(getTimer());
	var tmpm = currDate.getMonth() + 1;
	if (tmpm<10) tmpm = "0"+tmpm;
	var tmpd = currDate.getDate();
	if (tmpd<10) tmpd = "0"+tmpd;
	var tmp = "";
	if (sep)
		tmp = ""+currDate.getFullYear()+"-"+tmpm+"-"+tmpd;
	else
		tmp = ""+currDate.getFullYear()+""+tmpm+""+tmpd;
	return(tmp);
}

function init() {
	db = _server.getDatabaseManager();

	zone = _server.getCurrentZone();
//	zone.setPubMsgInternalEvent(true);

	trace('init done...');

	var tmp = timeToStr(false);
	var tmpco = 0;
	logfile = tmp+"_0.log";
	while(_server.fileExist(logfile))
		{
		tmpco++;
		logfile = tmp+"_"+tmpco+".log";
		}
	var tmp = dateToStr(true);
	_server.makeDir("logs/poker/"+tmp);
	logfile = tmp+"/"+logfile;
	trace("logfile is "+logfile);
}

function log(line)
{
if (logfile=="") trace("could not log: "+line);
else
	{
	trace(line);
	_server.writeFile("logs/poker/"+logfile, timeToStr(true)+"\t"+line+"\r\n", true);
	}
}

function destroy() {
	clearNewGameTimer();
	delete db;
	delete rotatingUsers;
	delete packets;
	delete shuffledDeck;
	delete cardTable;
	delete users.data;
	cardTurn = null;
	cardRiver = null;
	tableAmount = 0;
	delete potsByTurn;
}

function userSitOut(uid)
{
users.set(uid, {'sitOut':true});
if (turnProgress>0)
	{
	outPlayer(uid);
	if (gotPlayers() == true && lastToBidReq==uid) doBid();
	}
}

function handleUserTimeout(uid)
{
var tc = users.get(uid, 'timeoutCount');
tc++;
users.set(uid, {'timeoutCount':tc});
trace("timeoutCount for "+uid+" is "+tc);
if (tc>=2) // 2 timeout = stand
	{
	var u = users.get(uid, 'user');
	specPlayer(u);
	return(true);
	}
return(false);
}

function handleRequest(cmd, params, user, fromRoom, protocol)
{
try{
	if(!db){trace('!!! database trouble !!!');}
	trace('cmd is '+cmd+' user is '+user.getUserId());
	room = zone.getRoom(fromRoom);
	roomid = fromRoom;
	var o = {};
	var uid = user.getUserId();

	if (users.get(uid, 'inSeat')!==true && users.get(uid, 'sitOut')!==true && (cmd=='fLd' || cmd=="fLdt" || cmd=='bRs'))
		{
		trace('WARNING: cmd is '+cmd+' but player is spectating');
		return;
		}

	if (uid!=lastToBidReq && (cmd=='fLd' || cmd=='fLdt' || cmd=='bRs'))
		{
		trace("WARNING: unexpected "+cmd+" from user, expecting it from "+lastToBidReq);
		return;
		}

	if ((cmd=='fLd' || cmd=='fLdt' || cmd=='bRs') && params.id != (bidReqCounter-1))
		{
		trace("WARNING: unexpected "+cmd+" from user, id mismatch (got "+params.id+", but waiting for "+(bidReqCounter-1)+")");
		return;
		}

	if (cmd=='fLd' || cmd=='bRs')
		{
		users.set(uid, {'timeoutCount':0});
		}

	switch(cmd){

//----------------------------------------------------------------------
// FOLD eden user'lar
//----------------------------------------------------------------------
		case 'fLdt':
							handleUserTimeout(uid);
		case 'fLd':			// folded user
								clearBidTimer();
								users.set(uid, {'folded':true});
								pushUserList();
								if (turnProgress>0 && gotPlayers() == true) doBid();
								break;

		case 'sio':			// sit-out
								userSitOut(uid);
								pushUserList();
								break;

		case 'sii':			// sit-in
								users.set(uid, {'sitOut':false, 'folded':true, 'joinNext':true});
								pushUserList();
								checkStartGame();
								break;

		case 'tbr':			// table ready -- her zaman tbl ile bitmeli yoksa client muted kalacak
						trace("dumping used packets to #"+uid);
						if (turnProgress>0)
							{
							for(var i=0;i<usedPackets.length;i++)
								{
								trace("..."+usedPackets[i][0]);
								_server.sendResponse(usedPackets[i], roomid, null, [user], 'str');
								}
							}
						trace("...tBl");
						_server.sendResponse(['tBl', String(tableAmount)], roomid, null, [user], 'str');
						trace("done!");
						break;

//----------------------------------------------------------------------
// içkilerin ücretinin user cash'den düşülmesi ve
// csH ile her oyuncunun cash miktarının güncellenmesi
//----------------------------------------------------------------------
		case 'dPt':			// deduct drink price
								var prc = Number(params.price);
								if (prc>0) prc = prc * -1;
								setCash(user, prc);
								break;

//----------------------------------------------------------------------
// seats setinin roomVar olarak hazırlanması
// uSx_[sirano++] = smartfoxid:profileid:index
//----------------------------------------------------------------------
		case 'sMs':
			pushUserList();
								break;

//----------------------------------------------------------------------
// masaya ilk oturan kişi, masanın sahibi konumunda ve 0 index'lidir.
// bu yüzden onun için uSx_0 roomVar kullanılır
//----------------------------------------------------------------------
		case 'fUs':			// exception: first user is the owner
								users.set(uid, {'dbid':params.who});
								
								if (owner.sfid == uid && owner.dbid < 1) {
									owner.dbid = parseInt(params.who);
									_server.setRoomVariables(room, null, [{name:'owner_dbid', val:owner.dbid}]);
									}

								// first set only contains the room-owner
								pushUserList();
								break;

//----------------------------------------------------------------------
// oyun başladıktan sonra masaya join etmek isteyenler waitingPlayers[]
// içinde tutulur
//----------------------------------------------------------------------
/*
		case 'rNp':			// request new waiting players
								// waiting players list (uid) will be sent to all users seated
								_server.sendResponse(['nWp', waitingPlayers.join(',')], roomid, null, seatPlayers, 'str');
								break;
*/
//----------------------------------------------------------------------
// masadaki oyuncuların profileid'leri
//----------------------------------------------------------------------
		case 'jdR':			// save players userId (DB) to an array
								users.set(uid, {'dbid':params.who});
								pushUserList();
								break;

		case 'uCn':			// userCount
								_server.sendResponse(['uCb', String(zone.getUserCount())], roomid, null, [user], 'str');
								break;

//----------------------------------------------------------------------
// masaya para koy,
//----------------------------------------------------------------------
		case 'cTT':			//cashToTable
								setCash(user, 0, params.amount);
								break;

//----------------------------------------------------------------------
// RAISE edildiğinde cash hesaplamalarını yap, nCs_nn ile üye parasını,
// tBl ile masa parasını güncelle, csH ile herkesin parasını güncelle
// raise döngüsü, raise eden kişiden sonraki kişiden raise eden kişiye
// kadar oyuncuları kapsar ve her raise edilişinde bu sıralı yeniden
// hesaplanır.
//----------------------------------------------------------------------
		case 'bRs':			// bidRaised
								betUser(user, params.amount, params.type);

//----------------------------------------------------------------------
// turn'u oluşturan temel döngü, ilk önce ilk oyuncuya doB komutu gönderilir,
// yanıt vermesi beklenir, sonra gelen yanıt (dBd) değerlendirilir,
// rotatingUsers[]'daki sonraki user'a doB iletilir.
// foldedUsers dikkate alınır, cAu komutu da packets içeriğindeki
// oyun aşamaları paketlerini oyunculara iletir.
// packets[] ya da rotatingUsers[] bittiğinde turn bitmiş olur, shw
// o aşamada devreye girer ve oyunculara iletilmeden masadaki parayla
// güncellenir
//----------------------------------------------------------------------
		case 'dBd':			// doBid
			doBid();
			break;
	}
}catch(e){trace('HANDLEREQUEST: '+e);}
}

function dumpRot(prefix)
{
var tmp = [];
for(var su=0; su<rotatingUsers.length; su++)
	{
	tmp.push(rotatingUsers[su].getUserId());
	}
trace(prefix+" rotatingUsers: "+tmp.join(","));
}

function doPackets(bidreq)
{
if(packets.length>0)
	{
	var p = packets.shift();
	// inject actual data
	usedPackets.push(p);
	if(p[0] == 'shw')
		{
		roundComplete();
		p.push( tableAmount );
		_server.sendResponse(p, roomid, null, room.getAllUsers(), 'str');
		winnerCash();
		users.setAll({'folded':false});
		turnStatus(0);
		checkStartGame();
		return;
		}

	_server.sendResponse(p, roomid, null, room.getAllUsers(), 'str');
	lastActingUser = -1;
	roundComplete();

	if (bidreq)
		{
		calcRotatingUsers(true);

		dumpRot("doPackets");

		if (rotatingUsers.length==0)
			{
			doBid();
			return;
			}

		if(packets.length>0)
			{
			bidRequest();
			}
		}
	}
}
function doBid()
{
dumpRot("doBid");

if(rotatingUsers.length == 0)
	{
	var pul = false;
	var nonFolded = users.getAllMatch({'inSeat':true, 'sitOut':false, 'folded':false, 'allIn':false, 'deleted':false}, false); //flat
		for(var i=0;i<nonFolded.length;i++)
			{
			if (nonFolded[i].cash<1)
				{
				users.set(nonFolded[i].sfid, {'allIn':true});
				pul = true;
				}
			}
	if (pul) pushUserList();
	nonFolded = users.getAllMatch({'inSeat':true, 'sitOut':false, 'folded':false, 'allIn':false, 'deleted':false}, false); //flat
	if (nonFolded.length < 2) //oyundaki user sayisi
		{
		while(packets.length>0) doPackets(false);
		return;
		}

	doPackets(true);
	return;
	}else{
dumpRot("doBid3");
	if  (packets.length>0)
		{
		bidRequest();
		}
	}
}

function clearNewGameTimer()
{
//trace("clear newgametimer! "+newGameTimer);
try
	{
	if (newGameTimer!=null) clearInterval(newGameTimer);
	newGameTimer=null;
	}
catch(e)
	{
	trace("clearNewGameTimer exception: "+e);
	}
}

function roundComplete()
{
var pot;
if (potsByTurn.length>0)
	{
	var prevPot = potsByTurn[potsByTurn.length - 1];
	pot = {'value':tableAmount - prevPot.table, 'table':tableAmount};
	}
else
	{
	pot = {'value':tableAmount, 'table':tableAmount};
	}
trace("pot #"+potsByTurn.length+" is "+pot.value+" (table is "+pot.table+")");
trace("totalbet per user is "+totalBet);
potsByTurn.push(pot);
users.setAll({'turnBet':0});
roundBet = 0;
actCounter = 0;
}

function turnStatus(st)
{
try{
clearNewGameTimer();
clearBidTimer();
turnProgress = st;
lastToBidReq = -1;
lastToCall = 0;
actCounter = 0;

if (turnProgress == 1)
	{
	tableAmount = 0;
	potsByTurn = [];
	lastActingUser = -1;
	totalBet = 0;
	}
else
	{
	users.setAll({'joinNext':false});
	}

_server.setRoomVariables(room, null, [{name:'turnProgress', val:st}, {name:'turnAt', val:0}]);

}catch(e){trace("Exception in turnStatus: "+e);}
}

function pushUserList()
{
try{
var rVars = [];
var ic = 0;

function sortByJO(a,b)
{
//asc
if (a.joinOrd < b.joinOrd) return(-1);
else if (a.joinOrd > b.joinOrd) return(1);
return(0);
}

var ulist = users.getAllMatch({'inSeat':true, 'deleted':false}, true);
ulist.sort(sortByJO);

for(var i=0;i<ulist.length;i++)
	{
	if (!ulist[i]) continue;
	var uid = ulist[i].sfid;
	var flg = 0;
/*
flags:
1: folded
2: sitting out
4: will join next turn
8: allin
*/
		if (ulist[i].folded==true) flg+=1;
		if (ulist[i].sitOut==true) flg+=2;
		if (ulist[i].joinNext==true) flg+=4;
		if (ulist[i].allIn==true) flg+=8;

		var k = String(uid) + ":" + String(ulist[i].dbid) + ":1:" + flg + ":" + String(ulist[i].joinOrd);
		rVars.push({name:'uSx_'+ic, val:k});
		ic++;
	}

for(var i=ic;i<10;i++)
	{
	rVars.push({name:'uSx_'+i, val:undefined});
	}

_server.setRoomVariables(room, null, rVars);
}catch(e){trace("pushUserList exception:"+e);}
}

function rounder(v)
{
return(Math.floor(v/5)*5);
}

function setCash(user, cashDiff, cashAbs)
{
if (user!=null)
	{
	var uid = user.getUserId();

	if (cashAbs>0)
		{
		var rcash = rounder(cashAbs);
		if (rcash!=cashAbs)
			{
			trace("CASH: "+uid+"'s cash rounded to "+rcash+" (was "+cashAbs+") (2)");
			}
		users.set(uid, {'cash':rcash});
		}
	else
		{
		var cash = 0;
		try{
			cash = parseInt(users.get(uid, 'cash'));
		}catch(e){}
		try{
			cash += parseInt(cashDiff);
		}catch(e){}
		var rcash = rounder(cash);
		if (rcash!=cash)
			{
			trace("CASH: "+uid+"'s cash rounded to "+rcash+" (was "+cash+")");
			}
		users.set(uid, {'cash':rcash});
		}
/*
	var cash = users.get(uid, 'cash');
	var paket = ['nCs_'+uid, String(cash)];
	_server.sendResponse(paket, roomid, null, [user], 'str');
*/
	}

var rVars = [];
for(var uid in users.data) {
	if (users.data[uid].inSeat!==true) continue;
		var cs = users.data[uid].cash;
		if (isNaN(cs)) cs=0;
		rVars.push(String(users.data[uid].dbid) + ':' + String(cs));
	}

_server.setRoomVariables(room, null, [{name:'csH', val: rVars.join(';')}]);
return(true);
}

function outPlayer(uid)
{
for(var su=0; su<rotatingUsers.length; su++)
	{
	if (rotatingUsers[su].getUserId() == uid)
		{
		rotatingUsers.splice(su, 1);
		break;
		}
	}
updatePC();
}

function setupRoomVars() {
if (game.type>-1) return;
/*
try
	{
	log("---------------");
	var tmpx = [];
	tmpx.push(0);
	tmpx.push(1);
	
	for(var idx in tmpx) //engine test
		{
//		if (!tmpx[idx])) continue;
//		if (isNaN(tmpx[idx])) continue;
		if (tmpx[idx]==undefined) continue;
		log("tmpx idx is "+idx+" val="+tmpx[idx]);
		}
	log("---------------");
	}
catch(e)
	{
	trace("debugRoomVars exception: "+e);
	}
/* */
try
	{
	log("Room: "+room.getName());

	moveRoomVariables();

	var bb = parseInt(room.getVariable('blind_big').value);
	var bs = parseInt(room.getVariable('blind_small').value);
	var tmp = room.getVariable('game_type').value;
	var tl = parseInt(room.getVariable('time_limit').value);

	game.blindBig = bb;
	game.blindSmall = bs;
	game.timelimit = tl;

	log("Game: "+tmp);
	log("Blinds: "+bs+"/"+bb);

	if (tmp=="Pot") game.type=1;
	else if (tmp=="Limit") game.type=2;
	else game.type=0;
	}
catch(e)
	{
	trace("getRoomVars exception: "+e);
	}
}


function specPlayer(u)
{
var uid = u.getUserId();
trace("specPlayer: "+uid);

users.set(uid, {'inSeat':false, 'sitOut':false, 'folded':true});
pushUserList();

updatePC();
_server.switchPlayer(u, roomid);

if (turnProgress>0)
	{
	outPlayer(uid);
//	if (gotPlayers() == true && lastToBidReq==uid) doBid();
	}
}

function moveRoomVariables()
{
if (movedVars)
	{
	trace("already moved vars, skipping");
	return;
	}

trace("moving room variables");

try{
var rVars = room.getVariables();

var rvd = [];
var rva = [];

var u = null;

for (var i = rVars.entrySet().iterator(); i.hasNext();)
	{
	var rVar = i.next();
	var vName = rVar.getKey();
	var v = rVar.getValue();
	var vVal = v.getValue();
//	var vo = v.getOwner(); //returns User

	var isint = false;
	try
		{
		var tmp = parseInt(vVal); // typeof vVal == object
		if (!isNaN(tmp)) isint = true;
		}
	catch(e) {}

//	trace(vName + " = " + vVal);
//	rvd.push({name:vName, val:undefined});

	if (isint)
		vVal = Number(vVal);
	else
		vVal = String(vVal);

	rva.push({name:vName, val:vVal});
	}

//trace("rvlen is "+rva.length);
//_server.setRoomVariables(room, null, rvd, true, false);
_server.setRoomVariables(room, null, rva, true, false);

trace("...moved");

}catch(e){trace("moveRoomVariables exception: "+e);}

}

//----------------------------------------------------------------------
// userjoin, leave, exit gibi durumlar burada işlenir
//----------------------------------------------------------------------
function handleInternalEvent(e) {
	var u = e.user;
	var r = _server.getCurrentRoom();

	var uid = e.user.getUserId();

	room = r;
	roomid = r.getId();

	if (e.name == "userJoin")
		{
		setupRoomVars();

//		trace('userJoin ('+uid+')');
		log("User joined: "+u.getName()+" (sfid#"+uid+")");

		var tb = users.get(uid, 'totalBet');
		var jo = users.get(uid, 'joinOrd');

		users.set(uid, {'user':u, 'sfid':uid, 'cash':0, 'deleted':false, 'folded':true, 'sitOut':false, 'inSeat':false, 'allIn':false, /*'totalBet':0,*/ 'cashDeducted':false, 'allInTurn':-1, 'joinNext':false, 'timeoutCount':0}, true);
		if (tb==null || isNaN(tb) || tb<1) tb=0;
		users.set(uid, {'totalBet':tb}); //totalbet varsa resetleme (kaybedip cikip giren adamlarda payout calc patlamasin diye)

		if (jo==null || isNaN(jo) || jo<0)
			{
			jo = joinOrd;
			joinOrd++;
			}
		users.set(uid, {'joinOrd':jo});
		var roomOwner = parseInt(room.getVariable('owner_id').value);
		_server.sendResponse(['jor', jo, roomOwner], roomid, null, [u], 'str');

		if (u.getPlayerIndex() != -1) //spec kontrolu, ama firstUser owner oldugu icin 0 ile basliyor
			{
			users.set(uid, {'sitOut':false, 'inSeat':true});
			pushUserList();

			var players = users.getAllMatch({'inSeat':true, 'sitOut':false, 'deleted':false}, false);

			if (players.length==1)
				{
				if (owner.sfid < 1) owner.sfid = uid;
				_server.sendResponse(['fUi'], roomid, null, [u], 'str');
				}
			else
				{
				_server.sendResponse(['jPt'], roomid, null, room.getAllUsers(), 'str');
				}

			checkStartGame(false);
			updatePC();
			}
/*
		else
			{
			var players = users.getAllMatch({'inSeat':true, 'sitOut':false, 'deleted':false}, false);
			if (players.length==0)
				{
				_server.switchSpectator(u, roomid);
				}
			}
*/
	}else if ((e.name == "userExit") || (e.name == "userLost") || (e.name == "logOut")){

//		log("User left: "+u.getName());
		trace("User: " + u.getName() + " left the room ("+uid+")");

/*
//adam girislerinde eger o sfid'nin totalbet varsa resetlememek daha iyi bir cozum.
//not: zaten adam lobiye cikinca once spec oluyor o calisiyor, sonra o sebeple gotplayers/winnercash, en son bu evente geliyor.
			var ue = users.get(uid);
			if (ue.totalBet>0 && ue.cashDeducted!=true)
				{
				cimdikUpdate(ue.dbid, ue.totalBet*-1);
				users.set(uid, {'cashDeducted':true});
				}
*/
			users.set(uid, {'inSeat':false, 'sitOut':false, 'folded':true, 'deleted':true});

			if (turnProgress>0)
				{
				dumpRot("exit:");
				outPlayer(uid);
				dumpRot("exit Result:");
				if (gotPlayers() == true && lastToBidReq==uid) doBid();
				}

			pushUserList();
			updatePC();
	}else if (e.name == "spectatorSwitched"){

//			trace('user > player ('+uid+')');

/*
			r = u.getRoomsConnected();
			r = r[0];
*/

			if (turnProgress==0)
			{
				log("Spectator to player: "+u.getName()+" (sitting)");

				users.set(uid, {'inSeat':true, 'sitOut':false, 'joinNext':false, 'timeoutCount':0});
				pushUserList();

				_server.sendResponse(['jPt'], roomid, null, room.getAllUsers(), 'str');
				checkStartGame(false);
			}
			else
			{
				log("Spectator to player: "+u.getName()+" (queued to sit)");

				trace('did not switch user '+uid+' to player');
				users.set(uid, {'inSeat':true, 'sitOut':false, 'folded':true, 'joinNext':true, 'timeoutCount':0});
				pushUserList();
			}

		updatePC();
	}else if (e.name == "playerSwitched"){

//			trace('player > spectator ('+uid+')');

			log("Player to spectator: "+u.getName());

			r = u.getRoomsConnected();
			r = r[0];

			users.set(uid, {'inSeat':false, 'sitOut':false, 'folded':true});
			pushUserList();

			if (turnProgress>0)
				{
				outPlayer(uid);
				if (gotPlayers() == true && lastToBidReq==uid) doBid();
				}
			updatePC();
	}
}

function updatePC()
{
var players = users.getAllMatch({'inSeat':true, 'deleted':false}, false);
var rv = [];
rv.push({name:'pc', val:players.length});
if (players.length==0)
	{
	users.setAll({'dealer':false});
	rv.push({name:'dealer', val:0});
	}
_server.setRoomVariables(room, null, rv);
}

function bidRequest(_debugstr)
{
try
{
clearBidTimer();
var debugstr = "";
if (_debugstr && _debugstr!="") debugstr=" ("+_debugstr+")";

var tempu = rotatingUsers.shift();
lastToBidReq = tempu.getUserId();

trace("bidreq to "+lastToBidReq+debugstr);

var turnBet = users.get(lastToBidReq, 'turnBet');
var uTotBet = users.get(lastToBidReq, 'totalBet');
trace("users turnbet is "+turnBet+" totalbet is "+uTotBet);
var toCall = totalBet - uTotBet;
if (toCall < 0) toCall = 0;

var uCash = users.get(lastToBidReq, 'cash');
var maxBet = 0;

var nonFolded = users.getAllMatch({'inSeat':true, 'sitOut':false, 'folded':false, 'allIn':false, 'deleted':false, 'joinNext':false}, false); //flat
for(var i=0;i<nonFolded.length;i++)
	{
	if (!nonFolded[i] || !nonFolded[i].totalBet || !nonFolded[i].cash) continue; //skip invalid
	if (nonFolded[i].sfid == lastToBidReq) continue; //skip self

	var xToCall = totalBet - nonFolded[i].totalBet;
	var xCash = nonFolded[i].cash - xToCall;
	if (isNaN(xCash) || xCash<1) continue;

	if (xCash > maxBet)
		{
		trace("valid: "+xCash);
		maxBet = xCash;
		}
	}
maxBet += toCall;
if (maxBet > uCash) maxBet = uCash;

/*
var openingBet = false;
if (turnBet==0 && toCall==0)
	{
	openingBet = true;
	}
*/

trace(toCall+" to call");
lastToCall = toCall;

lastActingUser = lastToBidReq;
/*
if (roundBet == 0) roundBet = game.blindBig;
var minRaise = roundBet;
*/
var minRaise = game.blindBig; //istek uzerine hayali kural, dogrusu yukarida
var maxRaise = 0;

if (game.type==1)
	{
	minRaise=game.blindBig;
	maxRaise=tableAmount - toCall; //according to wikipedia
	if (maxRaise < minRaise) maxRaise=minRaise;
	}
else if (game.type==2)
	{
	minRaise=game.blindBig;
	maxRaise=game.blindBig;
	if (packets.length>0 && (packets[0][0]=='rvr' || packets[0][0]=='shw')) //sirada rvr ya da shw varsa
		{
		maxRaise=game.blindBig*2;
		}
	}

_server.sendResponse(['doB', toCall, minRaise, /*openingBet?1:0*/0, maxRaise, maxBet, actCounter==0?1:0, String(bidReqCounter)], roomid, null, [tempu], 'str');
_server.setRoomVariables(room, null, [{name:'turnAt', val:tempu.getUserId()}]);

bidTimer = setInterval("bidTimeout", (game.timelimit+5)*1000, {uid:lastToBidReq, user:tempu, counterAt:bidReqCounter}); //timelimitten 5 saniye fazla sure
actCounter++;
bidReqCounter++;

}catch(e){trace("bidRequest exception: "+e);}
}

function clearBidTimer()
{
try{
if (bidTimer)
	{
	clearInterval(bidTimer);
	bidTimer=null;
	}
}catch(e){trace("clearBidTimer exception: "+e);}
}

function bidTimeout(params) {
clearBidTimer();
trace("bid timeout for "+params.uid);
if (params.uid!=lastToBidReq)
	{
	trace("ERROR invalid timeout, skipping");
	return;
	}
_server.sendResponse(['bto', String(params.counterAt)], roomid, null, [params.user], 'str');
handleUserTimeout(params.uid);
users.set(params.uid, {'folded':true});
pushUserList();
if (gotPlayers() == true) doBid();
}

function startGame() {
	clearNewGameTimer();
	if (turnProgress>0)
		{
		trace("startGame error: game already active");
		return(false);
		}

	var players = users.getAllMatch({'inSeat':true, 'sitOut':false, 'deleted':false, 'joinNext':false}, false);
	if (players.length < minPlayers)
		{
//player sayisi yetmiyorsa bir de joinNext'ler haric bak
		var players2 = users.getAllMatch({'inSeat':true, 'sitOut':false, 'deleted':false}, false);
		if (players2.length < minPlayers)
			{
			trace("can't start game, not enough players");
			return(false);
			}
		users.setAll({'joinNext':false});
		players = players2;
		}

	var pul = false;
	for(var i in players)
		{
		if (players[i].cash<game.blindBig)
			{
			trace("force user "+players[i].sfid+" to sit out");
			userSitOut(players[i].sfid);
			_server.sendResponse(['sio', 'cash'], roomid, null, [players[i].user], 'str');
			pul = true; //pushuserlist next
			}
		}

	players = users.getAllMatch({'inSeat':true, 'sitOut':false, 'deleted':false, 'joinNext':false}, false);
	if (players.length < minPlayers)
		{
		if (pul) pushUserList();
		trace("can't start game, not enough players (2)");
		return(false);
		}

//	trace('game started...');
	log("Game started");
try{
	users.setAll({'folded':false, 'allIn':false, 'totalBet':0, 'turnBet':0, 'cashDeducted':false, 'allInTurn':-1});

	var tmpplayers = users.getAllMatch({'joinNext':true});
	users.setAll({'folded':true}, tmpplayers);
	pushUserList();

	var currentDealer = users.getAllMatch({'dealer':true}, false);
	users.setAll({'dealer':false});
	var newDealer = false;

	if (currentDealer.length==1)
		{
		var tmp = users.getList('sfid');
//		trace('curdealer sfid is '+currentDealer[0].sfid);
		var sira = tmp.indexOf(currentDealer[0].sfid); //tum userlar icinde dealer'in sirasi ne
		if (sira>-1 && sira < tmp.length) //en sonda degilse
			{
			var playersAssoc = users.getAllMatch({'inSeat':true, 'sitOut':false, 'deleted':false});
			for (var i=sira+1;i<tmp.length;i++)
				{
				var sfid = tmp[i];
				if (playersAssoc[sfid])
					{
					newDealer = playersAssoc[sfid];
					break;
					}
				}
			}
		}
	if (newDealer===false) newDealer = players[0]; //bastan ilk playeri dealer yap

	 users.set(newDealer.sfid, {'dealer':true});
	_server.setRoomVariables(room, null, [{name:'dealer', val:newDealer.sfid}]);
	trace("dealer is "+newDealer.sfid+" (dbid is "+newDealer.dbid+")");

//2 player varken dealer small blind oder, oteki big blind.
//preflop sira bigblind'in solundan baslar
//dealer her zaman son act eden (2 player varken preflop sonrasi icin sadece, preflopta ilk act eden)
//2 player kalmissa "The big blind always continues moving, and then the button is positioned accordingly."

	turnStatus(1);
	roundComplete();
	calcRotatingUsers(true);
dumpRot("gamestart:");

	shuffledDeck = blankDeck.slice();
	shuffledDeck = shuffle(shuffledDeck);
	shuffledDeck.shift();

	var h = [];
	for(var i=0; i<rotatingUsers.length; i++){
		cardA = shuffledDeck.shift();
		cardB = shuffledDeck.shift();
		paket = {};
		paket['pck_'+rotatingUsers[i].getUserId()] = cardA+";"+cardB;
		_server.setUserVariables(rotatingUsers[i], paket);
		h[rotatingUsers[i].getUserId()] = [cardA, cardB];
//		trace("cards for "+rotatingUsers[i].getUserId()+" is "+blankDeck.indexOf(String(cardA))+" ("+cardA+"),"+blankDeck.indexOf(String(cardB))+"("+cardB+")");
		log("User cards for # "+rotatingUsers[i].getUserId()+": "+cardA+" "+cardB);
	}
	_server.sendResponse(['gst'], roomid, null, room.getAllUsers(), 'str');

	shuffledDeck.shift();
	cardTable[0] = shuffledDeck.shift();
	cardTable[1] = shuffledDeck.shift();
	cardTable[2] = shuffledDeck.shift();
	shuffledDeck.shift();
	cardTurn = shuffledDeck.shift();
	shuffledDeck.shift();
	cardRiver = shuffledDeck.shift();

	log("Table cards: "+cardTable[0]+" "+cardTable[1]+" "+cardTable[2]+" "+cardTurn+" "+cardRiver);

/*
	if (room.getName()=="kurbi")
		{
		cardTable = ["2h", "2c", "2d"];
		cardTurn = "Kh";
		cardRiver = "Kc";
		}
	else if (room.getName()=="gogol")
		{
		cardTable = ["Ah", "Kh", "Qh"];
		cardTurn = "Jh";
		cardRiver = "Th";
		}
//dikkat: oyunculara da bu kartlardan gelirse score'lar patliyor, bu kod test kodu oldugu icin bug degil, pesinden kosmaya luzum yok
*/

	var s = [];
	for(var i=0; i<rotatingUsers.length; i++){
		var ui = rotatingUsers[i].getUserId();
		var deckScore = calc( h[ui].concat(cardTable, [cardTurn, cardRiver]) );
//		trace("deckScore for #"+users.get(ui, 'dbid') + ' is ' + deckScore);
		log("Deck score for # "+ui+" is "+deckScore);
		s[i] = String(users.get(ui, 'dbid')) + ':' + deckScore;
		users.set(ui, {"deckScore":deckScore, "pocketCards":h[ui]});
	}

//	trace("blinds: "+game.blindBig+"/"+game.blindSmall);

	var bsmallu, bbigu;
	if (rotatingUsers.length == 2)
		{
		bsmallu = rotatingUsers[1]; // == dealer
		bbigu = rotatingUsers[0];

// preflop - dealer is the first to act
		var tmp = rotatingUsers.shift();
		rotatingUsers.push(tmp); //bb koyan act etsin
		}
	else
		{
		bsmallu = rotatingUsers.shift();
		bbigu = rotatingUsers.shift();
		rotatingUsers.push(bsmallu);
		rotatingUsers.push(bbigu); //bb koyan act etsin
		}

	betUser(bsmallu, game.blindSmall, 'blind_small');
	betUser(bbigu, game.blindBig, 'blind_big');

	usedPackets = [];
	usedPackets.push(['gst']);
	var pk;

	pk = ['bls', game.blindSmall, bsmallu.getUserId()];
	_server.sendResponse(pk, roomid, null, room.getAllUsers(), 'str');
	usedPackets.push(pk);

	pk = ['blb', game.blindBig, bbigu.getUserId()];
	_server.sendResponse(pk, roomid, null, room.getAllUsers(), 'str');
	usedPackets.push(pk);

	packets =	[	[	'flp', cardTable.join(';') ],
						[	'trn', cardTurn ],
						[	'rvr', cardRiver ],
						[	'shw', s.join(';') ]
					];

	bidRequest('startGame');
//								_server.sendResponse(['iBd', tempu.getUserId()], roomid, null, seatPlayers, 'str');
}catch(e){trace("Exception in startGame: "+e);}
}

function winnerCash(_revealHands)
{
try{
var revealHands = true;
if (_revealHands === false) revealHands = false;

var wc = 0;
var ws = 0;
var w = "";
/*
var check = 0;
for(var idx in potsByTurn)
	{
	if (!potsByTurn[idx]) continue;
//	trace("pot #"+idx+" was $"+potsByTurn[idx].value);
	check += potsByTurn[idx].value;
	}
if (check!=tableAmount)
	{
	trace("ERROR! total pot $"+check+", tableamount $"+tableAmount+", diff: "+(tableAmount-check));
	}
*/

var userhands = users.getAllMatch({'folded':false, 'inSeat':true, 'sitOut':false, 'deleted':false}, true);

function sortByHand(a,b)
{
//reverse sort, better hands on top
if (a.deckScore < b.deckScore) return(1);
else if (a.deckScore > b.deckScore) return(-1);

//in case of a tie, all-ins on top
if (a.allIn && !b.allIn) return(-1);
else if (!a.allIn && b.allIn) return(1);

return(0);
}

userhands.sort(sortByHand);

var userbets = [];
var handlist = [];
var moneyTrail = [];

for(var idx in users.data)
	{
	if (!users.data[idx]) continue;

	var uid = users.data[idx].sfid;

	userbets[uid] = Number(users.data[idx].totalBet);

	trace("totalBet for #"+uid+" is "+userbets[uid]);

	if (isNaN(userbets[uid]))
		{
		trace("WARNING: totalBet for user "+uid+" was NaN");
		userbets[uid] = 0;
		}
	moneyTrail[uid] = {dbid:users.data[idx].dbid, amount:0};
	}

for(var idx in userhands)
	{
	if (!userhands[idx]) continue;
	var deckScore = Number(userhands[idx].deckScore);
	var uid = userhands[idx].sfid;
	trace(idx+": uid="+uid+" (dbid "+userhands[idx].dbid+"), deckScore="+deckScore);

	if (!handlist[deckScore]) handlist[deckScore] = [];
	handlist[deckScore].push(uid);
	}

var handSorter = [];
for(var hand in handlist)
	{
	if (!handlist[hand]) continue;
	handSorter.push(Number(hand));
	}
handSorter.sort(function(a,b){ if(a<b)return(1); else if(a>b) return(-1); return(0); });//numeric descending

var winners = [];

//for(var hand in handlist) //iterate all hands best to worst
for(var handidx in handSorter)
	{
	if (!handSorter[handidx]) continue;
	hand = handSorter[handidx];
	if (!handlist[hand]) continue;
	var handPlayers = handlist[hand];
	var splitNum = handPlayers.length; //how many ways to split the bet
//	trace("hand "+hand+", players "+handPlayers.join(", ")+" ("+splitNum+" way split)");
	log("hand "+hand+", players "+handPlayers.join(", ")+" ("+splitNum+" way split)");

	var takeDeduct = [];

	for(var idx in handPlayers) //players having this hand
		{
		if (handPlayers[idx]==undefined) continue;
		var uid = handPlayers[idx];
		var bet = userbets[uid];

		var payout = 0;

		for(var victim in userbets) //all betting users on table
			{
			if (!userbets[victim]) continue;
			var take = userbets[victim]; //uid's take from victim
			if (take<1) continue;
			if (bet<take) take = bet;
			take = take / splitNum;
			log("["+uid+"] take from user #"+victim+" is "+take);
//			trace("["+uid+"] take from user #"+victim+" is "+take);
//			userbets[victim] -= take;
			if (isNaN(takeDeduct[victim])) takeDeduct[victim]=0;
			takeDeduct[victim] += take;
			payout += take;
			if (users.get(victim, 'cashDeducted')!=true) moneyTrail[victim].amount -= take;
			}

		if (payout>0)
			{
			payout = rounder(payout);
//			trace("["+uid+"] total payout of "+payout);
			log("["+uid+"] total payout of "+payout);
			setCash(_server.getUserById(uid), payout);
			moneyTrail[uid].amount += payout;
			tableAmount -= payout;

			var pock = users.get(uid, 'pocketCards').join(',');
//			trace("users pock is "+pock);
			var rp = calcRealPayout(payout);
			if (revealHands)
				winners.push(String(uid+':'+rp+':'+hand+':'+pock));
			else
				winners.push(String(uid+':'+rp+':-1:')); //don't send users hand score or pockets
			}
		if (tableAmount<1) break;
		}
	if (tableAmount<1) break;

	for(var victim in takeDeduct)
		{
		if (!takeDeduct[victim]) continue;

		userbets[victim] -= takeDeduct[victim];
		}

	}


if (tableAmount>0)
	{
// gorulmemis (call edilmemis) paralar (son adam arttirip oyundan cikti, vs) ortada kaliyor
// sebebi de herkesin digerlerinden anca bet ettigi kadar kazanabilmesi.
// kalan paralari burada dagitiyoruz (ilk adam aliyor tabi hepsini, berabere kalma varsa berabere kalanlar paylasiyor)

//	trace("WARNING, MONEY LEFT ON TABLE: "+tableAmount+" calculating leftovers");
	log("MONEY LEFT ON TABLE: "+tableAmount+" calculating leftovers");

	for(var handidx in handSorter)
		{
		if (!handSorter[handidx]) continue;
		hand = handSorter[handidx];
		if (!handlist[hand]) continue;
		var handPlayers = handlist[hand];
		var splitNum = handPlayers.length; //how many ways to split the bet
//		trace("hand "+hand+", players "+handPlayers.join(", ")+" ("+splitNum+" way split)");
		log("hand "+hand+", players "+handPlayers.join(", ")+" ("+splitNum+" way split)");

		var takeDeduct = [];

		for(var idx in handPlayers) //players having this hand
			{
			if (handPlayers[idx]==undefined) continue;
			var uid = handPlayers[idx];
			var bet = userbets[uid];

			var payout = 0;

			for(var victim in userbets) //all betting users on table
				{
				if (!userbets[victim]) continue;
				var take = userbets[victim]; //uid's take from victim
				if (take<1) continue;
				take = take / splitNum;
//				trace("["+uid+"] 2nd take from user #"+victim+" is "+take);
				log("["+uid+"] 2nd take from user #"+victim+" is "+take);
				if (isNaN(takeDeduct[victim])) takeDeduct[victim]=0;
				takeDeduct[victim] += take;
				payout += take;
				if (users.get(victim, 'cashDeducted')!=true) moneyTrail[victim].amount -= take;
				}

			if (payout>0)
				{
				payout = rounder(payout);
//				trace("["+uid+"] total payout of "+payout);
				log("["+uid+"] total payout of "+payout);
				setCash(_server.getUserById(uid), payout);
				moneyTrail[uid].amount += payout;
				tableAmount -= payout;

				for(var i=0;i<winners.length;i++)
					{
					if (!winners[i]) continue;
					var wt = winners[i].split(':');
					if (wt[0] == uid)
						{
						var rp = calcRealPayout(parseInt(payout))
						wt[1] = rounder(parseInt(wt[1]) + rp);
						winners[i] = wt.join(':');
						break;
						}
					}

				}
			if (tableAmount<1) break;
			}
		if (tableAmount<1) break;

		for(var victim in takeDeduct)
			{
			if (!takeDeduct[victim]) continue;
			userbets[victim] -= takeDeduct[victim];
			}
		}

	}

//if (tableAmount>0) trace("ERROR, MONEY LEFT ON TABLE: "+tableAmount);
if (tableAmount>0) log("ERROR, MONEY LEFT ON TABLE: "+tableAmount);

users.setAll({'totalBet':0, 'cashDeducted':true});
//trace("end payout calculation")
log("end payout calculation")

if (revealHands)
	lastHandWinnerCount = winners.length;
else
	lastHandWinnerCount = 0;

var winPack = ['win', winners.join(';')];
_server.sendResponse(winPack, roomid, null, room.getAllUsers(), 'str');
usedPackets.push(winPack);
tableAmount = 0;
putOnTable(tableAmount, true);
trace("-----");

for(var uid in moneyTrail)
	{
	if (moneyTrail[uid]==undefined || moneyTrail[uid].amount==0) continue;
//	trace("uid "+uid+", dbid "+moneyTrail[uid].dbid+", earnings "+moneyTrail[uid].amount);
	log("uid "+uid+", dbid "+moneyTrail[uid].dbid+", earnings "+moneyTrail[uid].amount);
	cimdikUpdate(moneyTrail[uid].dbid, moneyTrail[uid].amount);
	}

}catch(e){trace("winnerCash error: "+e.message);}
}

function putOnTable(bid, set)
{
if (set==undefined || set==false)
	tableAmount += parseInt(bid);
else
	tableAmount = bid;
_server.sendResponse(['tBl', String(tableAmount)], roomid, null, room.getAllUsers(), 'str');
}

function calcRealPayout(m) {
	return rounder(m * 0.96);
}

function checkStartGame(_withTimer)
{
if (newGameTimer)
	{
	trace("checkStartGame: timer already active, skipping");
	return;
	}
clearNewGameTimer();

var withTimer;
if (_withTimer == undefined)
	withTimer = true;
else
	withTimer = _withTimer;

trace("checkstartgame: "+withTimer);

if (turnProgress>0) return(false);

var players = users.getAllMatch({'inSeat':true, 'sitOut':false, 'deleted':false}, false);
if (players.length < minPlayers) return(false);

_server.sendResponse(['neG'], roomid, null, room.getAllUsers(), 'str');

if (!withTimer)
	{
//	startGame();
	trace("setting new turn w/o timer");
	newGameTimer = setInterval("startGame", 1000);
	}
else
	{
	trace("setting new turn w/ timer");
	newGameTimer = setInterval("startGame", 2000 + (lastHandWinnerCount*3000));
	}
lastHandWinnerCount = 0;
}

function gotPlayers()
{
var ingame = users.getAllMatch({'inSeat':true, 'sitOut':false, 'folded':false, 'deleted':false}, false);
trace('ingamelength: '+ingame.length);
if(ingame.length == 1)
	{
	if (turnProgress>0)
		{
		var lastUid = ingame[0].sfid;
//		trace('wTa: '+lastUid+' ($'+tableAmount+')');
		log('Last user standing: '+lastUid+' ($'+tableAmount+')');
		winnerCash(false);
		turnStatus(0);
		checkStartGame();
		}
	return(false);
	}
else if (ingame.length == 0) //kimse kalmamis (nasil olur)
	{
//	trace('WARNING: no users left in game');
	log('WARNING: no users left in game');
	turnStatus(0);
	return(false);
	}
return(true);
}

function betUser(user, _bid, _type)
{
try{
clearBidTimer();
var type = _type || "";
var bid = parseInt(_bid);
if (isNaN(bid) || bid<0) bid = 0;
if (type=="check") bid = 0;

var uid = user.getUserId();

trace("user "+uid+"'s bet is "+bid+" ("+type+")");

var isBlind = (type=="blind_big" || type=="blind_small");

var turb = users.get(uid, 'turnBet');
if (isNaN(turb)) turb=0;
var totb = users.get(uid, 'totalBet');
if (isNaN(totb)) totb=0;

var uc = users.get(uid, 'cash');
if (bid > uc)
	{
	trace("usersCash>bid, setting bid to "+uc);
	bid = uc;
	}

var newturnbet = turb + bid;
var newtotbet = totb + bid;

if (!isBlind && bid<lastToCall) //newturnbet < totalBet)
	{
	type = "allin";
	trace("user is allin! (lastToCall:"+lastToCall+", newturnbet:"+newturnbet+")");
	}

if (newtotbet > totalBet)
	{
	totalBet = newtotbet;
	if (!isBlind && type!="allin") type="raise";
	trace("it is the biggest bet! ("+type+")");
	}

if (bid>0)
	{
	setCash(user, bid*-1);
	putOnTable(bid);
	if (users.get(uid, 'cash')<1) type="allin";

	users.set(uid, {'totalBet':newtotbet, 'turnBet':newturnbet});

	if (type=="allin")
		{
		users.set(uid, {'allIn':true, 'allInTurn':potsByTurn.length});
		pushUserList();
		}

	if (type!="allin" && bid > lastToCall && bid-lastToCall > roundBet) //allin'de olmuyor bu, fb/zynga'da oyle gordum -k
		{
		roundBet = bid - lastToCall;
		trace("roundBet now "+roundBet);
		}

	if (type=="raise" || type=="allin")
		{
		calcRotatingUsers(false, uid);
		}
	}

return(type);
}catch(e){trace('betUser exception:'+e);}
}

function shuffle(arr) {
	var p = new Array();
	while(arr.length>0){
		p.push( arr.splice( Math.floor( Math.random() * arr.length ), 1) );
	}
	return(p);
}

function calc(ins) {
	p = 53;
	for(var j=0; j<ins.length; j++){
		t = p + blankDeck.indexOf( String(ins[j]) ) + 1;
//		sql = "SELECT hash FROM hashes WHERE id = "+t;
		sql = "SELECT hash FROM hash.dbo.hashes WHERE id = "+t;
		rs = db.executeQuery(sql);
		if (rs != null){
			row = rs.get(0);
			p = Number(row.getItem('hash'));
		}
	}
	return(p);
}

/* 	Payout hesabı yaparken payout'tan %4 (tekrar değişti) deduction olacak. Bunun 1%'i odayı açan kullanıcıya kalan %5 ise kesintiye uğramış olacak.
	Odayı açan kullanıcının id nasıl alındığını bilmediğim için şu aşamada dokunmadım. payout'tan kesilen miktarı setCash ile odayı yaratana
	dağıtırız herhalde diye düşünüyorum.
*/
function cimdikUpdate(_dbid, _amount) {
	var dbid = parseInt(_dbid);
	var amount = rounder(parseInt(_amount));
	var roomOwner = parseInt(room.getVariable('owner_id').value);

	log("cimdikUpdate for user #"+dbid+" amount: "+amount+" (non-rounded: "+_amount+")");
	if (amount<0){
		db.executeCommand("deleteCimdik "+dbid+","+(amount*-1));
	}else if (amount>0){
		var netAmount = rounder(amount * 0.96);
//		var cuts = amount - netAmount;
//		var ownerComm = cuts * 0.80; //%5'in %80'i = %4
		var ownerComm = Math.floor(amount * 0.01);
		var cuts = amount - netAmount - ownerComm;
		log("net amount is "+netAmount+", owner comm is "+ownerComm+" (total cuts: "+cuts+", owner dbid:"+roomOwner+")");
		if (netAmount>0) {
			db.executeCommand("addCimdik "+dbid+","+netAmount+",1");
			}
		if (ownerComm>0 && roomOwner>0) {
			log('Commision passed to user '+roomOwner);
			db.executeCommand("addCimdik "+roomOwner+","+ownerComm+",0");
			}
	}

}