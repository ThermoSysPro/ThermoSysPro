within ThermoSysPro.Examples.Book.PowerPlants;
model ConcentratedSolarPowerPlant_PTSC "Model of a concentrated solar power plant with PTSC"
  import ThermoSysPro;

//parameter Real L1 = 500 "Longueur de la première chaine de capteurs";
parameter Real L1 = 500 "Longueur de la première chaine de capteurs";
parameter Integer Ns1 = 20
    "Nombre de mailles de la première chaine de capteurs";

parameter Real L2 = 80 "Longueur de la deuxième chaine de capteurs";
parameter Integer Ns2 = 5 "Nombre de mailles de la deuxième échangeur";

parameter Real L3 = 450 "Longueur de la première chaine de capteurs";
parameter Integer Ns3 = 80 "Nombre de mailles de la première échangeur";

//parameter Real L4 = 7.9254 "Longueur de la première chaine de capteurs";
parameter Real L4 = 20 "Longueur de la première chaine de capteurs";
parameter Integer Ns4 = 3 "Nombre de mailles de la première échangeur";

  WaterSteam.HeatExchangers.DynamicOnePhaseFlowPipe TubeEcran_2(
    option_temperature=2,
    L=L2,
    Ns=Ns2,
    T0={659.137,684.387,693.983,697.543,698.861},
    h0=fill(650e3, Ns2),
    D=0.04,
    hcCorr=2,
    ntubes=3,
    inertia=false,
    advection=false,
    P(start={100000.0,8120050.0,8098500.0,8074750.0,8050150.0,8025170.0,8000000.0}),
    h(start={2756570.0,3040300.0,3147840.0,3187560.0,3202330.0,3208020.0,3208020.0}),
    mu2(start={1.94524E-005,0.0002,0.0002,0.0002,0.0002,0.0002}),
    pro2(d(start={43.2944,998.0,998.0,998.0,998.0,998.0})))
                     annotation (                        Placement(
        transformation(extent={{-31,34},{25,78}}, rotation=0)));

  Thermal.HeatTransfer.HeatExchangerWallCounterFlow Paroi2(
    cpw=1000,
    steady_state=true,
    lambda=26,
    L=L2,
    Ns=Ns2,
    D=0.04,
    ntubes=3,
    e=0.003,
    Tp2(start={699.6,697.841,694.783,686.553,664.851}),
    Tp(start={662.094,685.508,694.397,697.697,698.921}))
                     annotation (                         Placement(
        transformation(extent={{-34,54},{26,102}}, rotation=0)));
  WaterSteam.PressureLosses.SingularPressureLoss PerteCharge_Huile_3(K=1e-6,
      p_rho=900,
    C1(h_vol(start=462620.0)),
    C2(h_vol(start=462620.0)))
    annotation (
    Placement(transformation(
        origin={-134,138.5},
        extent={{6,-9.5},{-6,9.5}},
        rotation=180)));
  InstrumentationAndControl.Blocks.Tables.Table1DTemps Tatm(             Table=
        [0,300; 1,300])
    annotation (                             Placement(transformation(extent={{-322,
            186},{-306,202}},      rotation=0)));
  InstrumentationAndControl.Blocks.Tables.Table1DTemps Incidence(
      Table=[0,0; 1,0])
    annotation (                             Placement(transformation(extent={{-322,
            146},{-306,162}},      rotation=0)));
  Thermal.HeatTransfer.HeatExchangerWall Paroi3(
    cpw=1000,
    steady_state=true,
    lambda=26,
    L=L3,
    Ns=Ns3,
    D=0.06,
    e=0.006,
    Tp1(start={540.2,541.953,544.376,546.789,549.192,551.586,553.969,556.344,
          558.708,561.063,563.408,565.743,568.068,570.384,572.69,574.986,
          577.273,579.55,581.817,584.074,586.322,588.559,590.787,593.006,
          595.214,597.413,599.602,601.782,603.952,606.112,608.262,610.403,
          612.534,614.656,616.768,618.871,620.965,623.048,625.123,627.188,
          629.244,631.291,633.329,635.357,637.377,639.387,641.389,643.382,
          645.366,647.342,649.309,651.268,653.218,655.16,657.095,659.021,660.94,
          662.851,664.755,666.651,668.54,670.423,672.298,674.167,676.029,
          677.885,679.735,681.578,683.416,685.248,687.074,688.894,690.709,
          692.518,694.322,696.121,697.914,699.701,701.483,703.26}),
    Tp2(start={543.606,546.033,548.45,550.857,553.254,555.642,558.02,560.389,
          562.747,565.096,567.435,569.765,572.084,574.394,576.694,578.984,
          581.265,583.536,585.797,588.048,590.289,592.521,594.742,596.954,
          599.157,601.349,603.532,605.705,607.869,610.022,612.166,614.301,
          616.426,618.541,620.647,622.743,624.83,626.907,628.975,631.033,
          633.082,635.122,637.153,639.175,641.188,643.191,645.186,647.172,
          649.15,651.118,653.079,655.03,656.974,658.909,660.837,662.756,664.668,
          666.572,668.468,670.357,672.239,674.114,675.982,677.844,679.699,
          681.547,683.39,685.226,687.056,688.88,690.699,692.512,694.319,696.121,
          697.917,699.708,701.493,703.273,705.048,706.816}),
    Tp(start={541.71,544.139,546.559,548.969,551.369,553.759,556.14,558.511,
          560.872,563.224,565.566,567.898,570.22,572.533,574.836,577.129,
          579.412,581.685,583.949,586.203,588.447,590.682,592.907,595.122,
          597.327,599.522,601.708,603.884,606.05,608.207,610.354,612.492,614.62,
          616.738,618.847,620.946,623.036,625.116,627.187,629.249,631.301,
          633.344,635.378,637.403,639.419,641.426,643.424,645.413,647.393,
          649.365,651.329,653.284,655.231,657.169,659.1,661.022,662.937,664.845,
          666.745,668.637,670.522,672.401,674.272,676.137,677.995,679.847,
          681.693,683.533,685.366,687.194,689.016,690.833,692.643,694.449,
          696.249,698.043,699.832,701.615,703.393,705.165}))
                     annotation (                            Placement(
        transformation(extent={{-105,134},{-45,182}}, rotation=0)));
  ThermoSysPro.Solar.Collectors.SolarCollector SolarCollector1(
    EpsGlass=0.86,
    Gamma=0.83,
    h=3.06,
    AlphaGlass=0.0302,
    RimAngle=70,
    TauN=0.95,
    AlphaN=0.96,
    EpsTube=0.14,
    R=0.93,
    Lambda=2.891407518e-2,
    f=1.78518,
    AReflector(fixed=false, start=2750),
    DGlass=0.115,
    L=L3,
    Ns=Ns3,
    DTube=0.07,
    e=1.e-3,
    Tglass(start={364.716,365.398,366.082,366.767,367.453,368.14,368.829,
          369.519,370.209,370.901,371.594,372.288,372.982,373.678,374.374,
          375.071,375.768,376.466,377.165,377.864,378.564,379.264,379.964,
          380.665,381.366,382.067,382.769,383.47,384.172,384.873,385.575,
          386.276,386.978,387.679,388.38,389.081,389.782,390.482,391.182,
          391.882,392.581,393.28,393.979,394.677,395.375,396.072,396.769,
          397.465,398.161,398.856,399.551,400.245,400.939,401.632,402.324,
          403.017,403.708,404.399,405.09,405.78,406.47,407.16,407.849,408.538,
          409.226,409.915,410.603,411.29,411.978,412.665,413.352,414.039,
          414.726,415.413,416.099,416.786,417.472,418.158,418.843,419.528}))
    annotation (Placement(transformation(extent={{-108,166},{-43,200}},
          rotation=0)));
  Solar.HeatExchangers.DynamicOnePhaseFlowPipe_Oil
                                    TubeEcran_3(
    option_temperature=2,
    L=L3,
    Ns=Ns3,
    T0={539.521,700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,
        700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,
        700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,
        700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,
        700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,
        700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0,
        700.0,700.0,700.0,700.0,700.0,700.0,700.0,700.0},
    h0=fill(800e3, Ns3),
    advection=false,
    dpfCorr=0.4,
    hcCorr=2,
    D=0.06,
    h(start={463696.125,468056.0,473485.0,478907.0,484321.0,489728.0,495127.0,500518.0,
          505902.0,511278.0,516646.0,522007.0,527360.0,532705.0,538041.0,543370.0,
          548691.0,554004.0,559309.0,564606.0,569895.0,575175.0,580447.0,585711.0,
          590967.0,596214.0,601453.0,606683.0,611905.0,617118.0,622323.0,627519.0,
          632707.0,637886.0,643056.0,648217.0,653370.0,658514.0,663649.0,668775.0,
          673893.0,679001.0,684100.0,689191.0,694272.0,699345.0,704408.0,709462.0,
          714507.0,719542.0,724569.0,729586.0,734594.0,739593.0,744582.0,749562.0,
          754532.0,759493.0,764445.0,769387.0,774320.0,779242.0,784156.0,789059.0,
          793953.0,798837.0,803712.0,808577.0,813431.0,818276.0,823111.0,827936.0,
          832752.0,837557.0,842352.0,847137.0,851911.0,856676.0,861430.0,866175.0,
          870908.0,870908.0}))
                     annotation (                            Placement(
        transformation(extent={{-103,117},{-47,161}}, rotation=0)));
  WaterSteam.PressureLosses.SingularPressureLoss PerteCharge_Huile_4(K=1e-6,
      p_rho=650,
    C2(h_vol(start=870908.0)))
    annotation (
    Placement(transformation(
        origin={-5,139},
        extent={{6,-10},{-6,10}},
        rotation=180)));
  Solar.HeatExchangers.DynamicOnePhaseFlowPipe_Oil
                                    TubeEcran_22(
    option_temperature=2,
    Ns=Ns2,
    T0={698.976,700.0,700.0,700.0,700.0},
    h0=fill(800e3, Ns2),
    L=L2,
    D=0.04,
    advection=false,
    hcCorr=2,
    dpfCorr=0.4,
    ntubes=3,
    h(start={871999.6875,870017.0,867699.0,861464.0,844586.0,800057.0,800057.0}))
                     annotation (                         Placement(
        transformation(extent={{24,122},{-33,78}}, rotation=0)));
  Thermal.HeatTransfer.HeatExchangerWallCounterFlow Paroi1(
    cpw=1000,
    steady_state=true,
    lambda=26,
    L=L1,
    Ns=Ns1,
    D=0.04,
    ntubes=3,
    e=0.003,
    Tp1(start={532.912,533.493,534.161,534.93,535.816,536.836,538.01,539.364,
          540.926,542.728,544.809,547.216,550.002,553.232,556.986,561.36,
          566.473,572.131,573.043,574.577}),
    Tp2(start={589.9,577.664,573.793,567.743,562.426,557.888,553.999,550.657,
          547.777,545.292,543.143,541.284,539.674,538.278,537.068,536.017,
          535.105,534.312,533.624,533.026}),
    Tp(start={532.971,533.561,534.239,535.021,535.92,536.956,538.149,539.525,
          541.111,542.943,545.059,547.506,550.341,553.629,557.453,561.912,
          567.13,572.991,575.434,581.427}))
                     annotation (                            Placement(
        transformation(extent={{-174,54},{-114,102}}, rotation=0)));
  WaterSteam.HeatExchangers.DynamicTwoPhaseFlowPipe TubeEcran_1(
    option_temperature=2,
    L=L1,
    Ns=Ns1,
    T0=fill(300, Ns1),
    h0=fill(650e3, Ns1),
    D=0.04,
    ntubes=3,
    inertia=false,
    advection=false,
    P(start={8716030.0,8695070.0,8674080.0,8653070.0,8632030.0,8610950.0,8589840.0,
          8568690.0,8547480.0,8526210.0,8504870.0,8483450.0,8461930.0,8440290.0,
          8418510.0,8396570.0,8374420.0,8352020.0,8329300.0,8305110.0,8256160.0,
          8135653.0}),
    h(start={1130270.0,1132680.0,1135470.0,1138670.0,1142370.0,1146630.0,1151550.0,
          1157240.0,1163810.0,1171420.0,1180240.0,1190480.0,1202400.0,1216300.0,
          1232580.0,1251720.0,1274350.0,1301310.0,1336580.0,1434650.0,1715580.0,
          2756578.25}))
                     annotation (                           Placement(
        transformation(extent={{-171,34},{-115,78}}, rotation=0)));
  Solar.HeatExchangers.DynamicOnePhaseFlowPipe_Oil
                                    TubeEcran_11(
    option_temperature=2,
    L=L1,
    Ns=Ns1,
    T0={587.815,550.0,550.0,550.0,550.0,550.0,550.0,550.0,550.0,550.0,550.0,550.0,
        550.0,550.0,550.0,550.0,550.0,550.0,550.0,550.0},
    h0=fill(650e3, Ns1),
    D=0.04,
    advection=false,
    hcCorr=2,
    dpfCorr=0.4,
    ntubes=3,
    h(start={801122.25,638880.0,582613.0,562383.0,546913.0,533929.0,522949.0,513609.0,
          505631.0,498794.0,492917.0,487857.0,483492.0,479721.0,476460.0,473637.0,
          471191.0,469070.0,467231.0,465634.0,464248.0,464248.0}))
                     annotation (                            Placement(
        transformation(extent={{-116,122},{-173,78}}, rotation=0)));
  ThermoSysPro.WaterSteam.Junctions.SteamDryer Secheur(proe(x(start=0.273553)))
    annotation (Placement(transformation(extent={{-86,39},{-62,63}}, rotation=0)));
  WaterSteam.HeatExchangers.SimpleDynamicCondenser Condenseur(
    A=5,
    Kvl=100,
    e=0.0005,
    L=3.5,
    Vf0=0.15,
    ntubes=300,
    steady_state=false,
    V=30,
    P0=5000,
    Cv(Q(start=1.13)),
    Pfond(start=5000.53),
    proe(d(start=995.533)))
                     annotation (                           Placement(
        transformation(extent={{116,-51},{156,-11}}, rotation=0)));
  WaterSteam.BoundaryConditions.SinkP puitsPCaloporteur(
                    mode=0, P0=1e5,
    option_temperature=2) annotation (                           Placement(
        transformation(extent={{178,-48},{206,-22}}, rotation=0)));
  WaterSteam.PressureLosses.SingularPressureLoss PerteChargeCondPompe(             K=1e-6,
    C2(h_vol(start=137765.0)),
    Pm(start=5000.53))
    annotation (
    Placement(transformation(
        origin={117,-82.5},
        extent={{-6,-9.5},{6,9.5}},
        rotation=180)));
  WaterSteam.PressureLosses.InvSingularPressureLoss
    Connection_HQ_Secheur_Ballon(Q(start=1))
    annotation (
    Placement(transformation(
        origin={-73,-15},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  WaterSteam.Machines.StaticCentrifugalPump Pompe(
    Pm(fixed=false, start=3502560.0),
    a1(fixed=false) = -4.9345734425e8,
    hn(start=716.167),
    a3=2000,
    b1=-3500,
    b2=510,
    Q(fixed=true, start=1.13),
    C2(h_vol(start=150161.0)),
    Qv(start=0.00113454),
    h(start=143963.0))           annotation (                         Placement(
        transformation(extent={{84,-91},{64,-71}}, rotation=0)));
  WaterSteam.Volumes.VolumeC Ballon(
    V=1,
    h0=3e5,
    h(start=1125640.0),
    P0=7000000,
    dynamic_mass_balance=true,
    P(start=7000000))
    annotation (                           Placement(transformation(extent={{-63,-91},
            {-83,-71}},          rotation=0)));
  WaterSteam.PressureLosses.ControlValve ControlValveBallon(             Cvmax(
        fixed=true) = 300, C2(P(fixed=false, start=70e5)),
    Pm(start=7000060.0))
    annotation (
    Placement(transformation(
        origin={-30,-75},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  WaterSteam.PressureLosses.ControlValve ControlValveBallon1(             Cvmax=
       10,
    C1(P(start=10618800.0), h_vol(start=1127430.0)),
    C2(h_vol(start=1127430.0)),
    Pm(start=9676220.0))
    annotation (
    Placement(transformation(
        origin={-212,-75},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  WaterSteam.BoundaryConditions.SourceP sourcePCaloporteur(
    option_temperature=2,
    h0=63.03e3,
    P0(fixed=false) = 500000,
    Q(fixed=true, start=14.9263))
                                annotation (                         Placement(
        transformation(extent={{66,-49},{94,-22}}, rotation=0)));
  WaterSteam.PressureLosses.SingularPressureLoss PerteChargeCondPompe1(            K=1e-6)
    annotation (
    Placement(transformation(
        origin={171,-35},
        extent={{6,-10},{-6,10}},
        rotation=180)));
  WaterSteam.PressureLosses.SingularPressureLoss PerteChargeCondPompe2(            K=1e-6, pro(d(
          start=999.099)))
    annotation (
    Placement(transformation(
        origin={101,-36},
        extent={{6,-10},{-6,10}},
        rotation=180)));
  InstrumentationAndControl.Blocks.Sources.Constante Ouv(             k=0.5)
    annotation (                           Placement(transformation(extent={{-48,-62},
            {-38,-52}},          rotation=0)));
  InstrumentationAndControl.Blocks.Sources.Constante Ouv1(             k=0.5)
    annotation (                             Placement(transformation(extent={{-231,
            -62},{-221,-52}},      rotation=0)));
  WaterSteam.Machines.StaticCentrifugalPump Pompe1(
    Pm(fixed=false),
    hn(start=466.292),
    a3=2000,
    b2=510,
    b1=-3500,
    a1(fixed=false) = -9.5e8,
    Q(fixed=false, start=0.65),
    C2(P(fixed=false, start=75e5)),
    C1(P(fixed=true, start=70e5), h_vol(start=1125640.0)),
    Qv(start=0.00521975),
    h(start=1126540.0))          annotation (
      Placement(transformation(extent={{-158,-91},{-178,-71}}, rotation=0)));
  WaterSteam.PressureLosses.SingularPressureLoss PerteChargeCondPompe3(            K=1e-6)
    annotation (
    Placement(transformation(
        origin={-120,-81},
        extent={{-6,-10},{6,10}},
        rotation=180)));
  WaterSteam.Machines.StodolaTurbine Turbine(
    W_fric=1,
    Cst(fixed=false,
      start=68143000000.0)=
                       6.19323e6,
    Qmax=0.001,
    eta_is_min=0.80,
    rhos(start=10),
    eta_is_nom=0.92,
    Pe(fixed=true, start=8000000),
    Ps(fixed=false, start=1800000),
    pros(d(start=8.36949)))
                      annotation (                       Placement(
        transformation(extent={{47,72},{73,40}}, rotation=0)));
  WaterSteam.Machines.Generator Alternateur
    annotation (                          Placement(transformation(extent={{168,90},
            {198,130}},     rotation=0)));
  Thermal.HeatTransfer.HeatExchangerWallCounterFlow Paroi4(
    cpw=1000,
    steady_state=true,
    lambda=26,
    D=0.04,
    L=L4,
    Ns=Ns4,
    ntubes=3,
    e=0.003,
    Tp1(start={532.06,532.262,532.478}),
    Tp2(start={533.3,532.429,532.217}),
    Tp(start={532.141,532.349,532.57}))
                     annotation (
    Placement(transformation(
        origin={-269,-12},
        extent={{-24,-30},{24,30}},
        rotation=90)));
  WaterSteam.HeatExchangers.DynamicTwoPhaseFlowPipe TubeEcran_4(
    option_temperature=2,
    D=0.04,
    L=L4,
    Ns=Ns4,
    T0=fill(300, Ns4),
    h0=fill(650e3, Ns4),
    ntubes=3,
    inertia=false,
    advection=false,
    P(start={8751668.0,8729230.0,8724830.0,8720430.0,8733863.0}),
    h(start={1128519.5,1128310.0,1129260.0,1130270.0,1131729.0}))
                     annotation (
    Placement(transformation(
        origin={-245.5,-11.5},
        extent={{-23.5,-23.5},{23.5,23.5}},
        rotation=90)));
  Solar.HeatExchangers.DynamicOnePhaseFlowPipe_Oil
                                    TubeEcran_44(
    option_temperature=2,
    L=L4,
    Ns=Ns4,
    T0={532.656,550.0,550.0},
    h0=fill(650e3, Ns4),
    advection=false,
    D(fixed=true) = 0.04,
    C2(P(fixed=false, start=16.99e5), Q(fixed=false, start=2)),
    hcCorr=2,
    dpfCorr=0.4,
    ntubes=3,
    h(start={465547.78125,463670.0,463128.0,462620.0,462620.0}))
                     annotation (
    Placement(transformation(
        origin={-293,-12},
        extent={{23,-24},{-23,24}},
        rotation=90)));
  WaterSteam.Machines.StaticCentrifugalPump Pompe2(
    Pm(fixed=false),
    b2=510,
    b1=-3500,
    hn(start=350),
    adiabatic_compression=true,
    C1(P(fixed=false, start=17e5), h_vol(start=462620.0)),
    a3(fixed=true) = 500,
    C2(P(fixed=false, start=24.5146e5)),
    p_rho=900,
    Q(fixed=true, start=7.2),
    a1(fixed=false) = -1e8)      annotation (
      Placement(transformation(extent={{-184,129},{-164,149}}, rotation=0)));
  WaterSteam.PressureLosses.SingularPressureLoss PerteCharge_Huile_2(K=1e-6,
      p_rho=900)
    annotation (
    Placement(transformation(
        origin={-212,138.5},
        extent={{6,-9.5},{-6,9.5}},
        rotation=180)));
  WaterSteam.PressureLosses.SingularPressureLoss PerteCharge_Huile_1(K=1e-6,
      p_rho=900)
    annotation (
    Placement(transformation(
        origin={-286,138.5},
        extent={{6,-9.5},{-6,9.5}},
        rotation=180)));
  WaterSteam.Machines.StodolaTurbine TurbineMp(
    W_fric=1,
    Cst(fixed=false,
      start=8378550000.0)=
                       6.19323e6,
    Qmax=0.001,
    eta_is_min=0.80,
    rhos(start=10),
    eta_is_nom=0.94,
    Pe(fixed=true, start=1800000),
    Ps(fixed=false, start=5000),
    pros(d(start=0.0434309)),
    xm(start=0.908482))
                      annotation (                         Placement(
        transformation(extent={{105,72},{131,40}}, rotation=0)));
  WaterSteam.Volumes.Tank Tank(
    p_rho=895,
    A=0.1,
    z0=1,
    h0=423600,
    steady_state=true,
    h(start=462620.0),
    rho(start=895),
    Patm=1670000,
    P(start=1699000))
    annotation (
    Placement(transformation(
        origin={-248,142},
        extent={{6,6},{-6,-6}},
        rotation=180)));
  WaterSteam.Volumes.VolumeA VolumeMP(
    V=1,
    rho(start=10),
    h0=2.4e6,
    h(start=2868560.0),
    P0=1800000,
    dynamic_mass_balance=true,
    P(start=1800000),
    Cs2(Q(start=0.255955)))
    annotation (                       Placement(transformation(extent={{84,50},
            {94,62}}, rotation=0)));
  WaterSteam.Volumes.VolumeA VolumeCond(
    V=1,
    rho(start=10),
    h(start=1837610.0),
    h0=2.1e6,
    P0=5000,
    dynamic_mass_balance=false,
    P(start=5000))
    annotation (                         Placement(transformation(extent={{141,24},
            {130,34}},     rotation=0)));
  WaterSteam.HeatExchangers.NTUWaterHeating Re_1(
    KPurge=10,
    SPurge=0.3,
    Se(h(fixed=true, start=600e3)),
    SCondDes(fixed=false,
      start=9.57697) =      3,
    HDesF(start=583561.0),
    HeiF(start=150619.0),
    Hep(start=884611.0),
    SDes(start=0.932441),
    h(start=882589.0),
    lambdaE=1,
    KCond=500)  annotation (                         Placement(transformation(
          extent={{42,-106},{0,-56}}, rotation=0)));
  WaterSteam.PressureLosses.SingularPressureLoss Dp_Re_1(
    rho(start=10),
    h(start=2400e3),
    Q(start=0.1),
    K=1e-4,
    Pm(start=1800000))
    annotation (
    Placement(transformation(
        origin={31.5,-13.5},
        extent={{5.5,-5.5},{-5.5,5.5}},
        rotation=90)));
  WaterSteam.PressureLosses.InvSingularPressureLoss invSingularPressureLoss
    annotation (                            Placement(transformation(extent={{108,
            -106},{122,-90}},     rotation=0)));
  WaterSteam.PressureLosses.SingularPressureLoss Dp_Cond_2(
    K=1e-4,
    rho(start=10),
    Q(start=0.35),
    Pm(start=5000.53),
    h(start=2100e3))
    annotation (
    Placement(transformation(
        origin={135.5,8.5},
        extent={{5.5,-5.5},{-5.5,5.5}},
        rotation=90)));
  InstrumentationAndControl.Blocks.Tables.Table1DTemps Rayonnement(Table=[0,700;
        200,2; 1200,2; 1800,2; 2400,0.1; 3000,0.1; 3600,0.1; 4200,327; 4800,287;
        5400,176; 6000,410; 6600,299; 7200,26; 7800,168; 8400,485; 9000,482;
        9600,664; 10200,344; 10800,684; 11400,564; 12000,460; 12600,560; 13200,
        611; 13800,557; 14400,682; 15000,785; 15600,321; 16200,850; 16800,330;
        17400,619; 18000,480; 18600,192; 19200,750; 19800,650; 20400,450; 21000,
        350; 21600,763; 22200,455; 22800,290; 23400,494; 24000,800; 24600,565;
        25200,320; 25800,110; 26400,479; 27000,263; 27600,747; 28200,805; 28800,
        576; 29400,550; 30000,470; 30600,395; 31200,315; 31800,657; 32400,670;
        33000,381; 33600,209; 34200,457; 34800,320; 35400,13; 36000,0.1; 36600,
        0.1; 37200,0.1; 37800,0.1; 38400,0.1; 39000,0.1; 39600,0.1; 40200,0.1;
        40800,0; 41400,0; 42000,0; 42600,0; 43200,0; 43800,0])
    annotation (Placement(transformation(extent={{-322,166},{-306,182}},
          rotation=0)));
equation

public
  WaterSteam.Junctions.MassFlowMultiplier massFlowMultiplier(alpha=3, P(start=
          2300000))
    annotation (Placement(transformation(extent={{21,128},{37,150}})));
  WaterSteam.Junctions.MassFlowMultiplier massFlowMultiplier2(alpha=1/3, P(start=
          2400000))                              annotation (Placement(
        transformation(
        extent={{-7.75,-9.75},{7.75,9.75}},
        rotation=0,
        origin={-158.25,139.75})));
equation
  connect(TubeEcran_2.CTh, Paroi2.WT1) annotation (
    Line(points={{-3,62.6},{-4,64},{-4,73.2}}, color={191,95,0}));
  connect(SolarCollector1.ITemperature,Paroi3. WT2)
                                                   annotation (
    Line(points={{-74.3026,166.992},{-75,166.992},{-75,162.8}}, color={191,95,0}));
  connect(Incidence.y,SolarCollector1. IncidenceAngle)
    annotation (
              Line(points={{-305.2,154},{-262,154},{-262,182},{-106.289,182},{
          -106.289,183}}));
  connect(TubeEcran_3.CTh,Paroi3. WT1) annotation (
    Line(points={{-75,145.6},{-75,153.2}}, color={191,95,0}));
  connect(Tatm.y,SolarCollector1. AtmTemp) annotation (
    Line(points={{-305.2,194},{-282,194},{-282,197.167},{-106.289,197.167}}));
  connect(PerteCharge_Huile_3.C2, TubeEcran_3.C1)   annotation (
    Line(
      points={{-128,138.5},{-102,138.5},{-102,140},{-103,139}},
      color={0,127,0},
      thickness=0.5));
  connect(TubeEcran_3.C2, PerteCharge_Huile_4.C1)
    annotation (
    Line(
      points={{-47,139},{-11,139}},
      color={0,127,0},
      thickness=0.5));
  connect(Paroi2.WT2, TubeEcran_22.CTh) annotation (
    Line(points={{-4,82.8},{-4,93.4},{-4.5,93.4}}, color={191,95,0}));
  connect(TubeEcran_1.CTh,Paroi1. WT1) annotation (
    Line(points={{-143,62.6},{-144,64},{-144,73.2}}, color={191,95,0}));
  connect(Paroi1.WT2,TubeEcran_11. CTh) annotation (
    Line(points={{-144,82.8},{-144,93.4},{-144.5,93.4}}, color={191,95,0}));
  connect(TubeEcran_11.C1, TubeEcran_22.C2)
    annotation (
    Line(
      points={{-116,100},{-33,100}},
      color={0,127,0},
      thickness=0.5));
  connect(TubeEcran_1.C2, Secheur.Cev) annotation (
    Line(
      points={{-115,56},{-85.88,56},{-85.88,55.8}},
      color={255,0,0},
      thickness=0.5));
  connect(Secheur.Csv, TubeEcran_2.C1) annotation (
    Line(
      points={{-62.12,55.8},{-60,55.8},{-60,56},{-31,56}},
      color={255,0,0},
      thickness=0.5));
  connect(Pompe.C1,PerteChargeCondPompe. C2)
    annotation (
    Line(
      points={{84,-81},{84,-82},{111,-82},{111,-82.5}},
      color={0,0,255},
      thickness=0.5));
  connect(Ballon.Ce1,ControlValveBallon. C2)
    annotation (
    Line(
      points={{-63,-81},{-40,-81}},
      color={0,0,255},
      thickness=0.5));
  connect(Secheur.Csl,Connection_HQ_Secheur_Ballon. C1) annotation (
    Line(
      points={{-73.88,39},{-73.88,-5},{-73,-5}},
      color={0,0,255},
      thickness=0.5));
  connect(Connection_HQ_Secheur_Ballon.C2,Ballon. Ce2) annotation (
    Line(
      points={{-73,-25},{-73,-72}},
      color={0,0,255},
      thickness=0.5));
  connect(sourcePCaloporteur.C,PerteChargeCondPompe2. C1) annotation (
    Line(points={{94,-35.5},{94,-36},{95,-36}}, color={0,0,255}));
  connect(PerteChargeCondPompe1.C2,puitsPCaloporteur. C) annotation (
    Line(points={{177,-35},{178,-36},{178,-35}}, color={0,0,255}));
  connect(Pompe1.C2,ControlValveBallon1. C1) annotation (
    Line(
      points={{-178,-81},{-202,-81}},
      color={0,0,255},
      thickness=0.5));
  connect(PerteChargeCondPompe3.C1,Ballon. Cs)
    annotation (
    Line(
      points={{-114,-81},{-83,-81}},
      color={0,0,255},
      thickness=0.5));
  connect(Ouv1.y,ControlValveBallon1. Ouv)
    annotation (                                         Line(points={{-220.5,
          -57},{-212,-57},{-212,-64}}));
  connect(Ouv.y,ControlValveBallon. Ouv)
    annotation (                                      Line(points={{-37.5,-57},
          {-30,-57},{-30,-64}}));
  connect(PerteChargeCondPompe2.C2,Condenseur. Cee) annotation (
    Line(points={{107,-36},{109.25,-36},{109.25,-35.4},{116,-35.4}}, color={0,0,255}));
  connect(Condenseur.Cse,PerteChargeCondPompe1. C1) annotation (
    Line(points={{156,-35},{160,-34},{160,-35},{165,-35}}, color={0,0,255}));
  connect(Condenseur.Cl,PerteChargeCondPompe. C1) annotation (
    Line(
      points={{136.4,-51},{136.4,-82.5},{123,-82.5}},
      color={0,0,255},
      thickness=0.5));
  connect(PerteChargeCondPompe3.C2, Pompe1.C1) annotation (
    Line(
      points={{-126,-81},{-158,-81}},
      color={0,0,255},
      thickness=0.5));
  connect(Turbine.MechPower,Alternateur. Wmec5)
    annotation (                                            Line(points={{74.3,
          70.4},{76,70.4},{76,94},{168,94}}));
  connect(TubeEcran_2.C2, Turbine.Ce) annotation (
    Line(
      points={{25,56},{46.87,56}},
      color={255,0,0},
      thickness=0.5));
  connect(TubeEcran_4.CTh,Paroi4. WT1) annotation (
    Line(points={{-252.55,-11.5},{-257,-11.5},{-257,-12},{-263,-12}}, color={191,95,0}));
  connect(Paroi4.WT2, TubeEcran_44.CTh) annotation (
    Line(points={{-275,-12},{-280,-12},{-300.2,-12}}, color={191,95,0}));
  connect(ControlValveBallon1.C2, TubeEcran_4.C1) annotation (
    Line(
      points={{-222,-81},{-245.5,-81},{-245.5,-35}},
      color={0,0,255},
      thickness=0.5));
  connect(TubeEcran_4.C2, TubeEcran_1.C1) annotation (
    Line(
      points={{-245.5,12},{-245.5,56},{-171,56}},
      color={0,0,255},
      thickness=0.5));
  connect(TubeEcran_11.C2, TubeEcran_44.C1) annotation (
    Line(
      points={{-173,100},{-293,100},{-293,11}},
      color={0,127,0},
      thickness=0.5));
  connect(PerteCharge_Huile_2.C2, Pompe2.C1)   annotation (
    Line(
      points={{-206,138.5},{-184,138.5},{-184,139}},
      color={0,127,0},
      thickness=0.5));
  connect(Tank.Cs2, PerteCharge_Huile_2.C1)                    annotation (
    Line(
      points={{-242,138.4},{-230,138.4},{-230,138.5},{-218,138.5}},
      color={0,127,0},
      thickness=0.5));
  connect(PerteCharge_Huile_1.C2, Tank.Ce2) annotation (
    Line(
      points={{-280,138.5},{-268,138.5},{-268,138.4},{-254,138.4}},
      color={0,127,0},
      thickness=0.5));
  connect(Turbine.Cs, VolumeMP.Ce1) annotation (
    Line(
      points={{73.13,56},{84,56}},
      color={255,0,0},
      thickness=0.5));

  connect(VolumeMP.Cs1, TurbineMp.Ce) annotation (
    Line(
      points={{94,56},{104.87,56}},
      color={255,0,0},
      thickness=0.5));
  connect(TurbineMp.MechPower, Alternateur.Wmec4)
    annotation (                                                 Line(points={{132.3,
          70.4},{142,70.4},{142,102},{168,102}}));
  connect(TurbineMp.Cs, VolumeCond.Ce2) annotation (
    Line(
      points={{131.13,56},{135.5,56},{135.5,33.9}},
      color={255,0,0},
      thickness=0.5));
  connect(Re_1.Ee, Pompe.C2)
    annotation (
    Line(points={{42.42,-81},{64,-81}}, thickness=0.5));
  connect(VolumeMP.Cs2, Dp_Re_1.C1) annotation (
    Line(
      points={{89,50},{90,50},{90,22},{31.5,22},{31.5,-8}},
      color={255,0,0},
      thickness=0.5));
  connect(Dp_Re_1.C2, Re_1.Ev) annotation (
    Line(
      points={{31.5,-19},{31.5,-36},{8.4,-36},{8.4,-73}},
      color={255,0,0},
      thickness=0.5));
  connect(ControlValveBallon.C1, Re_1.Se)
    annotation (
    Line(points={{-20,-81},{0,-81}}, thickness=0.5));
  connect(Re_1.Sp, invSingularPressureLoss.C1) annotation (
    Line(
      points={{33.6,-89.25},{33.6,-98},{108,-98}},
      color={0,0,255},
      thickness=0.5));
  connect(invSingularPressureLoss.C2, VolumeCond.Ce1) annotation (
    Line(
      points={{122,-98},{202,-98},{202,29},{141,29}},
      color={0,0,255},
      thickness=0.5));
  connect(Dp_Cond_2.C1, VolumeCond.Cs2) annotation (
    Line(
      points={{135.5,14},{135.5,24}},
      color={255,0,0},
      thickness=0.5));
  connect(Condenseur.Cv, Dp_Cond_2.C2) annotation (
    Line(
      points={{136,-11},{136,3},{135.5,3}},
      color={255,0,0},
      thickness=0.5));
  connect(PerteCharge_Huile_4.C2, massFlowMultiplier.Ce) annotation (Line(
      points={{1,139},{21,139}},
      color={0,140,72},
      thickness=0.5));
  connect(massFlowMultiplier.Cs, TubeEcran_22.C1) annotation (Line(
      points={{37,139},{63,139},{63,100},{24,100}},
      color={0,140,72},
      thickness=0.5));
  connect(Pompe2.C2, massFlowMultiplier2.Ce) annotation (Line(
      points={{-164,139},{-166,139},{-166,139.75}},
      color={0,140,72},
      thickness=0.5));
  connect(massFlowMultiplier2.Cs, PerteCharge_Huile_3.C1) annotation (Line(
      points={{-150.5,139.75},{-140,139.75},{-140,138.5}},
      color={0,140,72},
      thickness=0.5));
  connect(PerteCharge_Huile_1.C1, TubeEcran_44.C2) annotation (Line(
      points={{-292,138.5},{-319,138.5},{-319,-80},{-293,-80},{-293,-35}},
      color={0,127,0},
      thickness=0.5));
  connect(Rayonnement.y, SolarCollector1.ISun) annotation (Line(points={{-305.2,
          174},{-280,174},{-280,190.083},{-106.289,190.083}}, color={0,0,255}));
  annotation (
    Window(
      x=0.43,
      y=0,
      width=0.57,
      height=0.63),
    Diagram(
      coordinateSystem(
        preserveAspectRatio=false,
        extent={{-320,-100},{200,200}},
        grid={2,2},
        initialScale=0.1),
      graphics={
        Text(
          extent={{-237,-8},{-217,-18}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString=
               "Eco"),
        Text(
          extent={{-164,48},{-126,34}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString=
               "Evaporator"),
        Text(
          extent={{-23,49},{21,33}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString=
               "Super-heater"),
        Text(
          extent={{151,-53},{194,-68}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString=
               "Condenser"),
        Text(
          extent={{-115,215},{-37,197}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString=
               "Parabolic solar receiver")}),
    experiment(StopTime=40000),
    Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni</li>
</ul>
</html>", info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019 </h4>
<p><b>ThermoSysPro Version 3.2 </h4>
<p>This is the dynamic model of a 1 MWe concentrated solar power plant with a parabolic trough collector. </p>
<p>It is documented in a<a href=\"https://www.sciencedirect.com/science/article/pii/S1876610214005761\"> conference paper</a> and in Sect. 6.7 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"),
    Icon(graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Polygon(
          origin={8.0,14.0},
          lineColor={78,138,73},
          fillColor={78,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}));
end ConcentratedSolarPowerPlant_PTSC;
