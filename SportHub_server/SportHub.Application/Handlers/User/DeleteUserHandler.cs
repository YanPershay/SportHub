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
    public class DeleteUserHandler : IRequestHandler<DeleteUserCommand, bool>
    {
        private readonly IUserRepository _userRepository;
        private readonly IPostRepository _postRepository;

        public DeleteUserHandler(IUserRepository userRepository, IPostRepository postRepository)
        {
            _userRepository = userRepository;
            _postRepository = postRepository;
        }

        public async Task<bool> Handle(DeleteUserCommand request, CancellationToken cancellationToken)
        {
            //var userPosts = await _postRepository.GetPostsByGuidAsync(request.UserId);
            //foreach(var post in userPosts)
            //{
            //    await _postRepository.DeleteAsync(post);
            //}

            var user = await _userRepository.GetUserByGuidAsync(request.UserId);

            await _userRepository.DeleteAsync(user);
            return true;
        }
    }
}
