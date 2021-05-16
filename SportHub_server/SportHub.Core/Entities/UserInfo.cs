using SportHub.Core.Entities.Base;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Core.Entities
{
    public class UserInfo : Entity
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Country { get; set; }
        public string City { get; set; }
        public string DateOfBirth { get; set; }
        public string SportLevel { get; set; }
        public float Height { get; set; }
        public float Weight { get; set; }
        public string AboutMe { get; set; }
        public string Motivation { get; set; }
        public string AvatarUrl { get; set; }

        public Guid UserId { get; set; }
        public User User { get; set; }

        public UserInfo(string firstName, string lastName, string country, string city, string dateOfBirth, 
            string sportLevel, float height, float weight, string aboutMe, string motivation, string avatarUrl, Guid userId)
        {
            FirstName = firstName;
            LastName = lastName;
            Country = country;
            City = city;
            DateOfBirth = dateOfBirth;
            SportLevel = sportLevel;
            Height = height;
            Weight = weight;
            AboutMe = aboutMe;
            Motivation = motivation;
            AvatarUrl = avatarUrl;
            UserId = userId;
        }
    }
}
