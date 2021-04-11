using MediatR;
using SportHub.Application.Mappers;
using SportHub.Application.Queries.PostQueries;
using SportHub.Application.Responses;
using SportHub.Core.Repositories;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace SportHub.Application.Handlers
{
    public class GetSavedPostsHandler : IRequestHandler<GetSavedPostsQuery, IEnumerable<PostResponse>>
    {
        private readonly IPostRepository _postRepository;

        public GetSavedPostsHandler(IPostRepository postRepository)
        {
            _postRepository = postRepository;
        }

        public async Task<IEnumerable<PostResponse>> Handle(GetSavedPostsQuery request, CancellationToken cancellationToken)
        {
            var post = await _postRepository.GetSavedPosts(request.UserId);
            var postResponse = PostMapper.Mapper.Map<IEnumerable<PostResponse>>(post);
            return postResponse;
        }
    }
}

