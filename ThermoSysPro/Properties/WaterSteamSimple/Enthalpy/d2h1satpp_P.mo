within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
function d2h1satpp_P
  "derivative of specific enthalpy at liquid saturation wrt. pressure"

  input Modelica.SIunits.Pressure p "pressure";
  output Real d2hpp "second derivative of enthalpy";
protected
  h1sat_P_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm
  d2hpp := coef.a*coef.b*(coef.b-1)*abs(p)^(coef.b-2);
end d2h1satpp_P;
