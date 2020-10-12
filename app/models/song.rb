class Song < ApplicationRecord
    validates :title, presence: true, uniqueness: { scope: [:artist_name, :release_year], if: :title? }
    with_options if: :released? do |song|
        song.validates :release_year, presence: true
        song.validate :release_year_not_future
    end

    validates :released, inclusion: [true, false]
    validates :release_year, presence: true, if: :released?

    private

    def release_year_not_future
        errors.add(:release_year, "release year can't be in future") if self.release_year && self.release_year > Time.now.year
    end
end
