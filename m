Return-Path: <linux-hyperv+bounces-10622-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBaJEp1W+WkK8AIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10622-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 04:31:57 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D90A74C603C
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 04:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C974301FC9B
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 May 2026 02:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09AE3A783D;
	Tue,  5 May 2026 02:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZkcg8/M"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FAC3A6B74;
	Tue,  5 May 2026 02:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777948269; cv=none; b=A68BUjyJJjnmp+/dXTWLwiDXjGN5CAAOhpjAPxOVga7NSnL0AnrM1OUceRxVgUj8WkE3SDTDagxhxftXzVmy/YmjBdgmAW5D8YvB8W7ON14xpEa9Mvt3TnsiV+ZOyfa28Ip9TsVqamjWndFsMK01SJcRgq24fI79zqjhh4e74+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777948269; c=relaxed/simple;
	bh=Z6Gbevj3t94Bn8F2V+JHzP+LoO9va/htSsbzoxc88b8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L3xtR1rX6otpGW9Xq4+JOQsJ82Nhq+0OgivWHtroxz2uuIpS+d21s52fz9DffqMNBgNpIh5xy/oe8DPLcRn5Vki6ss3cDpe/bf045PuJcah1/mW+32nWQP0j0fLAy89MexHNlDJKOSPp30BXzhsZut00c0uGyfTBeCEsqyZ5WnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZkcg8/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDC7C2BCB8;
	Tue,  5 May 2026 02:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777948269;
	bh=Z6Gbevj3t94Bn8F2V+JHzP+LoO9va/htSsbzoxc88b8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZZkcg8/MDq4ggWvXVe5fWN39VF7E10+mkp6SqLE47HP4A7M/lxFUjcBEagN65C7xM
	 L0RIa6NrWQnkEkIJaPstQCErHi7pgHIj4RRE35hhfj/jIoRBDfsxXXDLmTSQyESbTh
	 OrmnTbP463LFLhG1eUYGRonjRGbGuihWvmVq+MXKbDHYMEARfnS6ChhQ/DdYrF6b6b
	 BDxD5ZRM8nt2uiaugL/+6TwfUFevrqyvv70kSjFvfK8Vqkiflhm+6Wh8QjB0FpUH4S
	 FYZ+X80BcnvEcS9N90/zu801SlFAqJcHf1Whmq9ew1u9Lm+u0AFInDEG3nGvwSf+7k
	 sDbpfIl9LZTAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCCB39301A2;
	Tue,  5 May 2026 02:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: mana: hardening: Reject zero
 max_num_queues
 from GDMA_QUERY_MAX_RESOURCES
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177794822004.1394832.4803471358610574659.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 02:30:20 +0000
References: <20260430083627.1873757-1-ernis@linux.microsoft.com>
In-Reply-To: <20260430083627.1873757-1-ernis@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shradhagupta@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, yury.norov@gmail.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: D90A74C603C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-10622-lists,linux-hyperv=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Apr 2026 01:36:21 -0700 you wrote:
> In a CVM environment, hardware responses cannot be trusted. The
> GDMA_QUERY_MAX_RESOURCES command returns resource limits used to
> determine the maximum number of queues.
> 
> In mana_gd_query_max_resources(), gc->max_num_queues is initialized
> from num_online_cpus() and successively clamped by the hardware-reported
> max_eq, max_cq, max_sq, max_rq, and num_msix_usable values. If any of
> these hardware values is zero, gc->max_num_queues becomes zero and the
> function returns success. This leads to a confusing failure later when
> alloc_etherdev_mq() is called with zero queues, returning NULL and
> producing a misleading -ENOMEM error.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: mana: hardening: Reject zero max_num_queues from GDMA_QUERY_MAX_RESOURCES
    https://git.kernel.org/netdev/net-next/c/f7622e58e802

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



