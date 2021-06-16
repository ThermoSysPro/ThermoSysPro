within ThermoSysPro.WaterSteam.HeatExchangers;
model SimpleDynamicCondenser
  parameter Modelica.SIunits.Volume V=1 "Cavity volume";
  parameter Modelica.SIunits.Area A=1 "Cavity cross-sectional area";
  parameter Real Vf0=0.5
    "Fraction of initial water volume in the drum (active if steady_state=false)";
  parameter Modelica.SIunits.AbsolutePressure P0=0.1e5
    "Fluid initial pressure (active if steady_state=false)";
  parameter Boolean gravity_pressure=false
    "true: fluid pressure at the bottom of the cavity includes gravity term - false: without gravity term";
  parameter Real Ccond=0.01 "Condensation coefficient";
  parameter Real Cevap=0.09 "Evaporation coefficient";
  parameter Real Xlo=0.0025
    "Vapor mass fraction in the liquid phase from which the liquid starts to evaporate";
  parameter Real Xvo=0.9975
    "Vapor mass fraction in the gas phase from which the liquid starts to condensate";
  parameter Modelica.SIunits.Area Avl=A
    "Heat exchange surface between the liquid and gas phases";
  parameter Real Kvl=1000
    "Heat exchange coefficient between the liquid and gas phases";
  parameter Modelica.SIunits.Length L=10. "Pipe length";
  parameter Modelica.SIunits.Diameter D=0.02 "Pipe internal diameter";
  parameter Modelica.SIunits.Length e=2.e-3 "Wall thickness";
  parameter Modelica.SIunits.Position z1=0 "Inlet altitude";
  parameter Modelica.SIunits.Position z2=0 "Outlet altitude";
  parameter Modelica.SIunits.Length rugosrel=0.0007 "Pipe roughness";
  parameter Real lambda= 0.03
    "Friction pressure loss coefficient (active if lambda_fixed=true)";
  parameter Integer ntubes=1 "Number of pipes in parallel";
  parameter Modelica.SIunits.Area At=ntubes*pi*D^2/4
    "Internal pipe cross-section area (cooling fluid)";
  parameter Boolean steady_state=true
    "true: start from steady state - false: start from (P0, Vl0)";
  parameter Integer mode=0
    "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";

protected
  constant Modelica.SIunits.Acceleration g=Modelica.Constants.g_n
    "Gravity constant";
  parameter Modelica.SIunits.MassFlowRate Qeps=1.e-3
    "Small mass flow rate for continuous flow reversal";
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Real eps=1.e-0 "Small number for pressure loss equation";

public
  Modelica.SIunits.Density rhom(start=998) "Liquid phase density";
  ThermoSysPro.Units.DifferentialPressure dpf "Friction pressure loss";
  ThermoSysPro.Units.DifferentialPressure dpg "Gravity pressure loss";
  Real khi "Hydraulic pressure loss coefficient";
  Modelica.SIunits.AbsolutePressure P "Fluid average pressure";
  Modelica.SIunits.AbsolutePressure Pfond
    "Fluid pressure at the bottom of the cavity";
  Modelica.SIunits.SpecificEnthalpy hl "Liquid phase spepcific enthalpy";
  Modelica.SIunits.SpecificEnthalpy hv "Gas phase spepcific enthalpy";
  Modelica.SIunits.Temperature Tl "Liquid phase temperature";
  Modelica.SIunits.Temperature Tv "Gas phase temperature";
  Modelica.SIunits.Volume Vl "Liquid phase volume";
  Modelica.SIunits.Volume Vv "Gas phase volume";
  Real xl(start=0.0) "Mass vapor fraction in the liquid phase";
  Real xv(start=1) "Mass vapor fraction in the gas phase";
  Modelica.SIunits.Density rhol(start=996) "Liquid phase density";
  Modelica.SIunits.Density rhov(start=1.5) "Gas phase density";
  Modelica.SIunits.MassFlowRate BQl
    "Right hand side of the mass balance equation of the liquid phase";
  Modelica.SIunits.MassFlowRate BQv
    "Right hand side of the mass balance equation of the gas phaser";
  Modelica.SIunits.Power BHl
    "Right hand side of the energy balance equation of the liquid phase";
  Modelica.SIunits.Power BHv
    "Right hand side of the energy balance equation of the gas phase";
  Modelica.SIunits.MassFlowRate Qcond
    "Condensation mass flow rate from the vapor phase";
  Modelica.SIunits.MassFlowRate Qevap
    "Evaporation mass flow rate from the liquid phase";
  Modelica.SIunits.Power Wvl
    "Thermal power exchanged from the gas phase to the liquid phase";
  Modelica.SIunits.Power Wout
    "Thermal power exchanged from the steam to the pipes";
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prol
    "Propriétés de l'eau dans le ballon" annotation (Placement(transformation(
          extent={{-100,80},{-80,100}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prov
    "Propriétés de la vapeur dans le ballon" annotation (Placement(
        transformation(extent={{80,80},{100,100}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsat
    annotation (Placement(transformation(extent={{-30,40},{-10,60}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsat
                                           annotation (Placement(transformation(
          extent={{10,40},{30,60}}, rotation=0)));
  Connectors.FluidInlet Cv     annotation (Placement(transformation(extent={{
            -10,90},{10,110}}, rotation=0)));
  Connectors.FluidOutlet Cl     annotation (Placement(transformation(extent={{
            -8,-110},{12,-90}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal yNiveau          annotation (Placement(
        transformation(extent={{100,-82},{120,-62}}, rotation=0)));
public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prod
    annotation (Placement(transformation(extent={{-60,20},{-40,40}}, rotation=0)));
public
  Connectors.FluidInlet Cee    annotation (Placement(transformation(extent={{
            -110,-32},{-90,-12}}, rotation=0)));
  Connectors.FluidOutlet Cse   annotation (Placement(transformation(extent={{90,
            -30},{110,-10}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proe
    "Propriétés de l'eau "                   annotation (Placement(
        transformation(extent={{40,20},{60,40}}, rotation=0)));
initial equation
  if steady_state then
    der(hl) = 0;
    der(hv) = 0;
    der(Vl) = 0;
    der(P) = 0;
  else
    hl = lsat.h;
    hv = vsat.h;
    Vl = Vf0*V;
    P = P0;
  end if;

equation

  /* Unconnected connectors */
  if (cardinality(Cl) == 0) then
    Cl.Q = 0;
    Cl.h = 1.e5;
    Cl.a = true;
  end if;

  if (cardinality(Cv) == 0) then
    Cv.Q = 0;
    Cv.h = 1.e5;
    Cv.b = true;
  end if;

  if (cardinality(Cee) == 0) then
    Cee.Q = 0;
    Cee.h = 1.e5;
    Cee.b = true;
  end if;

  if (cardinality(Cse) == 0) then
    Cse.Q = 0;
    Cse.h = 1.e5;
    Cse.a = true;
  end if;

  Cl.P = Pfond;
  Cv.P = P;

  V = Vl + Vv;

  Cee.Q = Cse.Q;

  /* Flow reversal */
  if continuous_flow_reversal then
    0 = noEvent(if (Cee.Q > Qeps) then Cee.h - Cee.h_vol else if (Cee.Q < -Qeps) then
      Cse.h - Cse.h_vol else Cee.h - 0.5*((Cee.h_vol - Cse.h_vol)*Modelica.Math.sin(pi
      *Cee.Q/2/Qeps) + Cee.h_vol + Cse.h_vol));
  else
    0 = if (Cee.Q > 0) then Cee.h - Cee.h_vol else Cse.h - Cse.h_vol;
  end if;

  /* Pressure at the bottom of the condenser */
  Pfond = if gravity_pressure then P + prod.d*g*Vl/A else P;

  /* Water mass balance equation */
  BQl = -Cl.Q + Qcond - Qevap;
  rhol*der(Vl) + Vl*(prol.ddph*der(P) + prol.ddhp*der(hl)) = BQl;

  /* Vapor mass balance equation */
  BQv = Cv.Q + Qevap - Qcond;
  rhov*der(Vv) + Vv*(prov.ddph*der(P) + prov.ddhp*der(hv)) = BQv;

  /* Water energy balance equation */
  BHl = -Cl.Q*(Cl.h - (hl - P/rhol)) + Qcond*(lsat.h - (hl - P/rhol)) - Qevap*(vsat.h - (hl - P/rhol)) + Wvl;
  Vl*((P/rhol*prol.ddph - 1)*der(P) + (P/rhol*prol.ddhp + rhol)*der(hl)) = BHl;

  Cl.h_vol = hl;

  /* Vapor energy balance equation */
  BHv = Cv.Q*(Cv.h - (hv - P/rhov)) + Qevap*(vsat.h - (hv - P/rhov)) - Qcond*(lsat.h - (hv - P/rhov)) - Wvl + Wout;
  Vv*((P/rhov*prov.ddph - 1)*der(P) + (P/rhov*prov.ddhp + rhov)*der(hv)) = BHv;

  Cv.h_vol = hv;

  /* Heat transfer between the water and the vapor */
  Wvl = Kvl*Avl*(Tv - Tl);

  /* Condensation and evaporation mass flow rates */
  Qcond = if  (xv < Xvo) then Ccond*rhov*Vv*(Xvo - xv) else 0;
  Qevap = if noEvent((xl > Xlo)) then Cevap*rhol*Vl*(xl - Xlo) else 0;

  /* Water level */
  yNiveau.signal = Vl/A;

  /* Thermal power exchanged from the steam to the pipes */
  Wout = -Cv.Q*(Cv.h - hl);
  Wout = -Cee.Q*(Cse.h - Cee.h);

  /* Pressure losses in the pipes */
  dpf = khi*ThermoSysPro.Functions.ThermoSquare(Cee.Q,eps)/(2*At^2*rhom);
  //dpg = rhom*g*(z2 - z1)*L;
  dpg = rhom*g*(z2 - z1);

  khi = lambda*L/D;

  Cee.P - Cse.P = dpf + dpg;

  /* Fluid thermodynamic properties */
  prol = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(P,hl,0);
  prov = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(P,hv,0);
  prod = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Pfond,Cl.h,0);
  proe = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph((Cee.P+Cse.P)/2, (Cee.h+Cse.h)/2, mode);

  (lsat,vsat) = ThermoSysPro.Properties.WaterSteam.IF97.Water_sat_P(P);

  rhom = proe.d;

  Tl = prol.T;
  rhol = prol.d;
  xl = prol.x;

  Tv = prov.T;
  rhov = prov.d;
  xv = prov.x;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{100,20},{80,-60}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,20},{-80,-60}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,6},{-80,0}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,-18},{-80,-24}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,-40},{-80,-46}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,6},{20,0}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,-40},{20,-46}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,-18},{20,-24}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,-18},{-30,-24}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,-40},{-30,-46}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,6},{-30,0}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,-72},{100,-100}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-20,100},{20,100},{100,20},{100,-100},{-100,-100},{-100,20},
              {-20,100}},
          color={0,0,255},
          thickness=0.5)}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(
          points={{-20,100},{20,100},{100,20},{100,-100},{-100,-100},{-100,20},
              {-20,100}},
          color={0,0,255},
          thickness=0.5),
        Rectangle(
          extent={{100,20},{80,-60}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,20},{-80,-60}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,6},{-80,0}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,-18},{-80,-24}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,-40},{-80,-46}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,6},{20,0}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,-40},{20,-46}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,-18},{20,-24}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,-18},{-30,-24}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,-40},{-30,-46}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,6},{-30,0}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,-72},{100,-100}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-2,102},{-22,100},{-42,94},{-62,82},{-82,62},{-94,42},{-100,
              22},{-100,20},{-98,20},{100,20},{100,20},{96,28},{90,42},{78,62},
              {58,82},{38,94},{18,100},{-2,102}},
          lineColor={0,0,255},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-66,66},{72,22}},
          lineColor={0,0,255},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          textString=
               "Simple")}),
    Window(
      x=0.11,
      y=0.06,
      width=0.78,
      height=0.88),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2014</b> </p>
<p><b>ThermoSysPro Version 3.1</h4>
<p>This component model is documented in Sect. 9.5.3 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </h4>
</html>", revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end SimpleDynamicCondenser;
