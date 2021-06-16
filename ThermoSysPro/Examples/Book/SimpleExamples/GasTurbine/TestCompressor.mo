within ThermoSysPro.Examples.Book.SimpleExamples.GasTurbine;
model TestCompressor
  parameter Real is_eff_n1(fixed=false,start=0.85) "Nominal isentropic efficiency";

  FlueGases.Machines.Compressor Compressor(
    Ps(fixed=false),
    tau_n=16,
    is_eff_n=is_eff_n1,
    Pe(fixed=false, start=100000),
    Ts(fixed=true, start=680)) annotation (Placement(transformation(extent={{
            -52,-52},{48,52}}, rotation=0)));
  FlueGases.BoundaryConditions.SourcePQ SourceQ1(
    Xso2=0,
    T0=288,
    Xco2=0.0,
    Xh2o=0.003,
    Xo2=0.23,
    P0=1e5,
    Q0=420)
    annotation (Placement(transformation(extent={{-104,-10},{-84,10}},
          rotation=0)));
  FlueGases.BoundaryConditions.SinkP SinkP1(P0=15.8e5)
    annotation (Placement(transformation(
        origin={96,0},
        extent={{10,-10},{-10,10}},
        rotation=180)));
equation
  connect(SourceQ1.C, Compressor.Ce) annotation (Line(
      points={{-84,0},{-39.5,0}},
      color={0,0,0},
      thickness=1));
  connect(Compressor.Cs, SinkP1.C) annotation (Line(
      points={{35.5,0},{86.2,0}},
      color={0,0,0},
      thickness=1));
  annotation (Diagram(graphics), Icon(graphics={
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
<p><b>ThermoSysPro Version 3.2 </p>
<p>This model is documented in Sect. 11.3.4 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>.</h4>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"));
end TestCompressor;
