default
{
    state_entry()
    {
        llSay(0, "Script running");
        llSetPrimitiveParams([
            7,<0.025,0.025,0.025>,
            9, 3, 0, <0.0,1.0,0.0>, 0.0, <0.0,0.0,0.0>, <0.0,1.0,0.0>,
           17, -1, "5748decc-f629-461c-9a36-a35a221fe21f", <1.0,1.0,0.0>, <0.0,0.0,0.0>, 0.0,
           18, -1, <0.0,255.0,0.0>, 1.0,
           25, -1, 0.20,
           27, "Blip"]);

        llParticleSystem([
             PSYS_PART_FLAGS
             , 0
             | PSYS_PART_EMISSIVE_MASK
             | PSYS_PART_INTERP_COLOR_MASK
             | PSYS_PART_INTERP_SCALE_MASK
             | PSYS_PART_FOLLOW_SRC_MASK
             ,
            
             PSYS_SRC_PATTERN, PSYS_SRC_PATTERN_DROP,
            
             PSYS_SRC_MAX_AGE, 0.0,
             PSYS_SRC_BURST_RATE, 5.0,
             PSYS_SRC_BURST_PART_COUNT, 1,
            
             PSYS_SRC_ACCEL, <0.0,0.0,0.01>,
            
             PSYS_PART_MAX_AGE, 3.,
             PSYS_PART_START_COLOR, <0,1,0>,
             PSYS_PART_END_COLOR, <1,1,1>,
             PSYS_PART_START_ALPHA, 0.8,
             PSYS_PART_END_ALPHA, 0.,
            
             PSYS_PART_START_SCALE, <0.5,0.5,0>,
             PSYS_PART_END_SCALE, <.01,.01,0>]);
        llRemoveInventory(llGetScriptName());
    }
}