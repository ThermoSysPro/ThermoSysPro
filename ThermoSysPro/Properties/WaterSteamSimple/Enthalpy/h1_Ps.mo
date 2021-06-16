within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
function h1_Ps
  "Specific enthalpy in liquid region for given pressure and specific entropy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEntropy s "Specific entropy";
 output Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
protected
  h1_Ps_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  h := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3(
    coef,
    p,
    s);

end h1_Ps;
