local Pipeline(name, branch="master") = {
  local directory = " /opt/usemarcon/rda_fin2swe",
  kind: "pipeline",
  name: name,
  steps: [{
    name: "deploy",
    image: "quay.io/natlibfi/drone-plugin-scp",
    settings: {
      host: name,        
      username: {
        from_secret: "username_"+name
      },
      key: {
          from_secret: "ssh_key_"+name
      },
      target: directory,
      rm: true,       
      source: ["*"]
    }
  }],
  trigger: {
    branch: [branch],
    event: ["push"]
  }
};

local PipelineVoyager(name, branch="master") = {
  local directory = " /m1/voyager/usemarcon/rda_fin2swe",
  kind: "pipeline",
  name: name,
  steps: [{
    name: "deploy",
    image: "quay.io/natlibfi/drone-plugin-scp",
    settings: {
      host: name,
      username: {
        from_secret: "username_"+name
      },
      key: {
          from_secret: "ssh_key_"+name
      },
      target: directory,
      rm: true, 
      tar_exec: "/usr/sfw/bin/gtar",
      source: ["*"]
    }
  }],
  trigger: {
    branch: [branch],
    event: ["push"]
  }
};

[
  PipelineVoyager("linnea1.csc.fi"),
  PipelineVoyager("linnea3.csc.fi"),
  PipelineVoyager("armas.csc.fi"),
  PipelineVoyager("libtest2.csc.fi", branch="test"),
  Pipeline("replikointi-kk.lib.helsinki.fi")
]