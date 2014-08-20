describe("Predictor", function() {
  describe("when user hovers over a space that won’t end the game", function() {
    it("should return false", function() {
      var predictor = new Predictor();
      var new_board = [0];

      var result = predictor.will_move_end_game(0, new_board);
      expect(result).toEqual(false);
    });
  });
});
