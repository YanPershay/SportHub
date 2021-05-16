using MediatR;
using SportHub.Application.Responses;
using SportHub.Core.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Commands
{
    public class CreatePostCommand : IRequest<PostResponse>
    {
        public string Text { get; set; }
        public string ImageUrl { get; set; }
        public DateTime DateCreated { get; set; }
        public bool IsUpdated { get; set; }
        public Guid UserId { get; set; }
    }
}
