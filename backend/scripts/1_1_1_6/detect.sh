#!/usr/bin/env bash
{
   l_mod_name="overlayfs" l_mod_type="fs"
   while IFS= read -r l_mod_path; do
      if [ -d "$l_mod_path/${l_mod_name//-/\/}" ] &&  \
      [ -n "$(ls -A "$l_mod_path/${l_mod_name//-/\/}")" ]; then
         printf '%s\n' "$l_mod_name exists in $l_mod_path"
      fi
   done < <(readlink -e /usr/lib/modules/**/kernel/$l_mod_type \
   || readlink -e /lib/modules/**/kernel/$l_mod_type)
}
