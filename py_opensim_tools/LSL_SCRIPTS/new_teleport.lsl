//Simple teleport

vector vPos = <42, 88, 71>;
vector vDest = <206, 99, 23.44>;

default {
   state_entry() {
      llSetPos(vPos);
   }

   touch_start(integer total_number) {
      llSetPos(vDest);
      llSleep(3.0);
      llSetPos(vPos);
   }
}
