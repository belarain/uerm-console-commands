#include "include/uerm.as"

array<Player> connPlayers;

void OnInitialize()
{
    RegisterCallback(ServerConsole_c, "OnConsole");
    RegisterCallback(PlayerConnect_c, "cPlayers::OnConnect");
    RegisterCallback(PlayerDisconnect_c, "cPlayers::OnDisconnect");
        
    print(" ");
    print("----------------------------------------------------------------------------");
    print("[SERVER] Console Commands has loaded successfully");
    print("[SERVER] By BelaRain");
    print("[SERVER] The Repository - https://github.com/belarain/uerm-console-commands");
    print("----------------------------------------------------------------------------");
    print(" ");
}

bool OnConsole(string cmd)
{
    if (cmd == "help")
    {
        print("[SERVER] CONSOLE COMMANDS:");
        print("[SERVER] playerlist | List of players with names, IDs, IPs");
        print("[SERVER] playerinfo [ID] | Player info");
        print("[SERVER] clear | Clear console");
        print("[SERVER] restart | Restart server");
        print("[SERVER] message [TEXT] | Message to server (in chat)");
        print("[SERVER] info | Server info");
        print("[SERVER] kick [ID] | Kick player (That is standart command, but I make better :3)");
        return false;
    }
    if (cmd == "playerlist")
    {
        print("[SERVER] " + connPlayers.size() + " players:");
        for (int i = 0; i < connPlayers.size(); ++i)
        {
            Player player = connPlayers[i];
            print("[SERVER] Name: " + player.GetName() + " | ID: " + player.GetIndex() + " | IP: " + player.GetIP());
        }
        return false;
    }
    
    if (cmd == "clear" || cmd == "cls")
    {
        print(" \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n
                \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n
                \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n
                \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n"); // wtf
        print("[SERVER] Success!");
        return false;
    }

    if (cmd == "restart") { server.Restart(); return false; }
    if (cmd == "info")
    {
        print("[SERVER] Setting \"hostname\": " + server.hostname);
        print("[SERVER] Setting \"version\": " + server.GetVersion());
        print("[SERVER] Setting \"ups\": " + server.GetUPS());
        print("[SERVER] Setting \"port\": " + server.port);
        print("[SERVER] Setting \"corpsealivetime\": " + server.corpsealivetime);
        print("[SERVER] Setting \"timeout\": " + server.timeout);
        print("[SERVER] Setting \"chat\": " + server.chat);
        print("[SERVER] Setting \"console\": " + server.console);
        print("[SERVER] Setting \"voicebitrate\": " + server.voicebitrate);
        print("[SERVER] Setting \"maxplayers\": " + server.maxplayers);
        print("[SERVER] Setting \"mapseed\": " + server.mapseed);
        print("[SERVER] Setting \"adminpassword\": " + server.adminpassword);
        print("[SERVER] Setting \"difficulty\": " + server.difficulty);
        print("[SERVER] Setting \"gamemode\": " + server.gamemode);
        print("[SERVER] Setting \"emptybehaviour\": " + server.emptybehaviour);
        print("[SERVER] Setting \"scriptsautoload\": " + server.scriptsautoload);
        print("[SERVER] Setting \"disablenpcs\": " + server.disablenpcs);
        print("[SERVER] Setting \"proximityplayers\": " + server.proximityplayers);
        print("[SERVER] Setting \"mapbounds\": " + server.mapbounds);
        print("[SERVER] Setting \"respawntime\": " + server.respawntime);
        print("[SERVER] Setting \"contenturl\": " + server.contenturl);
        print("[SERVER] Setting \"password\": " + server.password);
        print("[SERVER] Setting \"improvedgates\": " + server.improvedgates);
        print("[SERVER] Setting \"mapsize\": " + server.mapsize);
        print("[SERVER] Setting \"masterserver\": " + server.masterserver);
        print("[SERVER] Setting \"allowjump\": " + server.allowjump);
        print("[SERVER] Setting \"description\": " + server.description);
        print("[SERVER] Setting \"fastslots\": " + server.fastslots);
        return false;
    }
    
    if (cmd == "message") { print("[SERVER] message [TEXT]"); return false; }
    if (cmd.findFirst("message ") >= 0)
    {
        chat.Send(cmd.substr(8, cmd.length()-8));
        return false;
    }

    if (cmd == "createbot") { print("[SERVER] createbot [NAME]"); return false; }
    if (cmd.findFirst("createbot ") >= 0)
    {
        world.CreateBot(cmd.substr(10, cmd.length()-10));
        print("[SERVER] Bot has been created with name: " + cmd.substr(10, cmd.length()-10));
        return false;
    }

    if (cmd == "playerinfo") { print("[SERVER] playerinfo [ID]"); return false; }
    if (cmd.findFirst("playerinfo ") >= 0)
    {
        Player player = cPlayers::SelectPlayerFromId(parseInt(cmd.substr(11, cmd.length()-11)));
        if (player == NULL) { print("[SERVER] User is not found"); return false; }
        float x, y, z, pitch, yaw;
        player.GetNetworkPosition(x, y, z);
        player.GetNetworkRotation(pitch, yaw);

        print("[SERVER] PLAYER INFORMATION:");
        print("[SERVER] Name: " + player.GetName() + " | ID: " + player.GetIndex() + " | IP: " + player.GetIP() + " | SteamID: " + player.GetSteamID() + " | HWID: " + player.GetHWID() + " | Ping: " + player.GetPing());
        print("[SERVER] Language: " +  player.GetLanguage() + " | Dead Status: " + player.IsDead() + " | Admin Status: " + player.IsAdmin() + " | Bot Status: " + player.IsBot());
        print("[SERVER] Room: " + player.GetRoom() + " | Room Position: " + x + " " + y + " " + z + " " + " | Room Rotation: " + pitch + " " + yaw);
        return false;
    }
    
    if (cmd == "kick") { print("[SERVER] kick [ID]"); return false; }
    if (cmd.findFirst("kick ") >= 0)
    {
        Player player = cPlayers::SelectPlayerFromId(parseInt(cmd.substr(5, cmd.length()-5)));
        if (player == NULL) { print("[SERVER] User is not found"); return false; }
        
        print("[SERVER] " + player.GetName() + " has been kicked");
        player.Kick(CODE_KICKED);
        return false;
    }

    return true;
}

namespace cPlayers
{
    void OnConnect(Player player)
    {
        connPlayers.push_back(player); // Add player to connPlayers
    }

    void OnDisconnect(Player player)
    {
        connPlayers.removeAt(connPlayers.find(player)); // Remove player from connPlayers
    }

    Player SelectPlayerFromId(int id)
    {
        Player player = NULL;
        for (int i = 0; i < connPlayers.size(); ++i)
        {
            player = connPlayers[i];
            if (player.GetIndex() == id) break;
        }
        if (player != NULL) return player;
        return NULL;
    }
}





