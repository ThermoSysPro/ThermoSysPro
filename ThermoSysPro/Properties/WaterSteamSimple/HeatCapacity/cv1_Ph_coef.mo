within ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity;
record cv1_Ph_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order5(
    c00 =  4.304834e+03,
    c10 =  -3.760969e-06,
    c01 =  -1.530567e-03,
    c20 =  1.927013e-13,
    c11 =  -5.657385e-13,
    c02 =  1.346921e-09,
    c30 =  -7.039089e-21,
    c21 =  3.116868e-19,
    c12 =  -7.644685e-18,
    c03 =  -2.161111e-15,
    c40 =  8.260882e-29,
    c31 =  -1.684752e-27,
    c22 =  -1.752758e-25,
    c13 =  6.726723e-24,
    c04 =  1.694097e-21,
    c50 =  -3.168745e-37,
    c41 =  1.231252e-36,
    c32 =  2.357419e-34,
    c23 =  8.508953e-32,
    c14 =  -4.647867e-30,
    c05 =  -3.860965e-28);
  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end cv1_Ph_coef;
