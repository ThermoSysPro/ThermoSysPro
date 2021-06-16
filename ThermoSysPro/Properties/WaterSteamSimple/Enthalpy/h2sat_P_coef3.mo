within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
record h2sat_P_coef3
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_x_order7(
    c6=-3.735e-37,
    c5=2.48e-29,
    c4=-6.566e-22,
    c3=8.838e-15,
    c2=-6.44e-08,
    c1=0.2298,
    c0=2.491e+06);

  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end h2sat_P_coef3;
