within ThermoSysPro.Properties.WaterSteamSimple.Density;
function dd2sp_Ps
  "Derivative of density wrt. specific entropy at constant pressure in liquid region for given pressure and specific entropy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEntropy s "Specific entropy";
 output ThermoSysPro.Units.DerDensityByEntropy ddsp
    "Derivative of density wrt. specific enthalpy at constant pressure";
protected
  d2_Ps_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  ddsp :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5_derivative_y(
    coef,
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.logBase10(p),
    s);

end dd2sp_Ps;
