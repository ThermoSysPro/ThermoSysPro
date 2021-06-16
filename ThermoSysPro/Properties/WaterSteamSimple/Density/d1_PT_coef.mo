within ThermoSysPro.Properties.WaterSteamSimple.Density;
record d1_PT_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order5(
    c00=-1.829480e+03,
    c10=3.054319e-05,
    c01=2.781477e+01,
    c20=3.828328e-14,
    c11=-3.043374e-07,
    c02=-9.811186e-02,
    c30=8.084907e-22,
    c21=-6.519321e-16,
    c12=1.176861e-09,
    c03=1.443719e-04,
    c40=-6.330092e-32,
    c31=-4.041731e-24,
    c22=2.507897e-18,
    c13=-2.063206e-12,
    c04=-6.651181e-08,
    c50=-3.239489e-39,
    c41=1.530767e-33,
    c32=4.801971e-27,
    c23=-2.757629e-21,
    c14=1.380801e-15,
    c05=-1.948287e-11);

  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end d1_PT_coef;
