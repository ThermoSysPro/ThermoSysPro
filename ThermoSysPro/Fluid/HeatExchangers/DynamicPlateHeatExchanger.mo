within ThermoSysPro.Fluid.HeatExchangers;
model DynamicPlateHeatExchanger "Dynamic plate heat exchanger"
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Units.SI.ThermalConductivity lambdam=15.0
    "Metal thermal conductivity";
  parameter Units.SI.CoefficientOfHeatTransfer p_hc=6000
    "Heat transfer coefficient for the hot side if not computed by the correlations";
  parameter Units.SI.CoefficientOfHeatTransfer p_hf=3000
    "Heat transfer coefficient for the cold side if not computed by the correlations";
  parameter Real p_Kc=100 "Pressure loss coefficient for the hot side if not computed by the correlations";
  parameter Real p_Kf=100 "Pressure loss coefficient for the cold side if not computed by the correlations";
  parameter Units.SI.Volume Vc=1 "Hot side volume";
  parameter Units.SI.Volume Vf=1 "Cold side volume";
  parameter Units.SI.Thickness emetal=0.0006 "Wall thickness";
  parameter Units.SI.Area Sp=2 "Plate area";
  parameter Real nbp=499 "Number of plates";
  parameter Real c1=1.12647 "Correction coefficient";
  parameter Integer Ns=10 "Number of segments";
  parameter Integer heat_exchange_correlation=1 "Correlation for the computation of the heat exchange coefficient - 0: no correlation. 1: SRI correlations";
  parameter Integer pressure_loss_correlation=1 "Correlation for the computation of the pressure loss coefficient - 0: no correlation. 1: SRI correlations";
  parameter Units.SI.MassFlowRate gamma_diff_c=1e-4
    "Diffusion conductance for the hot fluid (active if diffusion=true in neighbouring volumes)";
  parameter Units.SI.MassFlowRate gamma_diff_f=1e-4
    "Diffusion conductance for the cold fluid (active if diffusion=true in neighbouring volumes)";
  parameter Units.SI.AbsolutePressure Pc0=1.e5
    "Hot fluid initial pressure (active if steady_state = false)"
    annotation (Evaluate=true, Dialog(enable=not steady_state));
  parameter Units.SI.AbsolutePressure Pf0=1.e5
    "Cold fluid initial pressure (active if steady_state = false)"
    annotation (Evaluate=true, Dialog(enable=not steady_state));
  parameter Units.SI.Temperature Tc0[Ns]=fill(290, Ns)
    "Initial hot fluid temperature (active if steady_state = false and option_temperature=true)"
    annotation (Evaluate=true, Dialog(enable=not steady_state and
          option_temperature));
  parameter Units.SI.Temperature Tf0[Ns]=fill(290, Ns)
    "Initial cold fluid temperature (active if steady_state = false and option_temperature=true)"
    annotation (Evaluate=true, Dialog(enable=not steady_state and
          option_temperature));
  parameter Units.SI.SpecificEnthalpy hc0[Ns]=fill(1e5, Ns)
    "Initial hot fluid specific enthalpy (active if steady_state = false and option_temperature=false)"
    annotation (Evaluate=true, Dialog(enable=not steady_state and not
          option_temperature));
  parameter Units.SI.SpecificEnthalpy hf0[Ns]=fill(1e5, Ns)
    "Initial cold fluid specific enthalpy (active if steady_state = false and option_temperature=false)"
    annotation (Evaluate=true, Dialog(enable=not steady_state and not
          option_temperature));
  parameter Boolean dynamic_energy_balance=true
    "true: dynamic energy balance equation - false: static energy balance equation";
  parameter Boolean steady_state=true
    "true: start from steady state - false: start from T0 (if option_temperature = true) or h0 (if option_temperature=false)(active if dynamic_energy_balance=true)" annotation(Evaluate=true, Dialog(enable=dynamic_energy_balance));
  parameter Boolean option_temperature=true
    "true: initial temperature is fixed - false: initial specific enthalpy is fixed (active if steady_state=false)" annotation(Evaluate=true, Dialog(enable=not steady_state));
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Boolean diffusion=false
    "true: energy balance equation with diffusion - false: energy balance equation without diffusion";
  parameter Units.SI.Density p_rhoc=0
    "If > 0, fixed fluid density for the hot fluid"
    annotation (Evaluate=true, Dialog(tab="Fluid", group="Fluid properties"));
  parameter Units.SI.Density p_rhof=0
    "If > 0, fixed fluid density for the cold fluid"
    annotation (Evaluate=true, Dialog(tab="Fluid", group="Fluid properties"));
  parameter IF97Region region_c=IF97Region.All_regions "Hot fluid IF97 region (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype_c==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));
  parameter IF97Region region_f=IF97Region.All_regions "Cold fluid IF97 region (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype_f==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

protected
  constant Units.SI.Acceleration g=Modelica.Constants.g_n "Gravity constant";
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Integer mode_c=Integer(region_c) - 1 "Hot fluid IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_f=Integer(region_f) - 1 "Cold fluid IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer N=Ns + 1 "Number of hydraulic nodes (= number of thermal nodes + 1)";
  parameter Units.SI.Area Ac=1
    "Internal cross sectional pipe area for the hot fluid";
  parameter Units.SI.Area Af=1
    "Internal cross sectional pipe area for the cold fluid";
  parameter Units.SI.PathLength dx2_c=Vc/N/Ac
    "Length of a hydraulic node for the hot fluid";
  parameter Units.SI.PathLength dx2_f=Vf/N/Af
    "Length of a hydraulic node for the cold fluid";
  parameter Units.SI.MassFlowRate gamma0=1.e-4
    "Pseudo-diffusion conductance use for continuous flow reversal (active if diffusion=false and continuous_flow_reversal=true)";

public
  Units.SI.AbsolutePressure Pc[N + 1](start=fill(1.e5, N + 1), nominal=fill(
        1.e5, N + 1)) "Hot fluid pressure in node i";
  Units.SI.AbsolutePressure Pf[N + 1](start=fill(1.e5, N + 1), nominal=fill(
        1.e5, N + 1)) "Cold fluid pressure in node i";
  Units.SI.MassFlowRate Qc[N](start=fill(10, N), nominal=fill(10, N))
    "Hot fluid mass flow rate in node i";
  Units.SI.MassFlowRate Qf[N](start=fill(10, N), nominal=fill(10, N))
    "Cold fluid mass flow rate in node i";
  Units.SI.SpecificEnthalpy hc[N + 1](start=fill(1.e5, N + 1), nominal=fill(
        1.e6, N + 1)) "Hot fluid specific enthalpy in node i";
  Units.SI.SpecificEnthalpy hf[N + 1](start=fill(1.e5, N + 1), nominal=fill(
        1.e6, N + 1)) "Cold fluid specific enthalpy in node i";
  Units.SI.SpecificEnthalpy hbc[N]
    "Hot fluid specific enthalpy at the boundary of node i";
  Units.SI.SpecificEnthalpy hbf[N]
    "Cold fluid specific enthalpy at the boundary of node i";
  Units.SI.Density rhoc1[N - 1](start=fill(998, N - 1), nominal=fill(1, N - 1))
    "Hot fluid density in thermal node i";
  Units.SI.Density rhof1[N - 1](start=fill(998, N - 1), nominal=fill(1, N - 1))
    "Cold fluid density in thermal node i";
  Units.SI.Density rhoc2[N](start=fill(998, N), nominal=fill(1, N))
    "Hot fluid density in hydraulic node i";
  Units.SI.Density rhof2[N](start=fill(998, N), nominal=fill(1, N))
    "Cold fluid density in hydraulic node i";
  Units.SI.MassFlowRate BQc[N - 1]
    "Right hand side of the mass balance equation for thermal node i for the hot fluid";
  Units.SI.MassFlowRate BQf[N - 1]
    "Right hand side of the mass balance equation for thermal node i for the cold fluid";
  Units.SI.Power BHc[N - 1]
    "Right hand side of the energy balance equation for thermal node i for the cold fluid";
  Units.SI.Power BHf[N - 1]
    "Right hand side of the energy balance equation for thermal node i for the hot fluid";
  Units.SI.CoefficientOfHeatTransfer hconv[N - 1]
    "Global heat transfer coefficient in thermal node i";
  Units.SI.CoefficientOfHeatTransfer hconv_c[N - 1](start=fill(2000, N - 1),
      nominal=fill(200, N - 1)) "Hot fluid heat exchange coefficient in node i";
  Units.SI.CoefficientOfHeatTransfer hconv_f[N - 1](start=fill(2000, N - 1),
      nominal=fill(200, N - 1))
    "Cold fluid heat exchange coefficient in node i";
  Units.SI.ThermalConductivity kc1[N - 1](start=fill(0.6, N - 1), nominal=fill(
        0.6, N - 1)) "Hot fluid thermal conductivity in thermal node i";
  Units.SI.ThermalConductivity kf1[N - 1](start=fill(0.6, N - 1), nominal=fill(
        0.6, N - 1)) "Cold fluid thermal conductivity in thermal node i";
  Units.SI.ThermalConductivity kc2[N](start=fill(0.6, N), nominal=fill(0.6, N))
    "Hot fluid thermal conductivity in hydraulic node i";
  Units.SI.ThermalConductivity kf2[N](start=fill(0.6, N), nominal=fill(0.6, N))
    "Cold fluid thermal conductivity in hydraulic node i";
  Units.SI.DynamicViscosity muc1[N - 1](start=fill(2.e-4, N - 1), nominal=fill(
        2.e-4, N - 1)) "Hot fluid dynamic viscosity in thermal node i";
  Units.SI.DynamicViscosity muf1[N - 1](start=fill(2.e-4, N - 1), nominal=fill(
        2.e-4, N - 1)) "Cold fluid dynamic viscosity in thermal node i";
  Units.SI.DynamicViscosity muc2[N](start=fill(2.e-4, N), nominal=fill(2.e-4, N))
    "Hot fluid dynamic viscosity in hydraulic node i";
  Units.SI.DynamicViscosity muf2[N](start=fill(2.e-4, N), nominal=fill(2.e-4, N))
    "Cold fluid dynamic viscosity in hydraulic node i";
  Units.SI.SpecificHeatCapacity cpc1[N - 1](start=fill(4000, N - 1), nominal=
        fill(4000, N - 1)) "Hot fluid specific heat capacity in thermal node i";
  Units.SI.SpecificHeatCapacity cpf1[N - 1](start=fill(4000, N - 1), nominal=
        fill(4000, N - 1))
    "Cold fluid specific heat capacity in thermal node i";
  Units.SI.SpecificHeatCapacity cpc2[N](start=fill(4000, N), nominal=fill(4000,
        N)) "Hot fluid specific heat capacity in hydraulic node i";
  Units.SI.SpecificHeatCapacity cpf2[N](start=fill(4000, N), nominal=fill(4000,
        N)) "Cold fluid specific heat capacity in hydraulic node i";
  Units.SI.ThermalConductivity lambdac1[N - 1](start=fill(0.602698, N - 1))
    "Hot fluid thermal conductivity in thermal node i";
  Units.SI.ThermalConductivity lambdaf1[N - 1](start=fill(0.597928, N - 1))
    "Cold fluid thermal conductivity in thermal node i";
  Units.SI.Temperature Tc1[N - 1] "Hot fluid temperature in thermal node i";
  Units.SI.Temperature Tf1[N - 1] "Cold fluid temperature in thermal node i";
  Units.SI.Temperature Tc2[N] "Hot fluid temperature in hydraulic node i";
  Units.SI.Temperature Tf2[N] "Cold fluid temperature in hydraulic node i";
  Units.SI.Area dS "Heat exchange surface";
  Units.SI.Power dW[N - 1]
    "Thermal power exchanged between the hot and cold sides in thermal node i";
  Real qmc1[N - 1];
  Real qmf1[N - 1];
  Real qmc2[N];
  Real qmf2[N];
  Real quc[N];
  Real quf[N];
  Real M;
  ThermoSysPro.Units.SI.PressureDifference DPc[N]
    "Pressure loss of the hot fluid in hydraulic node i";
  ThermoSysPro.Units.SI.PressureDifference DPf[N]
    "Pressure loss of the cold fluid in hydraulic node i";
  Units.SI.Temperature Tec "Fluid temperature at the hot inlet";
  Units.SI.Temperature Tsc "Fluid temperature at the hot outlet";
  Units.SI.Temperature Tef "Fluid temperature at the cold inlet";
  Units.SI.Temperature Tsf "Fluid temperature at the cold outlet";
  FluidType ftype_c "Hot fluid type";
  FluidType ftype_f "Cold fluid type";
  Integer fluid_c=Integer(ftype_c) "Hot fluid number";
  Integer fluid_f=Integer(ftype_f) "Cold fluid number";
  ThermoSysPro.Units.SI.MassFraction Xco2_c "Hot fluid CO2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xco2_f "Cold fluid CO2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xh2o_c "Hot fluid H2O mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xh2o_f "Cold fluid H2O mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xo2_c "Hot fluid O2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xo2_f "Cold fluid O2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xso2_c "Hot fluid SO2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xso2_f "Cold fluid SO2 mass fraction";
  Real diff_res_c[N] "Diffusion resistance in hydraulic node i for the hot fluid";
  Real diff_res_f[N] "Diffusion resistance in hydraulic node i for the cold fluid";
  Real diff_res_t_c "Total diffusion resistance in the pipe for the hot fluid";
  Real diff_res_t_f "Total diffusion resistance in the pipe for the cold fluid";
  Real diff_res_e_c[N - 1] "Diffusion resistance at inlet of thermal node i for the hot fluid";
  Real diff_res_e_f[N - 1] "Diffusion resistance at inlet of thermal node i for the cold fluid";
  Real diff_res_s_c[N - 1] "Diffusion resistance at outlet of thermal node i for the hot fluid";
  Real diff_res_s_f[N - 1] "Diffusion resistance at outlet of thermal node i for the cold fluid";
  Units.SI.MassFlowRate gamma_c[N]
    "Total diffusion conductance in hydraulic node i for the hot fluid";
  Units.SI.MassFlowRate gamma_f[N]
    "Total diffusion conductance in hydraulic node i for the cold fluid";
  Units.SI.MassFlowRate gamma_e_c[N - 1]
    "Diffusion conductance at inlet of thermal node i for the hot fluid";
  Units.SI.MassFlowRate gamma_e_f[N - 1]
    "Diffusion conductance at inlet of thermal node i for the cold fluid";
  Units.SI.MassFlowRate gamma_s_c[N - 1]
    "Diffusion conductance at outlet of thermal node i for the hot fluid";
  Units.SI.MassFlowRate gamma_s_f[N - 1]
    "Diffusion conductance at outlet of thermal node i for the cold fluid";
  Units.SI.Power Je_c[N - 1]
    "Thermal power diffusion from inlet of thermal node i for the hot fluid";
  Units.SI.Power Je_f[N - 1]
    "Thermal power diffusion from inlet of thermal node i for the cold fluid";
  Units.SI.Power Js_c[N - 1]
    "Thermal power diffusion from outlet of thermal node i for the hot fluid";
  Units.SI.Power Js_f[N - 1]
    "Thermal power diffusion from outlet of thermal node i for the cold fluid";
  Units.SI.Power J_c[N - 1]
    "Total thermal power diffusion of thermal node i for the hot fluid";
  Units.SI.Power J_f[N - 1]
    "Total thermal power diffusion of thermal node i for the cold fluid";
  Real re_c[N - 1] "Value of r(Q/gamma) for inlet of thermal node i for the hot fluid";
  Real re_f[N - 1] "Value of r(Q/gamma) for inlet of thermal node i for the cold fluid";
  Real rs_c[N - 1] "Value of r(Q/gamma) for outlet of thermal node i for the hot fluid";
  Real rs_f[N - 1] "Value of r(Q/gamma) for outlet of thermal node i for the cold fluid";

public
  Interfaces.Connectors.FluidInlet Ec annotation (Placement(transformation(
          extent={{-110,-10},{-90,10}}, rotation=0)));
  Interfaces.Connectors.FluidInlet Ef annotation (Placement(transformation(
          extent={{-60,-70},{-40,-50}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet Sf annotation (Placement(transformation(
          extent={{40,-70},{60,-50}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet Sc annotation (Placement(transformation(
          extent={{90,-10},{110,10}}, rotation=0)));
initial equation
  if dynamic_energy_balance then
    if steady_state then
      for i in 2:N loop
        der(hc[i]) = 0;
        der(hf[i]) = 0;
      end for;
    else
      if option_temperature then
        for i in 2:N loop
          hc[i] = ThermoSysPro.Properties.Fluid.SpecificEnthalpy_PT(Pc0, Tc0[i - 1], fluid_c, mode_c, Xco2_c, Xh2o_c, Xo2_c, Xso2_c);
          hf[i] = ThermoSysPro.Properties.Fluid.SpecificEnthalpy_PT(Pf0, Tf0[i - 1], fluid_f, mode_f, Xco2_f, Xh2o_f, Xo2_f, Xso2_f);
        end for;
      else
        for i in 2:N loop
          hc[i] = hc0[i - 1];
          hf[i] = hf0[i - 1];
        end for;
      end if;
    end if;
  end if;

equation

  /* Heat exchanger boundaries */
  Pc[1] = Ec.P;
  Pc[N + 1] = Sc.P;

  Pf[1] = Sf.P;
  Pf[N + 1] = Ef.P;

  Qc[1] = Ec.Q;
  Qc[N] = Sc.Q;

  Qf[1] = Sf.Q;
  Qf[N] = Ef.Q;

  hbc[1] = Ec.h;
  hbc[N] = Sc.h;

  hbf[1] = Sf.h;
  hbf[N] = Ef.h;

  hc[1] = Ec.h_vol_1;
  hc[N + 1] = Sc.h_vol_2;

  hf[N + 1] = Ef.h_vol_1;
  hf[1] = Sf.h_vol_2;

  Ec.h_vol_2 = hc[2];
  Sc.h_vol_1 = hc[N];

  Ef.h_vol_2 = hf[N];
  Sf.h_vol_1 = hf[2];

  Sc.diff_on_1 = diffusion;
  Ec.diff_on_2 = diffusion;

  Sf.diff_on_1 = diffusion;
  Ef.diff_on_2 = diffusion;

  Sc.diff_res_1 = Ec.diff_res_1 + diff_res_t_c;
  Ec.diff_res_2 = Sc.diff_res_2 + diff_res_t_c;

  Sf.diff_res_1 = Ef.diff_res_1 + diff_res_t_f;
  Ef.diff_res_2 = Sf.diff_res_2 + diff_res_t_f;

  Ec.ftype = Sc.ftype;
  Sf.ftype = Ef.ftype;

  Ec.Xco2 =  Sc.Xco2;
  Ec.Xh2o = Sc.Xh2o;
  Ec.Xo2 = Sc.Xo2;
  Ec.Xso2 = Sc.Xso2;

  Sf.Xco2 = Ef.Xco2;
  Sf.Xh2o = Ef.Xh2o;
  Sf.Xo2 = Ef.Xo2;
  Sf.Xso2 = Ef.Xso2;

  ftype_c = Ec.ftype;
  ftype_f = Sf.ftype;

  Xco2_c = Ec.Xco2;
  Xh2o_c = Ec.Xh2o;
  Xo2_c = Ec.Xo2;
  Xso2_c = Ec.Xso2;

  Xco2_f = Sf.Xco2;
  Xh2o_f = Sf.Xh2o;
  Xo2_f = Sf.Xo2;
  Xso2_f = Sf.Xso2;

  /* Exchange area for the plate exchanger */
  dS = (nbp - 2)*Sp/(N - 1);

  /* Mass and energy balance equations (thermal nodes) */
  for i in 1:N - 1 loop
    /* Mass balance equations */
    BQc[i] = Qc[i] - Qc[i + 1];
    BQf[i] = Qf[i + 1] - Qf[i];

    0 = BQc[i];
    0 = BQf[i];

    /* Energy balance equations */
    BHc[i] = hbc[i]*Qc[i] - hbc[i + 1]*Qc[i + 1] - dW[i] + J_c[i];
    BHf[i] = hbf[i + 1]*Qf[i + 1] - hbf[i]*Qf[i] + dW[i] + J_f[i];

    if dynamic_energy_balance then
      Vc/(N - 1)*rhoc1[i]*der(hc[i + 1]) = BHc[i];
      Vf/(N - 1)*rhof1[i]*der(hf[i + 1]) = BHf[i];
    else
      0 = BHc[i];
      0 = BHf[i];
    end if;

    /* Heat transfer between the hot and cold sides */
    /* 1/hconv = 1/hconv_c + 1/hconv_f + emetal/lambdam */
    hconv[i] = if noEvent(hconv_c[i]*hconv_f[i] < 1.e-6) then 0 else hconv_c[i]*hconv_f[i]/(hconv_c[i] + hconv_f[i] + hconv_c[i]*hconv_f[i]*emetal/lambdam);
    dW[i] = hconv[i]*dS*(Tc1[i] - Tf1[i]);

    /* Heat transfer correlations for water/steam */
    qmc1[i] = (qmc2[i] + qmc2[i + 1])/2;
    qmf1[i] = (qmf2[i] + qmf2[i + 1])/2;

    if (heat_exchange_correlation == 0) then
      hconv_c[i] = p_hc;
      hconv_f[i] = p_hf;
    elseif (heat_exchange_correlation == 1) then
      hconv_c[i] = noEvent(if (qmc1[i] < 1.e-3) then 0 else 11.245*abs(qmc1[i])^0.8*abs(muc1[i]*cpc1[i]/lambdac1[i])^0.4*lambdac1[i]);
      hconv_f[i] = noEvent(if (qmf1[i] < 1.e-3) then 0 else 11.245*abs(qmf1[i])^0.8*abs(muf1[i]*cpf1[i]/lambdaf1[i])^0.4*lambdaf1[i]);
    else
      hconv_c[i] = 0;
      hconv_f[i] = 0;
      assert(false, "DynamicWaterWaterExchanger: incorrect heat exchange correlation number");
    end if;

    /* Diffusion power */
    if diffusion then
      re_c[i] = exp(-0.033*(Qc[i]*diff_res_e_c[i])^2);
      rs_c[i] = exp(-0.033*(Qc[i + 1]*diff_res_s_c[i])^2);

      gamma_e_c[i] = 1/diff_res_e_c[i];
      gamma_s_c[i] = 1/diff_res_s_c[i];

      re_f[i] = exp(-0.033*(Qf[i]*diff_res_e_f[i])^2);
      rs_f[i] = exp(-0.033*(Qf[i + 1]*diff_res_s_f[i])^2);

      gamma_e_f[i] = 1/diff_res_e_f[i];
      gamma_s_f[i] = 1/diff_res_s_f[i];

      if i == 1 then
        diff_res_e_c[i] = (if Ec.diff_on_1 then Ec.diff_res_1 else 0) + diff_res_c[i];
        Je_c[i] = if Ec.diff_on_1 then re_c[i]*gamma_e_c[i]*(hc[i] - hc[i + 1]) else 0;
     else
        diff_res_e_c[i] = diff_res_c[i];
        Je_c[i] = re_c[i]*gamma_e_c[i]*(hc[i] - hc[i + 1]);
      end if;

      if i == N - 1 then
        diff_res_s_c[i] = (if Sc.diff_on_2 then Sc.diff_res_2 else 0) + diff_res_c[i + 1];
        Js_c[i] = if Sc.diff_on_2 then rs_c[i]*gamma_s_c[i]*(hc[i + 2] - hc[i + 1]) else 0;
      else
        diff_res_s_c[i] = diff_res_c[i + 1];
        Js_c[i] = rs_c[i]*gamma_s_c[i]*(hc[i + 2] - hc[i + 1]);
     end if;

      if i == N - 1 then
        diff_res_e_f[i] = (if Ef.diff_on_1 then Ef.diff_res_1 else 0) + diff_res_f[i];
        Je_f[i] = if Ef.diff_on_1 then re_f[i]*gamma_e_f[i]*(hf[i] - hf[i + 1]) else 0;
     else
        diff_res_e_f[i] = diff_res_f[i];
        Je_f[i] = re_f[i]*gamma_e_f[i]*(hf[i] - hf[i + 1]);
      end if;

      if i == 1 then
        diff_res_s_f[i] = (if Sf.diff_on_2 then Sf.diff_res_2 else 0) + diff_res_f[i + 1];
        Js_f[i] = if Sf.diff_on_2 then rs_f[i]*gamma_s_f[i]*(hf[i + 2] - hf[i + 1]) else 0;
      else
        diff_res_s_f[i] = diff_res_f[i + 1];
        Js_f[i] = rs_f[i]*gamma_s_f[i]*(hf[i + 2] - hf[i + 1]);
     end if;
    else
      diff_res_e_c[i] = 1/gamma0;
      diff_res_s_c[i] = 1/gamma0;

      re_c[i] = 0;
      rs_c[i] = 0;

      gamma_e_c[i] = gamma0;
      gamma_s_c[i] = gamma0;

      Je_c[i] = 0;
      Js_c[i] = 0;

      diff_res_e_f[i] = 1/gamma0;
      diff_res_s_f[i] = 1/gamma0;

      re_f[i] = 0;
      rs_f[i] = 0;

      gamma_e_f[i] = gamma0;
      gamma_s_f[i] = gamma0;

      Je_f[i] = 0;
      Js_f[i] = 0;
    end if;

    J_c[i] = Je_c[i] + Js_c[i];
    J_f[i] = Je_f[i] + Js_f[i];

    /* Flow reversal */
    if continuous_flow_reversal then
      hbc[i + 1] = ThermoSysPro.Functions.SmoothCond(Qc[i + 1]/gamma_c[i + 1], hc[i + 1], hc[i + 2], 1);
      hbf[i + 1] = ThermoSysPro.Functions.SmoothCond(Qf[i + 1]/gamma_f[i + 1], hf[i + 1], hf[i + 2], 1);
    else
      hbc[i + 1] = if (Qc[i + 1] > 0) then hc[i + 1] else hc[i + 2];
      hbf[i + 1] = if (Qf[i + 1] > 0) then hf[i + 1] else hf[i + 2];
    end if;

    /* Fluid thermodynamic properties */
    if (p_rhoc > 0) then
      rhoc1[i] = p_rhoc;
    else
      rhoc1[i] = ThermoSysPro.Properties.Fluid.Density_Ph(Pc[i + 1], hc[i + 1], fluid_c, mode_c, Xco2_c, Xh2o_c, Xo2_c, Xso2_c);
    end if;

    Tc1[i] = ThermoSysPro.Properties.Fluid.Temperature_Ph(Pc[i + 1], hc[i + 1], fluid_c, mode_c, Xco2_c, Xh2o_c, Xo2_c, Xso2_c);
    cpc1[i] = ThermoSysPro.Properties.Fluid.SpecificHeatCapacityCp_Ph(Pc[i + 1], hc[i + 1], fluid_c, mode_c, Xco2_c, Xh2o_c, Xo2_c, Xso2_c);
    muc1[i] = ThermoSysPro.Properties.Fluid.DynamicViscosity_Ph(Pc[i + 1], hc[i + 1], fluid_c, mode_c, Xco2_c, Xh2o_c, Xo2_c, Xso2_c);
    kc1[i] = ThermoSysPro.Properties.Fluid.ThermalConductivity_Ph(Pc[i + 1], hc[i + 1], fluid_c, mode_c, Xco2_c, Xh2o_c, Xo2_c, Xso2_c);
    lambdac1[i] = ThermoSysPro.Properties.Fluid.ThermalConductivity_rhoT(rhoc1[i], Tc1[i], Pc[i + 1], 0, fluid_c);

    if (p_rhof > 0) then
      rhof1[i] = p_rhof;
    else
      rhof1[i] = ThermoSysPro.Properties.Fluid.Density_Ph(Pf[i + 1], hf[i + 1], fluid_f, mode_f, Xco2_f, Xh2o_f, Xo2_f, Xso2_f);
    end if;

    Tf1[i] = ThermoSysPro.Properties.Fluid.Temperature_Ph(Pf[i + 1], hf[i + 1], fluid_f, mode_f, Xco2_f, Xh2o_f, Xo2_f, Xso2_f);
    cpf1[i] = ThermoSysPro.Properties.Fluid.SpecificHeatCapacityCp_Ph(Pf[i + 1], hf[i + 1], fluid_f, mode_f, Xco2_f, Xh2o_f, Xo2_f, Xso2_f);
    muf1[i] = ThermoSysPro.Properties.Fluid.DynamicViscosity_Ph(Pf[i + 1], hf[i + 1], fluid_f, mode_f, Xco2_f, Xh2o_f, Xo2_f, Xso2_f);
    kf1[i] = ThermoSysPro.Properties.Fluid.ThermalConductivity_Ph(Pf[i + 1], hf[i + 1], fluid_f, mode_f, Xco2_f, Xh2o_f, Xo2_f, Xso2_f);
    lambdaf1[i] = ThermoSysPro.Properties.Fluid.ThermalConductivity_rhoT(rhof1[i], Tf1[i], Pf[i + 1], 0, fluid_f);
  end for;

  /* Pressure losses correlations */
  M = (nbp - 1)/2;

  /* Momentum balance equations (hydraulic nodes) */
  for i in 1:N loop
    /* Pressure losses */
    Pc[i + 1] = if Qc[i] > 0 then Pc[i] - DPc[i]/N else Pc[i] + DPc[i]/N;
    Pf[i + 1] = if Qf[i] > 0 then Pf[i] - DPf[i]/N else Pf[i] + DPf[i]/N;

    qmc2[i] = noEvent(abs(Qc[i])/(max(ThermoSysPro.Properties.WaterSteam.InitLimits.ETAMIN, muc2[i])*M));
    qmf2[i] = noEvent(abs(Qf[i])/(max(ThermoSysPro.Properties.WaterSteam.InitLimits.ETAMIN, muf2[i])*M));

    quc[i] = noEvent(abs(Qc[i])/M);
    quf[i] = noEvent(abs(Qf[i])/M);

    if (pressure_loss_correlation == 0) then
      DPc[i] = p_Kc*Qc[i]^2/rhoc2[i];
      DPf[i] = p_Kf*Qf[i]^2/rhof2[i];
    elseif (pressure_loss_correlation == 1) then
      DPc[i] = noEvent(if (qmc2[i] < 1.e-3) then 0 else c1*14423.2/rhoc2[i]*abs(qmc2[i])^(-0.097)*quc[i]^2*(1472.47 + 1.54*(M - 1)/2 + 104.97*abs(qmc2[i])^(-0.25)));
      DPf[i] = noEvent(if (qmf2[i] < 1.e-3) then 0 else 14423.2/rhof2[i]*abs(qmf2[i])^(-0.097)*quf[i]^2*(1472.47 + 1.54*(M - 1)/2 + 104.97*abs(qmf2[i])^(-0.25)));
    else
      DPc[i] = 0;
      DPf[i] = 0;
      assert(false, "DynamicWaterWaterExchanger: incorrect pressure loss correlation number");
    end if;

    /* Diffusion resistance */
    diff_res_c[i] = cpc2[i]*dx2_c/Ac/kc2[i];
    gamma_c[i] = if diffusion then 1/diff_res_c[i] else gamma0;

    diff_res_f[i] = cpf2[i]*dx2_f/Af/kf2[i];
    gamma_f[i] = if diffusion then 1/diff_res_f[i] else gamma0;

    /* Fluid thermodynamic properties */
    if (p_rhoc > 0) then
      rhoc2[i] = p_rhoc;
    else
      rhoc2[i] = ThermoSysPro.Properties.Fluid.Density_Ph((Pc[i] + Pc[i + 1])/2, hbc[i], fluid_c, mode_c, Xco2_c, Xh2o_c, Xo2_c, Xso2_c);
    end if;

    Tc2[i] = ThermoSysPro.Properties.Fluid.Temperature_Ph((Pc[i] + Pc[i + 1])/2, hbc[i], fluid_c, mode_c, Xco2_c, Xh2o_c, Xo2_c, Xso2_c);
    cpc2[i] = ThermoSysPro.Properties.Fluid.SpecificHeatCapacityCp_Ph((Pc[i] + Pc[i + 1])/2, hbc[i], fluid_c, mode_c, Xco2_c, Xh2o_c, Xo2_c, Xso2_c);
    muc2[i] = ThermoSysPro.Properties.Fluid.DynamicViscosity_Ph((Pc[i] + Pc[i + 1])/2, hbc[i], fluid_c, mode_c, Xco2_c, Xh2o_c, Xo2_c, Xso2_c);
    kc2[i] = ThermoSysPro.Properties.Fluid.ThermalConductivity_Ph((Pc[i] + Pc[i + 1])/2, hbc[i], fluid_c, mode_c, Xco2_c, Xh2o_c, Xo2_c, Xso2_c);

    if (p_rhof > 0) then
      rhof2[i] = p_rhof;
    else
      rhof2[i] = ThermoSysPro.Properties.Fluid.Density_Ph((Pf[i] + Pf[i + 1])/2, hbf[i], fluid_f, mode_f, Xco2_f, Xh2o_f, Xo2_f, Xso2_f);
    end if;

    Tf2[i] = ThermoSysPro.Properties.Fluid.Temperature_Ph((Pf[i] + Pf[i + 1])/2, hbf[i], fluid_f, mode_f, Xco2_f, Xh2o_f, Xo2_f, Xso2_f);
    cpf2[i] = ThermoSysPro.Properties.Fluid.SpecificHeatCapacityCp_Ph((Pf[i] + Pf[i + 1])/2, hbf[i], fluid_f, mode_f, Xco2_f, Xh2o_f, Xo2_f, Xso2_f);
    muf2[i] = ThermoSysPro.Properties.Fluid.DynamicViscosity_Ph((Pf[i] + Pf[i + 1])/2, hbf[i], fluid_f, mode_f, Xco2_f, Xh2o_f, Xo2_f, Xso2_f);
    kf2[i] = ThermoSysPro.Properties.Fluid.ThermalConductivity_Ph((Pf[i] + Pf[i + 1])/2, hbf[i], fluid_f, mode_f, Xco2_f, Xh2o_f, Xo2_f, Xso2_f);
  end for;

  /* Calcul des températures en entrée et en sortie de l'échangeur */
   Tec = ThermoSysPro.Properties.Fluid.Temperature_Ph(Ec.P, Ec.h, fluid_c, mode_c, Xco2_c, Xh2o_c, Xo2_c, Xso2_c);
   Tsc = ThermoSysPro.Properties.Fluid.Temperature_Ph(Sc.P, Sc.h, fluid_c, mode_c, Xco2_c, Xh2o_c, Xo2_c, Xso2_c);

   Tef = ThermoSysPro.Properties.Fluid.Temperature_Ph(Ef.P, Ef.h, fluid_f, mode_f, Xco2_f, Xh2o_f, Xo2_f, Xso2_f);
   Tsf = ThermoSysPro.Properties.Fluid.Temperature_Ph(Sf.P, Sf.h, fluid_f, mode_f, Xco2_f, Xh2o_f, Xo2_f, Xso2_f);

  /* Total fluid diffusion resistance */
  diff_res_t_c = sum(diff_res_c);
  diff_res_t_f = sum(diff_res_f);

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,60},{100,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={127,255,0}),
        Line(points={{-80,60},{-80,-60}}),
        Line(points={{80,60},{80,-60}}),
        Line(points={{-80,0},{-60,0},{-40,20},{40,-20},{60,0},{80,0}}, color={
              28,108,200}),
        Line(
          points={{-40,60},{-40,-60}},
          color={28,108,200},
          pattern=LinePattern.Dot),
        Line(
          points={{0,60},{0,-60}},
          color={28,108,200},
          pattern=LinePattern.Dot),
        Line(
          points={{40,60},{40,-60}},
          color={28,108,200},
          pattern=LinePattern.Dot)}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,60},{100,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor= DynamicSelect({85,170,255},
          if dynamic_energy_balance then fill_color_dynamic
          else if diffusion then fill_color_singular
          else fill_color_static),
          lineThickness=0),
        Line(points={{-80,60},{-80,-60}}),
        Line(points={{80,60},{80,-60}}),
        Line(points={{-80,0},{-60,0},{-40,20},{40,-20},{60,0},{80,0}}, color={
              28,108,200}),
        Line(
          points={{-40,60},{-40,-60}},
          color={28,108,200},
          pattern=LinePattern.Dot),
        Line(
          points={{0,60},{0,-60}},
          color={28,108,200},
          pattern=LinePattern.Dot),
        Line(
          points={{40,60},{40,-60}},
          color={28,108,200},
          pattern=LinePattern.Dot),
        Text(
          extent={{104,24},{128,10}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Hot outlet"),
        Text(
          extent={{-82,-66},{-62,-76}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Cold inlet"),
        Text(
          extent={{-126,24},{-106,14}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Hot inlet"),
        Text(
          extent={{66,-66},{90,-76}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Cold outlet")}),
    Window(
      x=0.18,
      y=0.05,
      width=0.68,
      height=0.94),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
<p>This component model is documented in Sect. 9.6.1 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Daniel Bouskela</li>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end DynamicPlateHeatExchanger;
