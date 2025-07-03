integer card;list cardlist=[];integer limit = 10000; 
// <- bytes This was only for this script.

default{	changed(integer ch)	{		
if(ch&CHANGED_OWNER)		{			
llResetScript();		}	}	

on_rez(integer num)	{		llResetScript();	}	

state_entry()	{		
llSetMemoryLimit(limit);//No point waisting resorces	}	

touch_start(integer total_number)	{		

card = (integer)(llFrand(52));//This you have to change 		
if(~llListFindList(cardlist,(list)card))//Search to see if card is in the memory		
{			
llSay(0,(string)card+" You got a match, card number is "+(string)card);//I would keep this as a debug		}		
else		{			
llSay(0,"card number is "+(string)card);//There was no match in the memory, so your message would go here			
cardlist += card;//Add card to list			
cardlist = llListSort(cardlist, 1, TRUE);//I
 just like neatness		

}	}}
 

