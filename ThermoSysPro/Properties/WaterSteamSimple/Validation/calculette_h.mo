within ThermoSysPro.Properties.WaterSteamSimple.Validation;
model calculette_h
  parameter Modelica.SIunits.Pressure p = 50e5;
  parameter Modelica.SIunits.SpecificEnthalpy h_min = 1e5;
  parameter Modelica.SIunits.SpecificEnthalpy h_max = 5e6;
  Modelica.SIunits.SpecificEnthalpy h;
  Modelica.SIunits.SpecificEnthalpy h1sat;
  Modelica.SIunits.SpecificEnthalpy h2sat;
  Modelica.SIunits.Temperature T1;
  Modelica.SIunits.Temperature Tsat1;
  Modelica.SIunits.SpecificEnthalpy h1sat_IF97;
  Modelica.SIunits.SpecificEnthalpy h2sat_IF97;

  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro_IF97;
  ThermoSysPro.Properties.WaterSteamSimple.ThermoProperties_ph pro_polynomial;

protected
  parameter Modelica.SIunits.Time dt = 10000;
  Real x = time/dt;

equation
  h = h_min + x*(h_max - h_min);
  pro_IF97 = ThermoSysPro.Properties.WaterSteam.IF97_packages.IF97_wAJ.Water_Ph(p,h);
  pro_polynomial =
    ThermoSysPro.Properties.WaterSteamSimple.SimpleWater.Water_Ph(
    p,
    h,
    0);

  h1sat = ThermoSysPro.Properties.WaterSteamSimple.Enthalpy.h1sat_P(p);
  h1sat_IF97 = ThermoSysPro.Properties.WaterSteam.BaseIF97.Regions.hl_p(p);

  h2sat = ThermoSysPro.Properties.WaterSteamSimple.Enthalpy.h2sat_P(p);
  T1 = ThermoSysPro.Properties.WaterSteamSimple.Temperature.T1_Ph(p, h);
  Tsat1 = ThermoSysPro.Properties.WaterSteamSimple.Temperature.Tsat_P(p);

  h2sat_IF97 = ThermoSysPro.Properties.WaterSteam.BaseIF97.Regions.hv_p(p);
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
          points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})},
                    coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=10000, __Dymola_NumberOfIntervals=5000),
    __Dymola_experimentSetupOutput);
end calculette_h;
