within ThermoSysPro.Properties.WaterSteamSimple.Pressure;
function dpsat1h_h "Derivative of saturation pressure wrt. specific enthalpy"
 input Modelica.SIunits.SpecificEnthalpy h "Enthalpy";
 output Real dph "Pressure";
  psat1_h_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dph :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_x_order5_derivative(
    coef, h);

end dpsat1h_h;
