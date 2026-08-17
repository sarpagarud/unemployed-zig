const State = struct {
  what: str,
  where: str,
  why: str,
  when: str,
  how: str,
  value: f64,
  
  pub fn init(what: str, where: str, why: str, when: str, how: str, value: f64) State {
    return State{
      .what = what,
      .where = where,
      .why = why,
      .when = when,
      .how = how,
      .value = value,
    };
  }
};

// Type of unemployment
const UnemploymentType = enum {
  Cyclical,
  Frictional,
  Structural,
  Classical,
  Seasonal,
  Hardcore,
  Hidden,
  RealWage,
  LongTerm,

  pub fn isCyclical(self: Unemployment) bool {
      return self == Unemployment.Cyclical;
  }
};

// Types of underemployment, unemployment and underutilization.
const UType = enum {
  U1,
  U2,
  U3,
  U4,
  U5,
  U6,
};

const LUType = enum {
  LU1,
  LU2,
  LU3,
  LU4,
};

const LU_U = struct {
  U1: f64,
  U2: f64,
  U3: f64,
  U4: f64,
  U5: f64,
  U6: f64,
  LU1: f64,
  LU2: f64,
  LU3: f64,
  LU4: f64,
  
  pub fn init() LU_U {
    return LU_U{
      U1 = 0.0,
      U2 = 0.0,
      U3 = 0.0,
      U4 = 0.0,
      U5 = 0.0,
      U6 = 0.0,
      LU1 = 0.0,
      LU2 = 0.0,
      LU3 = 0.0,
      LU4 = 0.0,
    };
  }

  pub fn calculate_rate(count: f64, total: f64) bool {
      return (count/total)*100.0;
  }

  pub fn calculate_U1() bool {
    self.U1 = self.calculate_rate(1.0, 1.0);
  }

  pub fn calculate_U2() bool {
    self.U2 = self.calculate_rate(1.0, 1.0);
  }

  pub fn calculate_U3() bool {
    self.U3 = self.calculate_rate(1.0, 1.0);
  }

  pub fn calculate_U4() bool {
    self.U4 = self.calculate_rate(1.0, 1.0);
  }

  pub fn calculate_U5() bool {
    self.U5 = self.calculate_rate(1.0, 1.0);
  }

  pub fn calculate_U6() bool {
    self.U6 = self.calculate_rate(1.0, 1.0);
  }

  pub fn calculate_U1() bool {
    self.U1 = self.calculate_rate(1.0, 1.0);
  }

  pub fn calculate_LU2() bool {
    self.LU2 = self.calculate_rate(1.0, 1.0);
  }

  pub fn calculate_LU3() bool {
    self.LU3 = self.calculate_rate(1.0, 1.0);
  }

  pub fn calculate_LU4() bool {
    self.LU4 = self.calculate_rate(1.0, 1.0);
  }

};

// Skill acquired through education or self study
const Skill = enum {
  Zig,
  Programming,
};

const NEET = enum {
  None,
  Education,
  Employment,
  Training,

  pub fn inEducation(self: NEET) bool {
      return self == NEET.Education;
  }
  pub fn inEmployment(self: NEET) bool {
      return self == NEET.Employment;
  }
  pub fn inTraining(self: NEET) bool {
      return self == NEET.Training;
  }
};

const Education = struct {
  
  pub fn init() Education {
    return Education{
      
    };
  }
};

const Employment = struct {
  training: Training,
  
  pub fn init() Employment {
    return Employment{
      
    };
  }
};

const Training = struct {
  
  pub fn init() Training {
    return Training{
      
    };
  }
};

const Skills = struct {
  
  pub fn init() Skills {
    return Skills{
      
    };
  }
};

const UnemployedStatus = struct {
  unemploymentType: UnemploymentType,
  uType: UType,
  lUType: LUType,
  
  pub fn init(unemploymentType: UnemploymentType, uType: UType, lUType: LUType) UnemployedStatus {
    return UnemployedStatus{
      
    };
  }
};

const Unemployed = struct {
  age: u32,
  neet: NEET,
  education: Education,
  employment: Employment,
  training: Training,
  skills: Skills,
  status: UnemployedStatus,
  
  pub fn init(age: u32, education: Education, 
    employment: Employment, training: Training, 
    skills: Skills, status: UnemployedStatus
  ) Unemployed {
    return Unemployed{
      .age = age,
      .education = education,
      .employment = employment,
      .training = training,
      .skills = skills,
      .status = status,
    };
  }
};

//syntax
