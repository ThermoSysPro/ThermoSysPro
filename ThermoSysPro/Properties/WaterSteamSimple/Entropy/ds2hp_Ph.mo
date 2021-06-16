within ThermoSysPro.Properties.WaterSteamSimple.Entropy;
function ds2hp_Ph
  "Derivative of specific entropy wrt. specific enthalpy at constant pressure in vapor region for given pressure and specific enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Real dshp
    "Derivative of specific entropy wrt. specific enthalpy at constant pressure";
  s2_Ph_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

   dshp:= coef.c1 +
          coef.c2*2*h;

end ds2hp_Ph;
