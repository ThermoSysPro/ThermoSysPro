within ThermoSysPro.Properties.Fluid;
function Water_sat_P
  input Modelica.SIunits.AbsolutePressure P "Pressure";
  input Integer fluid  "Fluid number - 1: IF97 - 7: SimpleWater";

  output ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsat
    annotation (Placement(transformation(extent={{-100,50},{-60,90}}, rotation=
            0)));
  output ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsat     annotation (Placement(
        transformation(extent={{60,50},{100,90}}, rotation=0)));
algorithm

  if (fluid == 1) then
    (lsat,vsat) := ThermoSysPro.Properties.WaterSteam.IF97.Water_sat_P(P);
  elseif (fluid == 7) then
    (lsat,vsat) := ThermoSysPro.Properties.WaterSteamSimple.SimpleWater.Water_sat_P(P);
  else
    assert(false, "(lsat,vsat) : incorrect fluid number");
  end if;

  annotation (
    smoothOrder=2,
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
    Window(
      x=0.06,
      y=0.1,
      width=0.75,
      height=0.73),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
"));
end Water_sat_P;
