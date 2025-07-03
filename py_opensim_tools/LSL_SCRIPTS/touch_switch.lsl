//touch switch

integer Switch = FALSE;

default
{
touch_start(integer total_number)
{
if(Switch == FALSE)
{
Switch = TRUE;
llSay(0, "On"); //turn on stuff here
}
else
{
Switch = FALSE;
llSay(0, "Off"); //turn off stuff here
}
}
}