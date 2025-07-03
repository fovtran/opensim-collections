/ Dome Builder
// 2007 Copyright by Shine Renoir (fb@frank-buss.de)
// Use it for whatever you want, but keep this copyright notice
// and credit my name in notecards etc., if you use it in
// closed source objects
// Modified by Adelle Fitzgerald for OpenSim

integer subdivision = 2; //Change for the amount of vertices
float length = 5.0; //Change this for the size of the dome
float lineWidth = 0.2; //'Thickness' of the lines
float triangleThickness = 0.05; //Thickness of the triangles
float delay = 0.1; //Delay between rezzing the prims and setting the properties - increase this if you experience 'bad' prims.
float initialDelay = 1.0; //Delay for the first few prims. Once the first few have rezzed it reverts to the delay above. Increase this if you experience 'bad' prims for the first few.

//Some good sizes to play with: subdevision = 2, length = 5 : subdevision = 3, length = 10 : subdevision = 4, length = 20 : subdevision = 5, length = 30
//And for something spectacular, subdevision = 18, length = 150 -- Do place the builder at the center of a region as this will pretty much fill it and create ~3600 prims in the process ;-)

vector base;
float r;
integer start;

move(vector destination)
{
    // llSetPos is limited to 10m distances,
    // so it is called until the target is reached
    //vector p = ZERO_VECTOR;
    //while (p.z != destination.z) {
    //    llSetPos(destination);
    //    p = llGetPos();
    //}
    
    //The original code above wouldn't work reliably in OpenSim, so as a workaround increase the 'ScriptDistanceLimitFactor' in opensim.ini to allow the prim to move more than the max of 10m. I set mine to 50 (ScriptDistanceLimitFactor = 50.0) to allow scripted prims to move upto 500m using llSetPos.
    llSetPos(destination);
}

drawLine(vector v1, vector v2)
{
    vector line = v2 - v1;
    vector pos = base + line / 2 + v1;
    float len = llVecMag(line);
    vector size = <lineWidth, lineWidth, len>;
    vector up = <0, 0, 1>;
    rotation rot = llRotBetween(up, llVecNorm(line));
    move(pos);
    llRezObject("Line", pos, ZERO_VECTOR, rot, 0);
    if (start < 6)
    {
        start += 1;
        llSleep(initialDelay);
    }
    else
    {
        llSleep(delay);
    }
    llSay(-43, (string) size);
}

drawTriangle(vector v1, vector v2, vector v3)
{
    // assuming a normal triangle: no zero area

    // make v1-v3 the longest side
    integer i = 0;
    for (i = 0; i < 2; i++) {
        float ax = llVecDist(v2, v3);
        float bx = llVecDist(v1, v3);
        float cx = llVecDist(v1, v2);
        if (ax > bx || cx > bx) {
            vector tmp = v1;
            v1 = v2;
            v2 = v3;
            v3 = tmp;
        }
    }
    
    // calculate side lengths
    float a = llVecDist(v2, v3);
    float b = llVecDist(v1, v3);
    float c = llVecDist(v1, v2);

    // b=b1+b2, a^2=h^2+b2^2, c^2=b1^2+h^2, solving:
    float b2 = (a*a + b*b - c*c)/2.0/b;
    float b1 = b - b2;
    float h = llSqrt(a*a - b2*b2);  // triangle height

    // calculate triangle height vector and shear value
    float hPosition = b1 / b;
    vector vb1 = (v3 - v1) * hPosition;
    vector vh = v2 - (v1 + vb1);
    float shear = hPosition - 0.5;

    // calculate position and rotation
    vector pos = base + v1 + (v3 - v1) / 2 + vh / 2;
    vector size = <b, triangleThickness, h>;
    vector up = <0.0, 0.0, 1.0>;
    rotation rot = llRotBetween(up, llVecNorm(vh));
    vector fwd = llVecNorm(v3 - v1);  // fwd is the base
    vector left = llVecNorm(vh);
    left = llVecNorm(left % fwd);  // "left" is cross product (orthogonal to base and left)
    rot = llAxes2Rot(fwd, left, fwd % left);  // calculate the needed rotation
    
    // create object
    llRezObject("Triangle", pos, ZERO_VECTOR, rot, 0);
    
    // set size and shear value
    list send = [size, shear ] ;
    if (start < 6)
    {
        start += 1;
        llSleep(initialDelay);
    }
    else
    {
        llSleep(delay);
    }
    llSay(-42, llList2CSV(send));
}

vector scaleToSphere(vector v)
{
    float l = llVecMag(v);
    return r / l * v;
}

drawSide(vector bottomLeft, vector top, vector bottomRight)
{
    integer i;
    integer segments = subdivision + 1;
    vector dx = (bottomRight - bottomLeft) / segments;
    vector dy = (top - bottomLeft) / segments;
    for (i = 0; i < segments; i++) {
        integer j;
        for (j = 0; j < subdivision * 2 + 1 - 2 * i; j++) {
            if ((j % 2) == 0) {
                // even, draw left and bottom line
                integer l = j / 2;
                vector v1 = scaleToSphere(bottomLeft + l * dx + i * dy);
                vector v2 = scaleToSphere(bottomLeft + l * dx + (i+1) * dy);
                vector v3 = scaleToSphere(bottomLeft + (l+1) * dx + i * dy);
                drawLine(v1, v2);
                drawLine(v1, v3);
                drawTriangle(v1, v2, v3);
            } else {
                // odd, draw right line
                integer l = (j - 1) / 2;
                vector v1 = scaleToSphere(bottomLeft + l * dx + (i+1) * dy);
                vector v2 = scaleToSphere(bottomLeft + (l+1) * dx + i * dy);
                vector v3 = scaleToSphere(bottomLeft + (l+1) * dx + (i+1) * dy);
                drawLine(v1, v2);
                drawTriangle(v1, v2, v3);
            }
        }
    }
}

drawDome()
{
    float l2 = length / 2.0;
    vector bottomLeft = <-l2, -l2, 0.0>;
    vector topLeft = <-l2, l2, 0.0>;
    vector topRight = <l2, l2, 0.0>;
    vector bottomRight = <l2, -l2, 0.0>;
    vector top = <0, 0, length * llSqrt(6.0) / 3.0>;
    r = llVecMag(bottomLeft - topRight) / 2.0;
    drawSide(bottomLeft, top, bottomRight);
    drawSide(topLeft, top, bottomLeft);
    drawSide(topRight, top, topLeft);
    drawSide(bottomRight, top, topRight);
}

initialize()
{
    llSetText("Position at the center of the dome and touch.", <1, 0, 0>, 1.0);
    llSitTarget(<0.5, 0.0, 0.7>, ZERO_ROTATION);
    base = llGetPos();
}

default
{
    touch_start(integer total_number)
    {
        start = 0;
        initialize();
        drawDome();
        base.z += length + 1.0;
        move(base);
    }

    on_rez(integer start_param) 
    {
        initialize();
    }
    
    state_entry()
    {
        initialize();
    }
}


Line Script:
{L_CODE}:
// One time scale script
// 2007 Copyright by Shine Renoir (fb@frank-buss.de)
// Use it for whatever you want, but keep this copyright notice
// and credit my name in notecards etc., if you use it in
// closed source objects
// Modified by Adelle Fitzgerald for OpenSim

integer handle;

default
{
    state_entry()
    {
        handle = llListen(-43, "", NULL_KEY, "" );
    }
    
    listen(integer channel, string name, key id, string message)
    {
        llSetScale((vector) message);
        llListenRemove(handle);
        llSleep(2);
        llRemoveInventory(llGetScriptName());
    }
    
    on_rez(integer param) {
        llResetScript();
    }
}