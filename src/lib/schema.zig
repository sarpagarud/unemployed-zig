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

  pub fn calculate_rate(count: f64, total: f64) f64 {
      return (count/total)*100.0;
  }

  pub fn calculate_U1(unemployed_gte_15_weeks: f64, total_labor_force: f64) void {
    self.U1 = self.calculate_rate(unemployed_gte_15_weeks, total_labor_force);
  }

  pub fn calculate_U2(unemployed_with_lost_jobs: f64, unemployed_who_had_temp_jobs: f64, total_labor_force: f64) void {
    self.U2 = self.calculate_rate(
      unemployed_with_lost_jobs + unemployed_who_had_temp_jobs, 
      total_labor_force
    );
  }

  pub fn calculate_U3(total_unemployed: f64, total_labor_force: f64) void {
    self.U3 = self.calculate_rate(total_unemployed, total_labor_force);
  }

  pub fn calculate_U4(discouraged_workers: f64, total_labor_force: f64) void {
    self.U4 = self.calculate_rate(
      self.U3 + discouraged_workers, 
      total_labor_force + discouraged_workers
    );
  }

  pub fn calculate_U5(marginally_attached: f64, total_labor_force: f64) void {
    self.U5 = self.calculate_rate(
      self.U4 + marginally_attached, 
      total_labor_force + marginally_attached
    );
  }

  pub fn calculate_U6(involuntary_part_time: f64, total_labor_force: f64) void {
    self.U6 = self.calculate_rate(
      self.U5 + involuntary_part_time, 
      total_labor_force + involuntary_part_time
    );
  }

  pub fn calculate_LU1(unemployed: f64, labor_force: f64) void {
    self.LU1 = self.calculate_rate(unemployed, labor_force);
  }

  pub fn calculate_LU2(unemployed: f64, time_related_unemployed: f64, total_labor_force: f64) void {
    self.LU2 = self.calculate_rate(
      unemployed + time_related_unemployed, 
      total_labor_force + time_related_unemployed
    );
  }

  pub fn calculate_LU3(unemployed: f64, potential_labor_force: f64, total_labor_force: f64) void {
    self.LU3 = self.calculate_rate(
      unemployed + potential_labor_force, 
      total_labor_force + potential_labor_force
    );
  }

  pub fn calculate_LU4() void {
    self.LU4 = self.LU1 + self.LU2 + self.LU3;
  }

  pub fn calculate_u(
    unemployed_gte_15_weeks: f64, 
    unemployed_with_lost_jobs: f64, 
    unemployed_who_had_temp_jobs: f64, 
    total_unemployed: f64,
    discouraged_workers: f64, 
    marginally_attached: f64, 
    involuntary_part_time: f64,
    total_labor_force: f64
  ) void {
    self.calculate_U1(unemployed_gte_15_weeks, total_labor_force);
    self.calculate_U2(unemployed_with_lost_jobs, unemployed_who_had_temp_jobs, total_labor_force);
    self.calculate_U3(total_unemployed, total_labor_force);
    self.calculate_U4(discouraged_workers, total_labor_force);
    self.calculate_U5(marginally_attached, total_labor_force);
    self.calculate_U6(involuntary_part_time, total_labor_force);
  }

  // TODO: check how to use "self"
  pub fn calculate_lu(unemployed: f64, 
    time_related_unemployed: f64, potential_labor_force: f64, 
    labor_force: f64
  ) void {
    self.calculate_LU1(unemployed, labor_force);
    self.calculate_LU2(unemployed, time_related_unemployed, labor_force);
    self.calculate_LU3(unemployed, potential_labor_force, labor_force);
    self.calculate_LU4();
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
