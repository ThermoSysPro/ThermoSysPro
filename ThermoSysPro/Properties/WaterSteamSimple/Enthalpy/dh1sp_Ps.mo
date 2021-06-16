within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
function dh1sp_Ps
  "Derivative of specific enthalpy wrt. specific entropy at constant pressure in liquid region for given pressure and specific entropy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEntropy s "Specific entropy";
 output Real dhsp
    "Derivative of specific enthalpy wrt. specific enthalpy at constant pressure";
  h1_Ps_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dhsp :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative_y(
    coef,
    p,
    s);

end dh1sp_Ps;
