within ThermoSysPro.InstrumentationAndControl.AdaptorForFMU;
model AdaptorTSPModelica "AdaptorTSPModelica"

  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),
        iconTransformation(extent={{100,-20},{140,20}})));

  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal inputReal
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
equation
  inputReal.signal =y;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Polygon(
          points={{0,100},{100,0},{0,-100},{0,100}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={0,0,175},
          fillPattern=FillPattern.Solid), Polygon(
          points={{-100,100},{0,0},{-100,-100},{-100,100}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                                    graphics={Polygon(
          points={{-100,100},{0,0},{-100,-100},{-100,100}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid), Polygon(
          points={{0,100},{100,0},{0,-100},{0,100}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={0,0,175},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p><b>Version 3.2</b></p>
</html>
"));
end AdaptorTSPModelica;
