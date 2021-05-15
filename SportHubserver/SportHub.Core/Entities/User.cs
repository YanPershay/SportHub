using SportHub.Core.Entities.Base;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace SportHub.Core.Entities
{
    public class User : Entity
    {
        [Key]
        public Guid GuidId { get; set; }
        public string Username { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public bool IsTrainer { get; set; }
        public virtual UserInfo UserInfo { get; set; }
        public List<Post> Posts { get; set; }
        public List<TrainerPost> TrainerPosts { get; set; }
        public List<Comment> Comments { get; set; }
        public List<Like> Likes { get; set; }
        public List<Subscribe> Subscribes { get; set; }
        public List<Subscribe> Subscribers { get; set; }

        public List<SavedPost> SavedPosts { get; set; }

        public User() { }

        public User(Guid guidId, string username, string email, string password, bool isTrainer)
        {
            GuidId = guidId;
            Username = username;
            Email = email;
            Password = password;
            IsTrainer = isTrainer;
        }
    }
}
