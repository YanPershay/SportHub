using MediatR;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Commands
{
    public class CreateCommentCommand : IRequest<CommentResponse>
    {
        public string Text { get; set; }
        public DateTime DateCreated { get; set; }
        public bool IsUpdated { get; set; }

        public Guid UserId { get; set; }

        public int PostId { get; set; }
    }
}
