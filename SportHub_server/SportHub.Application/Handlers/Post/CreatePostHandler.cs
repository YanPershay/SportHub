using MediatR;
using SportHub.Application.Commands;
using SportHub.Application.Mappers;
using SportHub.Application.Responses;
using SportHub.Core.Entities;
using SportHub.Core.Repositories;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace SportHub.Application.Handlers
{
    public class CreatePostHandler : IRequestHandler<CreatePostCommand, PostResponse>
    {
        private readonly IPostRepository _postRepository;

        public CreatePostHandler(IPostRepository postRepository)
        {
            _postRepository = postRepository;
        }

        public async Task<PostResponse> Handle(CreatePostCommand request, CancellationToken cancellationToken)
        {
            var postEntity = PostMapper.Mapper.Map<Post>(request);

            if (postEntity is null)
            {
                throw new ApplicationException("There is an issue with mapping");
            }

            var newPost = await _postRepository.AddAsync(postEntity);
            var postResponse = PostMapper.Mapper.Map<PostResponse>(newPost);
            return postResponse;
        }
    }
}
