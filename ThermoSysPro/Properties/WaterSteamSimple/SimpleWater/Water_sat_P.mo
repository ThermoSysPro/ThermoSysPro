within ThermoSysPro.Properties.WaterSteamSimple.SimpleWater;
function Water_sat_P
  input Modelica.SIunits.AbsolutePressure p "Pressure";

protected
  Modelica.SIunits.Temperature T;

public
  output ThermoSysPro.Properties.WaterSteamSimple.PropThermoSat lsat
    annotation (Placement(transformation(extent={{-85,15},{-15,85}}, rotation=0)));
  output ThermoSysPro.Properties.WaterSteamSimple.PropThermoSat vsat
    annotation (Placement(transformation(extent={{15,15},{85,85}}, rotation=0)));

algorithm
  lsat := ThermoSysPro.Properties.WaterSteamSimple.propsat1_P(p);
  vsat := ThermoSysPro.Properties.WaterSteamSimple.propsat2_P(p);
  annotation (
    derivative = Water_sat_P_der,
    Window(
      x=0.34,
      y=0.21,
      width=0.6,
      height=0.6),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(extent={{-134,104},{142,44}}, textString=
                                               "%name"),
        Ellipse(
          extent={{-100,40},{100,-100}},
          lineColor={255,127,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-84,-4},{84,-52}},
          lineColor={255,127,0},
          textString=
               "fonction")}),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
"));
end Water_sat_P;
