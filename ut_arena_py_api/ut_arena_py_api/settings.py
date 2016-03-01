stage = 'Local'

if stage == 'Development':
  from settings_development import *
elif stage == 'Test':
  from settings_test import *
elif stage == 'Production':
  from settings_production import *
else:
  from settings_local import *
