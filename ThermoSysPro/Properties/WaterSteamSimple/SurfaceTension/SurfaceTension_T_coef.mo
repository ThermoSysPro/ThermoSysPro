within ThermoSysPro.Properties.WaterSteamSimple.SurfaceTension;
record SurfaceTension_T_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_x_order5(
    c5=1.375111e-14,
    c4=-2.834172e-11,
    c3=2.324307e-08,
    c2=-9.664378e-06,
    c1=1.868712e-03,
    c0=-5.047045e-02);

  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end SurfaceTension_T_coef;
