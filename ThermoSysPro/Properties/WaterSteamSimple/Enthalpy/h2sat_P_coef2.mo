within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
record h2sat_P_coef2
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_x_order5(
    c4=-5.295450709151908e-23,
    c3=1.395998647281974e-15,
    c2=-1.415784081274956e-08,
    c1=5.366818361099557e-02,
    c0=2.737576737978614e+06);

  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end h2sat_P_coef2;
