within ThermoSysPro.Properties.WaterSteamSimple.Entropy;
function ds2ph_Ph
  "Derivative of specific entropy wrt. pressure at constant specific enthalpy in vapor region for given pressure and specific enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Real dsph
    "Derivative of specific entropy wrt. pressure at constant specific enthalpy";
protected
  s2_Ph_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

   dsph:= coef.a/log(10)/p;

end ds2ph_Ph;
