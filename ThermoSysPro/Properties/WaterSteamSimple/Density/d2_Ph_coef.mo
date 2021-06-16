within ThermoSysPro.Properties.WaterSteamSimple.Density;
record d2_Ph_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order5(
    c00=2938,
    c10=4.925e-05,
    c01=-0.003494,
    c20=-3.152e-13,
    c11=-2.816e-11,
    c02=1.626e-09,
    c30=-3.393e-21,
    c21=2.994e-19,
    c12=4.719e-18,
    c03=-3.697e-16,
    c40=3.707e-29,
    c31=-7.735e-29,
    c22=-6.358e-26,
    c13=-1.101e-25,
    c04=4.114e-23,
    c50=-1.176e-37,
    c41=-1.311e-36,
    c32=3.631e-35,
    c23=4.188e-33,
    c14=-2.086e-32,
    c05=-1.796e-30);

     annotation (Icon(graphics,
                      coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end d2_Ph_coef;
