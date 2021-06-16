within ThermoSysPro.Properties.WaterSteamSimple.Density;
function dd1hp_Ph
  "Derivative of density wrt. specific enthalpy at constant pressure in liquid region for given pressure and specific enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Modelica.SIunits.DerDensityByEnthalpy ddhp
    "Derivative of density wrt. specific enthalpy at constant pressure";
protected
  d1_Ph_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  ddhp :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative_y(
    coef,
    p,
    h);

end dd1hp_Ph;
