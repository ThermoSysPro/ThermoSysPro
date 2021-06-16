within ThermoSysPro.Examples.SimpleExamples;
model TestVolume_SteamCavitiesPipeValve

  WaterSteam.Volumes.VolumeA   volumeATh(
    steady_state=false,
    dynamic_mass_balance=true,
    V=10,
    P0=1000000,
    h0=35e5,
    P(start=1000000))
                   annotation (Placement(transformation(extent={{-92,21},{-62,
            -9}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve controlValve2
    annotation (Placement(transformation(extent={{16,2},{36,22}}, rotation=0)));
  InstrumentationAndControl.Blocks.Sources.Constante Constant
                                     annotation (Placement(transformation(
          extent={{-2,18},{14,34}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe lumpedStraightPipe1(D=0.1)
    annotation (Placement(transformation(extent={{-34,-4},{-14,16}}, rotation=0)));
  WaterSteam.Volumes.VolumeA   volumeATh1(
    V=10,
    dynamic_mass_balance=true,
    steady_state=false,
    P0=500000,
    h0=30e5,
    P(start=500000))
                   annotation (Placement(transformation(extent={{66,21},{96,-9}},
          rotation=0)));
equation
  connect(Constant.y, controlValve2.Ouv)
    annotation (Line(points={{14.8,26},{26,26},{26,23}}));
  connect(volumeATh.Cs1, lumpedStraightPipe1.C1)
    annotation (Line(points={{-62,6},{-34,6}}, color={0,0,255}));
  connect(lumpedStraightPipe1.C2, controlValve2.C1)
    annotation (Line(points={{-14,6},{16,6}}, color={0,0,255}));
  connect(controlValve2.C2, volumeATh1.Ce1)
    annotation (Line(points={{36,6},{66,6}}, color={0,0,255}));
  annotation (Icon(graphics={
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
end TestVolume_SteamCavitiesPipeValve;
