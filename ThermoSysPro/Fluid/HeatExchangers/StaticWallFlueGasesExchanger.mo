within ThermoSysPro.Fluid.HeatExchangers;
model StaticWallFlueGasesExchanger "Static wall - flue gases exchanger"
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Integer Ns=10 "Number of segments";
  parameter Integer NbTub=100 "Number of pipes";
  parameter Real DPc=0 "Pressure loss coefficient";
  parameter Units.SI.Length L=2 "Exchanger length";
  parameter Units.SI.Diameter Dext=0.022 "External pipe diameter";
  parameter Units.SI.PathLength step_L=0.033 "Longitudinal length step";
  parameter Units.SI.PathLength step_T=0.066 "Transverse length step";
  parameter Units.SI.Area St=100 "Cross-sectional area";
  parameter Units.SI.Area Surf_ext=pi*Dext*Ls*NbTub*CSailettes
    "Heat exchange surface for one section";
  parameter Real Encras=1.00 "Corrective term for the heat exchange coefficient";
  parameter Real Fa=0.7 "Fouling factor (0.3 - 1.1)";
  parameter Units.SI.MassFlowRate Qmin=1e-3 "Minimum flue gases mass flow rate";
  parameter Integer exchanger_type=1 "Exchanger type - 1:crossed flux - 2:longitudinal flux";
  parameter Units.SI.Temperature Tp0=500
    "Wall temperature (active if the thermal connector is not connected)";
  parameter Real CSailettes=1 "Increase factor of the heat exchange surface to to the fins";
  parameter Real Coeff=1 "Corrective coeffeicient";
  parameter Units.SI.MassFlowRate gamma_diff=1e-4
    "Diffusion conductance (active if diffusion=true in neighbouring volumes)";
  parameter Units.SI.Density p_rho=0 "If > 0, fixed fluid density"
    annotation (Evaluate=true, Dialog(tab="Fluid", group="Fluid properties"));
  parameter Boolean continuous_flow_reversal=false "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Boolean diffusion=false "true: energy balance equation with diffusion - false: energy balance equation without diffusion";

protected
  constant Real Mco2=44.009 "CO2 molar mass";
  constant Real Mh2o=18.0148 "H2O molar mass";
  constant Real Mo2=31.998 "O2 molar mass";
  constant Real Mn2=28.014 "N2 molar mass";
  constant Real Mso2=64.063 "SO2 molar mass";
  constant Real pi=Modelica.Constants.pi;
  constant Units.SI.Acceleration g=Modelica.Constants.g_n "Gravity constant";
  parameter Integer N=Ns + 1 "Number of hydraulic nodes (= number of thermal nodes + 1)";
  parameter Units.SI.PathLength Ls=L/Ns "Section length";
  parameter Units.SI.Area Surf_tot=Ns*Surf_ext "Total heat exchange surface";
  parameter Units.SI.Area Sgaz=St*(1 - Dext/step_T) "Geometrical parameter";
  parameter Real PasLD=step_L/Dext "Geometrical parameter";
  parameter Real PasTD=step_T/Dext "Geometrical parameter";
  parameter Real Optl=ThermoSysPro.Correlations.Misc.WBCorrectiveDiameterCoefficient(PasTD,PasLD,Dext) "Geometrical parameter";
  parameter Units.SI.Length Deq=4*Sgaz/Perb
    "Equivalent diameter for longitudinal flux";
  parameter Units.SI.Length Perb=Surf_ext/Ls "Geometrical parameter";
  parameter Units.SI.CoefficientOfHeatTransfer Kdef=50
    "Heat exchange coefficient in case of zero flow";
  parameter Units.SI.MassFlowRate gamma0=1.e-4
    "Pseudo-diffusion conductance use for continuous flow reversal (active if diffusion=false and continuous_flow_reversal=true)";
  parameter Real eps=1.e-1 "Small number for the computation of the pressure losses";

public
  Units.SI.AbsolutePressure P[N + 1](start=fill(1.e5, N + 1), nominal=fill(1.e5,
        N + 1)) "Fluid pressure in node i";
  Units.SI.MassFlowRate Q[N](start=fill(10, N), nominal=fill(10, N))
    "Mass flow rate in node i";
  Units.SI.SpecificEnthalpy h[N + 1](start=fill(1.e5, N + 1), nominal=fill(1.e6,
        N + 1)) "Fluid specific enthalpy in node i";
  Units.SI.SpecificEnthalpy hb[N]
    "Fluid specific enthalpy at the boundary of node i";
  Units.SI.Temperature T1[N - 1] "Fluid temperature in thermal node i";
  Units.SI.Temperature T2[N] "Fluid temperature in hydraulic node i";
  Units.SI.Density rho2[N](start=fill(998, N), nominal=fill(1, N))
    "Fluid density in hydraulic node i";
  Units.SI.Temperature Tp[N - 1](start=fill(500, N - 1))
    "Wall temperature in thermal node i";
  Units.SI.AbsolutePressure Pco2[N - 1]
    "CO2 partial pressure in thermal node i";
  Units.SI.AbsolutePressure Ph2o[N - 1]
    "H2O partial pressure in thermal node i";
  ThermoSysPro.Units.SI.MassFraction Xh2o "H2O mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xco2 "CO2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xo2 "O2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xso2 "SO2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xn2 "N2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xvh2o "H2O volume fraction";
  ThermoSysPro.Units.SI.MassFraction Xvco2 "CO2 volume fraction";
  ThermoSysPro.Units.SI.MassFraction Xvo2 "O2 volume fraction";
  ThermoSysPro.Units.SI.MassFraction Xvn2 "N2 volume fraction";
  ThermoSysPro.Units.SI.MassFraction Xvso2 "SO2 volume fraction";
  Units.SI.CoefficientOfHeatTransfer K(start=0)
    "Total heat exchange coefficient";
  Units.SI.CoefficientOfHeatTransfer Kc(start=0)
    "Convective heat exchange coefficient";
  Units.SI.CoefficientOfHeatTransfer Kr(start=0)
    "Radiative heat exchange coefficient";
  Units.SI.CoefficientOfHeatTransfer Kcc[N - 1](start=fill(0, N - 1))
    "Intermediate variable for the computation of the convective heat exchange coefficient";
  Units.SI.CoefficientOfHeatTransfer Krr[N - 1](start=fill(0, N - 1))
    "Intermediate variable for the computation of the radiative heat exchange coefficient";
  Units.SI.Power dW1[N - 1](start=fill(0, N - 1))
    "Power exchange between the wall and the fluid in each thermal node";
  Units.SI.Power W(start=0) "Total power exchanged";
  ThermoSysPro.Units.SI.TemperatureDifference deltaT[N - 1](start=fill(50, N
         - 1)) "Temperature difference between the fluid and the wall";
  Units.SI.Temperature TFilm[N - 1] "Film temperature";
  Real Mmt "Total flue gases molar mass";
  FluidType ftype "Fluid type";
  Integer fluid=Integer(ftype) "Fluid number";
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
  Interfaces.Connectors.FluidInlet C1 annotation (Placement(transformation(
          extent={{-110,-10},{-90,10}}, rotation=0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort CTh[Ns]
    annotation (Placement(transformation(extent={{-10,20},{10,40}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet C2 annotation (Placement(transformation(
          extent={{90,-10},{110,10}}, rotation=0)));
equation

  /* Check that the fluid type is flue gases */
  assert(ftype == FluidType.FlueGases, "StaticWallFlueGasesExchanger: the fluid type must be flue gases");

  /* Wall boundary */
  CTh.W = -dW1;
  CTh.T = Tp;

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

  Xh2o = C1.Xh2o;
  Xco2 = C1.Xco2;
  Xo2 = C1.Xo2;
  Xso2 = C1.Xso2;
  Xn2 = 1 - C1.Xco2 - C1.Xh2o - C1.Xo2 - C1.Xso2;

  /* Volume fractions */
  Xvco2 = (Xco2/Mco2)/(Xco2/Mco2 + Xh2o/Mh2o + Xo2/Mo2 + Xn2/Mn2 + Xso2/Mso2);
  Xvh2o = (Xh2o/Mh2o)/(Xco2/Mco2 + Xh2o/Mh2o + Xo2/Mo2 + Xn2/Mn2 + Xso2/Mso2);
  Xvo2 = (Xo2/Mo2)/(Xco2/Mco2 + Xh2o/Mh2o + Xo2/Mo2 + Xn2/Mn2 + Xso2/Mso2);
  Xvn2 = (Xn2/Mn2)/(Xco2/Mco2 + Xh2o/Mh2o + Xo2/Mo2 + Xn2/Mn2 + Xso2/Mso2);
  Xvso2 = (Xso2/Mso2)/(Xco2/Mco2 + Xh2o/Mh2o + Xo2/Mo2 + Xn2/Mn2 + Xso2/Mso2);

  /* Total molar mass */
  Mmt = Xvco2*Mco2 + Xvh2o*Mh2o + Xvo2*Mo2 + Xvn2*Mn2 + Xvso2*Mso2;

  /* Mass and energy balance equations (thermal nodes) */
  for i in 1:N - 1 loop
    /* Mass balance equation */
    0 = Q[i] - Q[i + 1];

    /* Energy balance equation */
    0 = hb[i]*Q[i] - hb[i + 1]*Q[i + 1] - dW1[i] + J[i];

    /* Temperature difference between the fluid and the wall */
    deltaT[i] = T1[i] - Tp[i];

    /* Partial gas pressures */
    Ph2o[i] = P[i + 1]*Xh2o*Mmt/Mh2o;
    Pco2[i] = P[i + 1]*Xco2*Mmt/Mco2;

    if (abs(Q[i]) >= Qmin) then
      /* Convective heat exchange coefficient */
      if (exchanger_type == 1) then
        /* Crossed flux */
        Kcc[i] = ThermoSysPro.Correlations.Thermal.WBCrossedCurrentConvectiveHeatTransferCoefficient(TFilm[i], abs(Q[i]), Xh2o*100, Sgaz, Dext, Fa);
      else
        /* Longitudinal flux */
        Kcc[i] = ThermoSysPro.Correlations.Thermal.WBLongitudinalCurrentConvectiveHeatTransferCoefficient(TFilm[i], T1[i], abs(Q[i]), Xh2o*100, Sgaz, Deq);
      end if;

      /* Radiative heat exchange coefficient */
      Krr[i] = ThermoSysPro.Correlations.Thermal.WBRadiativeHeatTransferCoefficient(deltaT[i], Tp[i], Ph2o[i]/P[i + 1], Pco2[i]/P[i + 1], Optl);
    else
      Krr[i] = 0;
      Kcc[i] = 0;
    end if;

    /* Film temperature */
    TFilm[i] = (T1[i] + Tp[i])/2;

    /* Power exchanged for each section */
    dW1[i] = Coeff*K*(T1[i] - Tp[i])*Surf_ext;

    /* Flow reversal */
    if continuous_flow_reversal then
      hb[i + 1] = ThermoSysPro.Functions.SmoothCond(Q[i + 1]/gamma[i + 1], h[i + 1], h[i + 2], 1);
    else
      hb[i + 1] = if (Q[i + 1] > 0) then h[i + 1] else h[i + 2];
    end if;

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

    /* Fluid thermodynamic properties */
    T1[i] = ThermoSysPro.Properties.Fluid.Temperature_Ph(P[i + 1], h[i + 1], fluid, 0, Xco2, Xh2o, Xo2, Xso2);
  end for;

  /* Momentum balance equations (hydraulic nodes) */
  for i in 1:N loop
    /* Pressure losses */
    P[i] - P[i + 1] = DPc/N*ThermoSysPro.Functions.ThermoSquare(Q[i],eps)/rho2[i];

    /* Diffusion resistance */
    diff_res[i] = 1/gamma_diff/N;
    gamma[i] = if diffusion then 1/diff_res[i] else gamma0;

    /* Fluid thermodynamic properties */
    if (p_rho > 0) then
      rho2[i] = p_rho;
    else
      rho2[i] = ThermoSysPro.Properties.Fluid.Density_Ph((P[i] + P[i + 1])/2, hb[i], fluid, 0, Xco2, Xh2o, Xo2, Xso2);
    end if;

    T2[i] = ThermoSysPro.Properties.Fluid.Temperature_Ph((P[i] + P[i + 1])/2, hb[i], fluid, 0, Xco2, Xh2o, Xo2, Xso2);
  end for;

  /* Total heat exchange coefficient ??? */
  0 = noEvent(if (abs(Q[1]) >= Qmin) then K - (Kc + Kr)*Encras else K - Kdef);

  /* Convective and radiative heat exchange coefficients */
  Kc = sum(Kcc)*Surf_ext/Surf_tot;
  Kr = sum(Krr)*Surf_ext/Surf_tot;

  /* Total power exchanged */
  W = sum(dW1);

  /* Total fluid diffusion resistance */
  diff_res_t = sum(diff_res);

  annotation (Diagram(graphics={
        Rectangle(
          extent={{-100,20},{100,-20}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Backward),
        Line(points={{-60,20},{-60,-20}}),
        Line(points={{-20,20},{-20,-20}}),
        Line(points={{20,20},{20,-20}}),
        Line(points={{60,20},{60,-20}})}),
                           Icon(graphics={
        Rectangle(
          extent={{-100,20},{100,-20}},
          lineColor={0,0,255},
          fillColor=DynamicSelect({255,255,0},
          if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=FillPattern.Backward),
        Line(points={{-60,20},{-60,-20}}),
        Line(points={{-20,20},{-20,-20}}),
        Line(points={{20,20},{20,-20}}),
        Line(points={{60,20},{60,-20}})}),
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
end StaticWallFlueGasesExchanger;
