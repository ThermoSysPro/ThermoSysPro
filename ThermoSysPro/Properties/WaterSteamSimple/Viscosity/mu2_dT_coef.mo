within ThermoSysPro.Properties.WaterSteamSimple.Viscosity;
record mu2_dT_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order3(
    c00 =  -6.342606e-06,
    c10 =  4.371500e-09,
    c01 =  4.976104e-08,
    c20 =  1.038249e-10,
    c11 =  1.710167e-11,
    c02 =  -5.808535e-12);
  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end mu2_dT_coef;
