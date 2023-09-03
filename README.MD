> [!WARNING]
> I'm not an SQLite developer nor am I using these files in a production capacity; no tests have been run on the resulting libraries beyond my own basic usage. Use at your own risk.

I'm using SQLite for a couple of minor C# projects that I'm running on Raspberry Pis at home. Unfortunately, as of 2023-09-02, there's no [System.Data.SQLite](https://www.nuget.org/packages/System.Data.SQLite/) package published for ARM64.

In this repo is a dockerfile which will build the managed `System.Data.SQLite.dll` and more interestingly the native `SQLite.Interop.dll` with ARM64 compatibility.

Review `build.sh` for an idea of how you might use Docker `build`'s [`--output`](https://docs.docker.com/engine/reference/commandline/build/#output) to export the build artifacts to a local folder.