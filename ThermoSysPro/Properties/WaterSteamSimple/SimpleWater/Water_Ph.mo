within ThermoSysPro.Properties.WaterSteamSimple.SimpleWater;
function Water_Ph
  input Modelica.SIunits.AbsolutePressure p "Pressure";
  input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
  input Integer mode = 0 "IF97 region. 0:automatic";
  output ThermoSysPro.Properties.WaterSteamSimple.ThermoProperties_ph pro
    annotation (Placement(transformation(extent={{-90,15},{-43.3333,61.6667}},
          rotation=0)));

  //Integer phase;
protected
  Integer  region;

algorithm
  //phase := ThermoSysPro.Properties.WaterSteamSimple.phase_ph(p,h);
 // region :=ThermoSysPro.Properties.WaterSteamSimple.region_ph(p,h,phase,mode);
  region := ThermoSysPro.Properties.WaterSteamSimple.region_ph(
    p,
    h,
    mode);

  if (region == 1) then
    pro := ThermoSysPro.Properties.WaterSteamSimple.prop1_Ph(p, h);
  elseif (region == 2) then
    pro := ThermoSysPro.Properties.WaterSteamSimple.prop2_Ph(p, h);
  elseif (region == 4) then
    pro := ThermoSysPro.Properties.WaterSteamSimple.prop4_Ph(p, h);
  else
    assert(false, "Water_Ph: Incorrect region number (" + String(region) + ")");
  end if;

  //derivative(noDerivative=mode) = ThermoSysPro.Properties.WaterSteamSimple.SimpleWater.Water_Ph_der,

  annotation (
  derivative(noDerivative=mode) = ThermoSysPro.Properties.WaterSteamSimple.SimpleWater.Water_Ph_der,
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
end Water_Ph;
