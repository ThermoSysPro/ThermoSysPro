within ThermoSysPro.WaterSteam.HeatExchangers;
model DynamicOnePhaseFlowShell "Dynamic one-phase flow shell"
  parameter Integer option_arrangement = 1 "1:triangle - 2: square";
  parameter Modelica.SIunits.Length L=12 "Shell length";
  parameter Modelica.SIunits.Diameter Ds = 1 "shell internal diameter";
  parameter Modelica.SIunits.Diameter De = 0.019 "tube external diameter";
  parameter Modelica.SIunits.Distance dc = 0.030
    "Central distance of two tubes";
  parameter Modelica.SIunits.Length B = 1.2
    "distance between two plates in the shell";
  parameter Real rugosrel=0.0007 "Pipe relative roughness";
  parameter Integer ntubes=500 "Number of pipes in parallel";
  parameter Modelica.SIunits.Position z1=0 "Pipe inlet altitude";
  parameter Modelica.SIunits.Position z2=0 "Pipe outlet altitude";
  parameter Real dpfCorr=1.00
    "Corrective term for the friction pressure loss (dpf) for each node";
  parameter Real hcCorr=1.00
    "Corrective term for the heat exchange coefficient (hc) for each node";
  parameter Integer Ns=10 "Number of segments";
  parameter Modelica.SIunits.Temperature T0[Ns]=fill(290, Ns)
    "Initial fluid temperature (active if steady_state = false and option_temperature = 1)";
  parameter Modelica.SIunits.SpecificEnthalpy h0[Ns]=fill(1e5, Ns)
    "Initial fluid specific enthalpy (active if steady_state = false and option_temperature = 2)";
  parameter Boolean inertia=true
    "true: momentum balance equation with inertia - false: without inertia";
  parameter Boolean advection=false
    "true: momentum balance equation with advection terme - false: without advection terme";
  parameter Boolean dynamic_mass_balance=true
    "true: dynamic mass balance equation - false: static mass balance equation";
  parameter Boolean dynamic_energy_balance=true
    "true: dynamic energy balance equation - false: static energy balance equation";
  parameter Boolean simplified_dynamic_energy_balance=true
    "true: simplified dynamic energy balance equation - false: full dynamic energy balance equation (active if dynamic_energy_balance=true)";
  parameter Boolean steady_state=true
    "true: start from steady state - false: start from T0 (if option_temperature=1) or h0 (if option_temperature=2)";
  parameter Integer option_temperature=1
    "1:initial temperature is fixed - 2:initial specific enthalpy is fixed (active if steady_state = false)";
  parameter Boolean continuous_flow_reversal=true
    "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Integer mode=0
    "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Modelica.SIunits.Area As = B*Ds*dt/dc
    "maximum cross sectional area of flow in shell";
  parameter Modelica.SIunits.Area A = pi*Ds^2/4 - ntubes*pi*De^2/4
    "Liquid cross sectional in shell";

protected
  parameter Integer Nb = integer(floor(L/B));
  parameter Modelica.SIunits.Distance dt = dc - De "distance between two tubes";
  constant Modelica.SIunits.Acceleration g=Modelica.Constants.g_n
    "Gravity constant";
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Real eps=1.e-0 "Small number for pressure loss equation";
  parameter Modelica.SIunits.MassFlowRate Qeps=1.e-3
    "Small mass flow rate for continuous flow reversal";
  parameter Integer N=Ns + 1
    "Number of hydraulic nodes (= number of thermal nodes + 1)";
  parameter Modelica.SIunits.Diameter Deq = if (option_arrangement ==1) then (3.464*dc^2 - pi*De^2)/(pi*De) else if (option_arrangement ==2) then (4*dc^2 - pi*De^2)/(pi*De) else De
    "equivalent diameter of triangle arrangement between tubes";
  parameter Modelica.SIunits.Area dSi=pi*De*ntubes*dx1
    "Internal heat exchange area for a node";
  parameter Modelica.SIunits.PathLength dx1=L/(N - 1)
    "Length of a thermal node";
  parameter Modelica.SIunits.PathLength dx2=L/N "Length of a hydraulic node";

public
  Modelica.SIunits.AbsolutePressure P[N + 1](start=fill(1.e5, N + 1), nominal=fill(1.e5, N + 1))
    "Fluid pressure in node i";
  Modelica.SIunits.MassFlowRate Q[N](start=fill(10, N), nominal=fill(10, N))
    "Mass flow rate in node i";
  Modelica.SIunits.SpecificEnthalpy h[N + 1](start=fill(1.e5, N + 1), nominal=fill(1.e6, N + 1))
    "Fluid specific enthalpy in node i";
  Modelica.SIunits.SpecificEnthalpy hb[N]
    "Fluid specific enthalpy at the boundary of node i";
  Modelica.SIunits.Density rho1[N - 1](start=fill(998, N - 1), nominal=fill(1, N - 1))
    "Fluid density in thermal node i";
  Modelica.SIunits.Density rho2[N](start=fill(998, N), nominal=fill(1, N))
    "Fluid density in hydraulic node i";
  Modelica.SIunits.Density rhoc[N + 1](start=fill(998, N + 1), nominal=fill(1, N + 1))
    "Fluid density at the boudary of node i";
  Modelica.SIunits.Power dW1[N - 1](start=fill(3.e5, N - 1), nominal=fill(3.e5, N - 1))
    "Thermal power exchanged on the water side for node i";
  Modelica.SIunits.Power W1t "Total power exchanged on the water side";
  Modelica.SIunits.Temperature Tp[N - 1](start=T0) "Wall temperature in node i";
  Modelica.SIunits.CoefficientOfHeatTransfer hc[N - 1](start=fill(2000, N - 1), nominal=fill(200, N - 1))
    "Fluid heat exchange coefficient in node i";
  Modelica.SIunits.ReynoldsNumber Re1[N - 1](start=fill(6.e4, N - 1), nominal=fill(0.5e4, N - 1))
    "Fluid Reynolds number in thermal node i";
  Modelica.SIunits.ReynoldsNumber Re2[N](start=fill(6.e4, N), nominal=fill(0.5e4, N))
    "Fluid Reynolds number in hydraulic node i";
  Real Pr[N - 1](start=fill(4, N - 1), nominal=fill(1, N - 1))
    "Fluid Prandtl number in node i";
  Modelica.SIunits.ThermalConductivity k[N - 1](start=fill(0.6, N - 1), nominal=fill(0.6, N - 1))
    "Fluid thermal conductivity in node i";
  Modelica.SIunits.DynamicViscosity mu1[N - 1](start=fill(2.e-4, N - 1), nominal=fill(2.e-4, N - 1))
    "Fluid dynamic viscosity in thermal node i";
  Modelica.SIunits.DynamicViscosity mu2[N](start=fill(2.e-4, N), nominal=fill(2.e-4, N))
    "Fluid dynamic viscosity in hydraulic node i";
  Modelica.SIunits.SpecificHeatCapacity cp[N - 1](start=fill(4000, N - 1), nominal=fill(4000, N - 1))
    "Fluid specific heat capacity";
  Modelica.SIunits.Temperature T1[N - 1] "Fluid temperature in thermal node i";
  Modelica.SIunits.Temperature T2[N] "Fluid temperature in hydraulic node i";
  ThermoSysPro.Units.DifferentialPressure dpa[N]
    "Advection term for the mass balance equation in node i";
  ThermoSysPro.Units.DifferentialPressure dpf[N]
    "Friction pressure loss in node i";
  ThermoSysPro.Units.DifferentialPressure dpg[N]
    "Gravity pressure loss in node i";
  Real lambda[N](start=fill(0.03, N), nominal=fill(0.03, N))
    "Friction pressure loss coefficient in node i";
  Modelica.SIunits.Diameter Deq1;

  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro1[
                                                              N - 1]
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proc[
                                                              2]
    annotation (Placement(transformation(extent={{60,80},{80,100}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro2[
                                                              N]
    annotation (Placement(transformation(extent={{-60,80},{-40,100}}, rotation=
            0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsat[
                                                        N - 1]
    annotation (Placement(transformation(extent={{-20,80},{0,100}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsat[
                                                        N - 1]
    annotation (Placement(transformation(extent={{20,80},{40,100}}, rotation=0)));
public
  Connectors.FluidInlet C1          annotation (Placement(transformation(extent=
           {{-110,-10},{-90,10}}, rotation=0)));
  Connectors.FluidOutlet C2         annotation (Placement(transformation(extent=
           {{90,-10},{110,10}}, rotation=0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort CTh[Ns]
    annotation (Placement(transformation(extent={{-10,20},{10,40}}, rotation=0)));
initial equation
  if steady_state then
    for i in 2:N loop
      der(h[i]) = 0;
    end for;
  else
    if (option_temperature == 1) then
      for i in 2:N loop
        h[i] = ThermoSysPro.Properties.WaterSteam.IF97.SpecificEnthalpy_PT(
          P[i],
          T0[i - 1],
          mode);
      end for;
    elseif (option_temperature == 2) then
      for i in 2:N loop
        h[i] = h0[i - 1];
      end for;
    else
      assert(false, "DynamicOnePhaseFlowPipe: incorrect option");
    end if;
  end if;

  if dynamic_mass_balance then
    for i in 2:N loop
      der(P[i]) = 0;
    end for;
  end if;

  if inertia then
    if dynamic_mass_balance then
      for i in 1:N loop
        der(Q[i]) = 0;
      end for;
    else
      der(Q[1]) = 0;
    end if;
  end if;

equation

  /* Wall temperature */
  Tp = CTh.T;
  CTh.W = dW1;

  /* Pipe boundaries */
  P[1] = C1.P;
  P[N + 1] = C2.P;

  Q[1] = C1.Q;
  Q[N] = C2.Q;

  hb[1] = C1.h;
  hb[N] = C2.h;

  h[1] = C1.h_vol;
  h[N + 1] = C2.h_vol;

  /* Mass and energy balance equations (thermal nodes) */
  for i in 1:N - 1 loop
    /* Mass balance equation */
    if dynamic_mass_balance then
      A*(pro1[i].ddph*der(P[i + 1]) + pro1[i].ddhp*der(h[i + 1]))*dx1 = Q[i] - Q[i + 1];
    else
      0 = Q[i] - Q[i + 1];
    end if;

    /* Energy balance equation */
    if dynamic_energy_balance then
      if simplified_dynamic_energy_balance then
        A*(-der(P[i + 1]) + rho1[i]*der(h[i + 1]))*dx1 = hb[i]*Q[i] - hb[i + 1]*Q[i + 1] + dW1[i];
      else
        A*((h[i + 1]*pro1[i].ddph - 1)*der(P[i + 1]) + (h[i + 1]*pro1[i].ddhp + rho1[i])*der(h[i + 1]))*dx1 = hb[i]*Q[i] - hb[i + 1]*Q[i + 1] + dW1[i];
      end if;
    else
      A*rho1[i]*der(h[i + 1])*dx1 = hb[i]*Q[i] - hb[i + 1]*Q[i + 1] + dW1[i];
    end if;

    /* Heat transfer at the wall */
    dW1[i] = hc[i]*dSi*(Tp[i] - T1[i]);

    /* Fluid thermodynamic properties */
    pro1[i] = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(P[i + 1], h[i + 1], mode);

    rho1[i] = pro1[i].d;
    T1[i] = pro1[i].T;

    (lsat[i],vsat[i]) = ThermoSysPro.Properties.WaterSteam.IF97.Water_sat_P(P[i + 1]);

    cp[i] = pro1[i].cp;

    mu1[i] = ThermoSysPro.Properties.WaterSteam.IF97.DynamicViscosity_rhoT(rho1[i], T1[i]);
    k[i] = noEvent(ThermoSysPro.Properties.WaterSteam.IF97.ThermalConductivity_rhoT(rho1[i], T1[i], P[i + 1]));

    /* Heat exchange coefficient (using the Dittus-Boelter correlation) */
    Pr[i] = mu1[i]*cp[i]/k[i];
    Re1[i] = noEvent(abs(De*(Q[i] + Q[i + 1])/(2*As*mu1[i])));

    hc[i] = hcCorr*(noEvent(if (Re1[i] < 2000) then 0.5*(k[i]/De)*Re1[i]^0.507*Pr[i]^0.33 else if ((Re1[i] > 2000) and (Re1[i] < 1e6)) then 0.36 * (k[i]/De) *Re1[i]^0.55*Pr[i]^0.33 else 0.023*k[i]/De*Re1[i]^0.8*Pr[i]^0.4));
    //hc[i] = noEvent(if ((Re1[i] > 1.e-6) and (Pr[i] > 1.e-6)) then hcCorr*0.023*k[i]/D*Re1[i]^0.8*Pr[i]^0.4 else 0);

  end for;

  /* Momentum balance equations (hydraulic nodes) */
  for i in 1:N loop
    /* Flow reversal */
    if continuous_flow_reversal then
      0 = noEvent(if (Q[i] > Qeps) then hb[i] - h[i] else if (Q[i] < -Qeps) then
        hb[i] - h[i + 1] else hb[i] - 0.5*((h[i] - h[i + 1])*Modelica.Math.sin(pi*Q[i]/2/Qeps) + h[i + 1] + h[i]));
    else
      0 = if (Q[i] > 0) then hb[i] - h[i] else hb[i] - h[i + 1];
    end if;

    /* Momentum balance equation */
    if inertia then
      1/As*der(Q[i])*dx2 = P[i] - P[i + 1] - dpf[i] - dpg[i] - dpa[i];
    else
      P[i] - P[i + 1] - dpf[i] - dpg[i] - dpa[i] = 0;
    end if;

    /* Advection term */
    if advection then
      dpa[i] = Q[i]^2*(1/rhoc[i + 1] - 1/rhoc[i])/As^2;
    else
      dpa[i] = 0;
    end if;

    /* Fluid thermodynamic properties */
    pro2[i] = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph((P[i] + P[i + 1])/2,hb[i], mode);

    rho2[i] = pro2[i].d;
    T2[i] = pro2[i].T;

    mu2[i] = ThermoSysPro.Properties.WaterSteam.IF97.DynamicViscosity_rhoT(rho2[i], T2[i]);
    //Re2[i] = noEvent(abs(Deq*Q[i]/(As*mu2[i])));
    Re2[i] = noEvent(De*abs(Q[i])/(As*mu2[i]));

    /* Gravity pressure losses */
    dpg[i] = rho2[i]*g*(z2 - z1)*dx2/L;

    /* Friction pressure losses */
    // Ds/dc is the number of rows
    //dpf[i] = noEvent(dpfCorr*Ds/dc*lambda[i]*Q[i]*abs(Q[i])/(2*As^2*rho2[i]));
   dpf[i] = noEvent(dpfCorr*Ds/dc*(Nb +1)*lambda[i]*Q[i]*abs(Q[i])/(2*As^2*rho2[i])/N);

    //lambda[i] = if noEvent(Re2[i] > 1) then 0.25*(Modelica.Math.log10(13/Re2[i] + rugosrel/3.7/De))^(-2) else 0.01;
    lambda[i] = Modelica.Math.exp(0.576-0.19*Modelica.Math.log(Re2[i]));
  end for;

  /* Fluid densities at the boundaries of the nodes */
  for i in 2:N loop
    rhoc[i] = rho1[i - 1];
  end for;

  proc[1] = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(P[1], h[1], mode);
  proc[2] = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(P[N + 1], h[N + 1], mode);

  rhoc[1] = proc[1].d;
  rhoc[N + 1] = proc[2].d;

  W1t = sum(dW1);

  Deq1 = Deq;
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-60,20},{-60,-20}}),
        Line(points={{-20,20},{-20,-20}}),
        Line(points={{20,20},{20,-20}}),
        Line(points={{60,20},{60,-20}}),
        Line(points={{-60,20},{-60,-20}}),
        Line(points={{-20,20},{-20,-20}}),
        Line(points={{20,20},{20,-20}}),
        Line(points={{60,20},{60,-20}}),
        Rectangle(
          extent={{-100,30},{100,-30}},
          lineColor={28,108,200},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{60,10},{60,-30}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{20,30},{20,-10}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-20,10},{-20,-30}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-60,30},{-60,-10}},
          color={0,0,0},
          thickness=1),
        Line(points={{-20,29},{-20,11}}, color={255,255,255}),
        Line(points={{-60,-10},{-60,-30}}, color={255,255,255}),
        Line(points={{20,-10},{20,-30}}, color={255,255,255}),
        Line(points={{60,30},{60,11}}, color={255,255,255}),
        Ellipse(
          extent={{-31,-35},{31,-95}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{14,-47},{24,-57}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-24,-74},{-14,-84}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{14,-73},{24,-83}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-14,-60},{-4,-70}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{6,-60},{16,-70}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{18,-60},{28,-70}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-12,-81},{-2,-91}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{2,-82},{12,-92}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{2,-39},{12,-49}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-29,-61},{-19,-71}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-5,-50},{5,-60}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-12,-39},{-2,-49}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-4,-69},{6,-79}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-24,-47},{-14,-57}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid)}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,30},{100,-30}},
          lineColor={28,108,200},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,30},{-60,-10}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-20,11},{-20,-29}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{20,30},{20,-10}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{60,10},{60,-30}},
          color={0,0,0},
          thickness=1),
        Line(points={{-20,30},{-20,12}}, color={255,255,255}),
        Line(points={{-60,-9},{-60,-29}}, color={255,255,255}),
        Line(points={{20,-9},{20,-29}}, color={255,255,255}),
        Line(points={{60,31},{60,12}}, color={255,255,255})}),
    Window(
      x=0.18,
      y=0.05,
      width=0.68,
      height=0.94),
    Documentation(info="<html>
<h4>Copyright &copy; EDF 2002 - 2019</h4>
<p><b>ThermoSysPro Version 3.2</h4>
<p>This component model is documented in Sect. 9.4.3 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </h4>
<p>Nota: component model name in title of Sect. 9.4.3.3 in book is incorrectly given as DynamicTwoPhaseFlowShell, instead of DynamicOnePhaseFlowShell</a>. </h4>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Baligh El Hefni</li>
<li>Daniel Bouskela</li>
<li>Jiahui Lu</li>
</ul>
</html>"));
end DynamicOnePhaseFlowShell;
