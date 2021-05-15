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
    public class GetSavedPostsByUserIdHandler : IRequestHandler<GetSavedPostsByUserIdQuery, IEnumerable<SavedPostResponse>>
    {
        private readonly ISavedPostRepository _savedPostRepository;

        public GetSavedPostsByUserIdHandler(ISavedPostRepository savedPostRepository)
        {
            _savedPostRepository = savedPostRepository;
        }

        public async Task<IEnumerable<SavedPostResponse>> Handle(GetSavedPostsByUserIdQuery request, CancellationToken cancellationToken)
        {
            var savedPosts = await _savedPostRepository.GetSavedPostsByUserIdAsync(request.UserId);
            var savedPostsResponse = SavedPostMapper.Mapper.Map<IEnumerable<SavedPostResponse>>(savedPosts);
            return savedPostsResponse;
        }
    }
}
