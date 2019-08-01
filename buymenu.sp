#include <sourcemod>
#include <sdktools_functions>
#include <cstrike>

#pragma semicolon 1
#pragma newdecls required 

public Plugin myinfo = 
{
	name = "Choose Gun Menu for FFA", 
	author = "jdtoombs", 
	description = "Type !guns in chat to choose from variety of permitted guns", 
	version = "1.0.0", 
	url = ""
};

public void OnPluginStart() {
	//**loose indentation occurs when mixmatching tab/space**
	PrintToServer("Is this working?");
	RegConsoleCmd("sm_test", Command_Test, "Displays a test menu");
}

public Action Command_Test(int client, int args) {
	Menu menu = new Menu(Menu_Callback);
	menu.SetTitle("Weapons:");
	menu.AddItem("ak47", "AK-47");
	//ITEMDRAW_DISABLED for third param if want to grey it out (eg) player doesnt have enough coins
	//space for micro transactions? lel
	menu.AddItem("m4", "M4A1");
	menu.AddItem("ssg", "SSG");
	menu.AddItem("awp", "AWP");
	menu.AddItem("AUG", "AUG");
	
	//who we are displaying it to, and the time it takes to time out
	menu.Display(client, 30);
	return Plugin_Handled;
}



public int Menu_Callback(Menu menu, MenuAction action, int p1, int p2) {
	switch (action) {
		case MenuAction_Select:
		{
			char item[32];
			menu.GetItem(p2, item, sizeof(item));
			
			if (StrEqual(item, "ak47")) {
				//give client ak47
				GivePlayerItem(client, "weapon_ak47");
			}
			else if (StrEqual(item, "m4")) {
				//give m4a1
			}
			
		}
		case MenuAction_End:
		{
			//must do it ourselves or mem leak
			delete menu;
		}
		
	}
} 
