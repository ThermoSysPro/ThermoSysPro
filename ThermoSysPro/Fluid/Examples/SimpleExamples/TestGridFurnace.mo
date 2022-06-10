within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestGridFurnace
  import ThermoSysPro;

  parameter Integer NCEL = 7;

  ThermoSysPro.Fluid.Combustion.BoundaryConditions.FuelSourcePQ fuelSourcePQ(
    Xn=0.0208,
    Xashes=0.136,
    Cp=1200,
    rho=1100,
    LHV=29245e3,
    Xc=0.719,
    Xh=0.0414,
    Xo=0.086,
    Xs=0.0044,
    Vol=0.286,
    Q0=57.20,
    T0=358.15,
    Hum=0.08) annotation (Placement(transformation(extent={{-106,-23},{-72,15}},
          rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourcePQ sourceAir(
    Xso2=0,
    Xh2o=0.01,
    Xo2=0.230,
    Xco2=0,
    T0=300,
    Q0=10,
    P0=1.9e5,
    option_temperature=true,
    ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.FlueGases)
    annotation (Placement(transformation(extent={{-74,-80},{-30,-40}},
                                                                     rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.Sink sink(option_temperature=true)
                                                  annotation (Placement(transformation(
          extent={{28,50},{72,92}}, rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourcePQ SourcePQ_Water(P0=1.e5, Q0=1)
    annotation (Placement(transformation(extent={{89,13},{53,47}},    rotation=
            0)));
  ThermoSysPro.Fluid.Combustion.CombustionChambers.GridFurnace gridFurnace
    annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
  ThermoSysPro.Fluid.BoundaryConditions.SourceQ  sourceAir1(
    Xso2=0,
    Xh2o=0.01,
    Xo2=0.230,
    Xco2=0,
    option_temperature=true,
    T0=300,
    Q0=10,
    ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.FlueGases)
    annotation (Placement(transformation(extent={{-90,4},{-46,44}},  rotation=0)));
equation
  connect(fuelSourcePQ.C, gridFurnace.Com)
    annotation (Line(points={{-72,-4},{-36,-4}}, color={0,0,0}));
  connect(gridFurnace.Cfg, sink.C)
    annotation (Line(points={{0,36},{0,71},{28,71}}, color={0,0,0}));
  connect(SourcePQ_Water.C, gridFurnace.port_eau_refroid)
    annotation (Line(points={{53,30},{32,30},{32,12}}, color={0,0,0}));
  connect(sourceAir1.C, gridFurnace.Ca2)
    annotation (Line(points={{-46,24},{-20,24}}, color={0,0,0}));
  connect(sourceAir.C, gridFurnace.Ca1)
    annotation (Line(points={{-30,-60},{0,-60},{0,-36}}, color={0,0,0}));
  annotation (         Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>", info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"),
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
          points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}));
end TestGridFurnace;
