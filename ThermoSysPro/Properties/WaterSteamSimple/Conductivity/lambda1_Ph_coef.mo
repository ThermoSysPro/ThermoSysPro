within ThermoSysPro.Properties.WaterSteamSimple.Conductivity;
record lambda1_Ph_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order5(
    c00=5.452677e-01,
    c10=-6.984453e-11,
    c01=5.724819e-07,
    c20=-8.605931e-19,
    c11=1.529135e-15,
    c02=-9.436446e-13,
    c30=3.467945e-28,
    c21=1.728908e-24,
    c12=-1.087772e-21,
    c03=7.614081e-19,
    c40=5.673171e-35,
    c31=-3.281411e-32,
    c22=3.121527e-30,
    c13=4.133284e-28,
    c04=-3.767334e-25,
    c50=-3.225145e-46,
    c41=-1.691485e-40,
    c32=6.735025e-38,
    c23=-8.798974e-36,
    c14=3.762968e-34,
    c05=6.501393e-32);
  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end lambda1_Ph_coef;
