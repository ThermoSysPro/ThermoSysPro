within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
record h2_dT_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order3(
    c00=1.981268e+06,
    c10=-1.283811e+04,
    c01=1.794505e+03,
    c20=1.453968e+01,
    c11=1.368782e+01,
    c02=1.770706e-01,
    c30=-4.932515e-03,
    c21=-9.713758e-03,
    c12=-3.878955e-03,
    c03=4.262431e-05);

   annotation (Icon(graphics,
                    coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end h2_dT_coef;
