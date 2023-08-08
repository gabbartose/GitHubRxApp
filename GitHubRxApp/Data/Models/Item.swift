//
//  Item.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

// GitHub API info:
/*
 // URL: https://api.github.com/search/repositories?q={query}{&page,per_page,sort,order}
 
 JSON response:
 {
    "id": 207645083,
    "node_id": "MDEwOlJlcG9zaXRvcnkyMDc2NDUwODM=",
    "name": "query",
    "full_name": "TanStack/query",
    "private": false,
    "owner": {
        "login": "TanStack",
        "id": 72518640,
        "node_id": "MDEyOk9yZ2FuaXphdGlvbjcyNTE4NjQw",
        "avatar_url": "https://avatars.githubusercontent.com/u/72518640?v=4",
        "gravatar_id": "",
        "url": "https://api.github.com/users/TanStack",
        "html_url": "https://github.com/TanStack",
        "followers_url": "https://api.github.com/users/TanStack/followers",
        "following_url": "https://api.github.com/users/TanStack/following{/other_user}",
        "gists_url": "https://api.github.com/users/TanStack/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/TanStack/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/TanStack/subscriptions",
        "organizations_url": "https://api.github.com/users/TanStack/orgs",
        "repos_url": "https://api.github.com/users/TanStack/repos",
        "events_url": "https://api.github.com/users/TanStack/events{/privacy}",
        "received_events_url": "https://api.github.com/users/TanStack/received_events",
        "type": "Organization",
        "site_admin": false
    },
    "html_url": "https://github.com/TanStack/query",
    "description": "🤖 Powerful asynchronous state management, server-state utilities and data fetching for the web. TS/JS, React Query, Solid Query, Svelte Query and Vue Query.",
    "fork": false,
    "url": "https://api.github.com/repos/TanStack/query",
    "forks_url": "https://api.github.com/repos/TanStack/query/forks",
    "keys_url": "https://api.github.com/repos/TanStack/query/keys{/key_id}",
    "collaborators_url": "https://api.github.com/repos/TanStack/query/collaborators{/collaborator}",
    "teams_url": "https://api.github.com/repos/TanStack/query/teams",
    "hooks_url": "https://api.github.com/repos/TanStack/query/hooks",
    "issue_events_url": "https://api.github.com/repos/TanStack/query/issues/events{/number}",
    "events_url": "https://api.github.com/repos/TanStack/query/events",
    "assignees_url": "https://api.github.com/repos/TanStack/query/assignees{/user}",
    "branches_url": "https://api.github.com/repos/TanStack/query/branches{/branch}",
    "tags_url": "https://api.github.com/repos/TanStack/query/tags",
    "blobs_url": "https://api.github.com/repos/TanStack/query/git/blobs{/sha}",
    "git_tags_url": "https://api.github.com/repos/TanStack/query/git/tags{/sha}",
    "git_refs_url": "https://api.github.com/repos/TanStack/query/git/refs{/sha}",
    "trees_url": "https://api.github.com/repos/TanStack/query/git/trees{/sha}",
    "statuses_url": "https://api.github.com/repos/TanStack/query/statuses/{sha}",
    "languages_url": "https://api.github.com/repos/TanStack/query/languages",
    "stargazers_url": "https://api.github.com/repos/TanStack/query/stargazers",
    "contributors_url": "https://api.github.com/repos/TanStack/query/contributors",
    "subscribers_url": "https://api.github.com/repos/TanStack/query/subscribers",
    "subscription_url": "https://api.github.com/repos/TanStack/query/subscription",
    "commits_url": "https://api.github.com/repos/TanStack/query/commits{/sha}",
    "git_commits_url": "https://api.github.com/repos/TanStack/query/git/commits{/sha}",
    "comments_url": "https://api.github.com/repos/TanStack/query/comments{/number}",
    "issue_comment_url": "https://api.github.com/repos/TanStack/query/issues/comments{/number}",
    "contents_url": "https://api.github.com/repos/TanStack/query/contents/{+path}",
    "compare_url": "https://api.github.com/repos/TanStack/query/compare/{base}...{head}",
    "merges_url": "https://api.github.com/repos/TanStack/query/merges",
    "archive_url": "https://api.github.com/repos/TanStack/query/{archive_format}{/ref}",
    "downloads_url": "https://api.github.com/repos/TanStack/query/downloads",
    "issues_url": "https://api.github.com/repos/TanStack/query/issues{/number}",
    "pulls_url": "https://api.github.com/repos/TanStack/query/pulls{/number}",
    "milestones_url": "https://api.github.com/repos/TanStack/query/milestones{/number}",
    "notifications_url": "https://api.github.com/repos/TanStack/query/notifications{?since,all,participating}",
    "labels_url": "https://api.github.com/repos/TanStack/query/labels{/name}",
    "releases_url": "https://api.github.com/repos/TanStack/query/releases{/id}",
    "deployments_url": "https://api.github.com/repos/TanStack/query/deployments",
    "created_at": "2019-09-10T19:23:58Z",
    "updated_at": "2023-08-04T05:07:52Z",
    "pushed_at": "2023-08-03T20:41:48Z",
    "git_url": "git://github.com/TanStack/query.git",
    "ssh_url": "git@github.com:TanStack/query.git",
    "clone_url": "https://github.com/TanStack/query.git",
    "svn_url": "https://github.com/TanStack/query",
    "homepage": "https://tanstack.com/query",
    "size": 36939,
    "stargazers_count": 35718,
    "watchers_count": 35718,
    "language": "TypeScript",
    "has_issues": true,
    "has_projects": true,
    "has_downloads": true,
    "has_wiki": false,
    "has_pages": false,
    "has_discussions": true,
    "forks_count": 2329,
    "mirror_url": null,
    "archived": false,
    "disabled": false,
    "open_issues_count": 42,
    "license": {
    "key": "mit",
    "name": "MIT License",
    "spdx_id": "MIT",
    "url": "https://api.github.com/licenses/mit",
    "node_id": "MDc6TGljZW5zZTEz"
    },
    "allow_forking": true,
    "is_template": false,
    "web_commit_signoff_required": false,
    "topics": [
    "async",
    "cache",
    "data",
    "fetch",
    "graphql",
    "hooks",
    "query",
    "react",
    "rest",
    "stale",
    "stale-while-revalidate",
    "update"
    ],
    "visibility": "public",
    "forks": 2329,
    "open_issues": 42,
    "watchers": 35718,
    "default_branch": "main",
    "score": 1.0
 },
 
 */

import Foundation

struct Item: Codable, Equatable {
    let id: Int?
    let name: String?
    let owner: Owner?
    let watchersCount: Int?
    let forksCount: Int?
    let stargazersCount: Int?
    let openIssues: Int?
    let language: String?
    let createdAt: String?
    let updatedAt: String?
    let htmlUrl: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, owner, language, description
        case watchersCount = "watchers_count"
        case forksCount = "forks_count"
        case stargazersCount = "stargazers_count"
        case openIssues = "open_issues_count"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case htmlUrl = "html_url"
    }
}