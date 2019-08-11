#include <sourcemod>
#include <sdktools_functions>
#include <cstrike>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo =
{
	name = "Choose Gun Menu for FFA",
	author = "jdtoombs/derekbell/nollidnosnhoj",
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
	// If there are more than one arguments.
	if (args > 1)
	{
		ReplyToCommand(client, "[SM] Usage: sm_test <weapon>");
		return Plugin_Handled;
	}
	// Argument will bypass menu and give player the weapon.
	if (args == 1)
	{
		char arg1[32];
		GetCmdArg(1, arg1, sizeof(arg1));
		GivePlayerWeapon(client, arg1);
		return Plugin_Handled;
	}
	// No arguments will open weapon menu
	if (args == 0)
	{
		Menu menu = new Menu(Menu_Callback);
		menu.SetTitle("Weapons:");
		AddWeaponsToMenu(menu);
		//who we are displaying it to, and the time it takes to time out
		menu.Display(client, 30);
		return Plugin_Handled;
	}
	return Plugin_Handled;	
}

public int Menu_Callback(Menu menu, MenuAction action, int client, int p2)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			// This code could be cleaner.
			char item[32];
			menu.GetItem(p2, item, sizeof(item));
			GivePlayerWeapon(client, item);
		}
		case MenuAction_End:
		{
			delete menu;	// avoid memory leak
		}
	}
}

// Add Weapons in referenced Menu object
void AddWeaponsToMenu(Menu& menu)
{
	menu.AddItem("ak47", "AK-47");
	//ITEMDRAW_DISABLED for third param if want to grey it out (eg) player doesnt have enough coins
	//space for micro transactions? lel
	menu.AddItem("m4", "M4A1");
	menu.AddItem("ssg", "SSG");
	menu.AddItem("awp", "AWP");
	menu.AddItem("aug", "AUG");
}

// Give the client (player) weapon based on string
void GivePlayerWeapon(int client, char[] item)
{
	if (StrEqual(item, "ak47"))
	{
		GivePlayerItem(client, "weapon_ak47");
	}
	else if (StrEqual(item, "m4"))
	{
		GivePlayerItem(client, "weapon_m4a1");
	}
	else if (StrEqual(item, "awp"))
	{
		GivePlayerItem(client, "weapon_awp");
	}
	else if (StrEqual(item, "aug"))
	{
		GivePlayerItem(client, "weapon_aug");
	}
	else
	{
		PrintToServer("Unknown weapon");
	}
}