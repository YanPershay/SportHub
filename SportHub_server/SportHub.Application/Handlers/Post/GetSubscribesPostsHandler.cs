using MediatR;
using SportHub.Application.Mappers;
using SportHub.Application.Queries;
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
    public class GetSubscribesPostsHandler : IRequestHandler<GetSubscribesPostsQuery, IEnumerable<PostResponse>>
    {
        private readonly IPostRepository _postRepository;

        public GetSubscribesPostsHandler(IPostRepository postRepository)
        {
            _postRepository = postRepository;
        }

        public async Task<IEnumerable<PostResponse>> Handle(GetSubscribesPostsQuery request, CancellationToken cancellationToken)
        {
            var post = await _postRepository.GetSubscribesPosts(request.SubscriberId);
            var postResponse = PostMapper.Mapper.Map<IEnumerable<PostResponse>>(post);
            return postResponse;
        }
    }
}
