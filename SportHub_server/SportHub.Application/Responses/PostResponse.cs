﻿using SportHub.Core.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Responses
{
    public class PostResponse
    {
        public int Id { get; set; }
        public string Text { get; set; }
        public string ImageUrl { get; set; }
        public DateTime DateCreated { get; set; }

        public Guid UserId { get; set; }

        public UserResponse User { get; set; }

        public List<LikeResponse> Likes { get; set; }
        public List<CommentResponse> Comments { get; set; }
    }
}
