Return-Path: <linux-hyperv+bounces-10054-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uE9SKIFa1Wmu4wcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10054-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 21:26:57 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCD13B387E
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 21:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D7F130166EB
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Apr 2026 19:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794563502A4;
	Tue,  7 Apr 2026 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFfE64ai"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BA8337689;
	Tue,  7 Apr 2026 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775590014; cv=none; b=I96HDdgBhxgfjWMuN2aoIl54l4YNwJ/PV2ks4kgP2GzYiclvYg92QbIOCHec1so3rmgCF2PT50Uoc7N5Ei9lSVdTD+1HgII6j+N2JFdvXjLH0pgP1AMFxvs3TCldcYwUHcLLxWikjGf4/A9DrXRaAoEBWDAOaOG3dnOiWzYYQl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775590014; c=relaxed/simple;
	bh=29+kv6bNhQdKNN629r/WX5Ax9ry9io6/4MTSqvzn+uk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IMdXv4Cmy9InWCzL9pirX46D9o/rqA0ZFMTmUBG/pH2LSjDZCRb5f8EnxSQFETKHaD6LnFxFcCSMbmHkjNf/RZNc24JdRkZoQSoDlvFhVBcCJdn4OY8IvopTEqYwKrs4DpuU3yh2SjxYahWPl8YlAU2et6WR8/iEVZDVZgeLyRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFfE64ai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87B4C116C6;
	Tue,  7 Apr 2026 19:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775590013;
	bh=29+kv6bNhQdKNN629r/WX5Ax9ry9io6/4MTSqvzn+uk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gFfE64aiaMnaUrVzuNfJTjwy0agsO7NNJaryvFpKzZaGFCWuSzTm1PR2zc5jFSA/h
	 BiZCfkZwqGopi8uYZDvsb+Fp2Mq5yzRPw+ywKBnebuW379z48tHTC2OK9D4RX60Tw8
	 6ee0wV2LaJXL2W38OnNdz+3cZma784+fYmo2jCWqo8mWqum7ECwrN7eAncmSVFqhg6
	 Son81xtHVUyqfkKq5apHwk+RLlivIUOkW+j75vxphoB4chhIi/j3J9Mxz6TWIQWgo5
	 QGbOac3vbV0RlIpd4XK5Y3RnQ2zx4HRm85O6VZsGYVtwR49eJgIA1zTE5vVxhsFxl6
	 gn+9qmdQpqnAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E923809A33;
	Tue,  7 Apr 2026 19:26:32 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for v7.0-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260407042912.GA1012143@liuwe-devbox-debian-v2.local>
References: <20260407042912.GA1012143@liuwe-devbox-debian-v2.local>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260407042912.GA1012143@liuwe-devbox-debian-v2.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20260406
X-PR-Tracked-Commit-Id: 16cbec24897624051b324aa3a85859c38ca65fde
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86782c16a81f8232c13c1509fd3295bd97d185b0
Message-Id: <177558999132.4123438.13950912378483414697.pr-tracker-bot@kernel.org>
Date: Tue, 07 Apr 2026 19:26:31 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-10054-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4BCD13B387E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pull request you sent on Tue, 7 Apr 2026 04:29:12 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20260406

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86782c16a81f8232c13c1509fd3295bd97d185b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

