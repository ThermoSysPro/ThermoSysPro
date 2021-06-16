within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
function h2_Ps
  "Specific enthalpy in vapor region for given pressure and specific entropy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEntropy s "Specific entropy";
 output Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
protected
  h2_Ps_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  h := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5(
    coef,
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.logBase10(p),
    s);

end h2_Ps;
