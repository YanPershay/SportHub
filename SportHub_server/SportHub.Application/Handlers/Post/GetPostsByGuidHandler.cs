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
    class GetPostsByGuidHandler : IRequestHandler<GetPostsByGuidQuery, IEnumerable<PostResponse>>
    {
        private readonly IPostRepository _postRepository;

        public GetPostsByGuidHandler(IPostRepository postRepository)
        {
            _postRepository = postRepository;
        }

        public async Task<IEnumerable<PostResponse>> Handle(GetPostsByGuidQuery request, CancellationToken cancellationToken)
        {
            var post = await _postRepository.GetPostsByGuidAsync(request.UserId);
            var postResponse = PostMapper.Mapper.Map<IEnumerable<PostResponse>>(post);
            return postResponse;
        }
    }
}
