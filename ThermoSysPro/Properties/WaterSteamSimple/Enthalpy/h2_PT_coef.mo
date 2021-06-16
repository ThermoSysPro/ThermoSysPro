within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
record h2_PT_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order3(
    c00=1.778741e+06,
    c10=-6.997339e-02,
    c01=2.423675e+03,
    c20=1.958603e-10,
    c11=8.100784e-05,
    c02=-3.747139e-01,
    c30=-1.016123e-19,
    c21=-1.234548e-13,
    c12=-2.324528e-08,
    c03=1.891004e-04);

  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end h2_PT_coef;
