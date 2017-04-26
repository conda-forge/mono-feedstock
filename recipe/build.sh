#!/usr/bin/env bash

./configure --prefix=$PREFIX --with-glib=embedded --enable-nls=no --disable-dependency-tracking --disable-silent-rules

make
make check
make install

cat <<EOF > hello.cs
      public class Hello1
      {
         public static void Main()
         {
            System.Console.WriteLine("Hello World");
         }
      }
EOF

${PREFIX}/bin/mcs hello.cs
${PREFIX}/bin/mono hello.exe | grep "Hello world"

cat <<EOF > test.csproj
      <?xml version="1.0" encoding="utf-8"?>
      <Project ToolsVersion="4.0" DefaultTargets="Build" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
        <PropertyGroup>
          <AssemblyName>HomebrewMonoTest</AssemblyName>
          <TargetFrameworkVersion>v4.5</TargetFrameworkVersion>
        </PropertyGroup>
        <ItemGroup>
          <Compile Include="#{test_name}" />
        </ItemGroup>
        <Import Project="$(MSBuildBinPath)\\Microsoft.CSharp.targets" />
      </Project>
EOF

${PREFIX}/bin/xbuild test.csproj

