within ThermoSysPro.Properties.WaterSteamSimple.Entropy;
record s2sat_P_coef1
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_x_order5(
    c5=0,
    c4=0,
    c3=0,
    c2=1.559066410833765e+01,
    c1=-9.382592335419915e+02,
    c0=1.165455266377105e+04);

   annotation (Icon(graphics,
                    coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end s2sat_P_coef1;
