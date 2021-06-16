within ThermoSysPro.Properties.WaterSteamSimple.SimpleWater;
function Water_sat_P_der
  input Modelica.SIunits.AbsolutePressure p "Pression";

  input Real p_der "derivative of pressure";

public
  output ThermoSysPro.Properties.WaterSteamSimple.PropThermoSat dlsat
    annotation (Placement(transformation(extent={{-85,15},{-15,85}}, rotation=0)));
  output ThermoSysPro.Properties.WaterSteamSimple.PropThermoSat dvsat
    annotation (Placement(transformation(extent={{15,15},{85,85}}, rotation=0)));

algorithm
  dlsat := ThermoSysPro.Properties.WaterSteamSimple.propsat1_P_der(p, p_der);
  dvsat := ThermoSysPro.Properties.WaterSteamSimple.propsat2_P_der(p, p_der);
  annotation (
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
end Water_sat_P_der;
