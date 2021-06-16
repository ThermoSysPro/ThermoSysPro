within ThermoSysPro.Properties.WaterSteamSimple.Temperature;
function T1_Ph
  "Temperature in liquid region for given pressure and specific enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Modelica.SIunits.Temperature T "Temperature";
protected
  T1_Ph_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  T := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3(
    coef,
    p,
    h);

end T1_Ph;
