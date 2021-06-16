within ThermoSysPro.Properties.WaterSteamSimple.SimpleWater;
function Water_Ph_der "Derivative function of Water_Ph"
  input Modelica.SIunits.AbsolutePressure p "Pressure";
  input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
  input Integer mode = 0 "Région IF97 - 0:calcul automatique";
  //input CombiPlant.ThermoFluidPro.Media.Common.IF97TwoPhaseAnalytic aux "auxiliary record";

  input Real p_der "derivative of Pressure";
  input Real h_der "derivative of Specific enthalpy";

  output ThermoSysPro.Properties.WaterSteamSimple.ThermoProperties_ph der_pro
    "Derivative";

 // Integer phase;
protected
  Integer region;

algorithm
  //phase := ThermoSysPro.Properties.WaterSteamSimple.phase_ph(p,h);
  //region :=ThermoSysPro.Properties.WaterSteamSimple.region_ph(p,h,phase,mode);
  region := ThermoSysPro.Properties.WaterSteamSimple.region_ph(
    p,
    h,
    mode);
  if (region == 1) then
    der_pro := ThermoSysPro.Properties.WaterSteamSimple.prop1_Ph_der(
      p,
      h,
      p_der,
      h_der);
  elseif (region == 2) then
    der_pro := ThermoSysPro.Properties.WaterSteamSimple.prop2_Ph_der(
      p,
      h,
      p_der,
      h_der);
  elseif (region == 4) then
    der_pro := ThermoSysPro.Properties.WaterSteamSimple.prop4_Ph_der(
      p,
      h,
      p_der,
      h_der);
  else
    assert(false, "Water_Ph: Incorrect region number (" + String(region) + ")");
  end if;

  annotation (
    Window(
      x=0.22,
      y=0.2,
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
end Water_Ph_der;
