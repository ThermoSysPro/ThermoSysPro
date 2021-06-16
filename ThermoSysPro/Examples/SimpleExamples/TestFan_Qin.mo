within ThermoSysPro.Examples.SimpleExamples;
model TestFan_Qin

  ThermoSysPro.FlueGases.BoundaryConditions.SourcePQ Source_Fumees(
    Xso2=0,
    Xco2=0.0,
    Xh2o=0.006,
    Xo2=0.23,
    P0=130000,
    Q0=4,
    T0=300)
    annotation (Placement(transformation(extent={{-210,-24},{-164,24}},
          rotation=0)));
  ThermoSysPro.FlueGases.BoundaryConditions.Sink Puits_Fumees
    annotation (Placement(transformation(
        origin={182,0},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  FlueGases.Volumes.VolumeATh              dynamicExchanger(T0=300, Xh2o0=0.006)
    annotation (Placement(transformation(extent={{-68,50},{-48,70}}, rotation=0)));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource heatSource(
      option_temperature=2, W0={1e4})
                            annotation (Placement(transformation(extent={{-48,
            90},{-28,110}}, rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.SingularPressureLoss
    singularPressureLossFlueGases(                    Q(fixed=false, start=10), K=10)
                                  annotation (Placement(transformation(extent={
            {12,50},{32,70}}, rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.SingularPressureLoss
    singularPressureLossFlueGases1(                      Q(fixed=false, start=
          11), K=0.01)            annotation (Placement(transformation(extent={
            {-108,50},{-88,70}}, rotation=0)));
  ThermoSysPro.FlueGases.Machines.StaticFan staticFan(
    VRotn=2700,
    rm=1,
    a2=0,
    b1=-1.315,
    b2=2.4593,
    VRot=2700,
    a1=-263.145,
    a3=500,
    Q(start=2),
    Qv(start=2),
    rho(start=1))
               annotation (Placement(transformation(extent={{52,50},{72,70}},
          rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.CheckValve
    singularPressureLossFlueGases2(                   Q(fixed=false, start=10))
                                  annotation (Placement(transformation(extent={
            {92,50},{112,70}}, rotation=0)));
  FlueGases.Volumes.VolumeCTh              dynamicExchanger1(Xh2o0=0.006, T0=
        300)
    annotation (Placement(transformation(extent={{-68,-70},{-48,-50}}, rotation=
           0)));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource heatSource1(
      option_temperature=2, W0={1e4})
                            annotation (Placement(transformation(extent={{-48,
            -90},{-28,-110}}, rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.SingularPressureLoss
    singularPressureLossFlueGases3(                   Q(fixed=false, start=10), K=10)
                                  annotation (Placement(transformation(extent={
            {12,-70},{32,-50}}, rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.SingularPressureLoss
    singularPressureLossFlueGases4(                      Q(fixed=false, start=
          11), K=0.01)            annotation (Placement(transformation(extent={
            {-108,-70},{-88,-50}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe rampe1(
    Starttime=50,
    Duration=50,
    Initialvalue=1e4,
    Finalvalue=2e5) annotation (Placement(transformation(extent={{0,-120},{-20,
            -100}}, rotation=0)));
  ThermoSysPro.FlueGases.Machines.StaticFan staticFan1(
    VRotn=2700,
    rm=1,
    b2=2.4593,
    b1=-1.315,
    VRot=2700,
    a1=-263.145,
    a2=0,
    a3=500,
    Q(start=2),
    Qv(start=2),
    rho(start=1))
               annotation (Placement(transformation(extent={{52,-70},{72,-50}},
          rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.CheckValve
    singularPressureLossFlueGases5(                   Q(fixed=false, start=10))
                                  annotation (Placement(transformation(extent={
            {92,-70},{112,-50}}, rotation=0)));
  ThermoSysPro.FlueGases.Junctions.Mixer2 mixerFlueGases2_1
    annotation (Placement(transformation(extent={{132,-10},{152,10}}, rotation=
            0)));
  FlueGases.Volumes.VolumeDTh              volume2S(
    Xh2o0=0.006,
    T0=300,
    dynamic_mass_balance=true,
    dynamic_composition_balance=true)
    annotation (Placement(transformation(extent={{-149,-10},{-129,10}},
          rotation=0)));
  ThermoSysPro.FlueGases.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{-28,58},{-8,78}}, rotation=0)));
  ThermoSysPro.FlueGases.Sensors.TemperatureSensor temperatureSensor1
    annotation (Placement(transformation(extent={{-28,-62},{-8,-42}}, rotation=
            0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe Qin(
    Starttime=50,
    Duration=50,
    Initialvalue=4,
    Finalvalue=1)   annotation (Placement(transformation(extent={{-200,40},{
            -180,60}}, rotation=0)));
equation
  connect(singularPressureLossFlueGases.C2, staticFan.C1) annotation (Line(
      points={{32,60},{52,60}},
      color={0,0,0},
      thickness=1));
  connect(staticFan.C2, singularPressureLossFlueGases2.C1) annotation (Line(
      points={{72,60},{91,60}},
      color={0,0,0},
      thickness=1));
  connect(singularPressureLossFlueGases3.C2, staticFan1.C1) annotation (Line(
      points={{32,-60},{52,-60}},
      color={0,0,0},
      thickness=1));
  connect(staticFan1.C2, singularPressureLossFlueGases5.C1) annotation (Line(
      points={{72,-60},{91,-60}},
      color={0,0,0},
      thickness=1));
  connect(singularPressureLossFlueGases2.C2, mixerFlueGases2_1.Ce1) annotation (Line(
      points={{113,60},{138,60},{138,10}},
      color={0,0,0},
      thickness=1));
  connect(singularPressureLossFlueGases5.C2, mixerFlueGases2_1.Ce2) annotation (Line(
      points={{113,-60},{138,-60},{138,-10}},
      color={0,0,0},
      thickness=1));
  connect(temperatureSensor1.C2, singularPressureLossFlueGases3.C1) annotation (Line(
      points={{-8,-60},{12,-60}},
      color={0,0,0},
      thickness=1));
  connect(temperatureSensor.C2, singularPressureLossFlueGases.C1) annotation (Line(
      points={{-8,60},{12,60}},
      color={0,0,0},
      thickness=1));
  connect(heatSource.C[1], dynamicExchanger.Cth) annotation (Line(points={{-38,
          90.2},{-58,60}}, color={191,95,0}));
  connect(heatSource1.C[1], dynamicExchanger1.Cth) annotation (Line(points={{
          -38,-90.2},{-58,-60}}, color={191,95,0}));
  connect(mixerFlueGases2_1.Cs, Puits_Fumees.C) annotation (Line(
      points={{152,0},{162,0},{162,-1.20011e-015},{172.2,-1.20011e-015}},
      color={0,0,0},
      thickness=1));
  connect(Qin.y, Source_Fumees.IMassFlow)
    annotation (Line(points={{-179,50},{-170,50},{-170,28},{-187,28},{-187,12}}));
  connect(singularPressureLossFlueGases1.C2, dynamicExchanger.Ce1) annotation (
      Line(
      points={{-88,60},{-68,60}},
      color={0,0,0},
      thickness=1));
  connect(dynamicExchanger.Cs1, temperatureSensor.C1) annotation (Line(
      points={{-48,60},{-28,60}},
      color={0,0,0},
      thickness=1));
  connect(Source_Fumees.C, volume2S.Ce) annotation (Line(
      points={{-164,0},{-149,0}},
      color={0,0,0},
      thickness=1));
  connect(volume2S.Cs1, singularPressureLossFlueGases1.C1) annotation (Line(
      points={{-139,10},{-140,10},{-140,60},{-108,60}},
      color={0,0,0},
      thickness=1));
  connect(volume2S.Cs2, singularPressureLossFlueGases4.C1) annotation (Line(
      points={{-139,-10},{-140,-10},{-140,-58},{-140,-60},{-108,-60}},
      color={0,0,0},
      thickness=1));
  connect(singularPressureLossFlueGases4.C2, dynamicExchanger1.Ce1) annotation (
     Line(
      points={{-88,-60},{-78,-60},{-68,-60}},
      color={0,0,0},
      thickness=1));
  connect(dynamicExchanger1.Cs, temperatureSensor1.C1) annotation (Line(
      points={{-48,-60},{-38,-60},{-28,-60}},
      color={0,0,0},
      thickness=1));
  annotation (experiment(StopTime=1000), Diagram(graphics,
                                                 coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-150},{200,150}},
        initialScale=0.1)),
    Icon(graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Polygon(
          origin={8.0,14.0},
          lineColor={78,138,73},
          fillColor={78,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019 </p>
<p><b>ThermoSysPro Version 3.2 </h4>
</html>"));
end TestFan_Qin;
