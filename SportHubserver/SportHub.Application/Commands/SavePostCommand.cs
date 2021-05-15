using MediatR;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Commands
{
    public class SavePostCommand : IRequest<SavedPostResponse>
    {
        public Guid UserId { get; set; }
        public int PostId { get; set; }
    }
}
