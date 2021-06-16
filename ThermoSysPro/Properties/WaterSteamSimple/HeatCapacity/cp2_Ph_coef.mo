within ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity;
record cp2_Ph_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order5(
    c00=-4400,
    c10=0.003162,
    c01=0.009958,
    c20=-2.36e-11,
    c11=-2.249e-09,
    c02=-5.926e-09,
    c30=1.036e-19,
    c21=1.214e-17,
    c12=5.98e-16,
    c03=1.669e-15,
    c40=-3.998e-28,
    c31=-2.848e-26,
    c22=-2.12e-24,
    c13=-7.018e-23,
    c04=-2.209e-22,
    c50=7.818e-37,
    c41=4.299e-35,
    c32=2.099e-33,
    c23=1.245e-31,
    c14=3.061e-30,
    c05=1.113e-29);

  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end cp2_Ph_coef;
