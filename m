Return-Path: <linux-hyperv+bounces-5195-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F68A9F5E1
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 18:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF569189C8FC
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 16:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F11427A10D;
	Mon, 28 Apr 2025 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzaVzzna"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED22E26FDBF;
	Mon, 28 Apr 2025 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745858015; cv=none; b=MdCeid0rZSLREokmbNAeaKH7qLJQFlCoKnZgP54v7vr611KgYQyp7kBvrvnwjcgDBjuWlaNwqALpGB2cXC/aV1KqXl7s4Fc98HqHRZZCgNxX5dzvoq5jw/yLD8imH7DyDxzpNni0ucJaHRnACHNKXCHTJEonrWJeje/kxbzmSLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745858015; c=relaxed/simple;
	bh=0OQyZTBfZAdphj3zSgM3pWl1cgwjdoODniA19+AUH90=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QDc+RbMrTFdGZijZC9qLSxrLWl1n63ywrzfjif0iY2KuZ22P+IsWX6HvGvvjkIjhfyuOIXuOSiTBLNv0wUKfdCS/L2aLNTE/m3xiewi276a+QoG4/CZB4dopekuA0m1bZlLT7dYFFhaFwFUCnJ8ONuYJlfnPrrHSwwI8V9dc5Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzaVzzna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DE9C4CEE4;
	Mon, 28 Apr 2025 16:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745858014;
	bh=0OQyZTBfZAdphj3zSgM3pWl1cgwjdoODniA19+AUH90=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IzaVzznakT66Igm0KXpb0HL7IOUF831e9ab7m8orTBP5iKgxIXxhG8+l/ibHuGK8m
	 7ogIz9DJkqIV6YYuGGqA47duuMQLxegnmuwsi+C41HLbCTmJGW6lJkeELqlzPnBjEQ
	 s41mppicYjxurmTYa5VW5wLmVTV8xtltw4U3Dm0mNyHd++gLSiXWjf+2o4kq18WnN2
	 jxD9xsLhvxBWJ+Vy6hrpQKPmRD7YDyjqAvQnZdk2ZOHhVw2jD199A7JRQlBWcAdS+i
	 VQPqNbQDGPZ7uRxCX6kfAdab5Ggv39a0+PuZddX5IUJcCNX4+zCiIH7C15pkLEakcb
	 j1bH8BxERdWFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711F93822D43;
	Mon, 28 Apr 2025 16:34:14 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 6.15-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <aA7PT_nDBiIk27w7@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <aA7PT_nDBiIk27w7@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <aA7PT_nDBiIk27w7@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20250427
X-PR-Tracked-Commit-Id: 14ae3003e73e777c9b36385a7c86f754b50a1821
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b94f88da544d7ace96a9e6b3522283b82ad310e8
Message-Id: <174585805302.971006.7345397060226536120.pr-tracker-bot@kernel.org>
Date: Mon, 28 Apr 2025 16:34:13 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Apr 2025 00:43:59 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20250427

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b94f88da544d7ace96a9e6b3522283b82ad310e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

