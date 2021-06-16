within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
function h1_PT
  "Specific enthalpy in liquid region for given pressure and temperature"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.Temperature T "Temperature";
 output Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
  h1_PT_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  h := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5(
    coef,
    p,
    T);

end h1_PT;
