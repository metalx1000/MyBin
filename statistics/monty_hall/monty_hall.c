#include<stdio.h>
#include<stdlib.h>

#define WIN 1
#define ZONK 0

#define FREE 1
#define TAKEN 0

#define NUM_DOORS 3

#define N_GAMES 10000

typedef enum {STAY, SWITCH} strategy_type;

typedef char * string;

typedef struct game_struct {
  int num_avilable_doors;
  int doors[NUM_DOORS];
  int prize_door_number;
} game_type;

int randomDoor(int num_of_doors)
{
  return rand() % num_of_doors;
}

void setupGame(game_type* game)
{
  int i;
  game->num_avilable_doors = NUM_DOORS;
  for (i=0;i<NUM_DOORS;i++) {
    game->doors[i] = FREE;
  }
  game->prize_door_number = randomDoor(NUM_DOORS);
}

void removeDoor(int door, game_type* game)
{
  game->doors[door] = TAKEN;
  game->num_avilable_doors--;
}

void addDoor(int door, game_type* game)
{
  game->doors[door] = FREE;
  game->num_avilable_doors++;
}

int getFirstAvilableDoor(game_type* game)
{
  int i;
  for (i=0;i<NUM_DOORS;i++) {
    if (game->doors[i] == FREE) {
      return i;
    }
  }
  //ERROR'
  fprintf(stderr, "\nNo Available Doors!\n");
  return -1;
}

int getFirstAvilableZonk(game_type* game)
{
  int i;
  for (i=0;i<NUM_DOORS;i++) {
    if (game->doors[i] == FREE && game->prize_door_number != i) {
      return i;
    }
  }
  //ERROR
  fprintf(stderr, "\nNo Zonk Available!!!\n");
  fprintf(stderr, "number of doors: %d\n", game->num_avilable_doors);
  return -1;
}

int revealOneZonk(game_type* game)
{
  int door;
  door = getFirstAvilableZonk(game);
  removeDoor(door, game);
  return door;
}

typedef struct player_struct {
  int selected_door;
  strategy_type strategy;
  int wins;
  int games_played;
} player_type;

int pickDoor(player_type* player, game_type* game)
{
  player->selected_door = randomDoor(NUM_DOORS);
  removeDoor(player->selected_door, game);
  fprintf(stdout, "player selects %d\n", player->selected_door);
  return player->selected_door;
}

int switchDoor(player_type* player, game_type* game)
{
  int old_selection;
  old_selection = player->selected_door;

  //at this point their is only one free door so I do not
  //need to pick it randomly, I can get the first avialable
  //and that will be the only free door.
  player->selected_door = getFirstAvilableDoor(game);
  removeDoor(player->selected_door, game);
  //I don't need to add the old one back in but just incase I wanted
  //todo something more complicated I could
  addDoor(old_selection, game);
  fprintf(stdout, "player switches to %d\n", player->selected_door);
  return player->selected_door;
}

int outcome(player_type* player, game_type* game)
{
  if (player->selected_door == game->prize_door_number) {
    fprintf(stdout, "player wins\n");
    return WIN;
  }
  fprintf(stdout, "player looses\n");
  return ZONK;
}

void playGame(player_type* player, game_type* game)
{
  setupGame(game);
  pickDoor(player, game);
  revealOneZonk(game);
  if (player->strategy == SWITCH) {
    switchDoor(player, game);
  }
  player->wins += outcome(player, game);
  player->games_played++;
}

int main(void)
{
  float win_percent;
  int i;
  player_type player;
  game_type game;

  player.strategy = SWITCH;//STAY;//SWITCH;
  player.wins = 0;
  player.games_played = 0;

  srand(time(NULL));

  for(i = 0; i < N_GAMES; i++) {
    playGame(&player, &game);
  }

  fprintf(stdout, "Player Won %d of %d games\n", player.wins, player.games_played);

  win_percent = ((float)player.wins / player.games_played) * 100;

  fprintf(stdout, "Player Won %f precent of his games\n", win_percent);

  return 0;
}
