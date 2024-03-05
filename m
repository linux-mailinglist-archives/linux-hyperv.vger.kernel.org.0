Return-Path: <linux-hyperv+bounces-1665-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E0F872962
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Mar 2024 22:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F1B1C21604
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Mar 2024 21:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B9812BEA3;
	Tue,  5 Mar 2024 21:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3O5xtc1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA5714288;
	Tue,  5 Mar 2024 21:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673928; cv=none; b=Gp2LaP28QG6gzrzqQ8L5Pid3o3xnlqVlqrOS7CkiEyu4mFl+5yq6LGSra+5lzcKFSD/BAWD/nxvs03koI3Ou7N0BlDp4h144PrJYQmxnBub9+iIjczDinf85GKZPWDHYlsKsHpZi2jMxgLBaJGIcSJwZyuOE1dXMX5kj+PXgQHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673928; c=relaxed/simple;
	bh=5l4tWT53ies4wGRoqAxWXq49y6ped3trbZ8tAIN7W50=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JyBKz5FB38cqRv+8fbYcDoeg4cBRp+FgERxK7IoQ2yRv1oGIVpmx6+F9sQsFw7D5pTUCVirLNEnQlsIOq+zekLZYK8N2yWisgn8rsJheE22UDEQ68z6/x6pn/cRQ2nkskH2TcG2DgVoLbZzbscIcEMwc2FehiY/RNWLbUYP8O60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3O5xtc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B7E8C433F1;
	Tue,  5 Mar 2024 21:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709673928;
	bh=5l4tWT53ies4wGRoqAxWXq49y6ped3trbZ8tAIN7W50=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=f3O5xtc1+wtTkpFIimJzJ0yBYyXSk7ZV6wTNhI6UUrFhWmjxa9atNiuMOcADOcs03
	 Sg6YdEXBk0nB50R+L6dIpdKFnJHQCAJiVqvTfevwNXpyL+uWm7tjknJKBfuyiIr56d
	 q8AUC8G26uviQmq+RkZmv0cGgPeYFEQXUqs+YZe5mySZWrRNWz1WSpfvQXi/8kijS9
	 p48Dk7q87SLhB0BqsLKPijAZJ9M7NqcTXWaVwvsy90fYNcnkeL+1C7bTLYG/o6Yl/8
	 r68U0w0MF2ungyaWWeM5LW2Yu5VaycBuHeiB9OOBFAlbhrbMDajf8GJYS8oluIaJCY
	 b374M+9VRCT5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3DD36C04D3F;
	Tue,  5 Mar 2024 21:25:28 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 6.8-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZeVojbuNPk3SMDIn@liuwe-devbox-debian-v2>
References: <ZeVojbuNPk3SMDIn@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZeVojbuNPk3SMDIn@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20240303
X-PR-Tracked-Commit-Id: aa707b615ce1551c25c5a3500cca2cf620e36b12
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c46d04a0dae3fcb8d6505de0091499b626cdb35
Message-Id: <170967392824.2988.13713279414300555504.pr-tracker-bot@kernel.org>
Date: Tue, 05 Mar 2024 21:25:28 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 4 Mar 2024 06:22:05 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20240303

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c46d04a0dae3fcb8d6505de0091499b626cdb35

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

