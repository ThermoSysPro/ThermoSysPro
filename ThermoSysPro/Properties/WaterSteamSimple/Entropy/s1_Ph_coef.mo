within ThermoSysPro.Properties.WaterSteamSimple.Entropy;
record s1_Ph_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order3(
    c00=3.288493e+01,
    c10=-3.150501e-06,
    c01=3.245253e-03,
    c20=1.085679e-15,
    c11=5.702081e-13,
    c02=-6.104960e-10);

   annotation (Icon(graphics,
                    coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end s1_Ph_coef;
