## statekit_cli

A CLI tool for generating Flutter project structures and screens.

<br />

### Installation
To use statekit_cli, you need to activate it globally using the following command:

```
dart pub global activate statekit_cli
```

### Usage

##### Initializing Project Structure
Initialize the structure of an existing project using the `init` command:

```
statekit init
```

This command sets up the necessary directories and files for your Flutter project.

<br />

##### Creating Screens
Generate screens (pages) for your application using the `create screen` command:

```
statekit create screen <screen_name>
```

Replace <screen_name> with the desired name of your screen. This command creates the necessary files for a new screen.

<br />

You can also generate multiple screens at once using the create screens command:

```
statekit create screens first_screen second_screen third_screen
```

This command will create the necessary files for each screen specified.

<br />

##### Help
To display this help message, use the help command:

```
statekit help
```

---