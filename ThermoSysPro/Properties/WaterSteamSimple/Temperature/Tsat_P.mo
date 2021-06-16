within ThermoSysPro.Properties.WaterSteamSimple.Temperature;
function Tsat_P "temperature at saturation for given pressure"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 output Modelica.SIunits.Temperature T "Temperature";
protected
  Tsat_P_coef coef annotation (Placement(transformation(extent={{-100,
            80},{-80,100}})));
algorithm

  T := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_x_order7(
    coef, p);

end Tsat_P;
