## [0.0.16+34] - 2022-05-06
## Changed
- Smartlook switch to use Firebase Remote Config
## Fixed
- Crashes caused when users attempt to log out before profile is loaded

## [0.0.15+32] - 2022-04-28
## Added
- Fetching of previous push notifications on app launch
## Fixed 
- Home page showing apply button on very frequent reloads

## [0.0.15+31] - 2022-04-27
## Fixed
- Payment DTO issue
- Redundant notification events on the event bus
- Permission names
- Proceed button being enabled while loading
- Auto focus on PIN field

## [0.0.15+30] - 2022-04-26
## Added
- Permissions prompt page for when users deny permissions 

## [0.0.15+29] - 2022-04-22
## Added
- Conditionally turning off SmartLook recording based on actions (PIN confirmation and login at the moment)

## [0.0.14+28] - 2022-04-21
### Fixed
- GSOD which was seen by some users
- Show more button on the homepage taking users to the old loan detail

### Added
- Environment configs for android
- Error display for when loan types aren't fetched properly

## [0.0.14+27] - 2022-04-15
### Added
- Homepage reload on loan cancellation
- Keyboard actions on authentication form (next and submit)
- Account locked message

### Fixed
- Credo "/" issue on ios, removed "/" from the environment variable
- Authentication attempts with one or more empty fields are taken care of by the provider
