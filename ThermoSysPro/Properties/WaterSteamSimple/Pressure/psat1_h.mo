within ThermoSysPro.Properties.WaterSteamSimple.Pressure;
function psat1_h "Saturation pressure for given specific enthalpy"
 input Modelica.SIunits.SpecificEnthalpy h "Enthalpy";
 output Modelica.SIunits.Pressure p "Pressure";
  psat1_h_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  p := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_x_order5(
    coef, h);

end psat1_h;
