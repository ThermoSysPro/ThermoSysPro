within ThermoSysPro.Properties.WaterSteamSimple.Density;
function d2_Ph
  "Density in steam region for given pressure and specific enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Modelica.SIunits.Density d "Density";
protected
  d2_Ph_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  d := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5(
    coef,
    p,
    h);

end d2_Ph;
