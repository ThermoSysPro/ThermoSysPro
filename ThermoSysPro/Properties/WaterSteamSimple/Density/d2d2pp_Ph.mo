within ThermoSysPro.Properties.WaterSteamSimple.Density;
function d2d2pp_Ph
  "Second derivative of density wrt. pressure in vapor region for given pressure and enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Real d2dpp;
protected
  d2_Ph_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  d2dpp :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5_derivative2_xx(
    coef,
    p,
    h);

end d2d2pp_Ph;
