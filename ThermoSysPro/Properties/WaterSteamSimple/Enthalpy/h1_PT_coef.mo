within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
record h1_PT_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order5(
    c00=-1.210342e+07,
    c10=3.932901e-02,
    c01=1.310565e+05,
    c20=-3.425284e-10,
    c11=-2.572281e-04,
    c02=-5.801243e+02,
    c30=1.974339e-19,
    c21=2.427381e-12,
    c12=4.966543e-07,
    c03=1.314839e+00,
    c40=-4.256626e-27,
    c31=1.512868e-21,
    c22=-6.054694e-15,
    c13=-8.389491e-11,
    c04=-1.484055e-03,
    c50=1.597043e-35,
    c41=1.356624e-31,
    c32=-2.492294e-24,
    c23=5.082575e-18,
    c14=-3.822957e-13,
    c05=6.712484e-07);

   annotation (Icon(graphics,
                    coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end h1_PT_coef;
