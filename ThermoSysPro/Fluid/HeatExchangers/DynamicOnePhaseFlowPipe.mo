within ThermoSysPro.Fluid.HeatExchangers;
model DynamicOnePhaseFlowPipe "Dynamic one-phase flow pipe"
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Units.SI.Length L=10. "Pipe length";
  parameter Units.SI.Diameter D=0.2 "Internal pipe diameter";
  parameter Real rugosrel=0.0007 "Pipe relative roughness";
  parameter Integer ntubes=1 "Number of pipes in parallel";
  parameter Units.SI.Position z1=0 "Pipe inlet altitude";
  parameter Units.SI.Position z2=0 "Pipe outlet altitude";
  parameter Real CSailettes=1 "Increase/decrease factor of the heat exchange surface for solar receiver or boiler ";
  parameter Real dpfCorr=1.00 "Corrective term for the friction pressure loss (dpf) for each node";
  parameter Real hcCorr=1.00 "Corrective term for the heat exchange coefficient (hc) for each node";
  parameter Integer Ns=10 "Number of segments";
  parameter Units.SI.AbsolutePressure P0=1.e5
    "Fluid initial pressure (active if steady_state = false)"
    annotation (Evaluate=true, Dialog(enable=not steady_state));
  parameter Units.SI.Temperature T0[Ns]=fill(290, Ns)
    "Initial fluid temperature (active if steady_state = false and option_temperature=true)"
    annotation (Evaluate=true, Dialog(enable=not steady_state and
          option_temperature));
  parameter Units.SI.SpecificEnthalpy h0[Ns]=fill(1e5, Ns)
    "Initial fluid specific enthalpy (active if steady_state = false and option_temperature=false)"
    annotation (Evaluate=true, Dialog(enable=not steady_state and not
          option_temperature));
  parameter Boolean inertia=true
    "true: momentum balance equation with inertia - false: without inertia";
  parameter Boolean advection=false
    "true: momentum balance equation with advection terme - false: without advection terme";
  parameter Boolean dynamic_energy_balance=true
    "true: dynamic energy balance equation - false: static energy balance equation";
  parameter Boolean dynamic_mass_balance=true
    "true: dynamic mass balance equation - false: static mass balance equation (active if dynamic_energy_balance=true)" annotation(Evaluate=true, Dialog(enable=dynamic_energy_balance));
  parameter Boolean simplified_dynamic_energy_balance=true
    "true: simplified dynamic energy balance equation - false: full dynamic energy balance equation (active if dynamic_energy_balance=true and dynamic_mass_balance=true)" annotation(Evaluate=true, Dialog(enable=dynamic_energy_balance and dynamic_mass_balance));
  parameter Boolean steady_state=true
    "true: start from steady state - false: start from T0 (if option_temperature = true) or h0 (if option_temperature=false)(active if dynamic_energy_balance=true)" annotation(Evaluate=true, Dialog(enable=dynamic_energy_balance));
  parameter Boolean option_temperature=true
    "true: initial temperature is fixed - false: initial specific enthalpy is fixed (active if steady_state=false)" annotation(Evaluate=true, Dialog(enable=not steady_state));
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Boolean diffusion=false
    "true: energy balance equation with diffusion - false: energy balance equation without diffusion";
  parameter IF97Region region=IF97Region.All_regions "IF97 region (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

protected
  constant Units.SI.Acceleration g=Modelica.Constants.g_n "Gravity constant";
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Integer mode=Integer(region) - 1 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer N=Ns + 1 "Number of hydraulic nodes (= number of thermal nodes + 1)";
  parameter Units.SI.Area A=ntubes*pi*D^2/4
    "Internal cross sectional pipe area";
  parameter Units.SI.Diameter Di=ntubes*D "Internal pipe diameter";
  parameter Units.SI.PathLength dx1=L/(N - 1) "Length of a thermal node";
  parameter Units.SI.PathLength dx2=L/N "Length of a hydraulic node";
  parameter Units.SI.Area dSi=pi*Di*dx1*CSailettes
    "Internal heat exchange area for a node";
  parameter Units.SI.MassFlowRate gamma0=1.e-4
    "Pseudo-diffusion conductance use for continuous flow reversal (active if diffusion=false and continuous_flow_reversal=true)";

public
  Units.SI.AbsolutePressure P[N + 1](start=fill(1.e5, N + 1), nominal=fill(1.e5,
        N + 1)) "Fluid pressure in node i";
  Units.SI.MassFlowRate Q[N](start=fill(10, N), nominal=fill(10, N))
    "Mass flow rate in node i";
  Units.SI.SpecificEnthalpy h[N + 1](start=fill(1.e5, N + 1), nominal=fill(1.e6,
        N + 1)) "Fluid specific enthalpy in node i";
  Units.SI.SpecificEnthalpy hb[N]
    "Fluid specific enthalpy at the boundary of node i";
  Units.SI.Density rho1[N - 1](start=fill(998, N - 1), nominal=fill(1, N - 1))
    "Fluid density in thermal node i";
  Units.SI.Density rho2[N](start=fill(998, N), nominal=fill(1, N))
    "Fluid density in hydraulic node i";
  Units.SI.Density rhoc[N + 1](start=fill(998, N + 1), nominal=fill(1, N + 1))
    "Fluid density at the boudary of node i";
  Units.SI.MassFlowRate BQ[N - 1]
    "Right hand side of the mass balance equation for thermal node i";
  Units.SI.Power BH[N - 1]
    "Right hand side of the energy balance equation for thermal node i";
  Units.SI.Power dW1_conv[N - 1](start=fill(3.e5, N - 1), nominal=fill(3.e5, N
         - 1))
    "Convection thermal power exchanged on the liquid side for node i";
  Units.SI.Power dW1_diff[N - 1](start=fill(3.e5, N - 1), nominal=fill(3.e5, N
         - 1))
    "Diffusion thermal power exchanged on the liquid side for node i";
  Units.SI.Power dW1[N - 1](start=fill(3.e5, N - 1), nominal=fill(3.e5, N - 1))
    "Thermal power exchanged on the water side for node i";
  Units.SI.Power W1t "Total power exchanged on the water side";
  Units.SI.Temperature Tp[N - 1](start=T0) "Wall temperature in node i";
  Units.SI.CoefficientOfHeatTransfer hc[N - 1](start=fill(2000, N - 1), nominal=
       fill(200, N - 1)) "Fluid heat exchange coefficient in node i";
  Units.SI.ReynoldsNumber Re1[N - 1](start=fill(6.e4, N - 1), nominal=fill(
        0.5e4, N - 1)) "Fluid Reynolds number in thermal node i";
  Units.SI.ReynoldsNumber Re2[N](start=fill(6.e4, N), nominal=fill(0.5e4, N))
    "Fluid Reynolds number in hydraulic node i";
  Real Pr[N - 1](start=fill(4, N - 1), nominal=fill(1, N - 1))
    "Fluid Prandtl number in node i";
  Units.SI.ThermalConductivity k1[N - 1](start=fill(0.6, N - 1), nominal=fill(
        0.6, N - 1)) "Fluid thermal conductivity in thermal node i";
  Units.SI.ThermalConductivity k2[N](start=fill(0.6, N), nominal=fill(0.6, N))
    "Fluid thermal conductivity in hydraulic node i";
  Units.SI.DynamicViscosity mu1[N - 1](start=fill(2.e-4, N - 1), nominal=fill(
        2.e-4, N - 1)) "Fluid dynamic viscosity in thermal node i";
  Units.SI.DynamicViscosity mu2[N](start=fill(2.e-4, N), nominal=fill(2.e-4, N))
    "Fluid dynamic viscosity in hydraulic node i";
  Units.SI.SpecificHeatCapacity cp1[N - 1](start=fill(4000, N - 1), nominal=
        fill(4000, N - 1)) "Fluid specific heat capacity in thermal node i";
  Units.SI.SpecificHeatCapacity cp2[N](start=fill(4000, N), nominal=fill(4000,
        N)) "Fluid specific heat capacity in hydraulic node i";
  Units.SI.Temperature T1[N - 1] "Fluid temperature in thermal node i";
  Units.SI.Temperature T2[N] "Fluid temperature in hydraulic node i";
  ThermoSysPro.Units.SI.PressureDifference dpa[N]
    "Advection term for the mass balance equation in node i";
  ThermoSysPro.Units.SI.PressureDifference dpf[N]
    "Friction pressure loss in node i";
  ThermoSysPro.Units.SI.PressureDifference dpg[N]
    "Gravity pressure loss in node i";
  Real khi[N] "Hydraulic pressure loss coefficient in node i";
  Real lambda[N](start=fill(0.03, N), nominal=fill(0.03, N))
    "Friction pressure loss coefficient in node i";
  Units.SI.DerDensityByPressure ddph[N - 1] "Density derivative wrt. pressure";
  Units.SI.DerDensityByEnthalpy ddhp[N - 1] "Density derivative srt. enthalpy";
  FluidType ftype "Fluid type";
  Integer fluid=Integer(ftype) "Fluid number";
  ThermoSysPro.Units.SI.MassFraction Xco2 "CO2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xh2o "H2O mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xo2 "O2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xso2 "SO2 mass fraction";
  Real diff_res[N] "Diffusion resistance in hydraulic node i";
  Real diff_res_t "Total diffusion resistance in the pipe";
  Real diff_res_e[N - 1] "Diffusion resistance at inlet of thermal node i";
  Real diff_res_s[N - 1] "Diffusion resistance at outlet of thermal node i";
  Units.SI.MassFlowRate gamma[N]
    "Total diffusion conductance in hydraulic node i";
  Units.SI.MassFlowRate gamma_e[N - 1]
    "Diffusion conductance at inlet of thermal node i";
  Units.SI.MassFlowRate gamma_s[N - 1]
    "Diffusion conductance at outlet of thermal node i";
  Units.SI.Power Je[N - 1]
    "Thermal power diffusion from inlet of thermal node i";
  Units.SI.Power Js[N - 1]
    "Thermal power diffusion from outlet of thermal node i";
  Units.SI.Power J[N - 1] "Total thermal power diffusion of thermal node i";
  Real re[N - 1] "Value of r(Q/gamma) for inlet of thermal node i";
  Real rs[N - 1] "Value of r(Q/gamma) for outlet of thermal node i";

public
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet C1 annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet C2 annotation (Placement(
        transformation(extent={{90,-10},{110,10}}, rotation=0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort CTh[Ns]
    annotation (Placement(transformation(extent={{-10,20},{10,40}}, rotation=0)));
initial equation
  if dynamic_energy_balance then
    if steady_state then
      for i in 2:N loop
        der(h[i]) = 0;
      end for;
    else
      if option_temperature then
        for i in 2:N loop
          h[i] = ThermoSysPro.Properties.Fluid.SpecificEnthalpy_PT(P0, T0[i-1], fluid, mode, Xco2, Xh2o, Xo2, Xso2);
        end for;
      else
        for i in 2:N loop
          h[i] = h0[i - 1];
        end for;
      end if;
    end if;

    if dynamic_mass_balance then
      for i in 2:N loop
        der(P[i]) = 0;
      end for;
    end if;
  end if;

  if inertia then
    for i in 1:N loop
      der(Q[i]) = 0;
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

  h[1] = C1.h_vol_1;
  h[N + 1] = C2.h_vol_2;

  C1.h_vol_2 = h[2];
  C2.h_vol_1 = h[N];

  C2.diff_on_1 = diffusion;
  C1.diff_on_2 = diffusion;

  C2.diff_res_1 = C1.diff_res_1 + diff_res_t;
  C1.diff_res_2 = C2.diff_res_2 + diff_res_t;

  C1.ftype = C2.ftype;

  C1.Xco2 = C2.Xco2;
  C1.Xh2o = C2.Xh2o;
  C1.Xo2 = C2.Xo2;
  C1.Xso2 = C2.Xso2;

  ftype = C1.ftype;

  Xco2 = C1.Xco2;
  Xh2o = C1.Xh2o;
  Xo2 = C1.Xo2;
  Xso2 = C1.Xso2;

  /* Mass and energy balance equations (thermal nodes) */
  for i in 1:N - 1 loop
    /* Mass balance equation */
    BQ[i] = Q[i] - Q[i + 1];

    if dynamic_energy_balance and dynamic_mass_balance then
      A*(ddph[i]*der(P[i + 1]) + ddhp[i]*der(h[i + 1]))*dx1 = BQ[i];
    else
      0 = BQ[i];
    end if;

    /* Energy balance equation */
    BH[i] = hb[i]*Q[i] - hb[i + 1]*Q[i + 1] + dW1[i] + J[i];

    if dynamic_energy_balance then
      if dynamic_mass_balance then
        if simplified_dynamic_energy_balance then
          A*(-der(P[i + 1]) + rho1[i]*der(h[i + 1]))*dx1 = BH[i];
        else
          A*((h[i + 1]*ddph[i] - 1)*der(P[i + 1]) + (h[i + 1]*ddhp[i] + rho1[i])*der(h[i + 1]))*dx1 = BH[i];
        end if;
      else
        A*rho1[i]*der(h[i + 1])*dx1 = BH[i];
      end if;
    else
      0 = BH[i];
    end if;

    /* Heat transfer at the wall */
    dW1_conv[i] = hc[i]*dSi*(Tp[i] - T1[i]);
    dW1_diff[i] = 2*pi*dx1*ntubes*k1[i]*(Tp[i] - T1[i]);

    dW1[i] = dW1_conv[i] + (if diffusion then dW1_diff[i] else 0);

    /* Heat exchange coefficient (using the Dittus-Boelter correlation) */
    if noEvent(Re1[i] > 2000) then
      hc[i] = hcCorr*0.023*k1[i]/D*Re1[i]^0.8*Pr[i]^0.4;
    else
      // Dittus-Boelter correlation or Lévêque correlation for constant temperature
      hc[i] = hcCorr*k1[i]/D*max(4.36,0.023*Re1[i]^0.8*Pr[i]^0.4);
    end if;

    Pr[i] = mu1[i]*cp1[i]/k1[i];
    Re1[i] = noEvent(abs(4*(Q[i] + Q[i + 1])/2/(pi*Di*mu1[i])));

    /* Diffusion power */
    if diffusion then
      re[i] = exp(-0.033*(Q[i]*diff_res_e[i])^2);
      rs[i] = exp(-0.033*(Q[i + 1]*diff_res_s[i])^2);

      gamma_e[i] = 1/diff_res_e[i];
      gamma_s[i] = 1/diff_res_s[i];

      if i == 1 then
        diff_res_e[i] = (if C1.diff_on_1 then C1.diff_res_1 else 0) + diff_res[i];
        Je[i] = if C1.diff_on_1 then re[i]*gamma_e[i]*(h[i] - h[i + 1]) else 0;
     else
        diff_res_e[i] = diff_res[i];
        Je[i] = re[i]*gamma_e[i]*(h[i] - h[i + 1]);
      end if;

      if i == N - 1 then
        diff_res_s[i] = (if C2.diff_on_2 then C2.diff_res_2 else 0) + diff_res[i + 1];
        Js[i] = if C2.diff_on_2 then rs[i]*gamma_s[i]*(h[i + 2] - h[i + 1]) else 0;
      else
        diff_res_s[i] = diff_res[i + 1];
        Js[i] = rs[i]*gamma_s[i]*(h[i + 2] - h[i + 1]);
      end if;
    else
      diff_res_e[i] = 1/gamma0;
      diff_res_s[i] = 1/gamma0;

      re[i] = 0;
      rs[i] = 0;

      gamma_e[i] = gamma0;
      gamma_s[i] = gamma0;

      Je[i] = 0;
      Js[i] = 0;
    end if;

    J[i] = Je[i] + Js[i];

    /* Flow reversal */
    if continuous_flow_reversal then
      hb[i + 1] = ThermoSysPro.Functions.SmoothCond(Q[i + 1]/gamma[i + 1], h[i + 1], h[i + 2], 1);
    else
      hb[i + 1] = if (Q[i + 1] > 0) then h[i + 1] else h[i + 2];
    end if;

    /* Fluid thermodynamic properties */
    ddph[i] = ThermoSysPro.Properties.Fluid.Density_derp_Ph(P[i + 1], h[i + 1], fluid, mode, Xco2, Xh2o, Xo2, Xso2);
    ddhp[i] = ThermoSysPro.Properties.Fluid.Density_derh_Ph(P[i + 1], h[i + 1], fluid, mode, Xco2, Xh2o, Xo2, Xso2);

    rho1[i] = ThermoSysPro.Properties.Fluid.Density_Ph(P[i + 1], h[i + 1], fluid, mode, Xco2, Xh2o, Xo2, Xso2);
    T1[i] = ThermoSysPro.Properties.Fluid.Temperature_Ph(P[i + 1], h[i + 1], fluid, mode, Xco2, Xh2o, Xo2, Xso2);
    cp1[i] = ThermoSysPro.Properties.Fluid.SpecificHeatCapacityCp_Ph(P[i + 1], h[i + 1], fluid, mode, Xco2, Xh2o, Xo2, Xso2);
    mu1[i] = ThermoSysPro.Properties.Fluid.DynamicViscosity_Ph(P[i + 1], h[i + 1], fluid, mode, Xco2, Xh2o, Xo2, Xso2);
    k1[i] = ThermoSysPro.Properties.Fluid.ThermalConductivity_Ph(P[i + 1], h[i + 1], fluid, mode, Xco2, Xh2o, Xo2, Xso2);
  end for;

  /* Momentum balance equations (hydraulic nodes) */
  for i in 1:N loop
    /* Momentum balance equation */
    if inertia then
      1/A*der(Q[i])*dx2 = P[i] - P[i + 1] - dpf[i] - dpg[i] - dpa[i];
    else
      P[i] - P[i + 1] - dpf[i] - dpg[i] - dpa[i] = 0;
    end if;

    /* Advection term */
    if advection then
      dpa[i] = Q[i]^2*(1/rhoc[i + 1] - 1/rhoc[i])/A^2;
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

    /* Diffusion resistance */
    diff_res[i] = cp2[i]*dx2/A/k2[i];
    gamma[i] = if diffusion then 1/diff_res[i] else gamma0;

    /* Fluid thermodynamic properties */
    rho2[i] = ThermoSysPro.Properties.Fluid.Density_Ph((P[i] + P[i + 1])/2, hb[i], fluid, mode, Xco2, Xh2o, Xo2, Xso2);
    T2[i] = ThermoSysPro.Properties.Fluid.Temperature_Ph((P[i] + P[i + 1])/2, hb[i], fluid, mode, Xco2, Xh2o, Xo2, Xso2);
    cp2[i] = ThermoSysPro.Properties.Fluid.SpecificHeatCapacityCp_Ph((P[i] + P[i + 1])/2, hb[i], fluid, mode, Xco2, Xh2o, Xo2, Xso2);
    mu2[i] = ThermoSysPro.Properties.Fluid.DynamicViscosity_Ph((P[i] + P[i + 1])/2, hb[i], fluid, mode, Xco2, Xh2o, Xo2, Xso2);
    k2[i] = ThermoSysPro.Properties.Fluid.ThermalConductivity_Ph((P[i] + P[i + 1])/2, hb[i], fluid, mode, Xco2, Xh2o, Xo2, Xso2);
  end for;

  /* Fluid densities at the boundaries of the nodes */
  for i in 2:N loop
    rhoc[i] = rho1[i - 1];
  end for;

  rhoc[1] = ThermoSysPro.Properties.Fluid.Density_Ph(P[1],h[1], fluid, mode, Xco2, Xh2o, Xo2, Xso2);
  rhoc[N + 1] = ThermoSysPro.Properties.Fluid.Density_Ph((P[N + 1]), h[N + 1], fluid, mode, Xco2, Xh2o, Xo2, Xso2);

  W1t = sum(dW1);

  /* Total fluid diffusion resistance */
  diff_res_t = sum(diff_res);

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
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Line(points={{60,20},{60,-20}}),
        Line(points={{20,20},{20,-20}}),
        Line(points={{-20,20},{-20,-20}}),
        Line(points={{-60,20},{-60,-20}})}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,20},{100,-20}},
          lineColor= {0,0,255},
          fillColor= DynamicSelect({85,170,255},
          if dynamic_energy_balance then fill_color_dynamic
          else if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=DynamicSelect(FillPattern.Solid,
          if dynamic_mass_balance and dynamic_energy_balance then FillPattern.Sphere
          else FillPattern.Solid)),
        Line(points={{-60,20},{-60,-20}}),
        Line(points={{-20,20},{-20,-20}}),
        Line(points={{20,20},{20,-20}}),
        Line(points={{60,20},{60,-20}})}),
    Window(
      x=0.18,
      y=0.05,
      width=0.68,
      height=0.94),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Daniel Bouskela</li>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end DynamicOnePhaseFlowPipe;
