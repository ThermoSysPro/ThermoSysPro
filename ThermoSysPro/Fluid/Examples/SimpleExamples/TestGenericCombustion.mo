within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestGenericCombustion

  ThermoSysPro.Fluid.Combustion.CombustionChambers.GenericCombustion genericCombustionCCS(
    kcham=0.1,
    Acham=275,
    Xbf=0,
    ImbCV=0.05,
    ImbBF=0.0,
    Psf(start=113275)) annotation (Placement(transformation(extent={{-32,-56},{
            92,72}},
                  rotation=0)));
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
    Hum=0.08) annotation (Placement(transformation(extent={{24,-95},{58,-57}},
          rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourcePQ SourcePQ_Water(Q0=0, P0=100000)
    annotation (Placement(transformation(extent={{-83,-3},{-47,31}},  rotation=
            0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourcePQ sourceAir(
    Xso2=0,
    Q0=609.29,
    Xh2o=0.01,
    Xo2=0.230,
    Xco2=0,
    P0=191000,
    T0=524.89,
    ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.FlueGases,
    option_temperature=true)
    annotation (Placement(transformation(extent={{-54,-94},{-10,-54}},
                                                                     rotation=0)));

  ThermoSysPro.Fluid.BoundaryConditions.Sink sink annotation (Placement(transformation(
          extent={{30,70},{74,112}},rotation=0)));
equation
  connect(fuelSourcePQ.C, genericCombustionCCS.Cfuel) annotation (Line(points={{58,-76},
          {73.4,-76},{73.4,-49.6}},         color={0,0,0}));
  connect(SourcePQ_Water.C, genericCombustionCCS.Cws) annotation (Line(points={{-47,14},
          {-36,14},{-36,14.4},{-25.8,14.4}},         color={0,0,0}));
  connect(genericCombustionCCS.Ca, sourceAir.C) annotation (Line(
      points={{11.4,-49.6},{11.4,-74},{-10,-74}},
      color={0,0,0},
      thickness=1));
  connect(genericCombustionCCS.Cfg, sink.C) annotation (Line(
      points={{11.4,65.6},{11.4,91},{30,91}},
      color={0,0,0},
      thickness=1));
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
end TestGenericCombustion;
