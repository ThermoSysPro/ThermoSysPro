within ThermoSysPro.Properties.WaterSteamSimple.Density;
record d2sat_T_coef
  extends Modelica.Icons.Record;
  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_x_order5(
        c0=-1.83956723E+01,
        c1=9.80585592E-02,
        c2=-1.73543962E-04,
        c3=1.10814001E-07);

   annotation (Icon(graphics,
                    coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end d2sat_T_coef;
