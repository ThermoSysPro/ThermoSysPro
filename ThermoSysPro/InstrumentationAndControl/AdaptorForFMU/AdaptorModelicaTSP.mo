within ThermoSysPro.InstrumentationAndControl.AdaptorForFMU;
model AdaptorModelicaTSP "AdaptorModelicaTSP"

  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));

  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal outputReal
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  outputReal.signal = u;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Polygon(
          points={{-100,100},{0,0},{-100,-100},{-100,100}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={0,0,175},
          fillPattern=FillPattern.Solid), Polygon(
          points={{0,100},{100,0},{0,-100},{0,100}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid)}), Diagram(graphics={Polygon(
          points={{0,100},{100,0},{0,-100},{0,100}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid), Polygon(
          points={{-100,100},{0,0},{-100,-100},{-100,100}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={0,0,175},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p><b>Version 3.2</b></p>
</html>
"));
end AdaptorModelicaTSP;
