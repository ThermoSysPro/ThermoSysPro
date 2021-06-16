within ThermoSysPro.Functions;
function SplineInterpolation "Spline interpolation"
  input Real TabX[:] "References table";
  input Real TabY[:] "Results table";
  input Real X "Reference value"; // index in table
  input Real t(max = 1) = 0.5 "Stiffness parameter";
  output Real Y "Interpolated result";

protected
  parameter Integer dimX=size(TabX, 1) "TabX dimension";
  parameter Integer dimY=size(TabY, 1) "TabY dimension";
  Real y0;
  Real y1;
  Real y2;
  Real x0;
  Real x1;
  Real x2;
  Real y1d "derivative at point at y1";
  Real y2d "derivative at point at y2";
  Integer IndX "Reference index";
  Boolean IndXcal "True if IndX is contained in TabX";

algorithm
  if (dimX <> dimY) then
    assert(false, "LinearInterpolation: the dimensions of the tables are different");
  end if;
  if (dimX < 2) then
    assert(false, "Only one data point in table");
  end if;

  IndXcal := false;

  // Find index in table:
  if (X > TabX[1]) then
    for i in 2:dimX loop
      if ((X <= TabX[i]) and (not IndXcal)) then // IndX => x2
        IndX := i;
        IndXcal := true;
      end if;
    end for;
  end if;

  // If index is outside of table => Linear extrapolation
  if (not IndXcal) then
    if (X <= 2) then
      IndX := 2;
    else
      IndX := dimX;
    end if;
  end if;

  // Relevant data points:
  y1 := TabY[IndX - 1];
  y2 := TabY[IndX];
  x1 := TabX[IndX - 1];
  x2 := TabX[IndX];
  y2d := (y2-y1)/(x2-x1); // Approximating derivative

  // Use spline interpolation if X i contained in the table interval,
  //  If NOT contained: Use linear extrapolation.
  if (not IndXcal) then
    // Linear Extrapolation
    if (IndX == dimX) then
      Y := y2d*(X - x2) + y2;
    else
      Y := y2d*(X-x1)+y1;
    end if;
  else
    // Spline interpolation:
    if (IndX == 2) then
      y1d := y2d; // Approximating derivative
    else
      // In table (genral case)
      y0 := TabY[IndX - 2];
      x0 := TabX[IndX - 2];
      y1d := (1 - t)*0.5*(y2d + (y1 - y0)/(x1 - x0)); // Approximating derivative
      if (IndX < dimX) then
        y2d := (1 - t)*0.5*(y2d + (TabY[IndX + 1] - y2)/(TabX[IndX + 1] - x2));
      end if;
    end if;

    // Compute Y using CubicHermite, spline interpolation
    Y := ThermoSysPro.Functions.Utilities.CubicHermite(
      x=X,
      x1=x1,
      x2=x2,
      y1=y1,
      y2=y2,
      y1d=y1d,
      y2d=y2d);
  end if;
  annotation (
    smoothOrder=1,
     Icon(graphics),       Documentation(info="<html>
<p><b>ThermoSysPro Version 3.1</b> </p>
<p>Spline interpolation function. The resulting spline will be continuous and have a continuous first derivative.</p>
<p><h4><font color=\"#008000\">Implementation</font></h4></p>
<p>It uses a cardinal spline interpolation algorithm. Cardinal splines are a sub-set of cubic Hermite splines where each piece is a third-degree polynomial specified in Hermite form: i.e specified by its values and the first derivatives at the end points of the reference interval.</p>
<p>The derivatives are calculated based on the non-uniform cardinal grid approach according to:</p>
<p>y1_der=0.5(1-t)(y1-y0/(x1-x0)+(y2-y1/(x2-x1)</p>
<p>I.e. the derivative in a point is calculated as an average of the surrounding points with an extra input shape parameter t.</p>
<p><h4><font color=\"#008000\">Inputs</font></h4></p>
<p><ul>
<li>TabX: Vector containing x-table values</li>
<li>TabY: Vector containing y-table values</li>
<li>X: The x-value that the spline should be evaluated at</li>
<li>t: Cardinal spline shape parameter. t = 0.5 is default and is generally a good choice. A value close to 1 will yield a stiff spline, t=0<a name=\"_x0000_i1025\">&nbsp;</a>corresponds to a Catmull-Rom spline and <a name=\"_x0000_i1025\">&nbsp;</a>t &LT; 0 corresponds to a more &ldquo;loose&rdquo; spline. From testing, t=0.5 <a name=\"_x0000_i1025\">&nbsp;</a>seems to be a good choice in general and is therefore chosen as a default value. A value of t = 1 corresponds to that the derivative in all data points is zero, which may result in strange curves . See Examples &GT; TestSplineInterpolation for a demonstration.</li>
</ul></p>
<p><h4><font color=\"#008000\">Output</font></h4></p>
<p><ul>
<li>Y: Interpolated value evaluated at X</li>
</ul></p>
<p><h4><font color=\"#008000\">Extrapolation</font></h4></p>
<p>Linear extrapolation is employed if the reference value is not contained in the reference value table.</p>
<p><h4><font color=\"#008000\">Example</font></h4></p>
<p><ul>
<li>TabX = {1,2,3,4};</li>
<li>TabY = {4,3,5,2};<br/><br/><img src=\"modelica://ThermoSysPro/Resources/Images/spline.png\"/></li>
</ul></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p><a href=\"http://people.cs.clemson.edu/~dhouse/courses/405/notes/splines.pdf\">http://people.cs.clemson.edu/~dhouse/courses/405/notes/splines.pdf</a></p>
</html>", revisions="<html>
</html>"));
end SplineInterpolation;
