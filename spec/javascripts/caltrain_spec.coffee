describe("Caltrain widget", =>

  it("shows NB and SB trains in separate columns, with up to 4 trains per direction", =>
    caltrain = new Dashing.Caltrain()
    caltrain.ready()
    data = [
        { route: "LOCAL", minutes: 5, direction: "NB" },
        { route: "BULLET", minutes: 47, direction: "SB" },
        { route: "LIMITED", minutes: 31, direction: "SB" },
        { route: "BULLET", minutes: 17, direction: "NB" },
        { route: "LOCAL", minutes: 10, direction: "NB" },
        { route: "BULLET", minutes: 57, direction: "NB" },
        { route: "LIMITED", minutes: 55, direction: "NB" },
        { route: "BULLET", minutes: 47, direction: "NB" }
    ]
    setDataOnWidget(caltrain, {data: data})
    expect(caltrain.departures.NB.length).toEqual(4);
    expect(caltrain.departures.SB.length).toEqual(2);
    expect(caltrain.departures).toEqual(
      NB: [
        { route: "LOCAL", minutes: 5, direction: "NB" },
        { route: "LOCAL", minutes: 10, direction: "NB" },
        { route: "BULLET", minutes: 17, direction: "NB" },
        { route: "BULLET", minutes: 47, direction: "NB" }
      ],
      SB: [
        { route: "LIMITED", minutes: 31, direction: "SB" },
        { route: "BULLET", minutes: 47, direction: "SB" }
      ]
    )
  )
)
