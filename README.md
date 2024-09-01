# Godot Humanoid Controller

A simple humanoid character controller with state machine and animation tree for Godot Engine 4.3 and above.

This repository is reserved for my ease of development and references. You can use it freely for personal or commercial purposes under CC0 license (but you might want to pay attention to Mixamo animations or bring your own animations).

## Setup Checkpoints

When copying and pasting the player controller to a new project, make sure to go through these checkpoints:

- Go to Project -> Project Settings -> Input Map, add the following actions (some might not be in use but could be referenced by physics functions):
  - `forward`
  - `backward`
  - `left`
  - `right`
  - `jump`
  - `walk`
  - `roll`
  - `move_left`
  - `move_right`
  - `mouse_left`
  - `mouse_right`
  - `cam_zoom_in`
  - `cam_zoom_out`
- Navigate to `Player` node on the level (`demo_scene` in the current project for example), make sure `player.gd` is attached to the script property
- Navigate to the `state_manager` node in the `Player` scene, expand it and check the following default values:
  - walk: `Movement Speed`: 2
  - run: `Movement Speed`: 6.5
  - jump: `Jump Time to Peak`: 1; `Jump Time to Descent`: 10000; `Jump Movement Speed`: 3
  - roll: `Roll Time`: 0.4

## Credits

- [Godot Engine](https://godotengine.org/)
- [Kaykit](https://kaylousberg.itch.io/kaykit-dungeon-remastered) for the floor and props model
- [Mixamo](https://www.mixamo.com) for the character animations
- Character model and texture made by LooieJones

## License

- [CC0-1.0](LICENSE)
- Mixamo animations are used under the [Mixamo license](https://community.adobe.com/t5/mixamo-discussions/mixamo-faq-licensing-royalties-ownership-eula-and-tos/td-p/13234775). Please credit Mixamo when using these animations in your projects.
