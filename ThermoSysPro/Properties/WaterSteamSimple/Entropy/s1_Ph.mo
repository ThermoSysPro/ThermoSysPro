within ThermoSysPro.Properties.WaterSteamSimple.Entropy;
function s1_Ph
  "Specific entropy in liquid region for given pressure and specific enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Modelica.SIunits.SpecificEntropy s "Specific entropy";
protected
  s1_Ph_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  s := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3(
    coef,
    p,
    h);

end s1_Ph;
