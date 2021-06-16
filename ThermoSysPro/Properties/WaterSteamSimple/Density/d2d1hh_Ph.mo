within ThermoSysPro.Properties.WaterSteamSimple.Density;
function d2d1hh_Ph
  "Second derivative of density wrt. enthalpy in liquid region for given pressure and enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Real d2dhh;
protected
  d1_Ph_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  d2dhh :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative2_yy(
    coef,
    p,
    h);

end d2d1hh_Ph;
