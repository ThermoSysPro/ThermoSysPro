within ThermoSysPro.Properties.WaterSteamSimple.Entropy;
record s2sat_P_coef2
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_x_order7(
      c7=-3.987096553509901e-47,
      c6=2.971445178363267e-39,
      c5=-9.186442753507775e-32,
      c4=1.535714267785520e-24,
      c3=-1.528004525781256e-17,
      c2=9.443878492492247e-11,
      c1=-4.196847249952369e-04,
      c0=6.903980457955598e+03);
   annotation (Icon(graphics,
                    coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end s2sat_P_coef2;
