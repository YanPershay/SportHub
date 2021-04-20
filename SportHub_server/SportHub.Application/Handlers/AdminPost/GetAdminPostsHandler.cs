using MediatR;
using SportHub.Application.Mappers;
using SportHub.Application.Queries;
using SportHub.Application.Responses;
using SportHub.Core.Repositories;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace SportHub.Application.Handlers
{
    public class GetAdminPostsHandler : IRequestHandler<GetAdminPostsQuery, IEnumerable<AdminPostResponse>>
    {
        private readonly IAdminPostRepository _adminPostRepository;

        public GetAdminPostsHandler(IAdminPostRepository adminPostRepository)
        {
            _adminPostRepository = adminPostRepository;
        }

        public async Task<IEnumerable<AdminPostResponse>> Handle(GetAdminPostsQuery request, CancellationToken cancellationToken)
        {
            var adminPost = await _adminPostRepository.GetAdminPostsAsync();
            var adminPostResponse = AdminPostMapper.Mapper.Map<IEnumerable<AdminPostResponse>>(adminPost);
            return adminPostResponse;
        }
    }
}
