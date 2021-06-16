within ThermoSysPro.Properties.WaterSteamSimple.Conductivity;
function lambda2_Ph
  "Conductivity in vapor region for given pressure and specific enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Modelica.SIunits.ThermalConductivity  lambda "Thermal conductivity";
  lambda2_Ph_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  lambda :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3(
    coef,
    p,
    h);

end lambda2_Ph;
