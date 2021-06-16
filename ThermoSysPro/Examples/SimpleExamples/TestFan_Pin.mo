within ThermoSysPro.Examples.SimpleExamples;
model TestFan_Pin

  FlueGases.BoundaryConditions.SourceP               Source_Fumees(
    Xso2=0,
    Xco2=0.0,
    Xh2o=0.006,
    Xo2=0.23,
    P0=130000,
    T0=300)
    annotation (Placement(transformation(extent={{-210,-24},{-164,24}},
          rotation=0)));
  FlueGases.BoundaryConditions.SinkP             Puits_Fumees(P0=136434, T(start=
          305.1156884766197))
    annotation (Placement(transformation(
        origin={182,0},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  FlueGases.Volumes.VolumeATh              dynamicExchanger(
    Ce1(T(start=300.0000000000001)),
    T(start=304.9170848582274),
    Xco2(start=1.0717322621381142E-29),
    Xh2o(start=0.0059999999999999715),
    Xo2(start=0.23),
    Xso2(start=2.580512329611796E-16))
    annotation (Placement(transformation(extent={{-68,50},{-48,70}}, rotation=0)));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource heatSource(
      option_temperature=2, W0={1e4})
                            annotation (Placement(transformation(extent={{-48,
            90},{-28,110}}, rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.SingularPressureLoss
    singularPressureLossFlueGases(                    Q(fixed=false, start=10), K=10,
    rho(start=1.473613481083164)) annotation (Placement(transformation(extent={
            {12,50},{32,70}}, rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.SingularPressureLoss
    singularPressureLossFlueGases1(                      Q(fixed=false, start=
          11), K=0.01,
    rho(start=1.4979229608974243))
                                  annotation (Placement(transformation(extent={
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
    Qv(start=1.3566066051273442),
    C2(T(start=305.11568847661977)),
    T(start=305.0163869268126),
    rho(start=1.4742671713265922))
               annotation (Placement(transformation(extent={{52,50},{72,70}},
          rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.CheckValve
    singularPressureLossFlueGases2(                   Q(fixed=false, start=10), touvert(
        start=true))              annotation (Placement(transformation(extent={
            {92,50},{112,70}}, rotation=0)));
  FlueGases.Volumes.VolumeCTh              dynamicExchanger1(
    T(start=304.91708485822744),
    Xco2(start=1.0708121131984948E-29),
    Xh2o(start=0.0059999999999999715),
    Xo2(start=0.23),
    Xso2(start=2.580512329611796E-16))
    annotation (Placement(transformation(extent={{-68,-70},{-48,-50}}, rotation=
           0)));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource heatSource1(
      option_temperature=2, W0={1e4})
                            annotation (Placement(transformation(extent={{-48,
            -90},{-28,-110}}, rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.SingularPressureLoss
    singularPressureLossFlueGases3(                   Q(fixed=false, start=10), K=10,
    rho(start=1.4736134810831638))
                                  annotation (Placement(transformation(extent={
            {12,-70},{32,-50}}, rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.SingularPressureLoss
    singularPressureLossFlueGases4(                      Q(fixed=false, start=
          11), K=0.01,
    rho(start=1.4979229608974243))
                                  annotation (Placement(transformation(extent={
            {-108,-70},{-88,-50}}, rotation=0)));
  ThermoSysPro.FlueGases.Machines.StaticFan staticFan1(
    VRotn=2700,
    rm=1,
    b2=2.4593,
    b1=-1.315,
    VRot=2700,
    a1=-263.145,
    a2=0,
    a3=500,
    Qv(start=1.356606605127344),
    C2(T(start=305.1156884766198)),
    T(start=305.01638692681263),
    rho(start=1.4742671713265918))
               annotation (Placement(transformation(extent={{52,-70},{72,-50}},
          rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.CheckValve
    singularPressureLossFlueGases5(                   Q(fixed=false, start=10), touvert(
        start=true))              annotation (Placement(transformation(extent={
            {92,-70},{112,-50}}, rotation=0)));
  ThermoSysPro.FlueGases.Junctions.Mixer2 mixerFlueGases2_1
    annotation (Placement(transformation(extent={{132,-10},{152,10}}, rotation=
            0)));
  FlueGases.Volumes.VolumeDTh              volume2S(dynamic_mass_balance=true,
      dynamic_composition_balance=true,
    Xco2(start=1.0683237791471977E-29),
    Xh2o(start=0.0059999999999999715),
    Xo2(start=0.23),
    Xso2(start=2.580512329611796E-16))
    annotation (Placement(transformation(extent={{-148,-10},{-128,10}},
          rotation=0)));
  ThermoSysPro.FlueGases.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{-28,58},{-8,78}}, rotation=0)));
  ThermoSysPro.FlueGases.Sensors.TemperatureSensor temperatureSensor1
    annotation (Placement(transformation(extent={{-28,-62},{-8,-42}}, rotation=
            0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe Pin(
    Starttime=50,
    Duration=50,
    Initialvalue=1.28837e5,
    Finalvalue=1.36434e5)
                    annotation (Placement(transformation(extent={{156,32},{176,
            52}},      rotation=0)));
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
  connect(singularPressureLossFlueGases1.C2, dynamicExchanger.Ce1) annotation (
      Line(
      points={{-88,60},{-68,60}},
      color={0,0,0},
      thickness=1));
  connect(dynamicExchanger.Cs1, temperatureSensor.C1) annotation (Line(
      points={{-48,60},{-28,60}},
      color={0,0,0},
      thickness=1));
  connect(Pin.y, Puits_Fumees.IPressure) annotation (Line(points={{177,42},{184,
          42},{196,42},{196,0},{187,0}}, color={0,0,255}));
  connect(Source_Fumees.C, volume2S.Ce) annotation (Line(
      points={{-164,0},{-156,0},{-148,0}},
      color={0,0,0},
      thickness=1));
  connect(volume2S.Cs1, singularPressureLossFlueGases1.C1) annotation (Line(
      points={{-138,10},{-138,10},{-138,60},{-108,60}},
      color={0,0,0},
      thickness=1));
  connect(volume2S.Cs2, singularPressureLossFlueGases4.C1) annotation (Line(
      points={{-138,-10},{-138,-10},{-138,-60},{-108,-60}},
      color={0,0,0},
      thickness=1));
  connect(singularPressureLossFlueGases4.C2, dynamicExchanger1.Ce1) annotation (
     Line(
      points={{-88,-60},{-78,-60},{-68,-60}},
      color={0,0,0},
      thickness=1));
  connect(dynamicExchanger1.Cs, temperatureSensor1.C1) annotation (Line(
      points={{-48,-60},{-28,-60}},
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
end TestFan_Pin;
