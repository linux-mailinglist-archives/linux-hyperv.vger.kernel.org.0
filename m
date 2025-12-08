Return-Path: <linux-hyperv+bounces-7994-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FE1CAE43A
	for <lists+linux-hyperv@lfdr.de>; Mon, 08 Dec 2025 22:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A57073050CD9
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Dec 2025 21:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500AF2D9ED1;
	Mon,  8 Dec 2025 21:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDpvi1Tx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239EC1B983F;
	Mon,  8 Dec 2025 21:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765231161; cv=none; b=R2x/KqKQdt1wykssBa13gjl8RSReRr7xN/vy5wuKyfMocMopDim6SsSMJDIsVfCPw6bU5w9L4Ee0P/JZ7Zbq1WcAczDVP7ALUzCibiixb9tjeaDA5SYIc8r0zQaISd8IunhgTTPospBdR6qFb6jSruyXxKExHHivu+lUh5ghyH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765231161; c=relaxed/simple;
	bh=wUOFcUpSBXwVGQNrfQ5G0gwhw4cq/UHqH1doxXverrw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tOJQOEUBUA8ANARVBZeR24E59jOeCVX9i1SHJhP2yoK2wrWXLUyFZEZvMzpm5N5x8VYbTuZ0nqiQyAJH5n1XzHCWmRQzyrcGoQA+kSGS9mDPn2mIaHltMGlsgcJlCDmuXYtJHNgBHNLdLUFmSnkkKmempd2yHXJIiUJfYWfFJAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDpvi1Tx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EE6C4CEF1;
	Mon,  8 Dec 2025 21:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765231161;
	bh=wUOFcUpSBXwVGQNrfQ5G0gwhw4cq/UHqH1doxXverrw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hDpvi1TxI0xgG9WiQIb3qm+/nTnc7X1SxwGCzgWgLsRwaJ88vMiSWpoNXKL1aZuPk
	 cmBQfu2MTqpQcjO12OzIznhYq/XjX1ACB6P8CpUkhBHoqVak9ckSAr+w2W3bkDlpst
	 inM8aFgOPcFWnNU+b1pS7oYztPHPl5JDz++6Pp3ygjP2oa7F1XMUkhnqxH402GN96i
	 7g9LTyWY5ZSUXRNhdkIPJUN8I4yacu16trP/z9ompvwVwvaGkJkQyEa8zSPIVfZqa0
	 u+4uoIz9ag1Ul2H3XEYTVRZdy65YaVVFXA3iyc58bd7zs2yqT2uVj+9lmPVCjOIJed
	 /A2W2/KIv/N3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5BFF3808200;
	Mon,  8 Dec 2025 21:56:17 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V patches for 6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251208064614.GA2485915@liuwe-devbox-debian-v2.local>
References: <20251208064614.GA2485915@liuwe-devbox-debian-v2.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251208064614.GA2485915@liuwe-devbox-debian-v2.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20251207
X-PR-Tracked-Commit-Id: 615a6e7d83f958e7ef3bc818e818f7c6433b4c2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: feb06d2690bb826fd33798a99ce5cff8d07b38f9
Message-Id: <176523097640.3308012.7244721510602033130.pr-tracker-bot@kernel.org>
Date: Mon, 08 Dec 2025 21:56:16 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Dec 2025 06:46:14 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20251207

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/feb06d2690bb826fd33798a99ce5cff8d07b38f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

