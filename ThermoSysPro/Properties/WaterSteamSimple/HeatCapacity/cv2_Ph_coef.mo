within ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity;
record cv2_Ph_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order3(
    c00 =  6.341265e+03,
    c10 =  9.157602e-05,
    c01 =  -3.468356e-03,
    c20 =  -1.075238e-12,
    c11 =  -1.720256e-11,
    c02 =  8.051195e-10,
    c30 =  2.904533e-21,
    c21 =  1.341240e-19,
    c12 =  3.664923e-19,
    c03 =  -5.649382e-17);
  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end cv2_Ph_coef;
