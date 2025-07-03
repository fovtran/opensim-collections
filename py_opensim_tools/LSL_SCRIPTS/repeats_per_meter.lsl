default
  2 {
  3     state_entry()
  4     {
  5         // round position to grid
  6         float grid = 0.125;
  7         vector pos = llGetPos();
  8         pos.x = grid * llRound(pos.x / grid);
  9         pos.y = grid * llRound(pos.y / grid);
 10         pos.z = 27.750;
 11         llSetPos(pos);
 12 
 13         // round scale to twice grid
 14         grid *= 2.0;
 15         vector scale = llGetScale();
 16         scale.x = grid * llRound(scale.x / grid);
 17         if(scale.x == 0) { scale.x = grid; }
 18         scale.y = grid * llRound(scale.y / grid);
 19         if(scale.y == 0) { scale.y = grid; }
 20         scale.z = 3.0;
 21         llSetScale(scale);
 22         llSay(0, "scale " + (string)scale);
 23         
 24         // repeats per meter
 25         float r = 0.5;
 26         llScaleTexture(r*scale.x, r*scale.z, 1);
 27         llScaleTexture(r*scale.y, r*scale.z, 2);
 28         llScaleTexture(r*scale.x, r*scale.z, 3);
 29         llScaleTexture(r*scale.y, r*scale.z, 4);
 30         
 31         //string me = llGetInventoryName(INVENTORY_SCRIPT, 0);
 32         //llRemoveInventory(me);
 33         llRemoveInventory(llGetScriptName());
 34     }
 35 }