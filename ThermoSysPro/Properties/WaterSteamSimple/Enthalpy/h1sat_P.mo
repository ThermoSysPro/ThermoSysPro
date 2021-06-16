within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
function h1sat_P "specific enthalpy at liquid saturation for given pressure"

  input Modelica.SIunits.Pressure p "pressure";
  output Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
protected
  h1sat_P_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm
 h := coef.a0 + coef.a*abs(p)^coef.b;

end h1sat_P;
