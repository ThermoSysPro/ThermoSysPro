within ThermoSysPro.Properties.WaterSteamSimple.Entropy;
record s1sat_P_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_x_order7(
    c7 = 4.783031268042318e+00,
    c6 =  -1.596826783529359e+02,
    c5 = 2.241912955256332e+03,
    c4 = -1.713580461176007e+04,
    c3 = 7.692114721625441e+04,
    c2 = -2.025392377804540e+05,
    c1 = 2.898136070796547e+05,
    c0 = -1.741778192246134e+05);

   annotation (Icon(graphics,
                    coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end s1sat_P_coef;
