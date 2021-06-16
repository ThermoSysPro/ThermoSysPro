within ThermoSysPro.Examples.Book.SimpleExamples.HeatExchanger;
model TestDynamicPlateHeatExchanger

  ThermoSysPro.WaterSteam.HeatExchangers.DynamicWaterWaterExchanger
    echangeurAPlaques1D1(
    modec=1,
    modef=1,
    N=5,
    Sc(Q(fixed=true, start=1036)))
         annotation (Placement(transformation(extent={{-14,6},{6,26}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP2(T0=340)
    annotation (Placement(transformation(extent={{-74,6},{-54,26}},   rotation=
            0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP3
                                            annotation (Placement(
        transformation(extent={{-54,-14},{-34,6}},   rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP puitsP2(P0(fixed=false)=
      100000)                            annotation (Placement(transformation(
          extent={{46,6},{66,26}},   rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP puitsP3
                                          annotation (Placement(transformation(
          extent={{26,-14},{46,6}},   rotation=0)));
equation
  connect(sourceP2.C, echangeurAPlaques1D1.Ec)
    annotation (Line(points={{-54,16},{-14,16}},   color={0,0,255}));
  connect(sourceP3.C, echangeurAPlaques1D1.Ef)
                                              annotation (Line(points={{-34,-4},
          {-9,-4},{-9,10}},     color={0,0,255}));
  connect(echangeurAPlaques1D1.Sc, puitsP2.C)
                                            annotation (Line(points={{6,16},{46,
          16}},     color={0,0,255}));
  connect(echangeurAPlaques1D1.Sf, puitsP3.C)
                                             annotation (Line(points={{1,10},{0,
          10},{0,-4},{26,-4}},         color={0,0,255}));
  annotation (Diagram(graphics={Text(
          extent={{72,24},{92,6}},
          lineColor={0,0,255},
          textString=
               "Qc=true")}), Icon(graphics={
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
<p>This model is documented in Sect. 9.6.1.5 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>.</h4>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"));
end TestDynamicPlateHeatExchanger;
