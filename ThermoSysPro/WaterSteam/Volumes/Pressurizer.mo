within ThermoSysPro.WaterSteam.Volumes;
model Pressurizer "Pressurizer"
  parameter Modelica.SIunits.Volume V=61.1 "Pressurizer volume";
  parameter Modelica.SIunits.Radius Rp=1.265
    "Pressurizer cross-sectional radius";
  parameter Modelica.SIunits.Area Ae=1 "Wall surface";
  parameter Modelica.SIunits.Position Zm=10.15
    "Hauteur de la gamme de mesure niveau";
  parameter Real Yw0=50
    "Initial water level - percent of the measure scale level (active if steady_state=false)";
  parameter Modelica.SIunits.AbsolutePressure P0=155e5
    "Initial fluid pressure (active if steady_state=false)";
  parameter Real Ccond=0.1 "Condensation coefficient";
  parameter Real Cevap=0.1 "Evaporation coefficient";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer Klv=0.5e6
    "Heat exchange coefficient between the liquid and gas phases";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer Klp=50000
    "Heat exchange coefficient between the liquid phase and the wall";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer Kvp=25
    "Heat exchange coefficient between the gas phase and the wall";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer Kpa=542
    "Heat exchange coefficient between the wall and the outside";
  parameter Modelica.SIunits.Mass Mp=117e3 "Wall mass";
  parameter Modelica.SIunits.SpecificHeatCapacity cpp=600 "Wall specific heat";
  parameter Boolean steady_state=true
    "true: start from steady state - false: start from (P0, Yw0)";

protected
  constant Real pi=Modelica.Constants.pi "Pi";
  constant Modelica.SIunits.Acceleration g=Modelica.Constants.g_n
    "Gravity constant";
  parameter Modelica.SIunits.Area Ap=pi*Rp*Rp
    "Pressurizer cross-sectional area";

public
  Modelica.SIunits.Area Slpin
    "Exchange surface between the liquid and the wall";
  Modelica.SIunits.Area Svpin "Exchange surface between the vapor and the wall";
  Real Yw(start=50) "Liquid level as a percent of the measure scale";
  Real y(start=0.5) "Liquid level as a proportion of the measure scale";
  Modelica.SIunits.Position Zl(start=20) "Liquid level in the pressurizer";
  Modelica.SIunits.Volume Vl "Liquid phase volume";
  Modelica.SIunits.Volume Vv "Gas phase volume";
  Modelica.SIunits.AbsolutePressure P(start=155.0e5) "Average fluid pressure";
  Modelica.SIunits.AbsolutePressure Pfond
    "Fluid pressure at the bottom of the drum";
  Modelica.SIunits.SpecificEnthalpy hl "Liquid phase specific enthalpy";
  Modelica.SIunits.SpecificEnthalpy hv "Gas phase specific enthalpy";
  Modelica.SIunits.SpecificEnthalpy hls
    "Liquid phase saturation specific enthalpy";
  Modelica.SIunits.SpecificEnthalpy hvs
    "Gas phase saturation specific enthalpy";
  Modelica.SIunits.Temperature Tl "Liquid phase temperature";
  Modelica.SIunits.Temperature Tv "Gas phase temperature";
  Modelica.SIunits.Temperature Tp(start=617.24) "Wall temperature";
  Modelica.SIunits.Temperature Ta "External temperature";
  Modelica.SIunits.Power Wlv
    "Thermal power exchanged from the gas phase to the liquid phase";
  Modelica.SIunits.Power Wpl
    "Thermal power exchanged from the liquid phase to the wall";
  Modelica.SIunits.Power Wpv
    "Thermal power exchanged from the gas phase to the wall";
  Modelica.SIunits.Power Wpa
    "Thermal power exchanged from the outside to the wall";
  Modelica.SIunits.Power Wch "Power released by the electrical heaters";
  Modelica.SIunits.MassFlowRate Qcond
    "Condensation mass flow rate from the vapor phase";
  Modelica.SIunits.MassFlowRate Qevap
    "Evaporation mass flow rate from the liquid phase";
  Modelica.SIunits.Density rhol(start=996) "Liquid phase density";
  Modelica.SIunits.Density rhov(start=1.5) "Vapor phase density";

  Connectors.FluidInlet Cas "Water input"
                                 annotation (Placement(transformation(extent={{
            -8,92},{8,108}}, rotation=0)));
  Connectors.FluidOutlet Cs "Steam output"
    annotation (Placement(transformation(extent={{92,90},{108,106}}, rotation=0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort Ca "Thermal input to the wall"
    annotation (Placement(transformation(extent={{-100,-8},{-80,12}}, rotation=
            0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort Cc "Thermal input to the liquid"
    annotation (Placement(transformation(extent={{-10,-42},{10,-22}}, rotation=
            0)));
protected
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prol;
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prov;
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsat;
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsat;
public
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal yLevel
    "Water level"
    annotation (Placement(transformation(extent={{80,-10},{100,10}}, rotation=0)));
  Connectors.FluidOutlet Cex "Water output"
    annotation (Placement(transformation(extent={{-8,-108},{8,-92}}, rotation=0)));
initial equation
  if steady_state then
    der(P) = 0;
    der(hl) = 0;
    der(hv) = 0;
    der(y) = 0;
    der(Tp) = 0;
  else
    P = P0;
    hl = hls;
    hv = hvs;
    Yw = Yw0;
    der(Tp) = 0;
  end if;

equation
  /* Unconnected connectors */
  if (cardinality(Cas) == 0) then
    Cas.Q = 0;
    Cas.h = 1.e5;
    Cas.b = true;
  end if;

  if (cardinality(Cex) == 0) then
    Cex.Q = 0;
    Cex.h = 1.e5;
    Cex.a = true;
  end if;

  if (cardinality(Cs) == 0) then
    Cs.Q = 0;
    Cs.h = 1.e5;
    Cs.a = true;
  end if;

  Cas.P = P;
  Cs.P = P;
  Cex.P = Pfond;

  Cas.h_vol = hl;
  Cs.h_vol = hv;
  Cex.h_vol = hl;

  Ca.W = Wpa;
  Ca.T = Ta;

  Cc.W = Wch;
  Cc.T = Tl;

  yLevel.signal = Yw;

  /* Computation of the geometrical variables */
  Yw = 100*y;
  Zl = Zm*y + 0.5*(V/Ap - Zm);
  Vl = Ap*Zl;
  Vv = V - Vl;
  Slpin = Zl*2*pi*Rp;
  Svpin = (V/Ap - Zl)*2*pi*Rp;

  /* Liquid phase mass balance equation */
  rhol*Ap*Zm*der(y) + Vl*prol.ddph*der(P) + Vl*prol.ddhp*der(hl) = Cas.Q - Cex.Q + Qcond - Qevap;

  /* Gas phase mass balance equation */
  -rhov*Ap*Zm*der(y) + Vv*prov.ddph*der(P) + Vv*prov.ddhp*der(hv) = Qevap - Cs.Q - Qcond;

  /* Liquid phase energy balance equation */
  rhol*Vl*der(hl) - Vl*der(P) = (Qcond + Cas.Q)*(hls - hl) - Qevap*(hvs - hl)
                                - Cex.Q*(Cex.h - hl) - Wpl + Wlv + Wch;

  /* Gas phase energy balance equation */
  rhov*Vv*der(hv) - Vv*der(P) = Qevap*(hvs - hv) - Qcond*(hls - hv)
                                - Cas.Q*(hls - Cas.h) - Wpv - Wlv - Cs.Q*(Cs.h - hv);

  /* Energy balance equation at the wall */
  Mp*cpp*der(Tp) = Wpl + Wpv + Wpa;

  /* Heat exchange between liquid and gas phases */
  Wlv = Klv*Ap*(Tv - Tl);

  /* Heat exchange between the liquid phase and the wall */
  Wpl = Klp*Slpin*(Tl - Tp);

  /* Heat exchange between the gas phase and the wall */
  Wpv = Kvp*Svpin*(Tv - Tp);

  /* Heat exchange between the wall and the outside */
  Wpa = Kpa*Ae*(Ta - Tp);

  /* Pressure in the expansion line */
  Pfond = P + g*(Vl*rhol + Vv*rhov)/Ap;

  /* Condensation and evaporation mass flows */
  Qevap = Cevap*rhol*Vl*(hl - hls)/(hvs - hls);
  //Qcond = noEvent(Ccond*rhov*Vv*(hvs - hv)/(hvs - hls) + (Cas.Q*(hls - Cas.h)
  //   + 0.5*(Wpv + abs(Wpv)) + Wlv)/(hv - hls));
  Qcond = Ccond*rhov*Vv*(hvs - hv)/(hvs - hls);

  /* Fluid thermodynamic properties */
  prol = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(P, hl, 0);
  prov = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(P, hv, 0);
  (lsat,vsat) = ThermoSysPro.Properties.WaterSteam.IF97.Water_sat_P(P);

  Tl = prol.T;
  Tv = prov.T;
  rhol = prol.d;
  rhov = prov.d;
  hls = lsat.h;
  hvs = vsat.h;

  annotation (Icon(graphics={
        Line(
          points={{100,90},{100,60},{80,60},{80,60}},
          color={0,0,255},
          thickness=1),
        Ellipse(
          extent={{-80,-92},{80,-42}},
          lineColor={0,0,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,-14},{80,-68}},
          lineColor={85,170,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-80,42},{80,92}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,40},{0,92}},
          color={0,0,255},
          thickness=1),
        Line(points={{0,38},{0,92}}, color={255,255,255}),
        Rectangle(
          extent={{-80,-14},{80,68}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-79,68},{80,68}}, color={255,255,255}),
        Line(points={{80,60},{100,60},{100,90}}, color={255,255,255})}),
                            Diagram(graphics={
        Ellipse(
          extent={{-80,-92},{80,-42}},
          lineColor={0,0,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,-14},{80,-68}},
          lineColor={85,170,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-80,42},{80,92}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,40},{0,92}},
          color={0,0,255},
          thickness=1),
        Line(points={{0,38},{0,92}}, color={255,255,255}),
        Rectangle(
          extent={{-80,-14},{80,68}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-79,68},{80,68}}, color={255,255,255}),
        Text(
          extent={{58,4},{58,-10}},
          lineColor={0,0,255},
          textString=
               "Niveau"),
        Line(
          points={{100,90},{100,60},{80,60},{80,60}},
          color={0,0,255},
          thickness=1),
        Line(points={{80,60},{100,60},{100,90}}, color={255,255,255})}),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019</b> </p>
<p><b>ThermoSysPro Version 3.2</h4>
<p>This component model is documented in Sect. 14.3 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </h4>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Daniel Bouskela</li>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end Pressurizer;
