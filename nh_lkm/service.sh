#!/system/bin/sh

load_modules() {
  local module_dir=$1
  if [ -d "$module_dir" ]; then
    find "$module_dir" -type f -name "*.ko" -exec sh -c '
      for module_file do
        log -p i "Loading module: $module_file"
        insmod "$module_file"
        if [ $? -ne 0 ]; then
          log -p e "Failed to load module: $module_file"
        fi
      done
    ' sh {} +
  fi
}

load_modules "/system/lib/modules"
load_modules "/vendor/lib/modules"
load_modules "/system/lib/modules"
load_modules "/vendor/lib/modules"