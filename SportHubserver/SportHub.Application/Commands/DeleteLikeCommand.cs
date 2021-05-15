using MediatR;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Commands
{
    public class DeleteLikeCommand : IRequest<int>
    {
        public int Id { get; set; }
        public Guid UserId { get; set; }

        public int PostId { get; set; }
    }
}
