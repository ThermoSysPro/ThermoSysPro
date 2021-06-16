within ThermoSysPro.Properties.WaterSteamSimple.Density;
record d1sat_T_coef
  extends Modelica.Icons.Record;
  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_x_order5(
      c0=5.42712985E+03,
      c1=-7.25236552E+01,
      c2=4.33707300E-01,
      c3=-1.21145352E-03,
      c4=1.60102374E-06,
      c5=-8.12916005E-10);

   annotation (Icon(graphics,
                    coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end d1sat_T_coef;
