using MediatR;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Queries
{
    public class GetSavedPostsByUserIdQuery : IRequest<IEnumerable<SavedPostResponse>>
    {
        public Guid UserId { get; set; }
        public GetSavedPostsByUserIdQuery(Guid userId)
        {
            UserId = userId;
        }
    }
}
