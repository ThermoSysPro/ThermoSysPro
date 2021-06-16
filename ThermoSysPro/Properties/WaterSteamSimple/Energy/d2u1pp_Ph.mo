within ThermoSysPro.Properties.WaterSteamSimple.Energy;
function d2u1pp_Ph
  "Second derivative of specific inner energy wrt. pressure in liquid region for given pressure and enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Real d2upp;
protected
  u1_Ph_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  d2upp :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative2_xx(
    coef,
    p,
    h);

end d2u1pp_Ph;
