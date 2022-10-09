﻿using GrpcDemo.Service.Data;
using GrpcDemo.Service.Models;

namespace GrpcDemo.Service.Services {
    public class TopicService : ITopicService {
        private readonly ITopicRepo _topicRepo;

        public TopicService(ITopicRepo topic) {
            _topicRepo = topic;
        }

        public async Task<bool> UpdateTopics(IList<Topic>? topics) {
            if (topics == null || topics.Count == 0)
                return false;

            foreach (var topic in topics) {
                await _topicRepo.UpdateTopic(topic.Name, topic.IsActive, topic.Description);
            }
            
            return true;
        }
    }
}
