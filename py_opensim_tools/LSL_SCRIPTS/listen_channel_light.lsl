integer set = 9;
integer chan = 2;//the channel the ligth listens on
vector green = <0,1,0>;
vector yellow = <1,1,0>;
vector red = <1,0,0>;
vector cyan = <0.25,1,1>;
vector pink = <1,0,0.5>;
vector orange = <1,0.5,0>;
vector white = <1,1,1>;
vector black = <0,0,0>;
vector blue = <0,0,0>;//add more light below
default
{
    state_entry()
    {
        llListen(chan,"","","");
    }
    listen(integer channel, string name, key id, string message)
    {
        if(llToLower(message) == "mix1")
        {
            set = 1;
            llSetTimerEvent(0.8);//edit the timer if your mix is longer
        }
        else if(llToLower(message) == "mix2")
        {
            set = 2;
            llSetTimerEvent(0.8);
        }
        else if(llToLower(message) == "mix3")
        {
            set = 3;
            llSetTimerEvent(0.8);
        }
        else if(llToLower(message) == "stop")
        {
            llSetTimerEvent(0.0);
            //add here the default values
        }//add more if events if you have mroe mixtures, but remember that the controller must be able to handel em all.
    }
    timer()
    {
        if (set == 1)
        {
            //here you can create mixtures, max functions: 27 This can be in the root prim, for the movement, or the light itself with light, color changes and brightness
        }
        else if (set == 2)
        {
            
        }
        else if (set == 3)
        {
            
        }

    }
}