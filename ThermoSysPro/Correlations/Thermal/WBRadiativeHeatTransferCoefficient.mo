within ThermoSysPro.Correlations.Thermal;
function WBRadiativeHeatTransferCoefficient
  "Radiative heat transfer coefficient for the wall heat exchanger"
  input ThermoSysPro.Units.DifferentialTemperature DeltaT
    "Temperature difference between the flue gases and the walls";
  input Modelica.SIunits.Temperature Tp "Surface temperature";
  input Real Pph2o "H20 fraction";
  input Real Ppco2 "CO2 fraction";
  input Real Beaml "Geometrical parameter";
  input Integer option_interpolation=1
    "1: linear interpolation - 2: spline interpolation";

  output Modelica.SIunits.CoefficientOfHeatTransfer Kr
    "Radiative heat transgfer coefficient";

protected
  Modelica.SIunits.AbsolutePressure Pgaz "CO2+H2O partial pressure";
  Real Rap "H20/C02 partial pressure";
  Real Kprim "Interpolation result over TabKr";
  Real Ak "Interpolation result over TabK2";
  Real Pperl "Intermediate variable";

  /****************************************************************************
        Valeurs du coefficient de rayonnement de base tirées de :
                D. Annaratone - GENERATORI DI VAPORE - fig. 9.8.6
                The Babcock & Wilcox Company - STEAM - fig 26.
        Les valeurs correspondantes à une température de paroi de 1366.483
        (2000. F) (tirées de STEAM) sont obtenues en supposant la courbe
        une droite et en actionnant une conversion d'unités de mesure
                                7.75      9
          Kr = 5.67826*[15.5 + ------- * --- DeltaT(°K)]
                                1500.     5

  ******************************************************************************/
  constant Real TabDeltaT[20]={-1100,-1000,-900,-800,-700,-600,-500,-400,-300,-200,
      -100,0,100,200,400,600,800,1000,1400,1500};
  constant Real TabTp[4]={273.15,523.15,773.15,1366.483333};
  constant Real TabKr[4, 20]=[1.E-04, 1.E-04, 1.E-04, 1.E-04, 1.E-04, 1.E-04,
      1.E-04, 1.E-04, 1.E-04, 1.E-04, 1.E-04, 1.163, 1.977, 2.56, 6.63, 12.793,
       22.446, 35.82, 59.89, 65.94; 1.E-04, 1.E-04, 1.E-04, 1.E-04, 1.E-04,
      1.E-04, 1.E-04, 1.E-04, 1.E-04, 1.72, 2.15, 6.98, 10.23, 14.54, 25.586,
      37.216, 49.08, 61.06, 84.9, 90.714; 1.E-04, 1.E-04, 1.E-04, 1.E-04,
      1.E-04, 1.E-04, 1.63, 1.977, 2.56, 8.47, 12.38, 30.59, 36.64, 42.22,
      54.08, 65.128, 76.76, 88.39, 110.48, 116.3; 1.E-04, 1.84, 2.52, 8.23,
      12.1, 16.64, 36.13, 41.96, 47.76, 53.55, 59.33, 88.01, 93.29, 98.57,
      109.14, 119.7, 130.26, 140.82, 161.94, 167.23];

  /******************************************************************************
        Modification to take into account the influence of different fuels
  ********************************************************************************/
  constant Real TabPl[6]={0.,0.06,0.12,0.18,0.24,0.30};
  constant Real TabRap[4]={0.3,0.4,0.76,2.};
  constant Real TabK2[4, 6]=[0.13, 0.372, 0.517, 0.626, 0.725, 0.815; 0.13,
      0.38, 0.545, 0.675, 0.792, 0.882; 0.13, 0.392, 0.592, 0.75, 0.875, 0.985;
       0.13, 0.429, 0.67, 0.862, 1.027, 1.1647];

algorithm
  Pgaz := Ppco2 + Pph2o;
  Rap := Pph2o/Ppco2;

  if Beaml <= 0 then
    Kr := 0;
  else
    if (option_interpolation == 1) then
      Kprim := ThermoSysPro.Functions.TableLinearInterpolation(TabTp, TabDeltaT, TabKr, Tp, DeltaT);
    elseif (option_interpolation == 2) then
      Kprim := ThermoSysPro.Functions.TableSplineInterpolation(TabTp, TabDeltaT, TabKr, Tp, DeltaT);
    else
      assert(false, "WBRadiativeHeatTransferCoefficient: incorrect interpolation option");
    end if;
    Pperl := Pgaz*Beaml;

    if (option_interpolation == 1) then
      Ak := ThermoSysPro.Functions.TableLinearInterpolation(TabRap, TabPl, TabK2, Rap, Pperl);
    elseif (option_interpolation == 2) then
      Ak := ThermoSysPro.Functions.TableSplineInterpolation(TabRap, TabPl, TabK2, Rap, Pperl);
    else
      assert(false, "WBRadiativeHeatTransferCoefficient: incorrect interpolation option");
    end if;
    Kr := Kprim*Ak;
  end if;

  annotation (
      smoothOrder=2,
      Icon(graphics),      Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2013</b> </p>
<p><b>ThermoSysPro Version 3.1</h4>
</html>", revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end WBRadiativeHeatTransferCoefficient;
