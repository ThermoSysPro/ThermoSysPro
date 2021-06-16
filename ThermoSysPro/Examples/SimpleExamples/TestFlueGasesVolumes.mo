within ThermoSysPro.Examples.SimpleExamples;
model TestFlueGasesVolumes

  ThermoSysPro.FlueGases.BoundaryConditions.SourcePQ Source_Fumees(
    Xso2=0,
    Xco2=0.0,
    Xh2o=0.006,
    Xo2=0.23,
    Q0=2,
    T0=300,
    P0=1.3e5)
    annotation (Placement(transformation(extent={{-120,60},{-100,80}}, rotation=
           0)));
  ThermoSysPro.FlueGases.BoundaryConditions.Sink Puits_Fumees
    annotation (Placement(transformation(
        origin={130,70},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.FlueGases.Volumes.VolumeDTh dynamicExchanger
    annotation (Placement(transformation(extent={{-40,60},{-20,80}}, rotation=0)));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource heatSource(
      option_temperature=2, W0={2e4})
                            annotation (Placement(transformation(extent={{-80,
            102},{-60,122}}, rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.SingularPressureLoss
    singularPressureLossFlueGases(K(fixed=true) = 10, Q(fixed=false, start=10))
                                  annotation (Placement(transformation(extent={
            {0,60},{20,80}}, rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.SingularPressureLoss
    singularPressureLossFlueGases1(K(fixed=true) = 0.01, Q(fixed=false, start=
          11))                    annotation (Placement(transformation(extent={
            {-80,60},{-60,80}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe rampe(
    Starttime=50,
    Duration=50,
    Initialvalue=1e4,
    Finalvalue=2e4) annotation (Placement(transformation(extent={{-20,120},{-40,
            140}}, rotation=0)));
  ThermoSysPro.FlueGases.Machines.StaticFan staticFan(
    VRotn=2700,
    rm=1,
    VRot=3000,
    a1=45.876,
    a2=-50,
    b1=-3.0752)
               annotation (Placement(transformation(extent={{40,60},{60,80}},
          rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.SingularPressureLoss
    singularPressureLossFlueGases2(
                                  K(fixed=true) = 10, Q(fixed=false, start=10))
                                  annotation (Placement(transformation(extent={
            {80,60},{100,80}}, rotation=0)));
  ThermoSysPro.FlueGases.BoundaryConditions.SourcePQ Source_Fumees1(
    Xso2=0,
    Xco2=0.0,
    Xh2o=0.006,
    Xo2=0.23,
    Q0=2,
    T0=300,
    P0=1.3e5)
    annotation (Placement(transformation(extent={{-120,-40},{-100,-20}},
          rotation=0)));
  ThermoSysPro.FlueGases.BoundaryConditions.Sink Puits_Fumees1
    annotation (Placement(transformation(
        origin={130,-30},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  FlueGases.Volumes.VolumeATh dynamicExchanger1
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}}, rotation=
           0)));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource heatSource1(
      option_temperature=2, W0={2e4})
                            annotation (Placement(transformation(extent={{-80,2},
            {-60,22}}, rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.SingularPressureLoss
    singularPressureLossFlueGases3(
                                  K(fixed=true) = 10, Q(fixed=false, start=10))
                                  annotation (Placement(transformation(extent={
            {0,-40},{20,-20}}, rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.SingularPressureLoss
    singularPressureLossFlueGases4(K(fixed=true) = 0.01, Q(fixed=false, start=
          11))                    annotation (Placement(transformation(extent={
            {-80,-40},{-60,-20}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe rampe1(
    Starttime=50,
    Duration=50,
    Initialvalue=1e4,
    Finalvalue=2e4) annotation (Placement(transformation(extent={{-20,20},{-40,
            40}}, rotation=0)));
  ThermoSysPro.FlueGases.Machines.StaticFan staticFan1(
    VRotn=2700,
    rm=1,
    VRot=3000,
    a1=45.876,
    a2=-50,
    b1=-3.0752)
               annotation (Placement(transformation(extent={{40,-40},{60,-20}},
          rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.SingularPressureLoss
    singularPressureLossFlueGases5(
                                  K(fixed=true) = 10, Q(fixed=false, start=10))
                                  annotation (Placement(transformation(extent={
            {80,-40},{100,-20}}, rotation=0)));
  ThermoSysPro.FlueGases.BoundaryConditions.SourcePQ Source_Fumees2(
    Xso2=0,
    Xco2=0.0,
    Xh2o=0.006,
    Xo2=0.23,
    Q0=2,
    T0=300,
    P0=1.3e5)
    annotation (Placement(transformation(extent={{-120,-140},{-100,-120}},
          rotation=0)));
  ThermoSysPro.FlueGases.BoundaryConditions.Sink Puits_Fumees2
    annotation (Placement(transformation(
        origin={130,-130},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  FlueGases.Volumes.VolumeCTh dynamicExchanger2
    annotation (Placement(transformation(extent={{-40,-140},{-20,-120}},
          rotation=0)));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource heatSource2(
      option_temperature=2, W0={2e4})
                            annotation (Placement(transformation(extent={{-80,
            -98},{-60,-78}}, rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.SingularPressureLoss
    singularPressureLossFlueGases6(
                                  K(fixed=true) = 10, Q(fixed=false, start=10))
                                  annotation (Placement(transformation(extent={
            {0,-140},{20,-120}}, rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.SingularPressureLoss
    singularPressureLossFlueGases7(K(fixed=true) = 0.01, Q(fixed=false, start=
          11))                    annotation (Placement(transformation(extent={
            {-80,-140},{-60,-120}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe rampe2(
    Starttime=50,
    Duration=50,
    Initialvalue=1e4,
    Finalvalue=2e4) annotation (Placement(transformation(extent={{-20,-80},{-40,
            -60}}, rotation=0)));
  ThermoSysPro.FlueGases.Machines.StaticFan staticFan2(
    VRotn=2700,
    rm=1,
    VRot=3000,
    a1=45.876,
    a2=-50,
    b1=-3.0752)
               annotation (Placement(transformation(extent={{40,-140},{60,-120}},
          rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.SingularPressureLoss
    singularPressureLossFlueGases8(
                                  K(fixed=true) = 10, Q(fixed=false, start=10))
                                  annotation (Placement(transformation(extent={
            {80,-140},{100,-120}}, rotation=0)));
equation
  connect(Source_Fumees.C, singularPressureLossFlueGases1.C1) annotation (Line(
      points={{-100,70},{-80,70}},
      color={0,0,0},
      thickness=1));
  connect(singularPressureLossFlueGases.C2, staticFan.C1) annotation (Line(
      points={{20,70},{40,70}},
      color={0,0,0},
      thickness=1));
  connect(staticFan.C2, singularPressureLossFlueGases2.C1) annotation (Line(
      points={{60,70},{80,70}},
      color={0,0,0},
      thickness=1));
  connect(singularPressureLossFlueGases1.C2, dynamicExchanger.Ce) annotation (Line(
      points={{-60,70},{-40,70}},
      color={0,0,0},
      thickness=1));
  connect(dynamicExchanger.Cs3, singularPressureLossFlueGases.C1) annotation (Line(
      points={{-20,70},{0,70}},
      color={0,0,0},
      thickness=1));
  connect(singularPressureLossFlueGases2.C2, Puits_Fumees.C) annotation (Line(
      points={{100,70},{120.2,70}},
      color={0,0,0},
      thickness=1));
  connect(rampe.y, heatSource.ISignal) annotation (Line(points={{-41,130},{-70,
          130},{-70,117}}));
  connect(heatSource.C[1], dynamicExchanger.Cth) annotation (Line(points={{-70,
          102.2},{-30,70}}, color={191,95,0}));
  connect(Source_Fumees1.C, singularPressureLossFlueGases4.C1)
                                                              annotation (Line(
      points={{-100,-30},{-80,-30}},
      color={0,0,0},
      thickness=1));
  connect(singularPressureLossFlueGases3.C2, staticFan1.C1)
                                                          annotation (Line(
      points={{20,-30},{40,-30}},
      color={0,0,0},
      thickness=1));
  connect(staticFan1.C2, singularPressureLossFlueGases5.C1)
                                                           annotation (Line(
      points={{60,-30},{80,-30}},
      color={0,0,0},
      thickness=1));
  connect(singularPressureLossFlueGases5.C2, Puits_Fumees1.C)
                                                             annotation (Line(
      points={{100,-30},{120.2,-30}},
      color={0,0,0},
      thickness=1));
  connect(rampe1.y, heatSource1.ISignal)
                                       annotation (Line(points={{-41,30},{-70,
          30},{-70,17}}));
  connect(heatSource1.C[1], dynamicExchanger1.Cth)
                                                 annotation (Line(points={{-70,
          2.2},{-30,-30}}, color={191,95,0}));
  connect(singularPressureLossFlueGases4.C2, dynamicExchanger1.Ce1) annotation (Line(
      points={{-60,-30},{-40,-30}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(dynamicExchanger1.Cs1, singularPressureLossFlueGases3.C1) annotation (Line(
      points={{-20,-30},{0,-30}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(Source_Fumees2.C, singularPressureLossFlueGases7.C1)
                                                              annotation (Line(
      points={{-100,-130},{-80,-130}},
      color={0,0,0},
      thickness=1));
  connect(singularPressureLossFlueGases6.C2, staticFan2.C1)
                                                          annotation (Line(
      points={{20,-130},{40,-130}},
      color={0,0,0},
      thickness=1));
  connect(staticFan2.C2, singularPressureLossFlueGases8.C1)
                                                           annotation (Line(
      points={{60,-130},{80,-130}},
      color={0,0,0},
      thickness=1));
  connect(singularPressureLossFlueGases8.C2, Puits_Fumees2.C)
                                                             annotation (Line(
      points={{100,-130},{120.2,-130}},
      color={0,0,0},
      thickness=1));
  connect(rampe2.y, heatSource2.ISignal)
                                       annotation (Line(points={{-41,-70},{-70,
          -70},{-70,-83}}));
  connect(heatSource2.C[1], dynamicExchanger2.Cth)
                                                 annotation (Line(points={{-70,
          -97.8},{-30,-130}}, color={191,95,0}));
  connect(singularPressureLossFlueGases7.C2, dynamicExchanger2.Ce1) annotation (Line(
      points={{-60,-130},{-40,-130}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(dynamicExchanger2.Cs, singularPressureLossFlueGases6.C1) annotation (Line(
      points={{-20,-130},{0,-130}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  annotation (experiment(StopTime=200), Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-150},{200,150}},
        initialScale=0.1), graphics),
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
end TestFlueGasesVolumes;
