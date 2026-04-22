Return-Path: <linux-hyperv+bounces-10317-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HCqANQx6WndVgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10317-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 22:38:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D22D44AA7B
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 22:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A008C300B19F
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 20:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5298E347BA9;
	Wed, 22 Apr 2026 20:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnKVT1S6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E36B33C502;
	Wed, 22 Apr 2026 20:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776890321; cv=none; b=JDyhnKYEKzwIj3pTnPhl4e2yALW1LpVMohZA5TTDucJ7xn39/DTheDMGFw3Pc1ErSOSEsbbPZq0xKZpEx+jZDyhDNgkI7Yp5GPECWmpvJSwrPuYavYPI4yF7nXffqLtx+uI1CiKW5T/jo4Zz3s4pNAkEkYkpt8wm7wi5cyjSDY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776890321; c=relaxed/simple;
	bh=xQurz2Xvezo0AomERFrCJsXM1shY44l+I/2QOjVwsKA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IHJtXbAy/fPQ2ZBrFMnYBhPYna0f9OSwJKHWK+MCt4/v3hMTjbFfkmi2u8frF09psFIiK+Hp0B2/exKG5fEbAG3GSf66aVz8z9JvljZ4+l/8zxkhUQ3inzcA4sYGPNDqOTgzf4Sw+fU5Y+dwfJlQxlGDi8PgHLURV7RntFyTHm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnKVT1S6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C075C19425;
	Wed, 22 Apr 2026 20:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776890321;
	bh=xQurz2Xvezo0AomERFrCJsXM1shY44l+I/2QOjVwsKA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MnKVT1S6fmVMAWI330zgXko+1QFdxiqraxDq8j2HaPBSX7WS/NL6PTmjQ1yzo0lFF
	 S3DQ2IvPk8FH+r2hGU4D/OyS5TlhaBbB0NdT6znbipFFKyfDk3800LROIJb2M/Zcu2
	 YOZEzm8R9UyIlZiLArkQUE7F0gMdo1zhnVRYoj6Ov2/lepMHh1NvJlG/uKc0qJ2bca
	 kk5caOOmxv4JNcoAl/hxCz4uXg6isJw4scX+uqrOtQX4tXnHkHxaSRxDcDq8syupCn
	 WXjWqghk6LoLwEHMBSs2PgEgtM5Fuu8ctcg8SBomotnXC29jEbhs6Yqh3SKTp6lFVk
	 jAp0JhWmw8irg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0513809A84;
	Wed, 22 Apr 2026 20:38:04 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V next for v7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260422064824.GC805420@liuwe-devbox-debian-v2.local>
References: <20260422064824.GC805420@liuwe-devbox-debian-v2.local>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260422064824.GC805420@liuwe-devbox-debian-v2.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20260421
X-PR-Tracked-Commit-Id: 5170a82e89211d876af17bf3d94a511fb2bb4921
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8fd12b03c7c888303c3c45559d8c3e270a916f9f
Message-Id: <177689028316.4027770.934602851877617668.pr-tracker-bot@kernel.org>
Date: Wed, 22 Apr 2026 20:38:03 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-10317-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D22D44AA7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pull request you sent on Wed, 22 Apr 2026 06:48:24 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20260421

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8fd12b03c7c888303c3c45559d8c3e270a916f9f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

