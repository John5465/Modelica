within Modelica.Mechanics.MultiBody.Examples.Systems;
package RobotR3 
  "Library to demonstrate robot system models based on the Manutec r3 robot" 
  
  model oneAxis 
    "Model of one axis of robot (controller, motor, gearbox) with simple load" 
    
    import SI = Modelica.SIunits;
    extends Modelica.Icons.Example;
    parameter SI.Mass mLoad(min=0)=15 "mass of load";
    parameter Real kp=5 "gain of position controller of axis 2";
    parameter Real ks=0.5 "gain of speed controller of axis 2";
    parameter SI.Time Ts=0.05 
      "time constant of integrator of speed controller of axis 2";
    parameter Real startAngle(unit="deg") = 0 "start angle of axis 2";
    parameter Real endAngle(unit="deg") = 120 "end angle of axis 2";
    
    parameter SI.Time swingTime=0.5 
      "additional time after reference motion is in rest before simulation is stopped";
    parameter SI.AngularVelocity refSpeedMax=3 "maximum reference speed";
    parameter SI.AngularAcceleration refAccMax=10 
      "maximum reference acceleration";
    
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.13,
        y=0.11,
        width=0.58,
        height=0.66),
      Documentation(info="<HTML>
<p>
With this model one axis of the r3 robot is checked.
The mechanical structure is replaced by a simple
load inertia.
</p>
</HTML>
"),   Diagram,
      experiment(StopTime=1.6),
      Commands(file=
            "Mechanics/MultiBody/Examples/Systems/oneAxisPlot.mos" 
          "Plot result"));
    
    Components.AxisType1 axis(
      w=5500,
      ratio=210,
      c=8,
      cd=0.01,
      Rv0=0.5,
      Rv1=(0.1/130),
      kp=kp,
      ks=ks,
      Ts=Ts) annotation (extent=[20, 0; 40, 20]);
    Modelica.Mechanics.Rotational.Inertia load(J=1.3*mLoad) 
      annotation (extent=[54, 0; 74, 20]);
    Components.PathPlanning1 pathPlanning(
      swingTime=swingTime,
      angleBegDeg=startAngle,
      angleEndDeg=endAngle,
      speedMax=refSpeedMax,
      accMax=refAccMax)   annotation (extent=[-60,0; -40,20]);
  protected 
    Components.ControlBus controlBus annotation (extent=[-32,10; 8,50]);
  equation 
    connect(axis.flange, load.flange_a) 
      annotation (points=[40,10; 54,10],   style(color=10, thickness=2));
    connect(pathPlanning.controlBus, controlBus) annotation (points=[-40,10; -15,
          10; -15,28; -12,28; -12,30],                 style(
        color=6,
        rgbcolor={255,204,51},
        thickness=2));
    connect(controlBus.axisControlBus1, axis.axisControlBus) annotation (
      points=[-12,30; -12,29; -9,29; -9,10; 20,10],
      style(
        color=6,
        rgbcolor={255,204,51},
        thickness=2),
      Text(
        string="%first",
        index=-1,
        extent=[-6,3; -6,3],
        style(color=0, rgbcolor={0,0,0})));
  end oneAxis;
  
  model fullRobot 
    "6 degree of freedom robot with path planning, controllers, motors, brakes, gears and mechanics" 
    
    annotation (
      Diagram,
      Coordsys(grid=[0.5, 0.5], component=[20, 20]),
      Icon(
        Rectangle(extent=[-99.5, 100; 100, -100], style(color=0, fillColor=8)),
        Bitmap(extent=[-75.5, 98.25; 87, -96.75], name=
              "../../../../Images/MultiBody/Examples/Systems/robot_kr15.bmp"),
        Text(extent=[-111.5, 130; 108.5, 100], string="%name"),
        Text(
          extent=[-104.5, -104; 115, -128],
          string="mLoad=%mLoad",
          style(color=0))),
      experiment(StopTime=3),
      Commands(
        file="Mechanics/MultiBody/Examples/Systems/fullRobotPlot.mos" "Animate"),
      Documentation(info="<HTML>
<p>
This is a detailed model of the robot. For animation CAD data
is used. Translate and simulate with the default settings
(default simulation time = 3 s). Use command script \"Scripts\\ExamplesfullRobotPlot.mos\"
to plot variables.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Examples/Systems/r3_fullRobot.png\" ALT=\"model Examples.Loops.Systems.RobotR3.fullRobot\">
</p>
</HTML>"));
    
    import SI = Modelica.SIunits;
    
    parameter SI.Mass mLoad(min=0) = 15 "mass of load";
    parameter SI.Position rLoad[3]={0.1,0.25,0.1} 
      "distance from last flange to load mass";
    parameter SI.Acceleration g=9.81 "gravity acceleration";
    parameter SI.Time refStartTime=0 "start time of reference motion";
    parameter SI.Time refSwingTime=0.7 
      "additional time after reference motion is in rest before simulation is stopped";
    
    parameter Real startAngle1(unit="deg") = -60 " start angle of axis 1" 
      annotation (Dialog(tab="Reference", group="startAngles"));
    parameter Real startAngle2(unit="deg") = 20 " start angle of axis 2" 
      annotation (Dialog(tab="Reference", group="startAngles"));
    parameter Real startAngle3(unit="deg") = 90 " start angle of axis 3" 
      annotation (Dialog(tab="Reference", group="startAngles"));
    parameter Real startAngle4(unit="deg") = 0 " start angle of axis 4" 
      annotation (Dialog(tab="Reference", group="startAngles"));
    parameter Real startAngle5(unit="deg") = -110 " start angle of axis 5" 
      annotation (Dialog(tab="Reference", group="startAngles"));
    parameter Real startAngle6(unit="deg") = 0 " start angle of axis 6" 
      annotation (Dialog(tab="Reference", group="startAngles"));
    
    parameter Real endAngle1(unit="deg") = 60 " end angle of axis 1" 
      annotation (Dialog(tab="Reference", group="endAngles"));
    parameter Real endAngle2(unit="deg") = -70 " end angle of axis 2" 
      annotation (Dialog(tab="Reference", group="endAngles"));
    parameter Real endAngle3(unit="deg") = -35 " end angle of axis 3" 
      annotation (Dialog(tab="Reference", group="endAngles"));
    parameter Real endAngle4(unit="deg") = 45 " end angle of axis 4" 
      annotation (Dialog(tab="Reference", group="endAngles"));
    parameter Real endAngle5(unit="deg") = 110 " end angle of axis 5" 
      annotation (Dialog(tab="Reference", group="endAngles"));
    parameter Real endAngle6(unit="deg") = 45 " end angle of axis 6" 
      annotation (Dialog(tab="Reference", group="endAngles"));
    
    parameter SI.AngularVelocity refSpeedMax[6]={3,1.5,5,3.1,3.1,4.1} 
      " Maximum reference speeds of all joints" 
      annotation (Dialog(tab="Reference", group="Limits"));
    parameter SI.AngularAcceleration refAccMax[6]={15,15,15,60,60,60} 
      " Maximum reference accelerations of all joints" 
      annotation (Dialog(tab="Reference", group="Limits"));
    
    parameter Real kp1=5 " gain of position controller" 
      annotation (Dialog(tab="Controller", group="Axis 1"));
    parameter Real ks1=0.5 "|Controller|Axis 1| gain of speed controller";
    parameter SI.Time Ts1=0.05 
      "|Controller|Axis 1| time constant of integrator of speed controller";
    parameter Real kp2=5 "|Controller|Axis 2| gain of position controller";
    parameter Real ks2=0.5 "|Controller|Axis 2| gain of speed controller";
    parameter SI.Time Ts2=0.05 
      "|Controller|Axis 2| time constant of integrator of speed controller";
    parameter Real kp3=5 "|Controller|Axis 3| gain of position controller";
    parameter Real ks3=0.5 "|Controller|Axis 3| gain of speed controller";
    parameter SI.Time Ts3=0.05 
      "|Controller|Axis 3| time constant of integrator of speed controller";
    parameter Real kp4=5 "|Controller|Axis 4| gain of position controller";
    parameter Real ks4=0.5 "|Controller|Axis 4| gain of speed controller";
    parameter SI.Time Ts4=0.05 
      "|Controller|Axis 4| time constant of integrator of speed controller";
    parameter Real kp5=5 "|Controller|Axis 5| gain of position controller";
    parameter Real ks5=0.5 "|Controller|Axis 5| gain of speed controller";
    parameter SI.Time Ts5=0.05 
      "|Controller|Axis 5| time constant of integrator of speed controller";
    parameter Real kp6=5 "|Controller|Axis 6| gain of position controller";
    parameter Real ks6=0.5 "|Controller|Axis 6| gain of speed controller";
    parameter SI.Time Ts6=0.05 
      "|Controller|Axis 6| time constant of integrator of speed controller";
    Components.MechanicalStructure mechanics(
      mLoad=mLoad,
      rLoad=rLoad,
      g=g) annotation (extent=[35,-35; 95,25]);
    Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.PathPlanning6
      pathPlanning(
      naxis=6,
      angleBegDeg={startAngle1,startAngle2,startAngle3,startAngle4,startAngle5,
          startAngle6},
      angleEndDeg={endAngle1,endAngle2,endAngle3,endAngle4,endAngle5,endAngle6},
      speedMax=refSpeedMax,
      accMax=refAccMax,
      startTime=refStartTime,
      swingTime=refSwingTime) annotation (extent=[-5,50; -25,70]);
    
    RobotR3.Components.AxisType1 axis1(
      w=4590,
      ratio=-105,
      c=43,
      cd=0.005,
      Rv0=0.4,
      Rv1=(0.13/160),
      kp=kp1,
      ks=ks1,
      Ts=Ts1) annotation (extent=[-25,-75; -5,-55]);
    RobotR3.Components.AxisType1 axis2(
      w=5500,
      ratio=210,
      c=8,
      cd=0.01,
      Rv1=(0.1/130),
      Rv0=0.5,
      kp=kp2,
      ks=ks2,
      Ts=Ts2) annotation (extent=[-25,-55; -5,-35]);
    
    RobotR3.Components.AxisType1 axis3(
      w=5500,
      ratio=60,
      c=58,
      cd=0.04,
      Rv0=0.7,
      Rv1=(0.2/130),
      kp=kp3,
      ks=ks3,
      Ts=Ts3) annotation (extent=[-25,-35; -5,-15]);
    RobotR3.Components.AxisType2 axis4(
      k=0.2365,
      w=6250,
      D=0.55,
      J=1.6e-4,
      ratio=-99,
      Rv0=21.8,
      Rv1=9.8,
      peak=26.7/21.8,
      kp=kp4,
      ks=ks4,
      Ts=Ts4) annotation (extent=[-25,-15; -5,5]);
    RobotR3.Components.AxisType2 axis5(
      k=0.2608,
      w=6250,
      D=0.55,
      J=1.8e-4,
      ratio=79.2,
      Rv0=30.1,
      Rv1=0.03,
      peak=39.6/30.1,
      kp=kp5,
      ks=ks5,
      Ts=Ts5) annotation (extent=[-25,5; -5,25]);
    RobotR3.Components.AxisType2 axis6(
      k=0.0842,
      w=7400,
      D=0.27,
      J=4.3e-5,
      ratio=-99,
      Rv0=10.9,
      Rv1=3.92,
      peak=16.8/10.9,
      kp=kp6,
      ks=ks6,
      Ts=Ts6) annotation (extent=[-25,25; -5,45]);
  protected 
    Components.ControlBus controlBus 
      annotation (extent=[-100,-30; -60,10], rotation=90);
  equation 
    connect(axis2.flange, mechanics.axis2) annotation (points=[-5,-45; 25,-45;
          25,-21.5; 33.5,-21.5],    style(color=0));
    connect(axis1.flange, mechanics.axis1) annotation (points=[-5,-65; 30,-65;
          30,-30.5; 33.5,-30.5],    style(color=0));
    connect(axis3.flange, mechanics.axis3) annotation (points=[-5,-25; 15,-25;
          15,-12.5; 33.5,-12.5],    style(color=0));
    connect(axis4.flange, mechanics.axis4) annotation (points=[-5,-5; 15,-5; 15,
          -3.5; 33.5,-3.5],      style(color=0));
    connect(axis5.flange, mechanics.axis5) 
      annotation (points=[-5,15; 10,15; 10,5.5; 33.5,5.5],     style(color=0));
    connect(axis6.flange, mechanics.axis6) annotation (points=[-5,35; 20,35; 20,
          14.5; 33.5,14.5],      style(color=0));
    connect(controlBus, pathPlanning.controlBus) 
                                         annotation (points=[-80,-10; -80,60; -25,
          60], style(
        color=6,
        rgbcolor={255,204,51},
        thickness=2));
    connect(controlBus.axisControlBus1, axis1.axisControlBus) annotation (
      points=[-80,-10; -80,-14.5; -79,-14.5; -79,-17; -65,-17; -65,-65; -25,-65],
      style(
        color=6,
        rgbcolor={255,204,51},
        thickness=2),
      Text(
        string="%first",
        index=-1,
        extent=[-6,3; -6,3],
        style(color=0, rgbcolor={0,0,0})));
    
    connect(controlBus.axisControlBus2, axis2.axisControlBus) annotation (
      points=[-80,-10; -79,-10; -79,-15; -62.5,-15; -62.5,-45; -25,-45],
      style(
        color=6,
        rgbcolor={255,204,51},
        thickness=2),
      Text(
        string="%first",
        index=-1,
        extent=[-6,3; -6,3],
        style(color=0, rgbcolor={0,0,0})));
    connect(controlBus.axisControlBus3, axis3.axisControlBus) annotation (
      points=[-80,-10; -77,-10; -77,-12.5; -61,-12.5; -61,-25; -25,-25],
      style(
        color=6,
        rgbcolor={255,204,51},
        thickness=2),
      Text(
        string="%first",
        index=-1,
        extent=[-6,3; -6,3],
        style(color=0, rgbcolor={0,0,0})));
    connect(controlBus.axisControlBus4, axis4.axisControlBus) annotation (
      points=[-80,-10; -60.5,-10; -60.5,-5; -25,-5],
      style(
        color=6,
        rgbcolor={255,204,51},
        thickness=2),
      Text(
        string="%first",
        index=-1,
        extent=[-6,3; -6,3],
        style(color=0, rgbcolor={0,0,0})));
    connect(controlBus.axisControlBus5, axis5.axisControlBus) annotation (
      points=[-80,-10; -77,-10; -77,-7; -63,-7; -63,15; -25,15],
      style(
        color=6,
        rgbcolor={255,204,51},
        thickness=2),
      Text(
        string="%first",
        index=-1,
        extent=[-6,3; -6,3],
        style(color=0, rgbcolor={0,0,0})));
    connect(controlBus.axisControlBus6, axis6.axisControlBus) annotation (
      points=[-80,-10; -79,-10; -79,-5; -65,-5; -65,35; -25,35],
      style(
        color=6,
        rgbcolor={255,204,51},
        thickness=2),
      Text(
        string="%first",
        index=-1,
        extent=[-6,3; -6,3],
        style(color=0, rgbcolor={0,0,0})));
  end fullRobot;
  extends Modelica.Icons.Library;
  import SI = Modelica.SIunits;
  
  package Components "Library of components of the robot" 
    extends Modelica.Icons.Library;
    
    expandable connector AxisControlBus "Data bus for one robot axis" 
      extends Modelica.Icons.SignalSubBus;
      
      annotation (defaultComponentPrefixes="protected",
                  Icon(Rectangle(extent=[-20, 2; 22, -2], style(rgbcolor={255,204,51}, thickness=2))), 
        Documentation(info="<html>
<p>
Signal bus that is used to communicate all signals for <b>one</b> axis.
This is an expandable connector which is \"empty\". 
The actual signal content is defined by connecting to an instance
of this connector.
</p>

</html>"));
    end AxisControlBus;
    
    expandable connector ControlBus "Data bus for all axes of robot" 
      extends Modelica.Icons.SignalBus;
      
      annotation (
        Icon(Rectangle(extent=[-20, 2; 22, -2], style(rgbcolor={255,204,51}, thickness=2))),
        Diagram, 
        Documentation(info="<html>
<p>
Signal bus that is used to communicate <b>all signals</b> of the robot.
This is an expandable connector which is \"empty\". 
The actual signal content is defined by connecting to an instance
of this connector. It consists of one instance of the \"AxisControlBus\"
for every axis.
</p>
</html>"));
    end ControlBus;
    
    model PathPlanning1 
      "Generate reference angles for fastest kinematic movement" 
      
      import SI = Modelica.SIunits;
      import Cv = Modelica.SIunits.Conversions;
      parameter Real angleBegDeg(unit="deg") = 0 "start angle";
      parameter Real angleEndDeg(unit="deg") = 1 "end angle";
      parameter SI.AngularVelocity speedMax = 3 "maximum axis speed";
      parameter SI.AngularAcceleration accMax = 2.5 "maximum axis acceleration";
      parameter SI.Time startTime=0 "start time of movement";
      parameter SI.Time swingTime=0.5 
        "additional time after reference motion is in rest before simulation is stopped";
      final parameter SI.Angle angleBeg=Cv.from_deg(angleBegDeg) "start angles";
      final parameter SI.Angle angleEnd=Cv.from_deg(angleEndDeg) "end angles";
      ControlBus controlBus 
        annotation (extent=[80,-20; 120,20], rotation=-90);
      Modelica.Blocks.Sources.KinematicPTP2 path(
        q_end={angleEnd},
        qd_max={speedMax},
        qdd_max={accMax},
        startTime=startTime,
        q_begin={angleBeg}) 
                          annotation (extent=[-50,-10; -30,10]);
      PathToAxisControlBus pathToAxis1(final nAxis=1, final axisUsed=1) 
        annotation (extent=[0,-10; 20,10]);
      
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-100, 100; 100, -100], style(color=0, fillColor=7)),
          Text(extent=[-150, 150; 150, 110], string="%name"),
          Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 88; -80, 90], style(
              color=8,
              fillColor=8,
              fillPattern=1)),
          Line(points=[-80, 78; -80, -82], style(color=8)),
          Line(points=[-90, 0; 82, 0], style(color=8)),
          Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(
              color=8,
              fillColor=8,
              fillPattern=1)),
          Text(
            extent=[-42, 55; 29, 12],
            string="w",
            style(color=8)),
          Line(points=[-80, 0; -41, 69; 26, 69; 58, 0], style(color=0)),
          Text(
            extent=[-73,-44; 82,-69],
            string="1 axis",
            style(color=0, rgbcolor={0,0,0}))),
        Window(
          x=0.03,
          y=0,
          width=0.88,
          height=0.79),
        Documentation(info="<html>
<p>
Given
</p>
<ul>
<li> start and end angle of an axis</li>
<li> maximum speed of the axis </li>
<li> maximum acceleration of the axis </li>
</ul>

<p>
this component computes the fastest movement under the
given constraints. This means, that:
</p>

<ol>
<li> The axis accelerates with the maximum acceleration
     until the maximum speed is reached.</li>
<li> Drives with the maximum speed as long as possible.</li>
<li> Decelerates with the negative of the maximum acceleration
     until rest.</li>
</ol>

<p>
The acceleration, constant velocity and deceleration
phase are determined in such a way that the movement
starts form the start angles and ends at the end angles.
The output of this block are the computed angles, angular velocities
and angular acceleration and this information is stored as reference
motion on the controlBus of the r3 robot.
</p>

</html>
"),     Diagram);
      
      Blocks.Logical.TerminateSimulation terminateSimulation(condition=time >= path.endTime
             + swingTime) annotation (extent=[-50,-30; 30,-24]);
    equation 
      connect(path.q, pathToAxis1.q)         annotation (points=[-29,8; -2,8],
                             style(color=74, rgbcolor={0,0,127}));
      connect(path.qd, pathToAxis1.qd)         annotation (points=[-29,3; -2,3],
                             style(color=74, rgbcolor={0,0,127}));
      connect(path.qdd, pathToAxis1.qdd)         annotation (points=[-29,-3; -2,
            -3],                  style(color=74, rgbcolor={0,0,127}));
      connect(path.moving, pathToAxis1.moving)             annotation (points=[-29,-8;
            -2,-8],                        style(color=5, rgbcolor={255,0,255}));
      connect(pathToAxis1.axisControlBus, controlBus.axisControlBus1) annotation (
        points=[20,0; 100,0],
        style(
          color=6,
          rgbcolor={255,204,51},
          thickness=2),
        Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3],
          style(color=0, rgbcolor={0,0,0})));
    end PathPlanning1;
    
    model PathPlanning6 
      "Generate reference angles for fastest kinematic movement" 
      
      import SI = Modelica.SIunits;
      import Cv = Modelica.SIunits.Conversions;
      parameter Integer naxis=6 "number of driven axis";
      parameter Real angleBegDeg[naxis](unit="deg") = zeros(naxis) 
        "start angles";
      parameter Real angleEndDeg[naxis](unit="deg") = ones(naxis) "end angles";
      parameter SI.AngularVelocity speedMax[naxis]=fill(3, naxis) 
        "maximum axis speed";
      parameter SI.AngularAcceleration accMax[naxis]=fill(2.5, naxis) 
        "maximum axis acceleration";
      parameter SI.Time startTime=0 "start time of movement";
      parameter SI.Time swingTime=0.5 
        "additional time after reference motion is in rest before simulation is stopped";
      final parameter SI.Angle angleBeg[:]=Cv.from_deg(angleBegDeg) 
        "start angles";
      final parameter SI.Angle angleEnd[:]=Cv.from_deg(angleEndDeg) 
        "end angles";
      ControlBus controlBus 
        annotation (extent=[80,-20; 120,20], rotation=-90);
      Modelica.Blocks.Sources.KinematicPTP2 path(
        q_end=angleEnd,
        qd_max=speedMax,
        qdd_max=accMax,
        startTime=startTime,
        q_begin=angleBeg) annotation (extent=[-90,-80; -70,-60]);
      PathToAxisControlBus pathToAxis1(nAxis=naxis, axisUsed=1) 
        annotation (extent=[-10,70; 10,90]);
      PathToAxisControlBus pathToAxis2(nAxis=naxis, axisUsed=2) 
        annotation (extent=[-10,40; 10,60]);
      PathToAxisControlBus pathToAxis3(nAxis=naxis, axisUsed=3) 
        annotation (extent=[-10,10; 10,30]);
      PathToAxisControlBus pathToAxis4(nAxis=naxis, axisUsed=4) 
        annotation (extent=[-10,-20; 10,0]);
      PathToAxisControlBus pathToAxis5(nAxis=naxis, axisUsed=5) 
        annotation (extent=[-10,-50; 10,-30]);
      PathToAxisControlBus pathToAxis6(nAxis=naxis, axisUsed=6) 
        annotation (extent=[-10,-80; 10,-60]);
      
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Icon(
          Rectangle(extent=[-100, 100; 100, -100], style(color=0, fillColor=7)),
          Text(extent=[-150, 150; 150, 110], string="%name"),
          Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 88; -80, 90], style(
              color=8,
              fillColor=8,
              fillPattern=1)),
          Line(points=[-80, 78; -80, -82], style(color=8)),
          Line(points=[-90, 0; 82, 0], style(color=8)),
          Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(
              color=8,
              fillColor=8,
              fillPattern=1)),
          Text(
            extent=[-42, 55; 29, 12],
            string="w",
            style(color=8)),
          Line(points=[-80, 0; -41, 69; 26, 69; 58, 0], style(color=0)),
          Text(
            extent=[-70,-43; 85,-68],
            style(color=0, rgbcolor={0,0,0}),
            string="6 axes")),
        Window(
          x=0.03,
          y=0,
          width=0.88,
          height=0.79),
        Documentation(info="<html>
<p>
Given
</p>
<ul>
<li> start and end angles of every axis</li>
<li> maximum speed of every axis </li>
<li> maximum acceleration of every axis </li>
</ul>

<p>
this component computes the fastest movement under the
given constraints. This means, that:
</p>

<ol>
<li> Every axis accelerates with the maximum acceleration
     until the maximum speed is reached.</li>
<li> Drives with the maximum speed as long as possible.</li>
<li> Decelerates with the negative of the maximum acceleration
     until rest.</li>
</ol>

<p>
The acceleration, constant velocity and deceleration
phase are determined in such a way that the movement
starts form the start angles and ends at the end angles.
The output of this block are the computed angles, angular velocities
and angular acceleration and this information is stored as reference
motion on the controlBus of the r3 robot.
</p>

</html>"),
        Diagram);
      
      Blocks.Logical.TerminateSimulation terminateSimulation(condition=time >= path.endTime
             + swingTime) annotation (extent=[-50,-100; 30,-94]);
    equation 
      connect(path.q, pathToAxis1.q)         annotation (points=[-69,-62; -60,-62;
            -60,88; -12,88], style(color=74, rgbcolor={0,0,127}));
      connect(path.qd, pathToAxis1.qd)         annotation (points=[-69,-67; -59,-67;
            -59,83; -12,83], style(color=74, rgbcolor={0,0,127}));
      connect(path.qdd, pathToAxis1.qdd)         annotation (points=[-69,-73; -58,
            -73; -58,77; -12,77], style(color=74, rgbcolor={0,0,127}));
      connect(path.moving, pathToAxis1.moving)             annotation (points=[-69,
            -78; -57,-78; -57,72; -12,72], style(color=5, rgbcolor={255,0,255}));
      connect(path.q, pathToAxis2.q)         annotation (points=[-69,-62; -60,-62;
            -60,58; -12,58], style(color=74, rgbcolor={0,0,127}));
      connect(path.qd, pathToAxis2.qd)         annotation (points=[-69,-67; -59,-67;
            -59,53; -12,53], style(color=74, rgbcolor={0,0,127}));
      connect(path.qdd, pathToAxis2.qdd)         annotation (points=[-69,-73; -58,
            -73; -58,47; -12,47], style(color=74, rgbcolor={0,0,127}));
      connect(path.moving, pathToAxis2.moving)             annotation (points=[-69,
            -78; -57,-78; -57,42; -12,42], style(color=5, rgbcolor={255,0,255}));
      connect(path.q, pathToAxis3.q)         annotation (points=[-69,-62; -60,-62;
            -60,28; -12,28], style(color=74, rgbcolor={0,0,127}));
      connect(path.qd, pathToAxis3.qd)         annotation (points=[-69,-67; -59,-67;
            -59,23; -12,23], style(color=74, rgbcolor={0,0,127}));
      connect(path.qdd, pathToAxis3.qdd)         annotation (points=[-69,-73; -58,
            -73; -58,17; -12,17], style(color=74, rgbcolor={0,0,127}));
      connect(path.moving, pathToAxis3.moving)             annotation (points=[-69,
            -78; -57,-78; -57,12; -12,12], style(color=5, rgbcolor={255,0,255}));
      connect(path.q, pathToAxis4.q)         annotation (points=[-69,-62; -60,-62;
            -60,-2; -12,-2], style(color=74, rgbcolor={0,0,127}));
      connect(path.qd, pathToAxis4.qd)         annotation (points=[-69,-67; -59,-67;
            -59,-7; -12,-7], style(color=74, rgbcolor={0,0,127}));
      connect(path.qdd, pathToAxis4.qdd)         annotation (points=[-69,-73; -58,
            -73; -58,-13; -12,-13], style(color=74, rgbcolor={0,0,127}));
      connect(path.moving, pathToAxis4.moving)             annotation (points=[-69,
            -78; -57,-78; -57,-18; -12,-18], style(color=5, rgbcolor={255,0,255}));
      connect(path.q, pathToAxis5.q)         annotation (points=[-69,-62; -60,-62;
            -60,-32; -12,-32], style(color=74, rgbcolor={0,0,127}));
      connect(path.qd, pathToAxis5.qd)         annotation (points=[-69,-67; -59,-67;
            -59,-37; -12,-37], style(color=74, rgbcolor={0,0,127}));
      connect(path.qdd, pathToAxis5.qdd)         annotation (points=[-69,-73; -58,
            -73; -58,-43; -12,-43], style(color=74, rgbcolor={0,0,127}));
      connect(path.moving, pathToAxis5.moving)             annotation (points=[-69,
            -78; -57,-78; -57,-48; -12,-48], style(color=5, rgbcolor={255,0,255}));
      connect(path.q, pathToAxis6.q)         annotation (points=[-69,-62; -12,-62],
          style(color=74, rgbcolor={0,0,127}));
      connect(path.qd, pathToAxis6.qd)         annotation (points=[-69,-67; -12,
            -67],                     style(color=74, rgbcolor={0,0,127}));
      connect(path.qdd, pathToAxis6.qdd)         annotation (points=[-69,-73;
            -12,-73],               style(color=74, rgbcolor={0,0,127}));
      connect(path.moving, pathToAxis6.moving)             annotation (points=[-69,
            -78; -12,-78], style(color=5, rgbcolor={255,0,255}));
      connect(pathToAxis1.axisControlBus, controlBus.axisControlBus1) annotation (
        points=[10,80; 80,80; 80,7; 98,7],
        style(
          color=6,
          rgbcolor={255,204,51},
          thickness=2),
        Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3],
          style(color=0, rgbcolor={0,0,0})));
      connect(pathToAxis2.axisControlBus, controlBus.axisControlBus2) annotation (
        points=[10,50; 77,50; 77,5; 97,5],
        style(
          color=6,
          rgbcolor={255,204,51},
          thickness=2),
        Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3],
          style(color=0, rgbcolor={0,0,0})));
      connect(pathToAxis3.axisControlBus, controlBus.axisControlBus3) annotation (
        points=[10,20; 75,20; 75,3; 96,3],
        style(
          color=6,
          rgbcolor={255,204,51},
          thickness=2),
        Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3],
          style(color=0, rgbcolor={0,0,0})));
      connect(pathToAxis4.axisControlBus, controlBus.axisControlBus4) annotation (
        points=[10,-10; 73,-10; 73,0; 100,0],
        style(
          color=6,
          rgbcolor={255,204,51},
          thickness=2),
        Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3],
          style(color=0, rgbcolor={0,0,0})));
      connect(pathToAxis5.axisControlBus, controlBus.axisControlBus5) annotation (
        points=[10,-40; 75,-40; 75,-3; 100,-3; 100,0],
        style(
          color=6,
          rgbcolor={255,204,51},
          thickness=2),
        Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3],
          style(color=0, rgbcolor={0,0,0})));
      connect(pathToAxis6.axisControlBus, controlBus.axisControlBus6) annotation (
        points=[10,-70; 78,-70; 78,-6; 98,-6],
        style(
          color=6,
          rgbcolor={255,204,51},
          thickness=2),
        Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3],
          style(color=0, rgbcolor={0,0,0})));
    end PathPlanning6;
    
    model PathToAxisControlBus "Map path planning to one axis control bus" 
      extends Blocks.Interfaces.BlockIcon;
      
      parameter Integer nAxis=6 "Number of driven axis";
      parameter Integer axisUsed=1 
        "Map path planning of axisUsed to axisControlBus";
      Blocks.Interfaces.RealInput q[nAxis] 
        annotation (extent=[-140,60; -100,100]);
      Blocks.Interfaces.RealInput qd[nAxis] 
        annotation (extent=[-140,10; -100,50]);
      Blocks.Interfaces.RealInput qdd[nAxis] 
        annotation (extent=[-140,-50; -100,-10]);
      AxisControlBus axisControlBus 
        annotation (extent=[80,-20; 120,20], rotation=-90);
      Blocks.Routing.RealPassThrough q_axisUsed(y(redeclare type SignalType = 
              Modelica.SIunits.Angle)) 
        annotation (extent=[-40,50; -20,70]);
      Blocks.Routing.RealPassThrough qd_axisUsed(y(redeclare type SignalType = 
              Modelica.SIunits.AngularVelocity)) 
        annotation (extent=[-40,10; -20,30]);
      Blocks.Routing.RealPassThrough qdd_axisUsed(y(redeclare type SignalType 
            = Modelica.SIunits.AngularAcceleration)) 
        annotation (extent=[-40,-30; -20,-10]);
      Blocks.Interfaces.BooleanInput moving[nAxis] 
        annotation (extent=[-140,-100; -100,-60]);
      Blocks.Routing.BooleanPassThrough motion_ref_axisUsed 
        annotation (extent=[-40,-70; -20,-50]);
      annotation (defaultComponentName="pathToAxis1",
        Diagram,
        Icon(
          Text(
            extent=[-100,98; -24,68],
            string="q",
            style(color=0, rgbcolor={0,0,0})),
          Text(
            extent=[-94,46; -18,16],
            style(color=0, rgbcolor={0,0,0}),
            string="qd"),
          Text(
            extent=[-96,-16; -20,-46],
            style(color=0, rgbcolor={0,0,0}),
            string="qdd"),
          Text(
            extent=[-2,20; 80,-18],
            style(color=0, rgbcolor={0,0,0}),
            string="%axisUsed"),
          Text(
            extent=[2,52; 76,28],
            style(color=0, rgbcolor={0,0,0}),
            string="axis"),
          Text(
            extent=[-94,-70; 32,-96],
            style(color=0, rgbcolor={0,0,0}),
            string="moving")),
        Coordsys(scale=0.1, grid=[2,2]));
    equation 
      connect(q_axisUsed.u, q[axisUsed]) annotation (points=[-42,60; -60,60; -60,80;
            -120,80],
          style(color=74, rgbcolor={0,0,127}));
      connect(qd_axisUsed.u, qd[axisUsed]) annotation (points=[-42,20; -80,20; -80,
            30; -120,30],
          style(color=74, rgbcolor={0,0,127}));
      connect(qdd_axisUsed.u, qdd[axisUsed]) annotation (points=[-42,-20; -80,
            -20; -80,-30; -120,-30],
                  style(color=74, rgbcolor={0,0,127}));
      connect(motion_ref_axisUsed.u, moving[axisUsed])     annotation (points=[-42,-60;
            -60,-60; -60,-80; -120,-80],
                            style(color=5, rgbcolor={255,0,255}));
      connect(motion_ref_axisUsed.y, axisControlBus.motion_ref) annotation (
        points=[-19,-60; 44,-60; 44,-8; 102,-8; 102,0; 100,0],
        style(color=5, rgbcolor={255,0,255}),
        Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3],
          style(color=0, rgbcolor={0,0,0})));
      connect(qdd_axisUsed.y, axisControlBus.acceleration_ref) annotation (
        points=[-19,-20; 40,-20; 40,-4; 98,-4; 98,0; 100,0],
        style(color=74, rgbcolor={0,0,127}),
        Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3],
          style(color=0, rgbcolor={0,0,0})));
      connect(qd_axisUsed.y, axisControlBus.speed_ref) annotation (
        points=[-19,20; 20,20; 20,0; 100,0],
        style(color=74, rgbcolor={0,0,127}),
        Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3],
          style(color=0, rgbcolor={0,0,0})));
      connect(q_axisUsed.y, axisControlBus.angle_ref) annotation (
        points=[-19,60; 40,60; 40,4; 96,4],
        style(color=74, rgbcolor={0,0,127}),
        Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3],
          style(color=0, rgbcolor={0,0,0})));
    end PathToAxisControlBus;
    
    model GearType1 "Motor inertia and gearbox model for r3 joints 1,2,3 " 
      extends Modelica.Mechanics.Rotational.Interfaces.TwoFlanges;
      parameter Real i=-105 "gear ratio";
      parameter Real c(unit="N.m/rad") = 43 "spring constant";
      parameter Real d(unit="N.m.s/rad") = 0.005 "damper constant";
      parameter SI.Torque Rv0=0.4 "viscous friction torque at zero velocity";
      parameter Real Rv1(unit="N.m.s/rad") = (0.13/160) 
        "viscous friction coefficient (R=Rv0+Rv1*abs(qd))";
      parameter Real peak=1 
        "peak*Rv0 = maximum static friction torque (peak >= 1)";
      SI.AngularAcceleration a_rel=der(spring.w_rel) 
        "Relative angular acceleration of spring";
      constant SI.AngularVelocity unitAngularVelocity = 1;
      constant SI.Torque unitTorque = 1;
      
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.22,
          y=0,
          width=0.71,
          height=0.71),
        Documentation(info="
Models the gearbox used in the first three joints with all its effects,
like elasticity and friction.
Coulomb friction is approximated by a friction element acting
at the \"motor\"-side. In reality, bearing friction should be
also incorporated at the driven side of the gearbox. However,
this would require considerable more effort for the measurement
of the friction parameters.
Default values for all parameters are given for joint 1.
Model relativeStates is used to define the relative angle
and relative angular velocity across the spring (=gear elasticity)
as state variables. The reason is, that a default initial
value of zero of these states makes always sense.
If the absolute angle and the absolute angular velocity of model
Jmotor would be used as states, and the load angle (= joint angle of
robot) is NOT zero, one has always to ensure that the initial values
of the motor angle and of the joint angle are modified correspondingly.
Otherwise, the spring has an unrealistic deflection at initial time.
Since relative quantities are used as state variables, this simplifies
the definition of initial values considerably.
"),     Icon(
          Rectangle(extent=[-100,10; -60,-10],  style(
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Polygon(points=[-60, 10; -60, 20; -40, 40; -40, -40; -60, -20; -60,
                10], style(
              color=10,
              gradient=2,
              fillColor=10,
              fillPattern=1)),
          Rectangle(extent=[-40, 60; 40, -60], style(
              color=3,
              pattern=1,
              thickness=1,
              gradient=2,
              arrow=0,
              fillColor=8,
              fillPattern=1)),
          Polygon(points=[60, 20; 40, 40; 40, -40; 60, -20; 60, 20], style(
              color=10,
              fillColor=10,
              fillPattern=1)),
          Rectangle(extent=[60,10; 100,-10],  style(
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Polygon(points=[-60, -90; -50, -90; -20, -30; 20, -30; 48, -90; 60, -90;
                 60, -100; -60, -100; -60, -90], style(
              color=0,
              fillColor=0,
              fillPattern=1)),
          Text(extent=[0, 128; 0, 68], string="%name"),
          Text(extent=[-36, 40; 36, -30], string="1")),
        Diagram(Text(
            extent=[72, 30; 130, 22],
            string="flange of joint axis",
            style(color=0)), Text(
            extent=[-128, 26; -70, 18],
            string="flange of motor axis",
            style(color=0))));
      
      Modelica.Mechanics.Rotational.IdealGear gear(ratio=i) 
        annotation (extent=[50, -10; 70, 10]);
      Modelica.Mechanics.Rotational.SpringDamper spring(c=c, d=d) 
        annotation (extent=[0, -10; 20, 10]);
      Modelica.Mechanics.Rotational.BearingFriction bearingFriction(tau_pos=[0,
             Rv0/unitTorque; 1, (Rv0 + Rv1*unitAngularVelocity)/unitTorque]) annotation (extent=[-60, -10; -40, 10]);
    equation 
      connect(spring.flange_b, gear.flange_a) 
        annotation (points=[20, 0; 50, 0], style(color=10, thickness=2));
      connect(bearingFriction.flange_b, spring.flange_a) 
        annotation (points=[-40, 0; 0, 0], style(color=10, thickness=2));
      connect(gear.flange_b, flange_b) 
        annotation (points=[70, 0; 100, 0], style(color=10, thickness=2));
      connect(bearingFriction.flange_a, flange_a) 
        annotation (points=[-60, 0; -100, 0], style(color=10, thickness=2));
    initial equation 
      spring.w_rel = 0;
      a_rel = 0;
    end GearType1;
    
    model GearType2 "Motor inertia and gearbox model for r3 joints 4,5,6  " 
      extends Modelica.Mechanics.Rotational.Interfaces.TwoFlanges;
      parameter Real i=-99 "gear ratio";
      parameter SI.Torque Rv0=21.8 "viscous friction torque at zero velocity";
      parameter Real Rv1=9.8 
        "viscous friction coefficient in [Nms/rad] (R=Rv0+Rv1*abs(qd))";
      parameter Real peak=(26.7/21.8) 
        "peak*Rv0 = maximum static friction torque (peak >= 1)";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.13,
          y=0.27,
          width=0.63,
          height=0.63),
        Documentation(info="The elasticity and damping in the gearboxes of the outermost
three joints of the robot is neglected.
Default values for all parameters are given for joint 4.
"),     Icon(
          Rectangle(extent=[-100,10; -60,-10],  style(
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Polygon(points=[-60, 10; -60, 20; -40, 40; -40, -40; -60, -20; -60,
                10], style(
              color=10,
              gradient=2,
              fillColor=10,
              fillPattern=1)),
          Rectangle(extent=[-40, 60; 40, -60], style(
              color=3,
              pattern=1,
              thickness=1,
              gradient=2,
              arrow=0,
              fillColor=8,
              fillPattern=1)),
          Polygon(points=[60, 20; 40, 40; 40, -40; 60, -20; 60, 20], style(
              color=10,
              fillColor=10,
              fillPattern=1)),
          Rectangle(extent=[60,10; 100,-10],  style(
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Polygon(points=[-60, -90; -50, -90; -20, -30; 20, -30; 48, -90; 60, -90;
                 60, -100; -60, -100; -60, -90], style(
              color=0,
              fillColor=0,
              fillPattern=1)),
          Text(extent=[0, 128; 0, 68], string="%name"),
          Text(extent=[-36, 40; 38, -30], string="2")),
        Diagram);
      
      constant SI.AngularVelocity unitAngularVelocity = 1;
      constant SI.Torque unitTorque = 1;
      Modelica.Mechanics.Rotational.IdealGear gear(ratio=i) 
        annotation (extent=[-28, -10; -8, 10]);
      Modelica.Mechanics.Rotational.BearingFriction bearingFriction(tau_pos=[0,
             Rv0/unitTorque; 1, (Rv0 + Rv1*unitAngularVelocity)/unitTorque], peak=peak) 
        annotation (extent=[30, -10; 50, 10]);
    equation 
      connect(gear.flange_b, bearingFriction.flange_a) 
        annotation (points=[-8, 0; 30, 0], style(color=10, thickness=2));
      connect(bearingFriction.flange_b, flange_b) 
        annotation (points=[50, 0; 100, 0], style(color=10, thickness=2));
      connect(gear.flange_a, flange_a) 
        annotation (points=[-28, 0; -100, 0], style(color=10, thickness=2));
    end GearType2;
    
    model Motor "Motor model including current controller of r3 motors " 
      extends Modelica.Icons.MotorIcon;
      parameter SI.Inertia J(min=0)=0.0013 "moment of inertia of motor";
      parameter Real k=1.1616 "gain of motor";
      parameter Real w=4590 "time constant of motor";
      parameter Real D=0.6 "damping constant of motor";
      parameter SI.AngularVelocity w_max=315 "maximum speed of motor";
      parameter SI.Current i_max=9 "maximum current of motor";
      
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.03,
          y=0.04,
          width=0.68,
          height=0.8),
        Documentation(info=" Default values are given for the motor of joint 1.
The input of the motor is the desired current
(the actual current is proportional to the torque
produced by the motor).
"),     Icon(Text(extent=[0, 120; 0, 60], string="%name"), Line(points=[80, -102;
                 80, -10], style(
              rgbcolor={255,204,51},
              thickness=2))),
        Diagram);
      
      Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_motor 
        annotation (extent=[90, -10; 110, 10]);
      Modelica.Electrical.Analog.Sources.SignalVoltage Vs 
        annotation (extent=[-80, -10; -100, 10], rotation=-90);
      Modelica.Electrical.Analog.Ideal.IdealOpAmp diff 
        annotation (extent=[-64, 15; -44, 35]);
      Modelica.Electrical.Analog.Ideal.IdealOpAmp power 
        annotation (extent=[16, 15; 36, 35]);
      Modelica.Electrical.Analog.Basic.EMF emf(k=k) 
        annotation (extent=[46, -10; 66, 10]);
      Modelica.Electrical.Analog.Basic.Inductor La(L=(250/(2*D*w))) 
        annotation (extent=[46, 20; 66, 40], rotation=-90);
      Modelica.Electrical.Analog.Basic.Resistor Ra(R=250) 
        annotation (extent=[46, 50; 66, 70], rotation=-90);
      Modelica.Electrical.Analog.Basic.Resistor Rd2(R=100) 
        annotation (extent=[-86, 22; -71, 38]);
      Modelica.Electrical.Analog.Basic.Capacitor C(C=0.004*D/w) 
        annotation (extent=[-14, 36; 6, 56]);
      Modelica.Electrical.Analog.Ideal.IdealOpAmp OpI 
        annotation (extent=[-14, 10; 6, 30]);
      Modelica.Electrical.Analog.Basic.Resistor Rd1(R=100) 
        annotation (extent=[-63, 37; -48, 53]);
      Modelica.Electrical.Analog.Basic.Resistor Ri(R=10) 
        annotation (extent=[-37, 17; -22, 33]);
      Modelica.Electrical.Analog.Basic.Resistor Rp1(R=200) 
        annotation (extent=[17, 38; 32, 54]);
      Modelica.Electrical.Analog.Basic.Resistor Rp2(R=50) 
        annotation (extent=[4, 64; 18, 80], rotation=90);
      Modelica.Electrical.Analog.Basic.Resistor Rd4(R=100) 
        annotation (extent=[-55, -15; -40, 1]);
      Modelica.Electrical.Analog.Sources.SignalVoltage hall2 
        annotation (extent=[-60,-40; -80,-60],   rotation=90);
      Modelica.Electrical.Analog.Basic.Resistor Rd3(R=100) 
        annotation (extent=[-77,-30; -63,-14],   rotation=90);
      Modelica.Electrical.Analog.Basic.Ground g1 
        annotation (extent=[-100, -37; -80, -17]);
      Modelica.Electrical.Analog.Basic.Ground g2 
        annotation (extent=[-80,-91; -60,-71]);
      Modelica.Electrical.Analog.Basic.Ground g3 
        annotation (extent=[-34, -27; -14, -7]);
      Modelica.Electrical.Analog.Sensors.CurrentSensor hall1 
        annotation (extent=[6, -60; 26, -40], rotation=-90);
      Modelica.Electrical.Analog.Basic.Ground g4 
        annotation (extent=[6, -84; 26, -64]);
      Modelica.Electrical.Analog.Basic.Ground g5 
        annotation (extent=[1, 83; 21, 103], rotation=180);
      Modelica.Mechanics.Rotational.Sensors.AngleSensor phi 
        annotation (extent=[66, -49; 86, -29], rotation=-90);
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor speed 
        annotation (extent=[45, -50; 65, -30], rotation=-90);
      Modelica.Mechanics.Rotational.Inertia Jmotor(J=J) 
        annotation (extent=[70, -10; 90, 10]);
      Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.AxisControlBus
        axisControlBus 
        annotation (extent=[60,-120; 100,-80],   rotation=0);
      Blocks.Math.Gain convert1 annotation(extent=[-30,-56; -42,-44]);
      Blocks.Math.Gain convert2 annotation(extent=[-30,-101; -42,-89]);
    equation 
      connect(La.n, emf.p) annotation (points=[56, 20; 56, 10]);
      connect(Ra.n, La.p) annotation (points=[56, 50; 56, 40]);
      connect(Rd2.n, diff.n1) annotation (points=[-71, 30; -64, 30]);
      connect(C.n, OpI.p2) annotation (points=[6, 46; 6, 20]);
      connect(OpI.p2, power.p1) annotation (points=[6, 20; 16, 20]);
      connect(Vs.p, Rd2.p) annotation (points=[-90, 10; -90, 30; -86, 30]);
      connect(diff.n1, Rd1.p) 
        annotation (points=[-64, 30; -68, 30; -68, 45; -63, 45]);
      connect(Rd1.n, diff.p2) annotation (points=[-48, 45; -44, 45; -44, 25]);
      connect(diff.p2, Ri.p) annotation (points=[-44, 25; -37, 25]);
      connect(Ri.n, OpI.n1) annotation (points=[-22, 25; -14, 25]);
      connect(OpI.n1, C.p) annotation (points=[-14, 25; -14, 46]);
      connect(power.n1, Rp1.p) 
        annotation (points=[16, 30; 11, 30; 11, 46; 17, 46]);
      connect(power.p2, Rp1.n) annotation (points=[36, 25; 36, 46; 32, 46]);
      connect(Rp1.p, Rp2.p) annotation (points=[17, 46; 11, 46; 11, 64]);
      connect(power.p2, Ra.p) 
        annotation (points=[36, 25; 42, 25; 42, 80; 56, 80; 56, 70]);
      connect(Rd3.p, hall2.p) annotation (points=[-70,-30; -70,-40]);
      connect(Rd3.n, diff.p1) annotation (points=[-70,-14; -70,20; -64,20]);
      connect(Rd3.n, Rd4.p) annotation (points=[-70,-14; -70,-7; -55,-7]);
      connect(Vs.n, g1.p) annotation (points=[-90, -10; -90, -17]);
      connect(g2.p, hall2.n) annotation (points=[-70,-71; -70,-60]);
      connect(Rd4.n, g3.p) annotation (points=[-40, -7; -24, -7]);
      connect(g3.p, OpI.p1) annotation (points=[-24, -7; -24, 15; -14, 15]);
      connect(g5.p, Rp2.n) 
        annotation (points=[11,83; 11,81.5; 11,81.5; 11,80]);
      connect(emf.n, hall1.p) 
        annotation (points=[56, -10; 56, -24; 16, -24; 16, -40]);
      connect(hall1.n, g4.p) annotation (points=[16, -60; 16, -64]);
      connect(emf.flange_b, phi.flange_a) 
        annotation (points=[66, 0; 66, -29; 76, -29], style(pattern=3));
      connect(emf.flange_b, speed.flange_a) 
        annotation (points=[66, 0; 66, -30; 55, -30], style(pattern=3));
      connect(OpI.n2, power.n2) 
        annotation (points=[-4, 10; -4, 4; 26, 4; 26, 15]);
      connect(OpI.p1, OpI.n2) annotation (points=[-14, 15; -14, 10; -4, 10]);
      connect(OpI.p1, diff.n2) annotation (points=[-14, 15; -54, 15]);
      connect(Jmotor.flange_a, emf.flange_b) 
        annotation (points=[70, 0; 66, 0], style(color=10, thickness=2));
      connect(Jmotor.flange_b, flange_motor) 
        annotation (points=[90, 0; 100, 0], style(color=10, thickness=2));
    initial equation 
      // initialize motor in steady state
      der(C.v) = 0;
      der(La.i) = 0;
      
    equation 
      connect(phi.phi, axisControlBus.motorAngle) 
                                       annotation(points=[76,-50; 76,-100; 80,-100], style(
            color=74, rgbcolor={0,0,127}));
      connect(speed.w, axisControlBus.motorSpeed) 
                                       annotation(points=[55,-51; 55,-95; 80,-95;
            80,-100], style(color=74, rgbcolor={0,0,127}));
      connect(hall1.i, axisControlBus.current) 
                                    annotation(points=[6,-50; -10,-50; -10,-95; 80,
            -95; 80,-100], style(color=74, rgbcolor={0,0,127}));
      connect(hall1.i, convert1.u) annotation(points=[6,-50; -28.8,-50], style(
            color=74, rgbcolor={0,0,127}));
      connect(convert1.y, hall2.v) annotation(points=[-42.6,-50; -63,-50],
          style(color=74, rgbcolor={0,0,127}));
      connect(convert2.u, axisControlBus.current_ref) 
                                           annotation(points=[-28.8,-95; 80,-95; 80,
            -100], style(color=74, rgbcolor={0,0,127}));
      connect(convert2.y, Vs.v) annotation(points=[-42.6,-95; -108,-95; -108,
            4.28626e-016; -97,4.28626e-016], style(color=74, rgbcolor={0,0,127}));
    end Motor;
    
    model Controller "P-PI cascade controller for one axis" 
      parameter Real kp=10 "gain of position controller";
      parameter Real ks=1 "gain of speed controller";
      parameter SI.Time Ts=0.01 
        "time constant of integrator of speed controller";
      parameter Real ratio=1 "gear ratio of gearbox";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Diagram,
        Icon(
          Rectangle(extent=[-100, -100; 100, 100], style(
              color=3,
              pattern=1,
              thickness=1,
              gradient=0,
              arrow=0,
              fillColor=30,
              fillPattern=1)),
          Rectangle(extent=[-30, 54; 30, 24], style(fillColor=7,
                fillPattern =                                                1)),
          Polygon(points=[-30, 40; -60, 50; -60, 30; -30, 40], style(
              color=3,
              fillColor=3,
              fillPattern=1)),
          Line(points=[-31, -41; -78, -41; -78, 39; -30, 39]),
          Rectangle(extent=[-30, -26; 30, -56], style(fillColor=7,
                fillPattern=
                  1)),
          Polygon(points=[60, -32; 30, -42; 60, -52; 60, -32], style(fillColor=
                  3, fillPattern=1)),
          Line(points=[30, 39; 76, 39; 76, -41; 30, -41]),
          Text(extent=[-100, 150; 100, 110], string="%name")),
        Window(
          x=0.01,
          y=0.01,
          width=0.84,
          height=0.76), 
        Documentation(info="<html>
<p>
This controller has an inner PI-controller to control the motor speed,
and an outer P-controller to control the motor position of one axis. 
The reference signals are with respect to the gear-output, and the
gear ratio is used in the controller to determine the motor
reference signals. All signals are communicated via the 
\"axisControlBus\".
</p>
</html>"));
      
      Modelica.Blocks.Math.Gain gain1(k=ratio) 
        annotation (extent=[-70,0; -50,20]);
      Modelica.Blocks.Continuous.PI PI(k=ks, T=Ts,
        y(redeclare type SignalType = Modelica.SIunits.Current)) 
        annotation (extent=[60, 0; 80, 20], rotation=0);
      Modelica.Blocks.Math.Feedback feedback1 
        annotation (extent=[-46, 0; -26, 20]);
      Modelica.Blocks.Math.Gain P(k=kp) annotation (extent=[-16, 0; 4, 20]);
      Modelica.Blocks.Math.Add3 add3(k3=-1) annotation (extent=[20, 0; 40, 20]);
      Modelica.Blocks.Math.Gain gain2(k=ratio) 
        annotation (extent=[-60, 40; -40, 60]);
      Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.AxisControlBus
        axisControlBus 
        annotation (extent=[-20,-120; 20,-80],    rotation=0);
    equation 
      connect(gain1.y, feedback1.u1) 
        annotation (points=[-49,10; -44,10], style(color=74, rgbcolor={0,0,127}));
      connect(feedback1.y, P.u) 
        annotation (points=[-27, 10; -18, 10], style(color=74, rgbcolor={0,0,
              127}));
      connect(P.y, add3.u2) annotation (points=[5, 10; 18, 10], style(color=74,
            rgbcolor={0,0,127}));
      connect(gain2.y, add3.u1) 
        annotation (points=[-39, 50; 10, 50; 10, 18; 18, 18], style(color=74,
            rgbcolor={0,0,127}));
      connect(add3.y, PI.u) 
        annotation (points=[41, 10; 58, 10], style(color=74, rgbcolor={0,0,127}));
      connect(gain2.u, axisControlBus.speed_ref) 
                                      annotation(points=[-62,50; -90,50; -90,
            -100; 0,-100], style(color=74, rgbcolor={0,0,127}));
      connect(gain1.u, axisControlBus.angle_ref) 
                                      annotation(points=[-72,10; -80,10; -80,
            -100; 0,-100], style(color=74, rgbcolor={0,0,127}));
      connect(feedback1.u2, axisControlBus.motorAngle) 
                                            annotation(points=[-36,2; -36,-100;
            0,-100], style(color=74, rgbcolor={0,0,127}));
      connect(add3.u3, axisControlBus.motorSpeed) 
                                       annotation(points=[18,2; 0,2; 0,-100],
          style(color=74, rgbcolor={0,0,127}));
      connect(PI.y, axisControlBus.current_ref) 
                                     annotation(points=[81,10; 90,10; 90,-100;
            0,-100], style(color=74, rgbcolor={0,0,127}));
    end Controller;
    
    model AxisType1 "Axis model of the r3 joints 1,2,3 " 
      extends AxisType2(redeclare GearType1 gear(c=c, d=cd));
      parameter Real c(unit="N.m/rad") = 43 " spring constant" 
        annotation (Dialog(group="Gear"));
      parameter Real cd(unit="N.m.s/rad") = 0.005 " damper constant" 
        annotation (Dialog(group="Gear"));
    end AxisType1;
    
    model AxisType2 "Axis model of the r3 joints 4,5,6 " 
      parameter Real kp=10 " gain of position controller" 
        annotation (Dialog(group="Controller"));
      parameter Real ks=1 " gain of speed controller" 
        annotation (Dialog(group="Controller"));
      parameter SI.Time Ts=0.01 
        " time constant of integrator of speed controller" 
        annotation (Dialog(group="Controller"));
      parameter Real k=1.1616 " gain of motor" 
        annotation (Dialog(group="Motor"));
      parameter Real w=4590 " time constant of motor" 
        annotation (Dialog(group="Motor"));
      parameter Real D=0.6 " damping constant of motor" 
        annotation (Dialog(group="Motor"));
      parameter SI.Inertia J(min=0) = 0.0013 " moment of inertia of motor" 
        annotation (Dialog(group="Motor"));
      parameter Real ratio=-105 " gear ratio" annotation (Dialog(group="Gear"));
      parameter SI.Torque Rv0=0.4 
        " viscous friction torque at zero velocity in [Nm]" 
        annotation (Dialog(group="Gear"));
      parameter Real Rv1(unit="N.m.s/rad") = (0.13/160) 
        " viscous friction coefficient in [Nms/rad]" 
        annotation (Dialog(group="Gear"));
      parameter Real peak=1 
        " peak*Rv0 = maximum static friction torque (peak >= 1)" 
        annotation (Dialog(group="Gear"));
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.16,
          y=0.02,
          width=0.76,
          height=0.84),
        Documentation(info="<HTML>
<p>
The axis model consists of the <b>controller</b>, the <b>motor</b> including current
controller and the <b>gearbox</b> including gear elasticity and bearing friction.
The only difference to the axis model of joints 4,5,6 (= model axisType2) is
that elasticity and damping in the gear boxes are not neglected.
</p>
<p>
The input signals of this component are the desired angle and desired angular
velocity of the joint. The reference signals have to be \"smooth\" (position
has to be differentiable at least 2 times). Otherwise, the gear elasticity
leads to significant oscillations.
</p>
<p>
Default values of the parameters are given for the axis of joint 1.
</p>
</HTML>
"),     Icon(Rectangle(extent=[-100, 50; 100, -50], style(
              color=9,
              gradient=2,
              fillColor=9,
              fillPattern=1)), Text(extent=[-150,57; 150,97],     string="%name")),
        Diagram);
      
      Modelica.Mechanics.Rotational.Interfaces.Flange_b flange 
        annotation (extent=[90,-10; 110,10]);
      replaceable GearType2 gear(
        Rv0=Rv0,
        Rv1=Rv1,
        peak=peak,
        i=ratio) annotation (extent=[0, -10; 20, 10]);
      Motor motor(
        J=J,
        k=k,
        w=w,
        D=D) annotation (extent=[-30, -10; -10, 10]);
      RobotR3.Components.Controller controller(
        kp=kp,
        ks=ks,
        Ts=Ts,
        ratio=ratio) annotation (extent=[-70, -10; -50, 10]);
      Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.AxisControlBus
        axisControlBus 
        annotation (extent=[-120,-20; -80,20],    rotation=-90);
      Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor 
        annotation (extent=[30,60; 50,80],     rotation=0);
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor 
        annotation (extent=[50,60; 30,40],     rotation=180);
      Modelica.Mechanics.Rotational.Sensors.AccSensor accSensor 
        annotation (extent=[30,20; 50,40],     rotation=0);
      Rotational.InitializeFlange initializeFlange(stateSelection=Modelica.Blocks.Types.StateSelection.Prefer) 
        annotation (extent=[-40,-60; -20,-40]);
      Blocks.Sources.Constant const(k=0) annotation (extent=[-65,-65; -55,-55]);
    equation 
      connect(gear.flange_b, flange) 
        annotation (points=[20,0; 100,0],   style(color=0));
      connect(gear.flange_b, angleSensor.flange_a) 
        annotation (points=[20,0; 20,70; 30,70],    style(color=0));
      connect(gear.flange_b, speedSensor.flange_a) 
        annotation (points=[20,0; 24,0; 24,50; 30,50],
                                                    style(color=0));
      connect(motor.flange_motor, gear.flange_a) 
        annotation (points=[-10, 0; 0, 0], style(color=0));
      connect(gear.flange_b, accSensor.flange_a) 
        annotation (points=[20,0; 28,0; 28,30; 30,30],
                                                    style(color=0));
      connect(controller.axisControlBus, axisControlBus) annotation (
        points=[-60,-10; -60,-20; -95,-20; -95,-4; -100,-4; -100,0],
        style(
          color=6,
          rgbcolor={255,204,51},
          thickness=2));
      connect(motor.axisControlBus, axisControlBus) annotation (
        points=[-12,-10; -12,-20; -95,-20; -95,-5; -100,-5; -100,0],
        style(
          color=6,
          rgbcolor={255,204,51},
          thickness=2));
      connect(angleSensor.phi, axisControlBus.angle) annotation (
        points=[51,70; 70,70; 70,84; -98,84; -98,9; -100,9; -100,0],
        style(color=74, rgbcolor={0,0,127}),
        Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3],
          style(color=0, rgbcolor={0,0,0})));
      connect(speedSensor.w, axisControlBus.speed) annotation (
        points=[51,50; 74,50; 74,87; -100,87; -100,0],
        style(color=74, rgbcolor={0,0,127}),
        Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3],
          style(color=0, rgbcolor={0,0,0})));
      connect(accSensor.a, axisControlBus.acceleration) annotation (
        points=[51,30; 77,30; 77,90; -102,90; -102,0; -100,0],
        style(color=74, rgbcolor={0,0,127}),
        Text(
          string="%second",
          index=1,
          extent=[6,3; 6,3],
          style(color=0, rgbcolor={0,0,0})));
      connect(axisControlBus.angle_ref, initializeFlange.phi_start) annotation (
        points=[-100,0; -100,-7; -97,-7; -97,-44; -42,-44],
        Text(
          string="%first",
          index=-1,
          extent=[-6,3; -6,3],
          style(color=0, rgbcolor={0,0,0})),
        style(color=0, rgbcolor={0,0,0}));
      connect(axisControlBus.speed_ref, initializeFlange.w_start) annotation (
        points=[-100,0; -99,0; -99,-50; -42,-50],
        Text(
          string="%first",
          index=-1,
          extent=[-6,3; -6,3],
          style(color=0, rgbcolor={0,0,0})),
        style(color=74, rgbcolor={0,0,127}));
      connect(initializeFlange.flange, flange) annotation (points=[-20,-50; 80,
            -50; 80,0; 100,0], style(color=0, rgbcolor={0,0,0}));
      connect(const.y, initializeFlange.a_start) annotation (points=[-54.5,-60;
            -48,-60; -48,-56; -42,-56], style(color=74, rgbcolor={0,0,127}));
    end AxisType2;
    
    model MechanicalStructure 
      "Model of the mechanical part of the r3 robot (without animation)" 
      
      parameter Boolean animation=true "= true, if animation shall be enabled";
      parameter SI.Mass mLoad(min=0)=15 "mass of load";
      parameter SI.Position rLoad[3]={0,0.25,0} 
        "distance from last flange to load mass>";
      parameter SI.Acceleration g=9.81 "gravity acceleration";
      SI.Angle q[6] "joint angles";
      SI.AngularVelocity qd[6] "joint speeds";
      SI.AngularAcceleration qdd[6] "joint accelerations";
      SI.Torque tau[6] "joint driving torques";
      //r0={0,0.351,0},
      annotation (
        Coordsys(
          extent=[-200, -200; 200, 200],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.16,
          y=0.06,
          width=0.73,
          height=0.87),
        Documentation(info="<HTML>
<p>
This model contains the mechanical components of the r3 robot
(multibody system).
</p>
</HTML>
"),     Icon(
          Rectangle(extent=[-200, 200; 200, -200], style(
              gradient=0,
              fillColor=8,
              fillPattern=1)),
          Text(extent=[-200, 280; 200, 200], string="%name"),
          Text(extent=[-200, -150; -140, -190], string="1"),
          Text(extent=[-200, -30; -140, -70], string="3"),
          Text(extent=[-200, -90; -140, -130], string="2"),
          Text(extent=[-200, 90; -140, 50], string="5"),
          Text(extent=[-200, 28; -140, -12], string="4"),
          Text(extent=[-198, 150; -138, 110], string="6"),
          Bitmap(extent=[-130, 195; 195, -195], name=
                "../../../../Images/MultiBody/Examples/Systems/robot_kr15.bmp")),
        Diagram);
      
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis1 
        annotation (extent=[-220, -180; -200, -160]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis2 
        annotation (extent=[-220, -120; -200, -100]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis3 
        annotation (extent=[-220, -60; -200, -40]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis4 
        annotation (extent=[-220, 0; -200, 20]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis5 
        annotation (extent=[-220, 60; -200, 80]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis6 
        annotation (extent=[-220, 120; -200, 140]);
      inner Modelica.Mechanics.MultiBody.World world(
        g=(g)*MultiBody.Frames.length(({0,-1,0})),
        n={0,-1,0},
        animateWorld=false,
        animateGravity=false,
        enableAnimation=animation) 
                              annotation (extent=[-100, -200; -80, -180]);
      Modelica.Mechanics.MultiBody.Joints.ActuatedRevolute r1(n={0,1,0},
          animation=animation) 
        annotation (extent=[-80, -170; -60, -150], rotation=90);
      Modelica.Mechanics.MultiBody.Joints.ActuatedRevolute r2(n={1,0,0},
          animation=animation) 
        annotation (extent=[-50, -110; -30, -90]);
      Modelica.Mechanics.MultiBody.Joints.ActuatedRevolute r3(n={1,0,0},
          animation=animation) 
        annotation (extent=[-60, -46; -40, -26], rotation=180);
      Modelica.Mechanics.MultiBody.Joints.ActuatedRevolute r4(n={0,1,0},
          animation=animation) 
        annotation (extent=[-80, 0; -60, 20], rotation=90);
      Modelica.Mechanics.MultiBody.Joints.ActuatedRevolute r5(n={1,0,0},
          animation=animation) 
        annotation (extent=[-60, 70; -40, 90]);
      Modelica.Mechanics.MultiBody.Joints.ActuatedRevolute r6(n={0,1,0},
          animation=animation) 
        annotation (extent=[-70, 120; -50, 140], rotation=90);
      Modelica.Mechanics.MultiBody.Parts.BodyShape b0(
        r={0,0.351,0},
        shapeType="0",
        r_shape={0,0,0},
        lengthDirection={1,0,0},
        widthDirection={0,1,0},
        length=0.225,
        width=0.3,
        height=0.3,
        color={0,0,255},
        animation=animation,
        animateSphere=false) 
        annotation (extent=[-40, -180; -20, -160], rotation=90);
      Modelica.Mechanics.MultiBody.Parts.BodyShape b1(
        r={0,0.324,0.3},
        I_22=1.16,
        shapeType="1",
        lengthDirection={1,0,0},
        widthDirection={0,1,0},
        length=0.25,
        width=0.15,
        height=0.2,
        animation=animation,
        animateSphere=false,
        color={255,0,0}) annotation (extent=[-80, -128; -60, -108], rotation=90);
      Modelica.Mechanics.MultiBody.Parts.BodyShape b2(
        r={0,0.65,0},
        r_CM={0.172,0.205,0},
        m=56.5,
        I_11=2.58,
        I_22=0.64,
        I_33=2.73,
        I_21=-0.46,
        shapeType="2",
        r_shape={0,0,0},
        lengthDirection={1,0,0},
        widthDirection={0,1,0},
        length=0.5,
        width=0.2,
        height=0.15,
        animation=animation,
        animateSphere=false,
        color={255,178,0}) annotation (extent=[-26, -80; -6, -60], rotation=90);
      Modelica.Mechanics.MultiBody.Parts.BodyShape b3(
        r={0,0.414,-0.155},
        r_CM={0.064,-0.034,0},
        m=26.4,
        I_11=0.279,
        I_22=0.245,
        I_33=0.413,
        I_21=-0.070,
        shapeType="3",
        r_shape={0,0,0},
        lengthDirection={1,0,0},
        widthDirection={0,1,0},
        length=0.15,
        width=0.15,
        height=0.15,
        animation=animation,
        animateSphere=false,
        color={255,0,0}) annotation (extent=[-76, -32; -96, -12], rotation=90);
      Modelica.Mechanics.MultiBody.Parts.BodyShape b4(
        r={0,0.186,0},
        r_CM={0,0,0},
        m=28.7,
        I_11=1.67,
        I_22=0.081,
        I_33=1.67,
        shapeType="4",
        r_shape={0,0,0},
        lengthDirection={1,0,0},
        widthDirection={0,1,0},
        length=0.73,
        width=0.1,
        height=0.1,
        animation=animation,
        animateSphere=false,
        color={255,178,0}) annotation (extent=[-80, 40; -60, 60], rotation=90);
      Modelica.Mechanics.MultiBody.Parts.BodyShape b5(
        r={0,0.125,0},
        r_CM={0,0,0},
        m=5.2,
        I_11=1.25,
        I_22=0.81,
        I_33=1.53,
        shapeType="5",
        r_shape={0,0,0},
        lengthDirection={1,0,0},
        widthDirection={0,1,0},
        length=0.225,
        width=0.075,
        height=0.1,
        animation=animation,
        animateSphere=false,
        color={0,0,255}) annotation (extent=[-30, 88; -10, 108], rotation=90);
      Modelica.Mechanics.MultiBody.Parts.BodyShape b6(
        r={0,0,0},
        r_CM={0.05,0.05,0.05},
        m=0.5,
        shapeType="6",
        r_shape={0,0,0},
        lengthDirection={1,0,0},
        widthDirection={0,1,0},
        animation=animation,
        animateSphere=false,
        color={0,0,255}) annotation (extent=[-70, 150; -50, 170], rotation=90);
      Modelica.Mechanics.MultiBody.Parts.BodyShape load(
        r_CM=rLoad,
        m=mLoad,
        r_shape={0,0,0},
        widthDirection={1,0,0},
        width=0.05,
        height=0.05,
        color={255,0,0},
        lengthDirection=rLoad,
        length=Modelica.Mechanics.MultiBody.Frames.length(rLoad),
        animation=animation) 
        annotation (extent=[-70,178; -50,198],   rotation=90);
    equation 
      connect(r6.frame_b, b6.frame_a) 
        annotation (points=[-60,140; -60,150], style(
          color=10,
          rgbcolor={95,95,95},
          thickness=2));
      q = {r1.phi,r2.phi,r3.phi,r4.phi,r5.phi,r6.phi};
      qd = der(q);
      qdd = der(qd);
      tau = {r1.axis.tau,r2.axis.tau,r3.axis.tau,r4.axis.tau,r5.axis.tau,r6.
        axis.tau};
      connect(load.frame_a, b6.frame_b) 
        annotation (points=[-60,178; -60,170], style(
          color=10,
          rgbcolor={95,95,95},
          thickness=2));
      connect(world.frame_b, b0.frame_a) annotation (points=[-80,-190; -30,-190;
            -30,-180], style(
          color=10,
          rgbcolor={95,95,95},
          thickness=2));
      connect(b0.frame_b, r1.frame_a) annotation (points=[-30,-160; -30,-146;
            -48,-146; -48,-180; -70,-180; -70,-170], style(
          color=10,
          rgbcolor={95,95,95},
          thickness=2));
      connect(b1.frame_b, r2.frame_a) annotation (points=[-70,-108; -70,-100;
            -50,-100], style(
          color=10,
          rgbcolor={95,95,95},
          thickness=2));
      connect(r1.frame_b, b1.frame_a) annotation (points=[-70,-150; -70,-128],
          style(
          color=10,
          rgbcolor={95,95,95},
          thickness=2));
      connect(r2.frame_b, b2.frame_a) annotation (points=[-30,-100; -16,-100;
            -16,-80], style(
          color=10,
          rgbcolor={95,95,95},
          thickness=2));
      connect(b2.frame_b, r3.frame_a) annotation (points=[-16,-60; -16,-36; -40,
            -36], style(
          color=10,
          rgbcolor={95,95,95},
          thickness=2));
      connect(r2.axis, axis2) annotation (points=[-40, -90; -42, -90; -42, -80;
             -160, -80; -160, -110; -210, -110], style(color=0));
      connect(r1.axis, axis1) annotation (points=[-80, -160; -160, -160; -160,
            -170; -210, -170], style(color=0));
      connect(r3.frame_b, b3.frame_a) annotation (points=[-60,-36; -88,-36; -86,
            -32], style(
          color=10,
          rgbcolor={95,95,95},
          thickness=2));
      connect(b3.frame_b, r4.frame_a) annotation (points=[-86,-12; -86,-8; -70,
            -8; -70,0], style(
          color=10,
          rgbcolor={95,95,95},
          thickness=2));
      connect(r3.axis, axis3) 
        annotation (points=[-50, -46; -50, -50; -210, -50], style(color=0));
      connect(r4.axis, axis4) 
        annotation (points=[-80, 10; -210, 10], style(color=0));
      connect(r4.frame_b, b4.frame_a) 
        annotation (points=[-70,20; -70,40], style(
          color=10,
          rgbcolor={95,95,95},
          thickness=2));
      connect(b4.frame_b, r5.frame_a) annotation (points=[-70,60; -70,80; -60,
            80], style(
          color=10,
          rgbcolor={95,95,95},
          thickness=2));
      connect(r5.axis, axis5) annotation (points=[-50, 90; -50, 94; -160, 94; -160,
             70; -210, 70], style(color=0));
      connect(r5.frame_b, b5.frame_a) annotation (points=[-40,80; -20,80; -20,
            88], style(
          color=10,
          rgbcolor={95,95,95},
          thickness=2));
      connect(b5.frame_b, r6.frame_a) annotation (points=[-20,108; -20,116; -60,
            116; -60,120], style(
          color=10,
          rgbcolor={95,95,95},
          thickness=2));
      connect(r6.axis, axis6) 
        annotation (points=[-70, 130; -210, 130], style(color=0));
    end MechanicalStructure;
    
    annotation (Documentation(info="<html>
<p>
This library contains the different components
of the r3 robot. Usually, there is no need to
use this library directly.
</p>
</html>"));
    package Internal "Internal models that should not be used" 
      expandable connector AxisControlBus "Data bus for one robot axis" 
        extends 
          Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.AxisControlBus;
        import SI = Modelica.SIunits;
        
        Boolean motion_ref "=true, if reference motion is not in rest";
        SI.Angle angle_ref "reference angle of axis flange";
        SI.Angle angle "angle of axis flange";
        SI.AngularVelocity speed_ref "reference speed of axis flange";
        SI.AngularVelocity speed "speed of axis flange";
        SI.AngularAcceleration acceleration_ref 
          "reference acceleration of axis flange";
        SI.AngularAcceleration acceleration "acceleration of axis flange";
        SI.Current current_ref "reference current of motor";
        SI.Current current "current of motor";
        SI.Angle motorAngle "angle of motor flange";
        SI.AngularVelocity motorSpeed "speed of motor flange";
      end AxisControlBus;
      
      expandable connector ControlBus "Data bus for all axes of robot" 
        extends 
          Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.ControlBus;
        Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.AxisControlBus
          axisControlBus1 "bus of axis 1";
        Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.AxisControlBus
          axisControlBus2 "bus of axis 2";
        Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.AxisControlBus
          axisControlBus3 "bus of axis 3";
        Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.AxisControlBus
          axisControlBus4 "bus of axis 4";
        Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.AxisControlBus
          axisControlBus5 "bus of axis 5";
        Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.AxisControlBus
          axisControlBus6 "bus of axis 6";
        
      /*
  parameter Integer naxis=6 "Number of axes";
  Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.Internal.AxisControlBus
    axisControlBus[naxis];
*/
      end ControlBus;
    end Internal;
    
  end Components;
  
  annotation (
    preferedView="info",
    Documentation(info="<HTML>
<p>
This package contains models of the robot r3 of the company Manutec.
These models are used to demonstrate in which way complex
robot models might be built up by testing first the component
models individually before composing them together.
Furthermore, it is shown how CAD data can be used
for animation.
</p>
<IMG SRC=\"../Images/MultiBody/Examples/Systems/robot_kr15.bmp\"
ALT=\"model Examples.Systems.RobotR3\">
<p>
The following models are available:
</p>
<pre>
   <b>oneAxis</b>   Test one axis (controller, motor, gearbox).
   <b>fullRobot</b> Test complete robot model.
</pre>
<p>
The r3 robot is no longer manufactured. In fact the company
Manutec does no longer exist.
The parameters of this robot have been determined by measurements
in the laboratory of DLR. The measurement procedure is described in:
</p>
<pre>
   Tuerk S. (1990): Zur Modellierung der Dynamik von Robotern mit
       rotatorischen Gelenken. Fortschrittberichte VDI, Reihe 8, Nr. 211,
       VDI-Verlag 1990.
</pre>
<p>
The robot model is described in detail in
</p>
<pre>
   Otter M. (1995): Objektorientierte Modellierung mechatronischer
       Systeme am Beispiel geregelter Roboter. Dissertation,
       Fortschrittberichte VDI, Reihe 20, Nr. 147, VDI-Verlag 1995.
       This report can be downloaded as compressed postscript file
       from: <a href=\"http://www.robotic.dlr.de/Martin.Otter/publications.html\">http://www.robotic.dlr.de/Martin.Otter/publications.html</a>.
</pre>
<p>
The path planning is performed in a simple way by using essentially
the Modelica.Mechanics.Rotational.KinematicPTP block. A user defines
a path by start and end angle of every axis. A path is planned such
that all axes are moving as fast as possible under the given
restrictions of maximum joint speeds and maximum joint accelerations.
The actual r3 robot from Manutec had a different path planning strategy.
Todays path planning algorithms from robot companies are much
more involved.
</p>
<p>
In order to get a nice animation, CAD data from a KUKA robot
is used, since CAD data of the original r3 robot was not available.
The KUKA CAD data was derived from public data of KUKA available at:
<a href=\"http://www.kuka-roboter.de/english/produkte/cad/low_payloads.html\">
http://www.kuka-roboter.de/english/produkte/cad/low_payloads.html</a>.
Since dimensions of the corresponding KUKA robot are similar but not
identical to the r3 robot, the data of the r3 robot (such as arm lengths) have been modified, such that it matches the CAD data.
</p>
<p>
In this model, a simplified P-PI cascade controller for every
axes is used. The parameters have been manually adjusted by
simulations. The original r3 controllers are more complicated.
The reason to use simplified controllers is to have a simpler demo.
</p>
</HTML>
"));
end RobotR3;
