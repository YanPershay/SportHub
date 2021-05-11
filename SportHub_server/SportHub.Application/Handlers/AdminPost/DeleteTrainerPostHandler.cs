using MediatR;
using SportHub.Application.Commands;
using SportHub.Core.Repositories;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace SportHub.Application.Handlers
{
    public class DeleteTrainerPostHandler : IRequestHandler<DeleteTrainerPostCommand, int>
    {
        private readonly IAdminPostRepository _postRepository;

        public DeleteTrainerPostHandler(IAdminPostRepository postRepository)
        {
            _postRepository = postRepository;
        }

        public async Task<int> Handle(DeleteTrainerPostCommand request, CancellationToken cancellationToken)
        {
            var post = await _postRepository.GetByIdAsync(request.Id);

            await _postRepository.DeleteAsync(post);
            return post.Id;
        }
    }
}
