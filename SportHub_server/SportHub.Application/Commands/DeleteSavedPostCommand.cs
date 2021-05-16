using MediatR;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Commands
{
    public class DeleteSavedPostCommand : IRequest<int>
    {
        public int Id { get; set; }
        public Guid UserId { get; set; }

        public int PostId { get; set; }
    }
}
