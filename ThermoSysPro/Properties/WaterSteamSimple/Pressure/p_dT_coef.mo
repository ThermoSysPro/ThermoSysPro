within ThermoSysPro.Properties.WaterSteamSimple.Pressure;
record p_dT_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order5(
    c00=6.038e+07,
    c10=6.363e+05,
    c01=-4.033e+05,
    c20=197.5,
    c11=-2881,
    c02=912.4,
    c30=-0.1172,
    c21=-1.324,
    c12=4.474,
    c03=-0.8923,
    c40=-0.003126,
    c31=0.004181,
    c22=-0.0001604,
    c13=-0.002129,
    c04=0.0003892,
    c50=2.222e-06,
    c41=-1.743e-08,
    c32=-1.245e-06,
    c23=3.575e-07,
    c14=3.257e-07,
    c05=-6.216e-08);

   annotation (Icon(graphics,
                    coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end p_dT_coef;
