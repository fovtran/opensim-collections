//BE SURE TO MAKE YOUR PRIM MATERIAL GLASS BEFORE USING VEHICLE PRIM

key agent;
vector PUSH_OFF = <0, .1, .1>;
integer iChan = 0;
key owner;

integer onoff = TRUE;

string last_wheel_direction;
string cur_wheel_direction;


default
{
    state_entry()
    {

        llSetSitText("Ride");
        llSitTarget(<0.00, 0.05, 0.65>, <0.0, 0.35, 0.0, 1>);
        llSetCameraEyeOffset(<-6.0, 0.0, 3.0>);
        llSetCameraAtOffset(<3.0, 0.0, 1.0>);
    //  llSetVehicleFlags(-1);
        llSetVehicleType(VEHICLE_TYPE_CAR);
    //  llSetVehicleFlags(VEHICLE_FLAG_NO_DEFLECTION_UP | VEHICLE_FLAG_LIMIT_ROLL_ONLY | VEHICLE_FLAG_LIMIT_MOTOR_UP);
        llSetVehicleFloatParam(VEHICLE_ANGULAR_DEFLECTION_EFFICIENCY, 1.00);
        llSetVehicleFloatParam(VEHICLE_LINEAR_DEFLECTION_EFFICIENCY, 1.0);
        llSetVehicleFloatParam(VEHICLE_ANGULAR_DEFLECTION_TIMESCALE, 0.01);
        llSetVehicleFloatParam(VEHICLE_LINEAR_DEFLECTION_TIMESCALE, 0.01);
         
        llSetVehicleFloatParam(VEHICLE_LINEAR_MOTOR_TIMESCALE, 0.1);
        llSetVehicleFloatParam(VEHICLE_LINEAR_MOTOR_DECAY_TIMESCALE, 0.1);
        llSetVehicleFloatParam(VEHICLE_ANGULAR_MOTOR_TIMESCALE, 1.0);
        llSetVehicleFloatParam(VEHICLE_ANGULAR_MOTOR_DECAY_TIMESCALE, 0.1);
        
        
        llSetVehicleVectorParam(VEHICLE_LINEAR_FRICTION_TIMESCALE, <100.0, 10.0, 100.0>);
        llSetVehicleVectorParam(VEHICLE_ANGULAR_FRICTION_TIMESCALE, <100.0, 10.0, 100.0>);
        
        
        llSetVehicleFloatParam(VEHICLE_VERTICAL_ATTRACTION_EFFICIENCY, 1.0);
        llSetVehicleFloatParam(VEHICLE_VERTICAL_ATTRACTION_TIMESCALE, 1.0);
        
        llSetVehicleFloatParam(VEHICLE_BANKING_EFFICIENCY, 1.0);
        llSetVehicleFloatParam(VEHICLE_BANKING_TIMESCALE, 0.1);
        
        owner = llGetOwner();
        llListen(iChan,"",owner,"");
    }
    
    changed(integer change)
    {
        if (change & CHANGED_LINK)
        {
            key agent = llAvatarOnSitTarget();
            if (agent)
            {
                if (agent != llGetOwner())
                {
                  //  llSay(0, "You aren't the owner");
                 //   llUnSit(agent);
                //    llPushObject(agent, <0,0,100>, ZERO_VECTOR, FALSE);
                }
                else
                {
                 //   llSleep(4.5);
                    llSetStatus(STATUS_PHYSICS | STATUS_ROTATE_X | STATUS_ROTATE_Y | STATUS_ROTATE_Z, TRUE);
                  //  llSleep(.1);
                  //  llSetTimerEvent(1.0);
                    llRequestPermissions(agent, PERMISSION_TRIGGER_ANIMATION | PERMISSION_TAKE_CONTROLS);
                }
            }
            else
            {
                llSetTimerEvent(0);
                llStopSound();
                llSetStatus(STATUS_PHYSICS | STATUS_ROTATE_X | STATUS_ROTATE_Y | STATUS_ROTATE_Z, FALSE); 
                llReleaseControls();
                llStopAnimation("motorcycle_sit");
                llPushObject(llGetOwner(), PUSH_OFF, <0,0,0>, TRUE);
            }
        }
        
    }
    
    run_time_permissions(integer perm)
    {
        if (perm)
        {
            llStartAnimation("motorcycle_sit");
            llTakeControls(CONTROL_FWD | CONTROL_BACK | CONTROL_RIGHT | CONTROL_LEFT | CONTROL_ROT_RIGHT | CONTROL_ROT_LEFT | CONTROL_UP | CONTROL_DOWN, TRUE, FALSE);
        }
    }
    control(key id, integer level, integer edge)
    {
        vector angular_motor;
        vector vel = llGetVel();
        
        if(level & CONTROL_FWD)
        {

            if(!llGetStatus(STATUS_PHYSICS))
            {
                llSetStatus(STATUS_PHYSICS | STATUS_ROTATE_X | STATUS_ROTATE_Y | STATUS_ROTATE_Z, TRUE);

            }
            
           llSetVehicleVectorParam(VEHICLE_LINEAR_MOTOR_DIRECTION, <15,0,0>);
        }
        if(level & CONTROL_BACK)
        {

            llSetVehicleRotationParam(VEHICLE_REFERENCE_FRAME, <0, 0, 1, 0> );  
            if(!llGetStatus(STATUS_PHYSICS))
            {
                llSetStatus(STATUS_PHYSICS | STATUS_ROTATE_X | STATUS_ROTATE_Y | STATUS_ROTATE_Z, TRUE);

            }
            llSetVehicleVectorParam(VEHICLE_LINEAR_MOTOR_DIRECTION, <-5,0,0>);
        }

        if(level & (CONTROL_RIGHT|CONTROL_ROT_RIGHT))
        {

            llSetVehicleRotationParam(VEHICLE_REFERENCE_FRAME, <0, 0, 0, 3> );
            angular_motor.x += 1;
            angular_motor.z -= 1;
        }
        if(level & (CONTROL_LEFT|CONTROL_ROT_LEFT))
        {

            llSetVehicleRotationParam(VEHICLE_REFERENCE_FRAME, <0, 0, 0, 3> );
            angular_motor.x -= 1;
            angular_motor.z += 1;
            //llWhisper(0,(string)llGround(<0,0,0>) + " -- " + (string)llGetPos());
        }
        if(level & (CONTROL_UP))
        {
            llSetVehicleRotationParam(VEHICLE_REFERENCE_FRAME, <0, 0, 0, 1> );
            angular_motor.y -= 1;
        }
        if(level & (CONTROL_DOWN))
        {
            llSetVehicleRotationParam(VEHICLE_REFERENCE_FRAME, <0, 0, 0, 1> );
            angular_motor.y += 1;
        }
        if((edge & CONTROL_FWD) && (level & CONTROL_FWD))
        {
            // We have a few message links to communicate to the other 
            // scritps when we start to accelerate and let off the gas.
            llMessageLinked(LINK_SET, 0, "burst", "");
        }
        if((edge & CONTROL_BACK) && !(level & CONTROL_BACK))
        {

        }

        llSetVehicleVectorParam(VEHICLE_ANGULAR_MOTOR_DIRECTION, angular_motor);
        
    }
        timer()
    {

    }
    
}