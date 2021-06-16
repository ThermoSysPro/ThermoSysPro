within ThermoSysPro.Properties.WaterSteamSimple.Entropy;
function ds1satp_P
  "derivative of specificentropy wrt. pressure at liquid saturation for given pressure"

  input Modelica.SIunits.Pressure p "pressure";
  output Real dsp(unit="m3/(kg.K)") "derivative of entropy";
  s1sat_P_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm
  dsp :=1/log(10)/p*
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_x_order7_derivative(
    coef, ThermoSysPro.Properties.WaterSteamSimple.Utilities.logBase10(p));
end ds1satp_P;
