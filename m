Return-Path: <linux-hyperv+bounces-3493-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32349F6EBD
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Dec 2024 21:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B20169A4A
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Dec 2024 20:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72931FBEAC;
	Wed, 18 Dec 2024 20:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vnt94Pg1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3BE1FBEB9;
	Wed, 18 Dec 2024 20:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734552667; cv=none; b=eprZlfgDkvj5ldLazPOpZyegvMXyy0a7cOzuH1cA/p6ODF0Slgnf9UvRQWWNB1ix66aHYhYQB9III7xdrVvEggJrzueakHypvdvm9JOQZiP6O2xRYnBM9dqaljaOvk+uDXafOzmdKF+DumYOcnfMkWLohz1x1n49w4gm9ek9PmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734552667; c=relaxed/simple;
	bh=e5GD0DDdXugwsbt8woTcDGpvAaArbJjDKbnwdKXFULk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Y+LGLUnfb0hO+TmK/w0BfV+/9tdD5oqBvhpby3VWXgbwimPgH6BWAxSgHadOlBXzB9sVs1UPRTsUDZ7Jo4Y98+NyJ+7POsbkt1EgVI9AY9eb9EoD4LqaS6vjCxcw+94VZk4yN6zXP0m9EdWWh1clT++72+H29IH0KP0rM3L5Gig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vnt94Pg1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C93C4CECD;
	Wed, 18 Dec 2024 20:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734552667;
	bh=e5GD0DDdXugwsbt8woTcDGpvAaArbJjDKbnwdKXFULk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Vnt94Pg1Dd5bGP3dvJ4bzQJNeBbaQBCfOVKFSC8/Z+rErboT+Oue5uYEZ8h9lXvkX
	 AR5Uh00skT5d6WgWlEX5l7XStUt8RpUzeOU7rbWBXjekkRGGDq6CxbQGnahLx94n8P
	 7eIeXh/BlYsZSv/utyXXSEwRd04M/ZVwIXE76a74qH0yZibFhoIpU6BT8Vy313Cj/8
	 1L3dhhAoPfQsse1Icp41EekKTzgsIVxsggRZVogLt7vA+SQcaSu60Gj7V0Gt/JUPs0
	 Z9xCTG9lpw0gG5s0O+jS6JbA/YJCxzRoHxjsgiO5QqSAUNjgvCTWNg4Caa/KyFYswB
	 x06VZxMfxsi4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1153805DB1;
	Wed, 18 Dec 2024 20:11:25 +0000 (UTC)
Subject: Re: [GIT PULL] Hyperv-fixes for v6.13-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z2HJB0qky91FHC7C@liuwe-devbox-debian-v2>
References: <Z2HJB0qky91FHC7C@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z2HJB0qky91FHC7C@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20241217
X-PR-Tracked-Commit-Id: 175c71c2aceef173ae6d3dceb41edfc2ac0d5937
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 37cb0c76ac6c3bf3d82d25a7c95950f2dac3ca41
Message-Id: <173455268442.1720125.11162183801615803364.pr-tracker-bot@kernel.org>
Date: Wed, 18 Dec 2024 20:11:24 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 17 Dec 2024 18:55:03 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20241217

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/37cb0c76ac6c3bf3d82d25a7c95950f2dac3ca41

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

