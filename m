Return-Path: <linux-hyperv+bounces-11536-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ue0kM53jJmrWmQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11536-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 08 Jun 2026 17:45:33 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8EC658438
	for <lists+linux-hyperv@lfdr.de>; Mon, 08 Jun 2026 17:45:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PHZlMNP6;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11536-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11536-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 926BC33EB9C4
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jun 2026 15:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF1141C302;
	Mon,  8 Jun 2026 15:03:58 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BE641C2E1;
	Mon,  8 Jun 2026 15:03:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931038; cv=none; b=khLoqM4B57VUQ3XYHuTPShR3CYdOwe1P835I/FAveQRAUlrLsUfTCUd4jVDkF6/Dbz83OiI/MgBomX5RlNvHKoQXzhE1l+Gi2NaQA9Np9OrVSiF4ZpTALQzaqtZjxb8K+5yNedV8jC1fospYovmp1pXulyQcPsr+5oZCm9vMQPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931038; c=relaxed/simple;
	bh=cvXix1/czz1rnKbxmTdvgvLvm0m2nMPf8k3z2mqbNEY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NdEv5uLFDZ7xD1VORwCTCdtBW7WNnJ/X87wklckoCn68xhN5WlgC15/woeEKp8juQmkcO6QJYt7IRPkhINKWu8vFsKHwF8luGppszPRt5xZaPyX5FHxJ1op+F6FtsFzf6eUupnl7fnWm3BjxoRoBAVkzbDFuG5JbkuR8br4RCW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHZlMNP6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27EA1F00893;
	Mon,  8 Jun 2026 15:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780931037;
	bh=QtHnCUrGvuOBvcaAChp7PbVS1X4Upstaaaa/0mcr1OM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=PHZlMNP6yGxgZtMPzJq9uUsEk1v4WxnBba77qiCAnb/2LMAneFxk2t3MxnzlSqO/n
	 XNSfu3FXXmacXzvcMQFdQCBaaCxSpBU6iX7piFTyCb2MmAcJlXLAg8u9pboHoTu7ti
	 ufW/wliMHA1lcQ+2hCGM61lCYY23MeLUdMH+Wk6gxp4dxI2rfLYdCWIta0sVYdxNdR
	 klceEoij/TEiWEJeo1+P8JokjRNKGszrjLD9VTjNGtOAKw3AuxaSfYuD3tDTpzRZdf
	 JqK+XOOi/dZncgCi78wFztR1WF1eiMdq/qjZmdfmmYkIzP2dg9O6ruVJMjENa58XMy
	 zz3UTg3igTHFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198BC3811A67;
	Mon,  8 Jun 2026 15:03:57 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for v7.1-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260608053408.GA1541576@liuwe-devbox-debian-v2.local>
References: <20260608053408.GA1541576@liuwe-devbox-debian-v2.local>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260608053408.GA1541576@liuwe-devbox-debian-v2.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20260607
X-PR-Tracked-Commit-Id: 98e0fc32e53dd62cd38a0d67eaf5846ae20078cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e92a7628772ba49f3cdc1d141cd2b0b5d607bda2
Message-Id: <178093103560.1528785.10563931039261125990.pr-tracker-bot@kernel.org>
Date: Mon, 08 Jun 2026 15:03:55 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[pr-tracker-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:wei.liu@kernel.org,m:torvalds@linux-foundation.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:decui@microsoft.com,m:longli@microsoft.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11536-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C8EC658438

The pull request you sent on Sun, 7 Jun 2026 22:34:08 -0700:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20260607

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e92a7628772ba49f3cdc1d141cd2b0b5d607bda2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

