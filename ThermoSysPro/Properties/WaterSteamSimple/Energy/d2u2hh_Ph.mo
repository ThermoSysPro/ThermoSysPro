within ThermoSysPro.Properties.WaterSteamSimple.Energy;
function d2u2hh_Ph
  "Second derivative of specific inner energy wrt. enthalpy in vapor region for given pressure and enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Real d2uhh;
protected
  u2_Ph_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  d2uhh :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative2_yy(
    coef,
    p,
    h);

end d2u2hh_Ph;
