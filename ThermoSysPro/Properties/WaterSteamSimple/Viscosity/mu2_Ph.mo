within ThermoSysPro.Properties.WaterSteamSimple.Viscosity;
function mu2_Ph
  "Viscosity in vapor region for given pressure and specific enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Modelica.SIunits.DynamicViscosity mu "Dynamic viscosity";
  mu2_Ph_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  mu := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3(
    coef,
    p,
    h);

end mu2_Ph;
