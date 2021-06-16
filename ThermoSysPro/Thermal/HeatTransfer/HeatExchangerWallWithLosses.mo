within ThermoSysPro.Thermal.HeatTransfer;
model HeatExchangerWallWithLosses "Heat exchanger wall"
  parameter Modelica.SIunits.Length L=10 "Tube length";
  parameter Modelica.SIunits.Diameter D=0.03 "Internal tube diameter";
  parameter Modelica.SIunits.Diameter D_rec=24 "receiver diameter";
  parameter Modelica.SIunits.Diameter L_rec=10
    "receiver height (characteristic length";
  parameter Modelica.SIunits.Thickness e=2.e-3 "Wall thickness";
  parameter Real Sc=0.5
    "Decrease factor of the external heat exchange surface for Solar Receiver or Boiler ";

  parameter Modelica.SIunits.ThermalConductivity lambda=21
    "Thermal conductivity of the pipes";
  parameter Real Eps=0.6 "Tube emissivity";
  parameter Modelica.SIunits.Thickness e_ins=0.1 "Insulation thickness";
  parameter Modelica.SIunits.ThermalConductivity lambda_ins=0.035
    "Equivalent thermal conductivity of Insulation + pipes";
  constant Modelica.SIunits.Acceleration g=Modelica.Constants.g_n
    "Gravity constant";

  parameter Real hcCorr1=1.00
    "Corrective term for Forced convection losses coefficient for each node";
  parameter Real hcCorr2=1.00
    "Corrective term for Natural convection losses coefficient for each node";

  parameter Integer Ns=1 "Number of sections inside the wall";
  parameter Modelica.SIunits.SpecificHeatCapacity cpw=480
    "Wall specific heat capacity";
  parameter Modelica.SIunits.Density rhow=7800 "Wall density";
  parameter Modelica.SIunits.Temperature T0=350
    "Initial temperature (active if steady_state=false)";

  parameter Boolean steady_state=true
    "true: start from steady state - false: start from T0";
  parameter Real ntubes=1 "Number of pipes in parallel";

protected
  constant Real pi=Modelica.Constants.pi "pi";
  constant Real sigma=5.67e-8 "Bolzmann constant";
  parameter Modelica.SIunits.Length dx=L/Ns "Section length";
  parameter Real ksD=(D+2*e)/(2*D_rec) "apparent roughness of the receiver";
  parameter Modelica.SIunits.Mass dM=ntubes*rhow*pi*((D + 2*e)^2 - D^2)/4*dx
    "Wall section mass";
public
  Modelica.SIunits.Power dW1[Ns](start=fill(3.e5, Ns), nominal=fill(3.e5, Ns))
    "Power in section i of side 1";
  Modelica.SIunits.Power dW2[Ns](start=fill(3.e5, Ns), nominal=fill(3.e5, Ns))
    "Power in section i of side 2";
  Modelica.SIunits.Power WRad[Ns](start=fill(0,Ns))
    "Radiation of the wall layer";
  Modelica.SIunits.Power WConv[Ns](start=fill(0,Ns))
    "Convection of the wall layer";
 Modelica.SIunits.Power Wrad_Total;
 Modelica.SIunits.Power Wconv_Total;
  Modelica.SIunits.Temperature Tatm(start=300) "Atmospheric temperature";
  Modelica.SIunits.Temperature Tfilm(start=300) "mean fluid temperature";
  Modelica.SIunits.ThermalConductivity lambda_air( start=0.03)
    "Air thermal conductivity";
  Modelica.SIunits.Density rho_air( start=1) "Air density";
  Modelica.SIunits.Density mu_air( start=1e-6) "Air viscosity";
  Modelica.SIunits.Temperature Tsky(start=300) "Sky temperature";
  Modelica.SIunits.Temperature Tp1[Ns](start=fill(300, Ns))
    "Wall temperature in section i of side 1";
  Modelica.SIunits.Temperature Tp2[Ns](start=fill(300, Ns))
    "Wall temperature in section i of side 2";
  Modelica.SIunits.Temperature Tp[Ns](start=fill(300, Ns))
    "Average wall temperature in section i";
  Modelica.SIunits.Temperature Tpm(start=300) "Average wall temperature";
  Modelica.SIunits.CoefficientOfHeatTransfer hc_n[Ns](start=fill(5, Ns))
    "Natural Convection losses coefficient";
  Modelica.SIunits.CoefficientOfHeatTransfer hc_f(start=11)
    "Forced Convection losses coefficient";
Modelica.SIunits.CoefficientOfHeatTransfer hc_f1(start=11)
    "Forced Convection losses coefficient";
Modelica.SIunits.CoefficientOfHeatTransfer hc_f2(start=11)
    "Forced Convection losses coefficient";
Modelica.SIunits.CoefficientOfHeatTransfer hc_f3(start=11)
    "Forced Convection losses coefficient";
  Modelica.SIunits.CoefficientOfHeatTransfer hc[Ns](start=fill(5, Ns))
    "Mixed Convection losses coefficient";
  Modelica.SIunits.Velocity v_wind(start=2) "Wind Velocity";
  Modelica.SIunits.ReynoldsNumber Re(start=6.e4) "Fluid Reynolds number ";
  Modelica.SIunits.GrashofNumber Gr[Ns](start=fill(1.e9, Ns))
    "Fluid Grashof number ";
 //Modelica.SIunits.Power WLosses[Ns](start=fill(10,Ns));

  ThermoSysPro.Thermal.Connectors.ThermalPort WT2[Ns] "Side 2"
    annotation (Placement(transformation(extent={{-10,10},{10,30}}, rotation=0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort WT1[Ns] "Side 1"
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}}, rotation=
            0)));
  InstrumentationAndControl.Connectors.InputReal AtmTemp
    "Atmospheric temperature (K)"
    annotation (Placement(transformation(extent={{-120,30},{-100,50}}, rotation=
           0)));
  InstrumentationAndControl.Connectors.InputReal WindVelo "wind velocity"
    annotation (Placement(transformation(extent={{-120,64},{-100,84}}, rotation=
           0)));
initial equation

   if steady_state then
    for i in 1:Ns loop
      der(Tp[i]) = 0;
    end for;

  else
    for i in 1:Ns loop
      Tp[i] = T0;
    end for;
  end if;

equation

  WT1.T = Tp1;
  WT1.W = dW1;

  WT2.T = Tp2;
  WT2.W = dW2;

  /* Input connectors */
  Tatm = AtmTemp.signal;
  Tfilm=  (Tatm+565.+273.15)/2;

/*
  rho_air = ThermoSysPro.Properties.FlueGases.FlueGases_rho(1e5, Tatm, 0, 0, 0.22, 0);
  mu_air = ThermoSysPro.Properties.FlueGases.FlueGases_mu(1e5, Tatm, 0, 0, 0.22, 0);
  lambda_air = ThermoSysPro.Properties.FlueGases.FlueGases_k(1e5, Tatm, 0, 0, 0.22, 0);
  rho_air = ThermoSysPro.Properties.FlueGases.FlueGases_rho(1e5, Tatm, 0, 0, 0.22, 0) + 0.01;
  mu_air = ThermoSysPro.Properties.FlueGases.FlueGases_mu(1e5, Tatm, 0, 0, 0.22, 0) + 1e-8;
  lambda_air = ThermoSysPro.Properties.FlueGases.FlueGases_k(1e5, Tatm, 0, 0, 0.22, 0) +0.001;
*/

  rho_air=  1.293*273/Tatm;
  mu_air=  8.8848e-15*Tatm^3-3.2398e-11*Tatm^2+6.2657e-8*Tatm+2.3543e-6;
  lambda_air=  Tatm^3*1.5207e-11-4.857e-8*Tatm^2+1.0184e-4*Tatm-3.9333e-4;

  v_wind = WindVelo.signal;

  /* Sky temperature */
  Tsky = 0.0552*Tatm^(1.5);

  /*Average wall temperature*/
  Tpm = sum(Tp2)/Ns;

  /* Convection Losses coefficient (using the Siebers & Kraabel correlation) */
  hc_f1 = noEvent(if ( Re < 7e5) and ( Re > 1.e-6) then hcCorr1*lambda_air/D_rec*(0.3+(0.488*Re^0.5*(1+(Re/282000)^0.625)^0.8)) else
     if ( Re < 2.2e7) and ( Re > 7e5) then hcCorr1*lambda_air/D_rec*2.57e-3*Re^0.98 else
     if (Re >= 2.2e7) then hcCorr1*lambda_air/D_rec*0.0455*Re^0.81 else 1e-6);
  hc_f2 = noEvent(if ( Re < 1.8e5) and ( Re > 1.e-6) then hcCorr1*lambda_air/D_rec*(0.3+(0.488*Re^0.5*(1+(Re/282000)^0.625)^0.8)) else
     if ( Re < 4e6) and ( Re > 1.8e5) then hcCorr1*lambda_air/D_rec*13.5e-3*Re^0.89 else
     if (Re >= 4e6) then hcCorr1*lambda_air/D_rec*0.0455*Re^0.81 else 1e-6);
  hc_f3 = noEvent(if ( Re < 1e5) and ( Re > 1.e-6) then hcCorr1*lambda_air/D_rec*(0.3+(0.488*Re^0.5*(1+(Re/282000)^0.625)^0.8)) else
     if (Re >= 1e5) then hcCorr1*lambda_air/D_rec*0.0455*Re^0.81 else 1e-6);

  hc_f = noEvent(if (ksD<150e-5) and
                                  (ksD>1e-10) then hc_f1 else if (ksD<700e-5) and (ksD>=150e-5) then hc_f2 else  hc_f3);

  Re = rho_air*v_wind*D_rec/mu_air;

  for i in 1:Ns loop
    /* natural Convection Losses coefficient */
    hc_n[i] = noEvent(if (lambda_air*Gr[i]*Tp2[i]) > 0 then hcCorr2*lambda_air/L_rec*0.098*Gr[i]^(1/3)*(Tp2[i]/Tatm)^(-0.14) else 1);

    /* Air volumetric expansion coefficient beta=1/Tatm */
    Gr[i] = noEvent( if (Tpm > Tatm) then g*(1/Tatm)*(Tpm-Tatm)*L_rec^3*rho_air^2/mu_air^2 else 1e-6);

    /* Mixed Convection Losses coefficient */
    hc[i] = (hc_n[i]^3.2+hc_f^3.2)^(1/3.2);
  end for;

  for i in 1:Ns loop
    /* Heat transfer on side 1 (internal) */
    dW1[i] = pi*dx*ntubes*lambda*(Tp1[i] - Tp[i])/(Modelica.Math.log(1 + e/D));

    /* Heat transfer on side 2 (external) */
    dW2[i]- WRad[i] - WConv[i] = pi*dx*ntubes*lambda*(Tp2[i] - Tp[i])/(Modelica.Math.log(1 + e/(e + D)));

    /* Thermal inertia */
    dM*cpw*der(Tp[i]) = dW2[i] + dW1[i] - WRad[i] - WConv[i];

    /* Heat losses on the 0.5 of the side 2 (convection, ratiation) */
    /*--------------------------------------------------------------*/
    /* Radiation losses: For Separation between cylinders = 0     => F12= 0.6366 */
    WRad[i] = noEvent( if (Tp2[i] > Tsky) then ( 0.5*0.6366*Sc*pi*(D+2*e)*dx*ntubes*sigma*Eps*(Tp2[i]^(4) - Tsky^(4)) + 0.5*0.6366*Sc*pi*(D+2*e)*dx*ntubes*sigma*Eps*(Tp2[i]^(4) - Tatm^(4))) else  0);

    /* Convection and conduction losses: For the conduction losses: the Receiver is considered as plain wall and */
    /* For simplify: We take the Temperature of the Inside of the Insulation wall is equal to Tp1 and Outside Temperature to Tatm */
    WConv[i] = noEvent( if (Tp2[i] > Tatm) then (Sc*pi*(D+2*e)*dx*ntubes*hc[i]*(Tp2[i] - Tatm)) + (Sc*pi*(D+2*e)*dx*ntubes*lambda_ins/e_ins)*(Tp1[i] - Tatm) else 0);

    //WLosses [i] = WConv[i] + WRad[i];

  end for;

Wrad_Total=sum(WRad);
Wconv_Total=sum(WConv);

  annotation (
    Icon(graphics={
        Rectangle(
          extent={{-100,10},{100,-10}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.CrossDiag),
        Text(
          extent={{-80,40},{-20,20}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString=
               "2"),
        Text(
          extent={{-80,-20},{-20,-40}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString=
               "1"),
        Text(
          extent={{20,40},{98,20}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString=
               "External"),
        Text(
          extent={{20,-20},{98,-40}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString=
               "Internal"),
        Text(
          extent={{-94,62},{-20,40}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString=
               "With Losses"),
        Text(
          extent={{-122,32},{-100,16}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString=
               "Tatm"),
        Text(
          extent={{-122,70},{-96,50}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString=
               "v_wind")}),
    Diagram(graphics={
        Rectangle(
          extent={{-100,10},{100,-10}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-80,30},{-20,10}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString=
               "Side 2"),
        Text(
          extent={{-80,-10},{-20,-30}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString=
               "Side 1"),
        Text(
          extent={{20,-10},{98,-30}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString=
               "Internal"),
        Text(
          extent={{20,30},{98,10}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString=
               "External"),
        Text(
          extent={{-96,66},{-22,44}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString=
               "With Losses")}),
    DymolaStoredErrors,
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019</h4>
<p><b>ThermoSysPro Version 3.2</h4>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Baligh El Hefni</li>
<li>Marie-Agnes Garnero</li>
<li>Guillaume Larrignon</li>
</ul>
</html>"));
end HeatExchangerWallWithLosses;
