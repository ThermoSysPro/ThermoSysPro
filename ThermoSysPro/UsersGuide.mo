within ThermoSysPro;
package UsersGuide "ThermoSysPro Licence and Users Guide"

  class ReleaseNotes "Release notes"

  class Version_2_0 "Version 2.0"

      annotation (Documentation(info="<html>
<h3><font color=\"#008000\">Version 2.0 (January 24, 2011)</font></h3>
<p> This is the first open source release of the library.
</p>
</html>
"), Icon(graphics={
          Ellipse(
            lineColor={75,138,73},
            fillColor={75,138,73},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-100.0,-100.0},{100.0,100.0}}),
          Polygon(origin={-4.167,-15.0},
            fillColor={255,255,255},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{-15.833,20.0},{-15.833,30.0},{14.167,40.0},{24.167,20.0},{4.167,-30.0},{14.167,-30.0},{24.167,-30.0},{24.167,-40.0},{-5.833,-50.0},{-15.833,-30.0},{4.167,20.0},{-5.833,20.0}},
            smooth=Smooth.Bezier),
          Ellipse(origin={7.5,56.5},
            fillColor={255,255,255},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-12.5,-12.5},{12.5,12.5}})}));
  end Version_2_0;

  class Version_3_0 "Version 3.0"

      annotation (Documentation(info="<html>
<p><b><span style=\"font-size: 10pt; color: #008000;\">Version 3.0 (December 20, 2011)</span></b></p>
<p align=\"center\"><b><span style=\"font-size: 16pt;\">ThermoSysPro modifications from version 2.0</span></b> </p>
<p>Analytic jacobian is added to the library.</p>
<p>The examples package is added to the library.</p>
<p>Other modifications:</p>
<ul>
<li>Component MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Introduction of two new parameters z1 and z2 </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Correction of parameters TwoPhaseFlowPipe.z1, and TwoPhaseFlowPipe.z2. Old values z1 = 0 and z2 = 0. New values z1 = z1 and z2 = z2. </p>
<ul>
<li>Package Units </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New unit AbsoluteTemperature </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New unit DifferentialTemperature </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New unit&nbsp; AbsolutePressure </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New unit DifferentialPressure </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New unit SpecificEnthalpy </p>
<ul>
<li>Component&nbsp; ElectroMechanics.Machines.SynchronousMotor </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Parameter permanent_meca changed to steady_stae_mech </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Parameter Coupleur changed to mech_coupling </p>
<ul>
<li>Component&nbsp; ElectroMechanics.Machines.Shaft </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Parameter permanent_meca changed to steady_state_mech </p>
<ul>
<li>Package Properties.WaterSteam.IF97_packages </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New IF97 package with analytic jacobian </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Removal of the old IF97 package </p>
<ul>
<li>Function IF97.SplineUtilities.Modelica_Interpolation.Bspline1D.parametrization </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">arccos changed to acos </p>
<ul>
<li>Component WaterSteam.PressureLosses.CheckValve </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Adding modifier (start=false, fixed=true) for variables touvert and tferme. </p>
<ul>
<li>Component WaterSteam.PressureLosses.IdealCheckValve </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Adding modifier (start=false, fixed=true) for variables touvert and tferme. </p>
<ul>
<li>Component FlueGases.PressureLosses.CheckValve </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Adding modifier (start=false, fixed=true) for variables touvert and tferme. </p>
<ul>
<li>Component WaterSteam.HeatExchangers.DynamicTwoPhaseFlowPipe </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Adding a default value to parameter T0 </p>
<ul>
<li>Package Functions </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New function SmoothStep </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New function SmoothSign </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New function SmoothAbs </p>
<ul>
<li>Component WaterSteam.Machines.DynamicCentrifugalPump </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Use of function SmoothSign for computation of Cf. </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New parameter continuous_flow_reversal </p>
<ul>
<li>Component WaterSteam.Machines.StaticCentrifugalPump </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New parameter continuous_flow_reversal </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Removing input commandePompe </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Input VRotation changed to rpm_or_mpower </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New parameter MPower </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New parameter fixed_rot_or_power </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Efficiency characteristics rh=a*Qv^2/R^2 + b*Qv/R + c changed to rh=a*Qv*abs(Qv)/R^2+b*Qv/R+c to ensure convergence for fixed mechanical power </p>
<ul>
<li>Component<span style=\"color: #ff0000;\"> </span>WaterSteam.PressureLoses.LumpedStraightPipe &lt;====== </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Modification of default value of parameter rugosrel. Old value: 0, new value 0.0001. </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Adding initial equation:&nbsp; der(Q) = 0 </p>
<ul>
<li>Component WaterSteam.Volumes.TwoPhaseVolume </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Property prol is computed at pressure (P + Pfond)/2 instead of P. </p>
<ul>
<li>Component WaterSteam.HeatExchangers.DynamicOnePhaseFlowPipe </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New parameter dpfCorr </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New parameter hcCorr </p>
<ul>
<li>Component WaterSteam.HeatExchanger.DynamicTwoPhaseFlowPipe </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New parameter dpfCorr </p>
<ul>
<li>Component Thermal.HeatTransfer.HeatExchangerWall </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Wall 1 becomes the internal wall </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Wall 2 becomes the external wall </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Heat flux through external wall is corrected </p>
<ul>
<li>Component WaterSteam.HeatExchanger. StaticWaterWaterExchangerDTorWorEff </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Modification of the power equation for case exchanger_type = 3. </p>
<ul>
<li>Component WaterSteam.HeatExchanger.TemperatureWallBoiler </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Modification of some parameter default values </p>
<ul>
<li>Function Correlations.PressureLosses.WBWaterSteamPressureLosses </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">b0 is bounded to 0.01 </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Gm^2 is replaced by Gm*abs(Gm) </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Adding equation dpa := 0. </p>
<ul>
<li>Function Properties.WaterSteam.BaseIF97.Basic.psat </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Calls to LogVariable removed. </p>
<ul>
<li>Component Combustion.BoundaryConditions.FuelSourcePQ </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Handling of input signals corrected. </p>
<ul>
<li>Component MultiFluid.HeatExchangers.NTUTechnologicalExchangerWaterSteamFlueGases </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Correction of computation of variable mono. </p>
<ul>
<li>Component WaterSteam.Machines.StodolaTurbine </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Modification of default value for parameter Qmax. Old Value=15, new value=1. </p>
<ul>
<li>Function Correlation.Thermal.WBInternalHeatTransferCoefficient </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New function. </p>
<ul>
<li>Component WaterSteamHeatExchangers.TemperatureWallBoiler </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Call to WBInternalHeatTransferCoefficient instead of separate calls to WBInternalOnePhaseFlowHeatTransferCoefficient and WBInternalTwoPhaseFlowHeatTransferCoefficient </p>
<ul>
<li>Component WaterSteam.Junctions.Mixer3 </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Bug correction: flow from port Ce3 added in mass balance and energy balance equations. </p>
<ul>
<li>Component WaterSteam.BoundaryConditions.RefQ </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Correction of default value for Q0. Old value=1.e5. New value=10. </p>
<ul>
<li>Component WaterSteam.Junctions.StaticDrum </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Correction of comment for parameter x </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Adding thermal connector Cth and variable T </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Modification of energy balance equation to take into account external energy supply. </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Adding equation Cth.T = T; </p>
<ul>
<li>Package Thermal.BoundaryConditions </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New component HeatSink </p>
<ul>
<li>Package WaterSteam.BoundaryConditions </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New components PlugA, PlugB </p>
<ul>
<li>Component InstrumentationAndControl.Blocks.Tables.Table1D </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Dymola specific function Interpolate is replaced by ThermoSysPro.Functions.LinearInterpolation. </p>
<ul>
<li>Component InstrumentationAndControl.Blocks.Tables.Table1DTemps </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Dymola specific function Interpolate is replaced by ThermoSysPro.Functions.LinearInterpolation. </p>
<ul>
<li>Function Functions.LinearInterpolation </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Output DeltaYX is removed. </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Function calls Functions.LinearInterpolation_i, which returns DelTaXY. </p>
<ul>
<li>Function Functions.TableLinearInterpolation </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Outputs DeltaYX and DeltaYP are removed. </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Function calls Functions.TableLinearInterpolation_i, which returns DelTaXY and DeltaYP. </p>
<ul>
<li>Function Correlations.Misc..WBCorrectiveDiameterCoefficient </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Unused variables Z1, Z2 are removed. </p>
<ul>
<li>Function Correlations.Thermal.WBCrossedCurrentConvectiveHeatTranferCoefficient </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Unused variables Z1, Z2 are removed. </p>
<ul>
<li>Function Correlations.Thermal.WBLongitudinalCurrentConvectiveHeatTranferCoefficient </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Unused variables Z1, Z2 are removed. </p>
<ul>
<li>Function Correlations.Thermal.WBRadiativeHeatTranferCoefficient </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Unused variables Z1, Z2, Z3, Z4 are removed. </p>
<ul>
<li>Component WaterSteam.Machines.SteamEngine </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Function Interpolation is replaced by function LinearInterpolation </p>
<ul>
<li>Component WaterSteam.PressureLosses.ControlValve </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Function Interpolation is replaced by function LinearInterpolation </p>
<ul>
<li>Component WaterSteam.PressureLosses.DynamicCheckValve </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Function Interpolation is replaced by function LinearInterpolation </p>
<ul>
<li>Component WaterSteam.PressureLosses.DynamicReliefValve </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Function Interpolation is replaced by function LinearInterpolation </p>
<ul>
<li>Component FlueGases.PressureLosses.ControlValve </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Function Interpolation is replaced by function LinearInterpolation </p>
<ul>
<li>Package Functions </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Function Interpolation is removed. One should use function LinearInterpolation instead. </p>
<ul>
<li>Package Units </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Unit RotationVelocity renamed to AngularVelocity_rpm </p>
</html>"), Icon(graphics={
          Ellipse(
            lineColor={75,138,73},
            fillColor={75,138,73},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-100.0,-100.0},{100.0,100.0}}),
          Polygon(origin={-4.167,-15.0},
            fillColor={255,255,255},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{-15.833,20.0},{-15.833,30.0},{14.167,40.0},{24.167,20.0},{4.167,-30.0},{14.167,-30.0},{24.167,-30.0},{24.167,-40.0},{-5.833,-50.0},{-15.833,-30.0},{4.167,20.0},{-5.833,20.0}},
            smooth=Smooth.Bezier),
          Ellipse(origin={7.5,56.5},
            fillColor={255,255,255},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-12.5,-12.5},{12.5,12.5}})}));
  end Version_3_0;

  class Version_3_1 "Version 3.1"

      annotation (Documentation(info="<html>
<p><b><span style=\"font-size: 10pt; color: #008000;\">Version 3.1 (June 12, 2014)</span></b> </p>
<p align=\"center\"><b><span style=\"font-size: 16pt;\">ThermoSysPro modifications from version 3.0</span></b> </p>
<p>&nbsp; </p>
<ul>
<li>Component ElectroMechanics.BoundaryConditions.SourceMechanicalPower </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Equation M.Ctr*abs(M.w) = IPower.signal is replaced by M.Ctr*M.w = IPower.signal </p>
<ul>
<li>Package ElectroMechanics.BoundaryConditions </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New component SourceAngularVelocity </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New component SourceTorque </p>
<ul>
<li>Package Function </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New function SmoothMax </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New function SmoothMin </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New function SmoothCond </p>
<ul>
<li>Package WaterSteam.Machines </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New component CentrifugalPump, replaces old components DynamicCentrifugalPump and StaticCentrifugalPump. </p>
<ul>
<li>Component WaterSteam.Machines.DynamicCentrifugalPump </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Obsolete component, replaced by component CentrifugalPump </p>
<ul>
<li>Component WaterSteam.Machines.StaticCentrifugalPump </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Obsolete component, replaced by component CentrifugalPump </p>
<ul>
<li>Component WaterSteam.HeatExchangers.DynamicOnePhaseFlowPipe </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Parameter dynamic_energy_balance is removed </p>
<ul>
<li>Component WaterSteam.HeatExchangers.DynamicTwoPhaseFlowPipe </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Parameter dynamic_energy_balance is removed </p>
<ul>
<li>Function Properties.CH3F5.CH3F5_Ps </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Correction of the computation of x for one-phase flow (liquid or vapor) </p>
<ul>
<li>Component WaterSteam.HeatExchangers.SimpleDynamicCondenser </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Correction of the computation of Wout </p>
<ul>
<li>Component WaterSteam.Volumes.TwoPhaseVolume </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Correction: Cl.a = true (instead of Cl.b = true) </p>
<ul>
<li>Component FlueGases.HeatExchangers. StaticWallFlueGasesExchanger </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Correction of the computation of dW[i] </p>
<ul>
<li>Component WaterSteam.Junctions.SteamDryer </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Correction of the mass balance equations </p>
<ul>
<li>Component Combustion.CombustionChambers.GenericCombustionChamber </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Correction of the computation of HFuel </p>
<ul>
<li>Component Combustion.CombustionChambers.GTCombustionChamber </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Correction of the computation of HFuel </p>
<ul>
<li>Component WaterSteam.Volumes.Tank </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Parameter k is replaced by parameters ke1, ke2, ks1, ks2. </p>
<ul>
<li>Function Functions. LinearInterpolation_i </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Correction of the computation of Y </p>
<ul>
<li>Package Units </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Unit SpecificEnthalpy removed </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Unit AbsolutePressure removed </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Unit AbsoluteTemperature removed </p>
<ul>
<li>Package WaterSteam.HeatExchangers </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New component DynamicWaterHeating </p>
<ul>
<li>Package WaterSteam.Volumes </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New component TwoPhaseCavity </p>
<ul>
<li>Component FlueGases.Volumes.VolumeATh </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Modifier stateSelect removed </p>
<ul>
<li>Component FlueGases.Volumes.VolumeBTh </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Modifier stateSelect removed </p>
<ul>
<li>Component FlueGases.Volumes.VolumeCTh </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Modifier stateSelect removed </p>
<ul>
<li>Component FlueGases.Volumes.VolumeDTh </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Modifier stateSelect removed </p>
<ul>
<li>Component WaterSteam.Machines.Compressor </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">xm is bounded by min value 0.01 (to avoid division by zero in case fluid is water, which should not happen in a compressor). </p>
<ul>
<li>Component FlueGases.PressureLosses.SingularPressureLoss </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Default value for parameter K changed to 1.e-3. </p>
<ul>
<li>Component WaterSteam.Machines.StodolaTurbine </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Extension of the computation of xm and Q for supercritical regimes. </p>
<ul>
<li>Component WaterSteam.Boilers.ElectricBoiler </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Correction of the computation of deltaH. </p>
<ul>
<li>Component WaterSteam.Machines.StaticCentrifugalPump </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Value of rh is changed. Old value: 0.05 - New value: 0.20 </p>
<ul>
<li>Component WaterSolution.Machines.StaticCentrifugalPump </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Value of rh is changed. Old value: 0.05 - New value: 0.20 </p>
<ul>
<li>Component FlueGases.Machines.StaticFan </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Value of rh is changed. Old value: 0.05 - New value: 0.20 </p>
<ul>
<li>Package Functions </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New functions SplineInterpolation and TableSplineInterpolation </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New package Utilities </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Function LinearInterpolation_i&nbsp; moved to Functions.Utilities </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Function TableLinearInterpolation_i&nbsp; moved to Functions.Utilities </p>
<ul>
<li>Package Functions.Utilities </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New function CubicHermite </p>
<ul>
<li>Block InstrumentationAndControl.Blocks.Table.Table1D </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New interpolating option: spline interpolation </p>
<ul>
<li>Block InstrumentationAndControl.Blocks.Table.Table1DTemps </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New interpolating option: spline interpolation </p>
<ul>
<li>Block InstrumentationAndControl.Blocks.Table.Table2D </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New interpolating option: spline interpolation </p>
<ul>
<li>Component WaterSteam.Machines.CentrifugalPump </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Linear interpolation of F and G is replaced by spline interpolation </p>
<ul>
<li>Component FlueGases.PressureLosses.ControlValve </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New interpolating option: spline interpolation </p>
<ul>
<li>Component WaterSteam.PressureLosses.ControlValve </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New interpolating option: spline interpolation </p>
<ul>
<li>Component WaterSteam.PressureLosses.DynamicCheckValve </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New interpolating option: spline interpolation </p>
<ul>
<li>Component WaterSteam.PressureLosses.DynamicReliefValve </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New interpolating option: spline interpolation </p>
<ul>
<li>Component WaterSteam.Machines.SteamEngine </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New interpolating option: spline interpolation </p>
<ul>
<li>Function Correlation.Misc.WBCorrectiveDiameterCoefficient </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New interpolating option: spline interpolation </p>
<ul>
<li>Function Correlation.Thermal. WBCrossedCurrentConvectiveHeatTransferCoefficient </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New interpolating option: spline interpolation </p>
<ul>
<li>Function Correlation.Thermal. WBLongitudinalCurrentConvectiveHeatTransferCoefficient </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New interpolating option: spline interpolation </p>
<ul>
<li>Function Correlation.Thermal. WBRadiativeHeatTransferCoefficient </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New interpolating option: spline interpolation </p>
<ul>
<li>Component WaterSteam.HeatExchangers.TwoPhaseFlowPipe </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Adding noEvent for the computation of hi and Xtt </p>
<ul>
<li>Component WaterSteam.HeatExchangers.DynamicOnePhaseFlowPipe </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Extension of the computation of hc for laminar flows </p>
<ul>
<li>Component WaterSteam.HeatExchangers.DynamicWaterWaterExchanger </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Modification of the computation of DPc and DPf. Previous&nbsp; version: DPc[i] = p_Kc*Qc[i]^2/(2*rhoc[i]); DPf[i] = p_Kf*Qf[i]^2/(2*rhof[i]); New version: DPc[i] = p_Kc*Qc[i]^2/rhoc[i]; DPf[i] = p_Kf*Qf[i]^2/rhof[i]; </p>
<ul>
<li>Component WaterSteam.HeatExchangers.StaticWaterWaterExchanger </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Modification of the computation of DPc and DPf. Previous&nbsp; version: DPc[i] = p_Kc*Qc[i]^2/(2*rhoc[i]); DPf[i] = p_Kf*Qf[i]^2/(2*rhof[i]); New version: DPc[i] = p_Kc*Qc[i]^2/rhoc[i]; DPf[i] = p_Kf*Qf[i]^2/rhof[i]; </p>
<ul>
<li>Component WaterSteam.HeatExchangers.NTUWaterHeating </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Modification of the value of eps. Previous value:&nbsp; 1. New value: 1.e-3. </p>
<ul>
<li>Component WaterSteam.HeatExchangers.DynamicTwoPhaseFlowPipe </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Adaptation to the supercritical phase </p>
<ul>
<li>Package WaterSteam.HeatExchangers </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New component DynamicWaterHeatingOnePipe </p>
<ul>
<li>Package Thermal.HeatTransfer </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New component HeatExchangerWallCounterFlow </p>
<ul>
<li>Package Properties </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New package MoltenSalt </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New package Oil_TherminolVP1 </p>
<ul>
<li>Component WaterSteam.Machines.StodolaTurbine </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Equation xm = if noEvent(Ps &gt; pcrit) then 1 else (1 + pros1.x)/2; is replaced by xm = 1; </p>
<ul>
<li>Component WaterSteam.Volumes.Tank </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New parameter dynamic_mass_balance </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New equation A*(pro.ddph*der(P) + pro.ddhp*der(h))*z + A*rho*der(z) = BQ; when dynamic_mass_balance = true </p>
</html>"), Icon(graphics={
          Ellipse(
            lineColor={75,138,73},
            fillColor={75,138,73},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-100.0,-100.0},{100.0,100.0}}),
          Polygon(origin={-4.167,-15.0},
            fillColor={255,255,255},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{-15.833,20.0},{-15.833,30.0},{14.167,40.0},{24.167,20.0},{4.167,-30.0},{14.167,-30.0},{24.167,-30.0},{24.167,-40.0},{-5.833,-50.0},{-15.833,-30.0},{4.167,20.0},{-5.833,20.0}},
            smooth=Smooth.Bezier),
          Ellipse(origin={7.5,56.5},
            fillColor={255,255,255},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-12.5,-12.5},{12.5,12.5}})}));
  end Version_3_1;

  class Version_3_2 "Version 3.2"

      annotation (Documentation(info="<html>
<p><b><span style=\"font-size: 10pt; color: #008000;\">Version 3.2 (May 15, 2019)</span></b> </p>
<p align=\"center\"><b><span style=\"font-size: 16pt;\">ThermoSysPro modifications from version 3.1</span></b></p>
<p>&nbsp; </p>
<ul>
<li>Package Correlations </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New Function Misc.Function_FM </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New Function Thermal.Function_U1 </p>
<ul>
<li>Component FlueGases.HeatExchangers.StaticFluegasesFluegasesExchangerKS </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Introduction of connector&nbsp; InputReal Kcorr and variable Kcorr </p>
<ul>
<li>Components FlueGases.Volumes.VolumesATh; VolumesBTh; VolumesCTh and VolumesDTh </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New&nbsp; parameters&nbsp;hr, Xco20, Xh2o0, Xo20, Xso20 </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Initial section is modified to replace state variable T with state variable h. </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Equation V*(ThermoSysPro.Properties.FlueGases.FlueGases_drhodp(P,&nbsp;T,&nbsp;Xco2,&nbsp;Xh2o,&nbsp;Xo2,&nbsp;Xso2)*der(P) +&nbsp;ThermoSysPro.Properties.FlueGases.FlueGases_drhodh(P,&nbsp;T,&nbsp;Xco2,&nbsp;Xh2o,&nbsp;Xo2,&nbsp;Xso2)*cp*der(T))&nbsp;=&nbsp;BQ; is replaced by&nbsp;V*(ThermoSysPro.Properties.FlueGases.FlueGases_drhodp(P,&nbsp;T,&nbsp;Xco2,&nbsp;Xh2o,&nbsp;Xo2,&nbsp;Xso2)*der(P) +&nbsp;ThermoSysPro.Properties.FlueGases.FlueGases_drhodh(P,&nbsp;T,&nbsp;Xco2,&nbsp;Xh2o,&nbsp;Xo2,&nbsp;Xso2)*der(h&nbsp;-&nbsp;Xh2o*hr))&nbsp;=&nbsp;BQ; </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Equation V*((h*ThermoSysPro.Properties.FlueGases.FlueGases_drhodp(P, T, Xco2, Xh2o, Xo2, Xso2) - 1)*der(P) + (h*ThermoSysPro.Properties.FlueGases.FlueGases_drhodh(P, T, Xco2, Xh2o, Xo2, Xso2) + rho)*cp*der(T)) = BH; is replaced by&nbsp; V*(((h - Xh2o*hr)*ThermoSysPro.Properties.FlueGases.FlueGases_drhodp(P, T, Xco2, Xh2o, Xo2, Xso2) - 1)*der(P) + ((h - Xh2o*hr)*ThermoSysPro.Properties.FlueGases.FlueGases_drhodh(P, T, Xco2, Xh2o, Xo2, Xso2) + rho)*der(h - Xh2o*hr)) = BH; </p>
<ul>
<li>Component FlueGases.Volumes.VolumesATh&nbsp; and VolumesBTh </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Equation&nbsp;BH&nbsp;=&nbsp;Ce1.Q*he1 + Ce2.Q*he2 - Cs1.Q*hs1 - Cs2.Q*hs2 + Cth.W; &nbsp;is replaced by&nbsp; BH&nbsp;=&nbsp;Ce1.Q*(he1&nbsp;-&nbsp;Ce1.Xh2o*hr)&nbsp;+&nbsp;Ce2.Q*(he2&nbsp;-&nbsp;Ce2.Xh2o*hr)&nbsp;-&nbsp;Cs1.Q*(hs1&nbsp;-&nbsp;Cs1.Xh2o*hr)&nbsp;-&nbsp;Cs2.Q*(hs2&nbsp;-&nbsp;Cs2.Xh2o*hr)&nbsp;+&nbsp;Cth.W; </p>
<ul>
<li>Component FlueGases.Volumes.VolumesCTh </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Equation BH = Ce1.Q*he1 + Ce2.Q*he2 + Ce3.Q*he3 - Cs.Q*hs + Cth.W; is replaced by&nbsp; BH = Ce1.Q*(he1 - Ce1.Xh2o*hr) + Ce2.Q*(he2 - Ce2.Xh2o*hr) + Ce3.Q*(he3 - Ce3.Xh2o*hr) - Cs.Q*(hs - Cs.Xh2o*hr) + Cth.W; </p>
<ul>
<li>Component FlueGases.Volumes.VolumesDTh </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Equation BH = Ce1.Q*he1 &ndash; Cs1.Q*hs1 &ndash; Cs2.Q*hs2 &ndash; Cs3.Q*hs3 + Cth.W; is replaced by&nbsp; &nbsp;BH&nbsp;=&nbsp;Ce.Q*(he&nbsp;-&nbsp;Ce.Xh2o*hr)&nbsp;-&nbsp;Cs1.Q*(hs1&nbsp;-&nbsp;Cs1.Xh2o*hr)&nbsp;-&nbsp;Cs2.Q*(hs2&nbsp;-&nbsp;Cs2.Xh2o*hr)&nbsp;-&nbsp;Cs3.Q*(hs3&nbsp;-&nbsp;Cs3.Xh2o*hr)&nbsp;+&nbsp;Cth.W; </p>
<ul>
<li>Component FlueGases.Junctions.Mixer2 </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Equation 0&nbsp;=&nbsp;Ce1.Q*he1&nbsp;+&nbsp;Ce2.Q*he2&nbsp;-&nbsp;Cs.Q*hs; is replaced by&nbsp;&nbsp; 0&nbsp;=&nbsp;Ce1.Q*(he1&nbsp;-&nbsp;Ce1.Xh2o*hr)&nbsp;+&nbsp;Ce2.Q*(he2&nbsp;-&nbsp;Ce2.Xh2o*hr)&nbsp;-&nbsp;Cs.Q*(hs&nbsp;-&nbsp;Cs.Xh2o*hr); </p>
<ul>
<li>Component FlueGases.Junctions.Splitter2 </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">&nbsp;Equation 0&nbsp;=&nbsp;Ce.Q*he - Cs1.Q*hs1 - Cs2.Q*hs2 is replaced by&nbsp;&nbsp; 0&nbsp;=&nbsp;Ce.Q*(he - Ce.Xh2o*hr) - Cs1.Q*(hs1 - Cs1.Xh2o*hr) - Cs2.Q*(hs2 - Cs2.Xh2o*hr); </p>
<ul>
<li>Package FlueGases.BoundaryConditions </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New component SourceQX </p>
<ul>
<li>Package Combustion.CombustionChambers </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New component GenericCombustion1D </p>
<ul>
<li>Component CombustionChamber.GenericCombustion </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Equations &nbsp;Hfuel = Cpfuel*Tfuel;&nbsp;&nbsp;&nbsp; Hcv = Cpcd*Tsf;&nbsp; Hbf = Cpcd*Tbf; &nbsp;are replaced by Hfuel = Cpfuel*(Tfuel - 273.16);&nbsp; Hcv = Cpcd*(Tsf-273.16);&nbsp; Hbf = Cpcd*(Tbf-273.16); </p>
<ul>
<li>Component Combustion.CombustionChambers.GTCombustionChamber </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Equation Wcpat&nbsp;=&nbsp;Qea*XQat*(Hiscpat&nbsp;-&nbsp;Hecpat)/eta_isc; is replaced by Wcpat&nbsp;=&nbsp;Qea*XQat*(Hiscpat&nbsp;-&nbsp;Hecpat)*eta_isc; </p>
<ul>
<li>Package Properties </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New Package Properties.DryAirIdealGas </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New Package Properties.SolarSalt </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Package Properties.Fluid has been completed </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Package Properties.C3H3F5 has been completed </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Package Properties.MoltenSalt has been completed </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Package Properties.Oil_TherminolVP1 has been completed </p>
<ul>
<li>Package ThermoSysPro </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New package Solar </p>
<ul>
<li>Package Thermal.HeatTransfer </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New component HeatExchangerWallWithLosses </p>
<ul>
<li>Package WaterSteam.HeatExchangers </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New component CoolingTower </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New component DynamicOnePhaseFlowShell </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New component DynamicTwoPhaseFlowRiser </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New component DynamicTwoFlowHeatExchangerShell </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New component SteamGenerator_1SG </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New component SteamGenerator_4SG </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New component StaticCondenserHEI </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Component TemperatureWallBoiler is removed </p>
<ul>
<li>Package WaterSteam.Volumes </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New component TwoPhaseCavityOnePipe </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New component TwoPhaseCavityOnePipe.mo </p>
<ul>
<li>Component WaterSteam.Machines.StodolaTurbine </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New parameter eta_is_wet( start=0.83) &quot;Isentropic efficiency for wet steam&quot;; eta_is_wet = xm*eta_is; </p>
<ul>
<li>Component WaterSteam.PressureLosses.LumpedStraightPipe </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New parameter ntubes </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Equation mu&nbsp;=&nbsp;ThermoSysPro.Properties.WaterSteam.IF97.DynamicViscosity_rhoT(rho,&nbsp;T); is replaced by mu&nbsp;=&nbsp;ThermoSysPro.Properties.Fluid.DynamicViscosity_Ph(Pm,h,fluid,mode, 0.1,0.1,0.1,0); for fluid = 2 </p>
<ul>
<li>Component WaterSteam.PressureLosses.InvSingularPressureLoss </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">&nbsp;Equation deltaP&nbsp;=&nbsp;if&nbsp;noEvent(abs(Q)&nbsp;&lt;&nbsp;Qeps)&nbsp;then&nbsp;1.e10&nbsp;else&nbsp;K*ThermoSysPro.Functions.ThermoSquare(Q,&nbsp;eps)/rho; is replaced by deltaP&nbsp;=&nbsp;if&nbsp;noEvent(abs(Q)&nbsp;&lt;&nbsp;Qeps)&nbsp;then&nbsp;1.e-10&nbsp;else&nbsp;K*ThermoSysPro.Functions.ThermoSquare(Q,&nbsp;eps)/rho; </p>
<ul>
<li>Component WaterSteam.HeatExchangers.DynamicOnePhaseFlowPipe </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">&nbsp;Equation hc[i] = hcCorr*3.66*k[i]/D; &nbsp;is replaced by hc[i] = hcCorr*k[i]/D*max(4.36,0.023*Re1[i]^0.8*Pr[i]^0.4); </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Equation dpa[i] = noEvent(Q[i]* abs Q[i]*(1/rhoc[i + 1] - 1/rhoc[i])/A^2); is replaced by dpa[i] = Q[i]^2*(1/rhoc[i + 1] - 1/rhoc[i])/A^2; </p>
<ul>
<li>Component WaterSteam. HeatExchangers.DynamicTwoPhaseFlowPipe </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Equation xv1[i] = pro1[i].x); is replaced by xv1[i] = if noEvent((P[i+1] &gt; pcrit) or (T1[i] &gt; Tcrit)) then 1 else pro1[i].x; </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Equation&nbsp;xv2[i] = pro2[i].x); is replaced by xv2[i]&nbsp;=&nbsp;if&nbsp;noEvent(((P[i]&nbsp;+&nbsp;P[i&nbsp;+&nbsp;1])/2&nbsp;&gt;&nbsp;pcrit)&nbsp;or&nbsp;(T2[i]&nbsp;&gt;&nbsp;Tcrit))&nbsp;then&nbsp;1&nbsp;else&nbsp;pro2[i].x; </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Equation dpa[i] = noEvent(Q[i]* abs Q[i]*(1/rhoc[i + 1] - 1/rhoc[i])/A^2); is replaced by dpa[i] = Q[i]^2*(1/rhoc[i + 1] - 1/rhoc[i])/A^2; </p>
<ul>
<li>Component WaterSteam.Junctions.SteamExtractionSplitter </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">parameter&nbsp;Real&nbsp;alpha&nbsp;=&nbsp;1&nbsp;&quot;Steam&nbsp;extraction&nbsp;rate&nbsp;(0&nbsp;&lt;=&nbsp;alpha&nbsp;&lt;=&nbsp;1)&quot;; is replaced by&nbsp; parameter&nbsp;Real&nbsp;alpha&nbsp;=&nbsp;1&nbsp;&quot;Vapor mass fraction at the extraction/Vapor mass fraction at the inlet (0 &lt;= alpha &lt;= 1)&quot;; </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">&nbsp;Equation x_ex = 1 - alpha*(1 - proe.x); is replaced by x_ex = alpha*proe.x; </p>
<ul>
<li>Component WaterSteam.HeatExchangers.DynamicCondenser </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Component is replaced by new component DynamicCondenser (from SEPTEN) </p>
<ul>
<li>Component&nbsp; WaterSteam.HeatExchangers.DynamicWaterWaterExchanger </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Equation DPc[i]&nbsp;=&nbsp;p_Kc*Qc[i]^2/rhoc[i]; is replaced by DPc[i]&nbsp;=&nbsp;p_Kc*ThermoSysPro.Functions.ThermoSquare(Qc[i],&nbsp;1.e-3)/rhoc[i]; </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Equation DPf[i]&nbsp;=&nbsp;p_Kf*Qf[i]^2/rhof[i]; is replaced &nbsp;by DPf[i]&nbsp;=&nbsp;p_Kf*ThermoSysPro.Functions.ThermoSquare(Qf[i],&nbsp;1.e-3)/rhof[i]; </p>
<ul>
<li>Component&nbsp; WaterSteam.HeatExchangers.StaticWaterWaterExchanger </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Equation DPc&nbsp;=&nbsp;p_Kc*Qc^2/rhoc; is replaced by DPc&nbsp;=&nbsp;p_Kc*ThermoSysPro.Functions.ThermoSquare(Qc,&nbsp;1.e-3)/rhoc; </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Equation DPf&nbsp;=&nbsp;p_Kf*Qf^2/rhof; is replaced by DPf&nbsp;=&nbsp;p_Kf*ThermoSysPro.Functions.ThermoSquare(Qf,&nbsp;1.e-3)/rhof; </p>
<ul>
<li>Component&nbsp; WaterSteam.Machines.CentrifugalPump </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">mode=0&nbsp; is replaced by&nbsp; mode=1&nbsp;</p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp;</span></span><span style=\"font-family: Courier New;\">Equation Wm = WR is replaced by Cm = Cr &nbsp;</p>
<ul>
<li>Component&nbsp; WaterSteam.Machines.DynamicCentrifugalPump </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">mode=0&nbsp; is replaced by&nbsp; mode=1&nbsp; </p>
<ul>
<li>Component&nbsp; WaterSteam.Machines.StaticCentrifugalPump </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">mode=0&nbsp; is replaced by&nbsp; mode=1&nbsp; </p>
<ul>
<li>Component&nbsp; WaterSteam.Volumes.Pressurizer </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">parameter Real Cevap=0.5 &quot;Evaporation coefficient&quot;; &nbsp;is replaced by&nbsp; parameter Real Cevap=0.1 &quot;Evaporation coefficient&quot;; </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Equation&nbsp;&nbsp;Qcond&nbsp;=&nbsp;noEvent(Ccond*rhov*Vv*(hvs&nbsp;-&nbsp;hv)/(hvs&nbsp;-&nbsp;hls)&nbsp;+&nbsp;(Cas.Q*(hls&nbsp;-&nbsp;Cas.h) +&nbsp;0.5*(Wpv&nbsp;+&nbsp;abs(Wpv))&nbsp;+&nbsp;Wlv)/(hv&nbsp;-&nbsp;hls));&nbsp; is replaced by&nbsp; Qcond = Ccond*rhov*Vv*(hvs - hv)/(hvs - hls); </p>
<ul>
<li>Component&nbsp; WaterSteam.Junctions.SteamDryer_Book </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Deleted variable Real&nbsp;eta1(start=1.0)&nbsp;&quot;Vapor&nbsp;mass&nbsp;fraction&nbsp;at&nbsp;outlet&nbsp;(0&nbsp;&lt;&nbsp;eta&nbsp;&lt;=&nbsp;1)&quot;; </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">&nbsp;Deleted equation eta1 = noEvent(max(xe, eta)); </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Equation&nbsp;Csl.h_vol&nbsp;=&nbsp;noEvent(if&nbsp;&nbsp;(Csv.Q&nbsp;&gt;&nbsp;0)&nbsp;then&nbsp;(if&nbsp;(xe&nbsp;&gt;&nbsp;0)&nbsp;then&nbsp;lsat1.h&nbsp;else&nbsp;Cev.h)&nbsp;else&nbsp;&nbsp;h); is replaced by Csl.h_vol&nbsp;=&nbsp;noEvent(if&nbsp;(xe&nbsp;&gt;&nbsp;0)&nbsp;then&nbsp;lsat1.h&nbsp;else&nbsp;Cev.h); </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Equation&nbsp;Csv.Q&nbsp;=&nbsp;Cev.Q*xe/eta1; is replaced by Csv.Q&nbsp;=&nbsp;noEvent(if&nbsp;(xe&nbsp;&gt;&nbsp;0)&nbsp;then&nbsp;Cev.Q*(1-eta*(1-xe))&nbsp;else&nbsp;0); </p>
<ul>
<li>Component&nbsp; MultiFluids.Machines.AlternatingEngine </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Parameter Pnom is removed </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Constant&nbsp;Real&nbsp;Gamma=1.3333&nbsp;&quot;Flue&nbsp;gases&nbsp;gamma&nbsp;=&nbsp;Cp/Cv&quot;; is replaced by parameter Real Gamma=1.3333 &quot;Flue gases gamma = Cp/Cv&quot;; </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Equation&nbsp;Tfcb&nbsp;=&nbsp;(Wcomb&nbsp;-&nbsp;Wpth_ref)/ThermoSysPro.Properties.FlueGases.FlueGases_cp(Pfcp,&nbsp;(Tfcp&nbsp;+&nbsp;Tfcb)/2,&nbsp;XsfCO2,&nbsp;XsfH2O,&nbsp;XsfO2,&nbsp;XsfSO2)/0.75/Qsf&nbsp;+&nbsp;Tfcp; &nbsp;is replaced by&nbsp; Tfcb = Wcomb/ThermoSysPro.Properties.FlueGases.FlueGases_cp(Pfcp, (Tfcp + Tfcb)/2, XsfCO2, XsfH2O, XsfO2, XsfSO2)/Qsf + Tfcp; </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Equation &nbsp;&nbsp;if&nbsp;(Wmeca&nbsp;&gt;&nbsp;(Pnom&nbsp;*&nbsp;0.5))&nbsp;then Welec&nbsp;=&nbsp;(Wmeca*Relec)*(0.0479*Cosphi&nbsp;+&nbsp;0.952); &nbsp;&nbsp;else Welec&nbsp;=&nbsp;(Wmeca*Relec_red)*(0.0479*Cosphi&nbsp;+&nbsp;0.952); &nbsp;&nbsp;end&nbsp;if; &nbsp;is replaced by Welec&nbsp;=&nbsp;Wmeca*Relec; </p>
<ul>
<li>Component&nbsp; MultiFluids.Boilers.FossilFuelBoiler </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New parameter&nbsp; Boiler_efficiency_type&nbsp;=&nbsp;1 &quot;1:&nbsp;Taking into account LHV&nbsp;only&nbsp;-&nbsp;2:&nbsp;Using&nbsp;the&nbsp;total&nbsp;incoming&nbsp;power&quot;; </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Equation eta_boil&nbsp;=&nbsp;100*Wboil/Wfuel; is replaced by if&nbsp;(Boiler_efficiency_type&nbsp;==&nbsp;1)&nbsp;then eta_boil&nbsp;=&nbsp;100*Wboil/Wfuel; else eta_boil&nbsp;=&nbsp;100*Wboil/Wtot; end&nbsp;if; </p>
<ul>
<li>Package InstrumentationAndControl </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New block AdaptorForFMU.AdaptorModelicaTSP </p>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">New block AdaptorForFMU.AdaptorTSPModelica </p>
<ul>
<li>All components MultiFluids.Machines.CHPEngine* </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Parameter Pnom is removed </p>
<ul>
<li>Component FlueGases.HeatExchangers.StaticWallFlueGasesExchanger </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Parameter Surf_ext becomes public </p>
<ul>
<li>Component WaterSteam.HeatExchangers.DynamicOnePhaseFlow </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Component is renamed as DynamicOnePhaseFlowShell </p>
<ul>
<li>Component WaterSteam.Volumes.Tank </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">The momentum balance equations are replaced by singular pressure losses that represent the pressure losses at the orifices. </p>
<ul>
<li>Component WaterSteam.PressureLosses.DynamicCheckValve </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">The spring torque Cr is removed. </p>
<ul>
<li>Component WaterSteam.PressureLosses.DynamicReliefValve </li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Courier New;\">o<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span></span><span style=\"font-family: Courier New;\">Component is completely modified (previous version was incorrect). </p>
</html>"), Icon(graphics={
          Ellipse(
            lineColor={75,138,73},
            fillColor={75,138,73},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-100.0,-100.0},{100.0,100.0}}),
          Polygon(origin={-4.167,-15.0},
            fillColor={255,255,255},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{-15.833,20.0},{-15.833,30.0},{14.167,40.0},{24.167,20.0},{4.167,-30.0},{14.167,-30.0},{24.167,-30.0},{24.167,-40.0},{-5.833,-50.0},{-15.833,-30.0},{4.167,20.0},{-5.833,20.0}},
            smooth=Smooth.Bezier),
          Ellipse(origin={7.5,56.5},
            fillColor={255,255,255},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-12.5,-12.5},{12.5,12.5}})}));
  end Version_3_2;
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>Release notes</font></h3>
<p>
This section summarizes the changes that have been performed
on the ThermoSysPro library.
</html>
"), Icon(graphics={
          Ellipse(
            lineColor={75,138,73},
            fillColor={75,138,73},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-100.0,-100.0},{100.0,100.0}}),
          Polygon(origin={-4.167,-15.0},
            fillColor={255,255,255},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{-15.833,20.0},{-15.833,30.0},{14.167,40.0},{24.167,20.0},{4.167,-30.0},{14.167,-30.0},{24.167,-30.0},{24.167,-40.0},{-5.833,-50.0},{-15.833,-30.0},{4.167,20.0},{-5.833,20.0}},
            smooth=Smooth.Bezier),
          Ellipse(origin={7.5,56.5},
            fillColor={255,255,255},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-12.5,-12.5},{12.5,12.5}})}));
  end ReleaseNotes;

  class Contact "Contact"

    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>Contact
</font></h3>
<dl><dt>The development of the ThermoSysPro library is organized by<br/></dt>
<dd>Daniel Bouskela and Baligh El Hefni<br/></dd>
<dd>EDF/R&AMP;D</dd>
<dd>6, quai Watier</dd>
<dd>F-78401 Chatou Cedex</dd>
<dd>France<br/></dd>
<dd>email: <a href=\"mailto:daniel.bouskela@edf.fr\">daniel.bouskela@edf.fr</a></dd>
<dd>email: <a href=\"mailto:baligh.el-hefni@edf.fr\">baligh.el-hefni@edf.fr</a><br/></dd>
</dl></html>"), Icon(graphics={
          Ellipse(
            lineColor={75,138,73},
            fillColor={75,138,73},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-100.0,-100.0},{100.0,100.0}}),
          Polygon(origin={-4.167,-15.0},
            fillColor={255,255,255},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{-15.833,20.0},{-15.833,30.0},{14.167,40.0},{24.167,20.0},{4.167,-30.0},{14.167,-30.0},{24.167,-30.0},{24.167,-40.0},{-5.833,-50.0},{-15.833,-30.0},{4.167,20.0},{-5.833,20.0}},
            smooth=Smooth.Bezier),
          Ellipse(origin={7.5,56.5},
            fillColor={255,255,255},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-12.5,-12.5},{12.5,12.5}})}));

  end Contact;

  class ThermoSysProLicense "License"

    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>The ThermoSysPro License
</font></h3>
<p>The use of the ThermoSysPro Library is granted by EDF under the provisions of Modelica License 2.</p>
<p>Packages <b>Neutronics</b> and <b>InstrumentationAndControl.BFE</b> are not released under open source license.</p>
<hr>
<h4><a name=\"ModelicaLicense2\"></a>The Modelica License 2</h4>
<p>
<b>Preamble.</b> The goal of this license is that Modelica related
model libraries, software, images, documents, data files etc. can be
used freely in the original or a modified form, in open source and in
commercial environments (as long as the license conditions below are
fulfilled, in particular sections 2c) and 2d). The Original Work is
provided free of charge and the use is completely at your own risk.
Developers of free Modelica packages are encouraged to utilize this
license for their work.</p>

<p>
The Modelica License applies to any Original Work that contains the
following licensing notice adjacent to the copyright notice(s) for
this Original Work:</p>
<p><b>Licensed
by the Modelica Association under the Modelica License 2</b></p>

<p><b>1. Definitions.</b></p>
<ol>
 <li>&ldquo;License&rdquo; is this Modelica License.</li>

 <li>
 &ldquo;Original Work&rdquo; is any work of authorship, including
 software, images, documents, data files, that contains the above
 licensing notice or that is packed together with a licensing notice
 referencing it.</li>

 <li>
 &ldquo;Licensor&rdquo; is the provider of the Original Work who has
 placed this licensing notice adjacent to the copyright notice(s) for
 the Original Work. The Original Work is either directly provided by
 the owner of the Original Work, or by a licensee of the owner.</li>

 <li>
 &ldquo;Derivative Work&rdquo; is any modification of the Original
 Work which represents, as a whole, an original work of authorship.
 For the matter of clarity and as examples: </li>

 <ol>
  <li>
  Derivative Work shall not include work that remains separable from
  the Original Work, as well as merely extracting a part of the
  Original Work without modifying it.</li>

  <li>
  Derivative Work shall not include (a) fixing of errors and/or (b)
  adding vendor specific Modelica annotations and/or (c) using a
  subset of the classes of a Modelica package, and/or (d) using a
  different representation, e.g., a binary representation.</li>

  <li>
  Derivative Work shall include classes that are copied from the
  Original Work where declarations, equations or the documentation
  are modified.</li>

  <li>
  Derivative Work shall include executables to simulate the models
  that are generated by a Modelica translator based on the Original
  Work (of a Modelica package).</li>
 </ol>

 <li>
 &ldquo;Modified Work&rdquo; is any modification of the Original Work
 with the following exceptions: (a) fixing of errors and/or (b)
 adding vendor specific Modelica annotations and/or (c) using a
 subset of the classes of a Modelica package, and/or (d) using a
 different representation, e.g., a binary representation.</li>

 <li>
 &quot;Source Code&quot; means the preferred form of the Original
 Work for making modifications to it and all available documentation
 describing how to modify the Original Work.</li>

 <li>
 &ldquo;You&rdquo; means an individual or a legal entity exercising
 rights under, and complying with all of the terms of, this License.</li>

 <li>
 &ldquo;Modelica package&rdquo; means any Modelica library that is
 defined with the<br>&ldquo;<FONT FACE=\"Courier New, monospace\"><FONT SIZE=2 STYLE=\"font-size: 9pt\"><b>package</b></FONT></FONT><FONT FACE=\"Courier New, monospace\"><FONT SIZE=2 STYLE=\"font-size: 9pt\">
 &lt;Name&gt; ... </FONT></FONT><FONT FACE=\"Courier New, monospace\"><FONT SIZE=2 STYLE=\"font-size: 9pt\"><b>end</b></FONT></FONT><FONT FACE=\"Courier New, monospace\"><FONT SIZE=2 STYLE=\"font-size: 9pt\">
 &lt;Name&gt;;</FONT></FONT>&ldquo; Modelica language element.</li>
</ol>

<p>
<b>2. Grant of Copyright License.</b> Licensor grants You a
worldwide, royalty-free, non-exclusive, sublicensable license, for
the duration of the copyright, to do the following:</p>

<ol>
 <li><p>
 To reproduce the Original Work in copies, either alone or as part of
 a collection.</li></p>
 <li><p>
 To create Derivative Works according to Section 1d) of this License.</li></p>
 <li><p>
 To distribute or communicate to the public copies of the <u>Original
 Work</u> or a <u>Derivative Work</u> under <u>this License</u>. No
 fee, neither as a copyright-license fee, nor as a selling fee for
 the copy as such may be charged under this License. Furthermore, a
 verbatim copy of this License must be included in any copy of the
 Original Work or a Derivative Work under this License.<br>      For
 the matter of clarity, it is permitted A) to distribute or
 communicate such copies as part of a (possible commercial)
 collection where other parts are provided under different licenses
 and a license fee is charged for the other parts only and B) to
 charge for mere printing and shipping costs.</li></p>
 <li><p>
 To distribute or communicate to the public copies of a <u>Derivative
 Work</u>, alternatively to Section 2c), under <u>any other license</u>
 of your choice, especially also under a license for
 commercial/proprietary software, as long as You comply with Sections
 3, 4 and 8 below. <br>      For the matter of clarity, no
 restrictions regarding fees, either as to a copyright-license fee or
 as to a selling fee for the copy as such apply.</li></p>
 <li><p>
 To perform the Original Work publicly.</li></p>
 <li><p>
 To display the Original Work publicly.</li></p>
</ol>

<p>
<b>3. Acceptance.</b> Any use of the Original Work or a
Derivative Work, or any action according to either Section 2a) to 2f)
above constitutes Your acceptance of this License.</p>

<p>
<b>4. Designation of Derivative Works and of Modified Works.
</b>The identifying designation of Derivative Work and of Modified
Work must be different to the corresponding identifying designation
of the Original Work. This means especially that the (root-level)
name of a Modelica package under this license must be changed if the
package is modified (besides fixing of errors, adding vendor specific
Modelica annotations, using a subset of the classes of a Modelica
package, or using another representation, e.g. a binary
representation).</p>

<p>
<b>5. Grant of Patent License.</b>
Licensor grants You a worldwide, royalty-free, non-exclusive, sublicensable license,
under patent claims owned by the Licensor or licensed to the Licensor by
the owners of the Original Work that are embodied in the Original Work
as furnished by the Licensor, for the duration of the patents,
to make, use, sell, offer for sale, have made, and import the Original Work
and Derivative Works under the conditions as given in Section 2.
For the matter of clarity, the license regarding Derivative Works covers
patent claims to the extent as they are embodied in the Original Work only.</p>

<p>
<b>6. Provision of Source Code.</b> Licensor agrees to provide
You with a copy of the Source Code of the Original Work but reserves
the right to decide freely on the manner of how the Original Work is
provided.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;For the matter of clarity, Licensor might provide only a binary
representation of the Original Work. In that case, You may (a) either
reproduce the Source Code from the binary representation if this is
possible (e.g., by performing a copy of an encrypted Modelica
package, if encryption allows the copy operation) or (b) request the
Source Code from the Licensor who will provide it to You.</p>

<p>
<b>7. Exclusions from License Grant.</b> Neither the names of
Licensor, nor the names of any contributors to the Original Work, nor
any of their trademarks or service marks, may be used to endorse or
promote products derived from this Original Work without express
prior permission of the Licensor. Except as otherwise expressly
stated in this License and in particular in Sections 2 and 5, nothing
in this License grants any license to Licensor&rsquo;s trademarks,
copyrights, patents, trade secrets or any other intellectual
property, and no patent license is granted to make, use, sell, offer
for sale, have made, or import embodiments of any patent claims.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;No license is granted to the trademarks of
Licensor even if such trademarks are included in the Original Work,
except as expressly stated in this License. Nothing in this License
shall be interpreted to prohibit Licensor from licensing under terms
different from this License any Original Work that Licensor otherwise
would have a right to license.</p>

<p>
<b>8. Attribution Rights.</b> You must retain in the Source
Code of the Original Work and of any Derivative Works that You
create, all author, copyright, patent, or trademark notices, as well
as any descriptive text identified therein as an &quot;Attribution
Notice&quot;. The same applies to the licensing notice of this
License in the Original Work. For the matter of clarity, &ldquo;author
notice&rdquo; means the notice that identifies the original
author(s). <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;You must cause the Source Code for any Derivative
Works that You create to carry a prominent Attribution Notice
reasonably calculated to inform recipients that You have modified the
Original Work. <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;In case the Original Work or Derivative Work is not provided in
Source Code, the Attribution Notices shall be appropriately
displayed, e.g., in the documentation of the Derivative Work.</p>

<p><b>9. Disclaimer
of Warranty. <br></b><u><b>The Original Work is provided under this
License on an &quot;as is&quot; basis and without warranty, either
express or implied, including, without limitation, the warranties of
non-infringement, merchantability or fitness for a particular
purpose. The entire risk as to the quality of the Original Work is
with You.</b></u><b> </b>This disclaimer of warranty constitutes an
essential part of this License. No license to the Original Work is
granted by this License except under this disclaimer.</p>

<p>
<b>10. Limitation of Liability.</b> Under no circumstances and
under no legal theory, whether in tort (including negligence),
contract, or otherwise, shall the Licensor, the owner or a licensee
of the Original Work be liable to anyone for any direct, indirect,
general, special, incidental, or consequential damages of any
character arising as a result of this License or the use of the
Original Work including, without limitation, damages for loss of
goodwill, work stoppage, computer failure or malfunction, or any and
all other commercial damages or losses. This limitation of liability
shall not apply to the extent applicable law prohibits such
limitation.</p>

<p>
<b>11. Termination.</b> This License conditions your rights to
undertake the activities listed in Section 2 and 5, including your
right to create Derivative Works based upon the Original Work, and
doing so without observing these terms and conditions is prohibited
by copyright law and international treaty. Nothing in this License is
intended to affect copyright exceptions and limitations. This License
shall terminate immediately and You may no longer exercise any of the
rights granted to You by this License upon your failure to observe
the conditions of this license.</p>

<p>
<b>12. Termination for Patent Action.</b> This License shall
terminate automatically and You may no longer exercise any of the
rights granted to You by this License as of the date You commence an
action, including a cross-claim or counterclaim, against Licensor,
any owners of the Original Work or any licensee alleging that the
Original Work infringes a patent. This termination provision shall
not apply for an action alleging patent infringement through
combinations of the Original Work under combination with other
software or hardware.</p>

<p>
<b>13. Jurisdiction.</b> Any action or suit relating to this
License may be brought only in the courts of a jurisdiction wherein
the Licensor resides and under the laws of that jurisdiction
excluding its conflict-of-law provisions. The application of the
United Nations Convention on Contracts for the International Sale of
Goods is expressly excluded. Any use of the Original Work outside the
scope of this License or after its termination shall be subject to
the requirements and penalties of copyright or patent law in the
appropriate jurisdiction. This section shall survive the termination
of this License.</p>

<p>
<b>14. Attorneys&rsquo; Fees.</b> In any action to enforce the
terms of this License or seeking damages relating thereto, the
prevailing party shall be entitled to recover its costs and expenses,
including, without limitation, reasonable attorneys' fees and costs
incurred in connection with such action, including any appeal of such
action. This section shall survive the termination of this License.</p>

<p>
<b>15. Miscellaneous.</b>
</p>
<ol>
 <li>If any
 provision of this License is held to be unenforceable, such
 provision shall be reformed only to the extent necessary to make it
 enforceable.</li>

 <li>No verbal
 ancillary agreements have been made. Changes and additions to this
 License must appear in writing to be valid. This also applies to
 changing the clause pertaining to written form.</li>

 <li>You may use the
 Original Work in all ways not otherwise restricted or conditioned by
 this License or by law, and Licensor promises not to interfere with
 or be responsible for such uses by You.</li>
</ol>

<p>
<br>
</p>

</html>
"), Icon(graphics={
          Ellipse(
            lineColor={75,138,73},
            fillColor={75,138,73},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-100.0,-100.0},{100.0,100.0}}),
          Polygon(origin={-4.167,-15.0},
            fillColor={255,255,255},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{-15.833,20.0},{-15.833,30.0},{14.167,40.0},{24.167,20.0},{4.167,-30.0},{14.167,-30.0},{24.167,-30.0},{24.167,-40.0},{-5.833,-50.0},{-15.833,-30.0},{4.167,20.0},{-5.833,20.0}},
            smooth=Smooth.Bezier),
          Ellipse(origin={7.5,56.5},
            fillColor={255,255,255},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-12.5,-12.5},{12.5,12.5}})}));

  end ThermoSysProLicense;

  class ThermoSysProDocumentation "Documentation"

    annotation (Documentation(info="<html>
<p><b><span style=\"font-size: 12pt; color: #008000;\">Documentation </span></b></p>
<p>A <a href=\"https://www.modelica.org/events/modelica2011/Proceedings/pages/papers/15_2_ID_115_a_fv.pdf\">conference paper</a> explains the fundamentals of the library.</p>
<p>The <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a> is available from Springer.</p>
<p>The full documentation of the library is still under construction. </p>
</html>"), Icon(graphics={
          Ellipse(
            lineColor={75,138,73},
            fillColor={75,138,73},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-100.0,-100.0},{100.0,100.0}}),
          Polygon(origin={-4.167,-15.0},
            fillColor={255,255,255},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{-15.833,20.0},{-15.833,30.0},{14.167,40.0},{24.167,20.0},{4.167,-30.0},{14.167,-30.0},{24.167,-30.0},{24.167,-40.0},{-5.833,-50.0},{-15.833,-30.0},{4.167,20.0},{-5.833,20.0}},
            smooth=Smooth.Bezier),
          Ellipse(origin={7.5,56.5},
            fillColor={255,255,255},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-12.5,-12.5},{12.5,12.5}})}));

  end ThermoSysProDocumentation;
  annotation (DocumentationClass=true, Documentation(info="<html>
<p><b><span style=\"font-size: 12pt; color: #008000;\">Users Guide of the ThermoSysPro Library</span></b></p>
<p>ThermoSysPro is a library for the modelling and simulation of power plants and energy systems. It is developed with the Modelica language from the <a href=\"http://www.Modelica.org\">Modelica Association</a>. It provides components in various disciplines related to the modelling of power plants and energy systems. </h4>
</html>"),
    Icon(graphics={
        Ellipse(
          lineColor={75,138,73},
          fillColor={75,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          extent={{-100.0,-100.0},{100.0,100.0}}),
        Polygon(origin={-4.167,-15.0},
          fillColor={255,255,255},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-15.833,20.0},{-15.833,30.0},{14.167,40.0},{24.167,20.0},{4.167,-30.0},{14.167,-30.0},{24.167,-30.0},{24.167,-40.0},{-5.833,-50.0},{-15.833,-30.0},{4.167,20.0},{-5.833,20.0}},
          smooth=Smooth.Bezier),
        Ellipse(origin={7.5,56.5},
          fillColor={255,255,255},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          extent={{-12.5,-12.5},{12.5,12.5}})}));
end UsersGuide;
