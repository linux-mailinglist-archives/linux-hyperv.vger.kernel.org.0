Return-Path: <linux-hyperv+bounces-11651-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ys7KAUxlOWpNrgcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11651-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jun 2026 18:39:40 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D666B12F1
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jun 2026 18:39:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kqGBmWD9;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11651-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11651-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2AC2304B541
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jun 2026 16:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BD033B6E3;
	Mon, 22 Jun 2026 16:36:43 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2998933A9CF;
	Mon, 22 Jun 2026 16:36:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146203; cv=none; b=UsBW5fxrKSh8WgiF2Y4eNmx/jEQzPUFQcXC/KcqgypeVMGRzKs/dWvbEkMGkTJ6SCDEh/PABDfCUHSPXF1GZkmpJfsDXCDc23+UNZMDtvjfJhPebcWZ1X9OjdUJp1aShwUJbQTOjJnh8zIfhXUK9a2yEPmAgK5ABCTu6uSi7pUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146203; c=relaxed/simple;
	bh=NWyY1R7RKyzQvPmtlMxYv6ZUPEFgvPpc5B1Ze5RtF0o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fdKTbsl7KxighfQdnfGEVT0EINCONMI/phBWSEUjA1UaWCaY6rtskRGOr8+zQ/OlcXwe3Txnb/C82rBV/zNMpzM4EcD1vW2VslJkE9AB56dJ3pbFDkxLy/O/0R5tKxKu60stuONYgeGRURB1YlWFTAYWayTnRtvzj7eYjTRTzFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqGBmWD9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085151F000E9;
	Mon, 22 Jun 2026 16:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782146202;
	bh=wqStrO37Yvo01QvBb9ZJsm0H8Qof2xASnIQrlNFRE+c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=kqGBmWD90FYSVQKiuUlxByJ+qaTAb6uuMT6TeMGVdilQ9zIK1GWE1dLbxkMARBTl5
	 qqJver7lleXA6XSZivRF0c7UVWTwfk9kLOTh4yAE5+MWPRWCqBxpVz6jiGsLI2mLS0
	 WM5LeuutG9i7NrZtXyTYk0KvobnDab8jJ99lSj08J52YY6bHB4R5gVtcunQFOxF7Zy
	 zlfuDXrqt1lT2PpNOYMGV+qSnQmlCqPJcm/YYXO6D+bLQzdIdYozpADsP7/y+5O56w
	 mFc90kAajA8lc0HB0WSFxQz4SZB43FPvgyh/Amsg9zVicwi3Ep6eZTb+W5ak6M6KEo
	 iPO3LTDtjMTsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C733930907;
	Mon, 22 Jun 2026 16:36:33 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V patches for v7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260622064549.GA2852659@liuwe-devbox-debian-v2.local>
References: <20260622064549.GA2852659@liuwe-devbox-debian-v2.local>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260622064549.GA2852659@liuwe-devbox-debian-v2.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20260621
X-PR-Tracked-Commit-Id: a4ffc59238be84dd1c26bf1c001543e832674fc6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e869de3a1b9ef9f096223e0e7f30c727de4f6bc
Message-Id: <178214619241.1310507.16461535384209779931.pr-tracker-bot@kernel.org>
Date: Mon, 22 Jun 2026 16:36:32 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11651-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:wei.liu@kernel.org,m:torvalds@linux-foundation.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:decui@microsoft.com,m:longli@microsoft.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pr-tracker-bot@kernel.org,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-hyperv@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73D666B12F1

The pull request you sent on Sun, 21 Jun 2026 23:45:49 -0700:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20260621

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e869de3a1b9ef9f096223e0e7f30c727de4f6bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

