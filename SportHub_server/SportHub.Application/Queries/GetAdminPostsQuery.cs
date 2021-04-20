using MediatR;
using SportHub.Application.Responses;
using SportHub.Core.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Queries
{
    public class GetAdminPostsQuery : IRequest<IEnumerable<AdminPostResponse>>
    {
        //public int CategoryId { get; set; }

        //public GetAdminPostsByCategoryIdQuery(int categoryId)
        //{
        //    CategoryId = categoryId;
        //}
    }
}
