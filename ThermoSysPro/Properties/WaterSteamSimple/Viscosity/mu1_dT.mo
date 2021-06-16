within ThermoSysPro.Properties.WaterSteamSimple.Viscosity;
function mu1_dT "Viscosity in liquid region for given density and temperature"
input Modelica.SIunits.Density d "Density";
 input Modelica.SIunits.Temperature T "Temperature";
 output Modelica.SIunits.DynamicViscosity mu "Dynamic viscosity";
protected
  mu1_dT_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  mu := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_x_order7(
    coef,T);

end mu1_dT;
