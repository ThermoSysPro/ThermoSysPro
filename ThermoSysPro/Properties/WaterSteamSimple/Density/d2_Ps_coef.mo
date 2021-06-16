within ThermoSysPro.Properties.WaterSteamSimple.Density;
record d2_Ps_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order5(
    c00=-1.166923e+03,
    c10=-2.232163e+02,
    c01=5.607440e-01,
    c20=8.114333e+01,
    c11=-4.192922e-03,
    c02=-8.206701e-05,
    c30=-1.000655e+01,
    c21=-3.733483e-03,
    c12=2.577362e-06,
    c03=4.905100e-09,
    c40=8.072126e-01,
    c31=-4.421570e-04,
    c22=4.654613e-07,
    c13=-2.235287e-10,
    c04=-9.381426e-14);

  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end d2_Ps_coef;
