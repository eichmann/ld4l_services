resource "aws_efs_file_system" "ld4l_services_efs" {

  encrypted = "true"

#  lifecycle_policy {
#    transition_to_ia = "AFTER_90_DAYS"
#  }

  performance_mode                = "generalPurpose"
  provisioned_throughput_in_mibps = "0"

  tags = {
    "Name"               = "ld4l_services"
    "Application"        = "LD4P"
    "Cost Center"        = "L858313"
    "Functional Contact" = "elr37"
    "Technical Contact"  = "gad22"
  }

  throughput_mode = "bursting"
}

resource "aws_efs_mount_target" "ld4l_services_efs_mt_0" {
  file_system_id  = aws_efs_file_system.ld4l_services_efs.id
  security_groups = var.sg_efs_for_ecs
  subnet_id       = tolist(data.aws_subnet_ids.private_subnets.ids)[0]
}

resource "aws_efs_mount_target" "ld4l_services_efs_mt_1" {
  file_system_id  = aws_efs_file_system.ld4l_services_efs.id
  security_groups = var.sg_efs_for_ecs
  subnet_id       = tolist(data.aws_subnet_ids.private_subnets.ids)[1]
}

resource "aws_efs_access_point" "ld4l_services_efs_data_ap" {
  file_system_id = aws_efs_file_system.ld4l_services_efs.id

  posix_user {
    gid = "0"
    uid = "0"
  }

  root_directory {
    creation_info {
      owner_gid   = "0"
      owner_uid   = "0"
      permissions = "0755"
    }

    path = "/data"
  }

  tags = {
    "Application"        = "LD4P"
    "Cost Center"        = "L858313"
    "Functional Contact" = "elr37"
    "Technical Contact"  = "gad22"
  }
}
