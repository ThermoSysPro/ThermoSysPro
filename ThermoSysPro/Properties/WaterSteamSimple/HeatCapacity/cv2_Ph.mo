within ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity;
function cv2_Ph
  "Specific heat capacity at constant volume in vapor region for given pressure and specific enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Modelica.SIunits.SpecificHeatCapacity cv
    "Specific heat capacity at constant volume";
  cv2_Ph_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  cv := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3(
    coef,
    p,
    h);

end cv2_Ph;
