within ThermoSysPro.Properties.WaterSteamSimple.Energy;
record u1_PT_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order5(
    c00=-1.199077e+07,
    c10=3.933724e-02,
    c01=1.294203e+05,
    c20=-3.373270e-10,
    c11=-2.689978e-04,
    c02=-5.708589e+02,
    c30=2.481700e-19,
    c21=2.378897e-12,
    c12=5.482753e-07,
    c03=1.289251e+00,
    c40=-4.631300e-27,
    c31=1.419574e-21,
    c22=-5.929846e-15,
    c13=-1.809839e-10,
    c04=-1.449570e-03,
    c50=1.702200e-35,
    c41=4.617004e-31,
    c32=-2.467419e-24,
    c23=4.993837e-18,
    c14=-3.200878e-13,
    c05=6.530896e-07);

  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end u1_PT_coef;
