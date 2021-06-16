within ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity;
record cp1_Ph_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order5(
    c00=4.207662e+03,
    c10=-3.773690e-06,
    c01=-3.744316e-04,
    c20=-2.140615e-15,
    c11=6.690603e-12,
    c02=1.265071e-09,
    c30=1.460525e-21,
    c21=-1.698335e-19,
    c12=-1.423996e-17,
    c03=-4.448595e-16,
    c40=-2.553418e-29,
    c31=4.136914e-27,
    c22=-4.694246e-25,
    c13=5.232495e-23,
    c04=-1.101472e-21,
    c50=6.623097e-38,
    c41=2.378719e-35,
    c32=-7.976355e-33,
    c23=9.128781e-31,
    c14=-5.496190e-29,
    c05=1.162449e-27);
  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end cp1_Ph_coef;
