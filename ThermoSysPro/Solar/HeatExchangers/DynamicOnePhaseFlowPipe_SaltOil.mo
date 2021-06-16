within ThermoSysPro.Solar.HeatExchangers;
model DynamicOnePhaseFlowPipe_SaltOil "Dynamic one-phase flow pipe Salt-Oil"
  parameter Modelica.SIunits.Length L=10. "Pipe length";
  parameter Modelica.SIunits.Diameter D=0.2 "Internal pipe diameter";
  parameter Real rugosrel=0.0007 "Pipe relative roughness";
  parameter Integer ntubes=1 "Number of pipes in parallel";
  parameter Modelica.SIunits.Position z1=0 "Pipe inlet altitude";
  parameter Modelica.SIunits.Position z2=0 "Pipe outlet altitude";
  parameter Real dpfCorr=1.00
    "Corrective term for the friction pressure loss (dpf) for each node";
  parameter Real hcCorr=1.00
    "Corrective term for the heat exchange coefficient (hc) for each node";
  parameter Integer Ns=10 "Number of segments";
  parameter Modelica.SIunits.Temperature T0[Ns]=fill(290, Ns)
    "Initial fluid temperature (active if steady_state = false)";
  parameter Modelica.SIunits.SpecificEnthalpy h0[Ns]=fill(1e5, Ns)
    "Initial fluid specific enthalpy (active if steady_state = false)";
  parameter Boolean advection=false
    "true: momentum balance equation with advection terme - false: without advection terme";
  parameter Boolean steady_state=true
    "true: start from steady state - false: start from  h0 ";
  parameter Boolean continuous_flow_reversal=true
    "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Integer mode=0
    "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer fluid=1 "1: Oil (TherminolVP1) - 2: Salt (KNO3-NaNO3)";

protected
  constant Modelica.SIunits.Acceleration g=Modelica.Constants.g_n
    "Gravity constant";
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Real eps=1.e-0 "Small number for pressure loss equation";
  parameter Modelica.SIunits.MassFlowRate Qeps=1.e-3
    "Small mass flow rate for continuous flow reversal";
  parameter Integer N=Ns + 1
    "Number of hydraulic nodes (= number of thermal nodes + 1)";
  parameter Modelica.SIunits.Area A=ntubes*pi*D^2/4
    "Internal cross sectional pipe area";
  parameter Modelica.SIunits.Diameter Di=ntubes*D "Internal pipe diameter";
  parameter Modelica.SIunits.PathLength dx1=L/(N - 1)
    "Length of a thermal node";
  parameter Modelica.SIunits.PathLength dx2=L/N "Length of a hydraulic node";
  parameter Modelica.SIunits.Area dSi=pi*Di*dx1
    "Internal heat exchange area for a node";

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
  Real khi[N] "Hydraulic pressure loss coefficient in node i";
  Real lambda[N](start=fill(0.03, N), nominal=fill(0.03, N))
    "Friction pressure loss coefficient in node i";
  Modelica.SIunits.Area Stot "Internal heat exchange area";

public
  WaterSteam.Connectors.FluidInlet C1
                                    annotation (Placement(transformation(extent=
           {{-110,-10},{-90,10}}, rotation=0)));
  WaterSteam.Connectors.FluidOutlet C2
                                    annotation (Placement(transformation(extent=
           {{90,-10},{110,10}}, rotation=0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort CTh[Ns]
    annotation (Placement(transformation(extent={{-10,20},{10,40}}, rotation=0)));
initial equation
  if steady_state then
    for i in 2:N loop
      der(h[i]) = 0;
    end for;
  else
    Tp = T0;

    for i in 2:N loop
      h[i] = h0[i - 1];
    end for;
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
    0 = Q[i] - Q[i + 1];

    /* Energy balance equation */
    A*rho1[i]*der(h[i + 1])*dx1 = hb[i]*Q[i] - hb[i + 1]*Q[i + 1] + dW1[i];

    /* Heat transfer at the wall */
    dW1[i] = hc[i]*dSi*(Tp[i] - T1[i]);

    /* Fluid thermodynamic properties */
    if (fluid == 1) then
      T1[i] = ThermoSysPro.Properties.Oil_TherminolVP1.Temperature_h(h[i + 1]);
      rho1[i] = ThermoSysPro.Properties.Oil_TherminolVP1.Density_T(T1[i]);
      cp[i] = ThermoSysPro.Properties.Oil_TherminolVP1.SpecificHeatCp_T( T1[i]);
      mu1[i] = ThermoSysPro.Properties.Oil_TherminolVP1.DynamicViscosity_T(T1[i]);
      k[i] = ThermoSysPro.Properties.Oil_TherminolVP1.ThermalConductivity_T(T1[i]);
    elseif (fluid == 2) then
      T1[i] = ThermoSysPro.Properties.MoltenSalt.Temperature_h(h[i + 1]);
      rho1[i] = ThermoSysPro.Properties.MoltenSalt.Density_T(T1[i]);
      cp[i] = ThermoSysPro.Properties.MoltenSalt.SpecificHeatCapacityCp_T( T1[i]);
      mu1[i] = ThermoSysPro.Properties.MoltenSalt.DynamicViscosity_T(T1[i]);
      k[i] = ThermoSysPro.Properties.MoltenSalt.ThermalConductivity_T(T1[i]);
    else
      assert(false, "DynamicOnePhaseFlowPipe_SaltOil: invalid option");
    end if;

    /* Heat exchange coefficient (using the Dittus-Boelter correlation) */
    //hc[i] = noEvent(if ((Re1[i] > 1.e-6) and (Pr[i] > 1.e-6)) then hcCorr*0.023*k[i]/D*Re1[i]^0.8*Pr[i]^0.4 else 0);
    if noEvent( Re1[i] > 2000) then
      hc[i] = noEvent(if (Pr[i] > 1.e-6) then hcCorr*0.023*k[i]/D*Re1[i]^0.8*Pr[i]^0.4 else 200);
    else
      // Lévêque equation
      hc[i] = hcCorr*3.66*k[i]/D;
    end if;

    Pr[i] = mu1[i]*cp[i]/k[i];
    Re1[i] = noEvent(abs(4*(Q[i] + Q[i + 1])/2/(pi*Di*mu1[i])));

  end for;

  /* Momentum balance equations (hydraulic nodes) */
  for i in 1:N loop
    /* Flow reversal */
    if continuous_flow_reversal then
      0 = noEvent(if (Q[i] > Qeps) then hb[i] - h[i] else if (Q[i] < -Qeps) then
        hb[i] - h[i + 1] else hb[i] - 0.5*((h[i] - h[i + 1])*Modelica.Math.sin(pi
        *Q[i]/2/Qeps) + h[i + 1] + h[i]));
    else
      0 = if (Q[i] > 0) then hb[i] - h[i] else hb[i] - h[i + 1];
    end if;

    /* Momentum balance equation */
    P[i] - P[i + 1] - dpf[i] - dpg[i] - dpa[i] = 0;

    /* Advection term */
    if advection then
      dpa[i] = noEvent(Q[i]*abs(Q[i])*(1/rhoc[i + 1] - 1/rhoc[i])/A^2);
    else
      dpa[i] = 0;
    end if;

    /* Gravity pressure losses */
    dpg[i] = rho2[i]*g*(z2 - z1)*dx2/L;

    /* Friction pressure losses */
    dpf[i] = noEvent(dpfCorr*khi[i]*Q[i]*abs(Q[i])/(2*A^2*rho2[i]));

    khi[i] = lambda[i]*dx2/D;

    lambda[i] = if noEvent(Re2[i] > 1) then 0.25*(Modelica.Math.log10(13/Re2[i] + rugosrel/3.7/D))^(-2) else 0.01;

    Re2[i] = noEvent(abs(4*Q[i]/(pi*Di*mu2[i])));

    /* Fluid thermodynamic properties */
    if (fluid == 1) then
      T2[i] = ThermoSysPro.Properties.Oil_TherminolVP1.Temperature_h(hb[i]);
      rho2[i] = ThermoSysPro.Properties.Oil_TherminolVP1.Density_T(T2[i]);
      mu2[i] = ThermoSysPro.Properties.Oil_TherminolVP1.DynamicViscosity_T(T2[i]);
    elseif (fluid == 2) then
      T2[i] = ThermoSysPro.Properties.MoltenSalt.Temperature_h(hb[i]);
      rho2[i] = ThermoSysPro.Properties.MoltenSalt.Density_T(T2[i]);
      mu2[i] = ThermoSysPro.Properties.MoltenSalt.DynamicViscosity_T(T2[i]);
    else
      assert(false, "DynamicOnePhaseFlowPipe_SaltOil: invalid option");
    end if;

  end for;

  /* Fluid densities at the boundaries of the nodes */
  for i in 2:N loop
    rhoc[i] = rho1[i - 1];
  end for;

  //proc[1] = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(P[1], h[1], mode);
  //proc[2] = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(P[N + 1],h[N + 1], mode);
  //rhoc[1] = proc[1].d;
  //rhoc[N + 1] = proc[2].d;

  rhoc[1] = rho1[1];
  rhoc[N + 1] = rhoc[N];

  W1t = sum(dW1);

  Stot = dSi*Ns;

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
          extent={{-100,20},{100,-20}},
          lineColor={28,108,200},
          fillColor={78,78,235},
          fillPattern=FillPattern.Solid),
        Line(points={{60,20},{60,-20}}, color={255,255,255}),
        Line(points={{20,20},{20,-20}}, color={255,255,255}),
        Line(points={{-20,20},{-20,-20}}, color={255,255,255}),
        Line(points={{-60,20},{-60,-20}}, color={255,255,255})}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,20},{100,-20}},
          lineColor={0,0,255},
          fillColor={78,78,235},
          fillPattern=FillPattern.Solid),
        Line(points={{-60,20},{-60,-20}}, color={255,255,255}),
        Line(points={{-20,20},{-20,-20}}, color={255,255,255}),
        Line(points={{20,20},{20,-20}}, color={255,255,255}),
        Line(points={{60,20},{60,-20}}, color={255,255,255})}),
    Window(
      x=0.18,
      y=0.05,
      width=0.68,
      height=0.94),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2012</h4></p>
<p><b>ThermoSysPro Version 3.1</h4>
</html>",
   revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end DynamicOnePhaseFlowPipe_SaltOil;
