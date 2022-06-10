within ThermoSysPro.Fluid.BoundaryConditions;
model AirHumidity "Air humidity"
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Real hum0=0.5 "Air humidiy";
  parameter Units.SI.Temperature T0=290 "Fixed fluid temperature";
  parameter IF97Region region=IF97Region.All_regions "IF97 region (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

protected
  parameter Integer mode=Integer(region) - 1 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

public
  FluidType ftype "Fluid type";
  Integer fluid=Integer(ftype) "Fluid number";
  Units.SI.AbsolutePressure ppvap0(start=1e4)
    "Intermediate vapor partial pressure";
  Units.SI.Density rho_vap0(start=200) "Intermediate H2O density";
  Units.SI.AbsolutePressure P "Air pressure";
  Units.SI.MassFlowRate Q "Air mass flow rate";
  Units.SI.SpecificEnthalpy h "Air specific enthalpy";
  Units.SI.Temperature T "Air temperature";
  Units.SI.Density rho_vap(start=200) "H20 density";
  Units.SI.Density rho_air(start=0.8) "Air density";
  Units.SI.AbsolutePressure psvap(start=1e5) "Vapor saturation pressure in the air";
  Units.SI.AbsolutePressure ppvap(start=1e4) "Vapor partial pressure";
  Units.SI.AbsolutePressure ppair "Air partial pressure";
  Real hum "Air relative humidity";
  Real Xo2as(start=0.2) "O2 mass fraction in dry air";
  Real Xco2 "CO2 mass fraction at the outlet";
  Real Xh2o "H2O mass fraction at the outlet";
  Real Xo2 "O2 mass fraction at the outlet";
  Real Xso2 "SO2 mas fraction at the outlet";

public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_pT pro
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  Interfaces.Connectors.FluidInlet C1 annotation (Placement(transformation(
          extent={{-110,-10},{-90,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal humidity
    "Air humidity"
    annotation (Placement(transformation(
        origin={0,110},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Interfaces.Connectors.FluidOutlet C2 annotation (Placement(transformation(
          extent={{90,-10},{110,10}}, rotation=0)));
equation
  /* The fluid type must be flue gases */
  assert(ftype == FluidType.FlueGases, "AirHumidity: the fluid type must be flue gases");

  if (cardinality(humidity) == 0) then
    humidity.signal = hum0;
  end if;

  hum = humidity.signal;

  C1.P = C2.P;
  C1.Q = C2.Q;
  C1.h = C2.h;

  C1.h_vol_1 = C2.h_vol_1;
  C1.h_vol_2 = C2.h_vol_2;

  C2.diff_on_1 = C1.diff_on_1;
  C1.diff_on_2 = C2.diff_on_2;

  C2.diff_res_1 = C1.diff_res_1;
  C1.diff_res_2 = C2.diff_res_2;

  C1.ftype = C2.ftype;

  P = C1.P;
  Q = C1.Q;
  h = C1.h;

  ftype = C1.ftype;

  /* O2 mass fraction at the inlet */
  Xo2as = C1.Xo2;

  /* Temperature at the outlet */
  T = ThermoSysPro.Properties.FlueGases.FlueGases_T(P, h, Xco2, Xh2o, Xo2as, Xso2);

  /* Flue gas composition at the outlet. The sole constituents for air are O2 and N2 */
  Xco2 = 0;
  Xso2 = 0;
  Xh2o = rho_vap/(rho_vap + rho_air);
  Xo2 = Xo2as*(1 - Xh2o);

  C2.Xco2 = Xco2;
  C2.Xso2 = Xso2;
  C2.Xh2o = Xh2o;
  C2.Xo2 = Xo2;

  /* Vapor partial pressure */
  ppvap = psvap*hum;
  0 = if (ppvap < 0.061080e-4) then ppvap0 - 0.061080e-4 else ppvap - ppvap0;

  /* Air partial pressure */
  ppair = P - ppvap;

  /* Vapor saturation pressure */
  psvap = ThermoSysPro.Properties.WaterSteam.BaseIF97.Basic.psat(T);

  /* H2O density */
  pro = ThermoSysPro.Properties.WaterSteam.IF97.Water_PT(ppvap, T, mode);

  rho_vap0 = pro.d;

  0 = if (ppvap < 0.061080e-4) then rho_vap - (rho_vap0*ppvap/ppvap0) else rho_vap - rho_vap0;

  /* Air density */
  rho_air = ThermoSysPro.Properties.FlueGases.FlueGases_rho(ppair, T, Xco2, Xh2o, Xo2as, Xso2);

  annotation (Diagram(graphics={
        Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Line(points={{0,100},{0,40}}, color={0,0,255}),
        Line(points={{20,60},{0,40},{-20,60}}, color={0,0,255}),
        Line(points={{-90,0},{-40,0}}, color={0,0,255}),
        Line(points={{40,0},{90,0}}, color={0,0,255}),
        Text(
          extent={{-28,30},{28,-26}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Solid,
          textString=
               "H2O")}),                 Icon(graphics={
        Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor=DynamicSelect({255,255,0}, fill_color_static),
          fillPattern=FillPattern.Solid),
        Line(points={{0,100},{0,40}}, color={0,0,255}),
        Line(points={{20,60},{0,40},{-20,60}}, color={0,0,255}),
        Line(points={{-90,0},{-40,0}}, color={0,0,255}),
        Line(points={{40,0},{90,0}}, color={0,0,255}),
        Text(
          extent={{-28,30},{28,-26}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Solid,
          textString=
               "H2O")}),
    Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>",
   info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end AirHumidity;
