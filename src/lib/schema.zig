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
