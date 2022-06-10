within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestGasTurbine

  ThermoSysPro.Fluid.BoundaryConditions.SourcePQ sourcePQ(
    P0=1.013e5,
    Q0=600,
    T0=29.4 + 273.16,
    option_temperature=true,
    Xco2=0,
    Xh2o=0,
    Xo2=0.20994,
    Xso2=0,
    ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.FlueGases)
            annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));

  BoundaryConditions.SinkP                   sink
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante humidity(k=0.93)
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe fuel(
    Starttime=200,
    Duration=800,
    Initialvalue=13.507,
    Finalvalue=8.756)
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe air(
    Starttime=200,
    Duration=800,
    Initialvalue=592.7,
    Finalvalue=415.70)
    annotation (Placement(transformation(extent={{-98,0},{-78,20}})));
  Combustion.BoundaryConditions.FuelSourcePQ fuelSourcePQ(
    Q0=13.4368286133,
    T0=185 + 273.16,
    LHV=46989e3,
    Cp=2255,
    Xc=0.755,
    Xh=0.245,
    rho=0.838) annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  BoundaryConditions.SourcePQ water(Q0=0)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Machines.GasTurbine gasTurbine(
    comp_tau_n=14.0178,
    comp_eff_n=0.87004,
    exp_tau_n=0.06458,
    exp_eff_n=0.89045,
    TurbQred=0.0175634,
    Kcham=2.02088,
    Wpth=1e6,
    Compresseur(
      Ps(start=1404200.0),
      Te(start=302.56000000000006),
      Tis(start=630.0),
      Ts(start=729.0)),
    TurbineAgaz(Tis(start=847.0)),
    chambreCombustionTAC(
      Psf(start=1310000.0),
      Tea(start=729.0),
      Tsf(start=1532.57)),
    xAIR(
      ppvap0(start=4104.0),
      rho_air(start=1.0836),
      rho_vap(start=0.029)))
    annotation (Placement(transformation(extent={{-30,-28},{30,28}})));
equation
  connect(air.y, sourcePQ.IMassFlow)
    annotation (Line(points={{-77,10},{-60,10},{-60,5}}, color={0,0,255}));
  connect(humidity.y, gasTurbine.Huminide) annotation (Line(points={{-79,40},{
          -60,40},{-60,16.8},{-31.2,16.8}},color={0,0,255}));
  connect(fuel.y, fuelSourcePQ.IMassFlow)
    annotation (Line(points={{-19,70},{-10,70},{-10,55}},
                                                        color={0,0,255}));
  connect(sourcePQ.C, gasTurbine.Entree_air) annotation (Line(points={{-50,0},{
          -32,0},{-32,3.55271e-015},{-30,3.55271e-015}}, color={0,0,0}));
  connect(fuelSourcePQ.C, gasTurbine.Entree_combustible)
    annotation (Line(points={{0,50},{18,50},{18,28}}, color={0,0,0}));
  connect(water.C, gasTurbine.Entree_eau_combustion)
    annotation (Line(points={{-40,50},{-18,50},{-18,28}}, color={0,0,0}));
  connect(gasTurbine.Sortie_fumees, sink.C)
    annotation (Line(points={{30,3.55271e-015},{46,3.55271e-015},{46,0},{60,0}},
                                             color={0,0,0}));
  annotation (                   Icon(graphics={
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
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"),
    experiment(StopTime=1200));
end TestGasTurbine;
