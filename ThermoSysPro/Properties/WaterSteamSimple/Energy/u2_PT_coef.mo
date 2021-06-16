within ThermoSysPro.Properties.WaterSteamSimple.Energy;
record u2_PT_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order3(
    c00=1.822267e+06,
    c10=-5.532014e-02,
    c01=1.840048e+03,
    c20=1.288956e-10,
    c11=6.553801e-05,
    c02=-2.793637e-01,
    c30=-4.283469e-20,
    c21=-8.415179e-14,
    c12=-1.945450e-08,
    c03=1.669594e-04);

  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end u2_PT_coef;
