Return-Path: <linux-hyperv+bounces-8450-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPKYJ9q8cWkmLwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8450-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 06:59:54 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05948621C5
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 06:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F6E64E74B6
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 05:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA03B4657E0;
	Thu, 22 Jan 2026 05:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBJ8TE/+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679874657C9;
	Thu, 22 Jan 2026 05:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769061576; cv=none; b=TWwYgg39BEwyZ6lXOgHSrsJnE+v7o3MFv39ycWxxYy+BeNKwffqoh3dZxT6JYIAK4gTp7UCH8Ukbm7gFnKofePd27V2qHAQ3oieWzCVkfM7Z6PRcWfArADIvRNiejFnhxKFJAT4C/sBFNyHZVDRb9xIi/x3oHq2O//uDXVBYY1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769061576; c=relaxed/simple;
	bh=Sj2qcQe62QNNaf8jtUZGFM/lIN46yvYlOrJY6LyF6x8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TMQAGq1RG8SOFCeBP000n0/zJV3UD/S4e6gb0fwVGjENBMt+iQiyl3+RwllIM9BG3tQS6v7ccO7n3x4bOLBxrneEBM3yoIUfJOhP58U1BHXvqwHKSD9g+A7VuX19usRTULuqRLDZfeIwDn60mFJ31JttFjhL9r2EWsnVUheDebg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBJ8TE/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F58C116C6;
	Thu, 22 Jan 2026 05:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769061575;
	bh=Sj2qcQe62QNNaf8jtUZGFM/lIN46yvYlOrJY6LyF6x8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cBJ8TE/+/X/fDxGoQMpC3rc1tjfBPDSBBgiz+Hk7tlnRUFC8fEnj4AYLynW6UbOQk
	 SB4Y4ba1f9jAvX6dTqlKvfYKWz6CdPWAWMTBSXT/yCZlks0OCxKA1gcGFOOmbMjuF5
	 CZ5ZOX7+118q9wInBDX3Iq6XZ3eQBGWq2JZyPnVQHwzUvzvXG2j57qWkXttpOxs599
	 gAhdlE9mYiC4o1nT8lVrh2HciR91ev/YTPOE07gTKJLhsTK63eTQNgTqT0Svr/cGXC
	 2YUauvYb5lTuAeJPYTSA7mu2ImWTyvcNkklScugp9/LF/KV/htjyqG2leX7h34iBLB
	 ip44EpF1A9jgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BCFC3808200;
	Thu, 22 Jan 2026 05:59:33 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for v6.19-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260122050548.GA909211@liuwe-devbox-debian-v2.local>
References: <20260122050548.GA909211@liuwe-devbox-debian-v2.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260122050548.GA909211@liuwe-devbox-debian-v2.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20260121
X-PR-Tracked-Commit-Id: 12ffd561d2de28825f39e15e8d22346d26b09688
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a66191c590b3b58eaff05d2277971f854772bd5b
Message-Id: <176906157215.1573610.3051222599221291230.pr-tracker-bot@kernel.org>
Date: Thu, 22 Jan 2026 05:59:32 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-8450-lists,linux-hyperv=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 05948621C5
X-Rspamd-Action: no action

The pull request you sent on Thu, 22 Jan 2026 05:05:48 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20260121

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a66191c590b3b58eaff05d2277971f854772bd5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

