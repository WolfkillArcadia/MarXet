/**
 *
 * Author: WolfkillArcadia
 * www.arcasindustries.com
 * © 2017 Arcas Industries
 *
 * This work is protected by Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0). 
 *
 */
 
_vehicleCheck = _this select 0;
_itemClassname = _this select 1;
_price = _this select 2;
_location = _this select 3;

// Didn't list a vehicle
if !(_vehicleCheck) then
{
    // Thx to Exile for the logic
    switch (_location) do
    {
        case 0:
        {
            // When you buy a uniform/vest/backpack in to your equipment, show the newest drop down options
            _containersBefore = [uniform player, vest player, backpack player];

            [player, _itemClassname] call ExileClient_util_playerCargo_remove;

            _containersAfter = [uniform player, vest player, backpack player];

            if !(_containersAfter isEqualTo _containersBefore) then
            {
                ["LoadDropdown","Left"] call ExileClient_MarXet_gui_load;
            };
        };

        case 1:
        {
            [(uniformContainer player), _itemClassname] call ExileClient_util_containerCargo_remove;
        };

        case 2:
        {
            [(vestContainer player), _itemClassname] call ExileClient_util_containerCargo_remove;
        };

        case 3:
        {
            [(backpackContainer player), _itemClassname] call ExileClient_util_containerCargo_remove;
        };
    };
};

_configName = _itemClassname call ExileClient_util_gear_getConfigNameByClassName;
_name = getText(configFile >> _configName >> _itemClassname >> "displayName");

["SuccessTitleAndText", [

    "It's been listed!",
    format ["You have successfully listed your <t color='#ff0000'>%1</t> for <t color='#ff0000'>%2</t><img image='\exile_assets\texture\ui\poptab_inline_ca.paa' size='24'/> on Mar<t color='#531517'>X</t>et.<br/>Thank you for using Mar<t color='#531517'>X</t>et: Exile's leading marketplace!", _name, _price]

]] call ExileClient_gui_toaster_addTemplateToast;
//Close the dialog as players could use lag switch to sell vehicle with the display open to list multiple times
closeDialog 21000;
// Update the trader dialog
_dialog = uiNameSpace getVariable ["RscMarXetDialog", displayNull];

// Only update it when its still opened
if !(_dialog isEqualTo displayNull) then
{
    MarXet_TempListingClassname = "";
    (_dialog displayCtrl 21018) lbSetCurSel -1;
    
    ["Sort",MarXet_Sorting] call ExileClient_MarXet_gui_load;
    ["LoadLeft"] call ExileClient_MarXet_gui_load;
    ["LoadRight"] call ExileClient_MarXet_gui_load;
    (_dialog displayCtrl 21024) ctrlEnable true;
    (_dialog displayCtrl 21011) ctrlEnable true;
};
