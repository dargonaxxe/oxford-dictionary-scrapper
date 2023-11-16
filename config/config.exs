import Config

config :scrapper, :output_directory, System.get_env("OUTPUT_DIR")

config :crawly,
  concurrent_requests_per_domain: 4,
  middlewares: [
    Crawly.Middlewares.DomainFilter,
    Crawly.Middlewares.UniqueRequest,
    {Crawly.Middlewares.UserAgent, user_agents: ["Crawly Bot"]}
  ],
  pipelines: [
    {Crawly.Pipelines.Validate, fields: [:phonetics, :examples, :definition, :word]},
    Crawly.Pipelines.JSONEncoder,
    {Crawly.Pipelines.WriteToFile,
     extension: "json", folder: System.get_env("OUTPUT_DIR"), include_timestamp: false}
  ]
