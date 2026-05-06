Return-Path: <linux-hyperv+bounces-10641-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KELwJwSo+mlbRAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-10641-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 06 May 2026 04:31:32 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFB34D5AE1
	for <lists+linux-hyperv@lfdr.de>; Wed, 06 May 2026 04:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3CF14301B04B
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 May 2026 02:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F8D2D46B3;
	Wed,  6 May 2026 02:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qhg85Uzs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5FF2C11FD;
	Wed,  6 May 2026 02:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778034683; cv=none; b=D5sDq89GJ4O26Bhkr/ouXNWYOCMjA99AAPh2O22p05FYc6ZohnzyJHKn+7Lr3KJfw+GPK9RvCD5a8PXjZX5ryX85SjVd37XNXLLZvGMm2+HbC5L/mUffvbTfjIltGAnXzTY2Tn6aF4pQRxrGfRA9UrNXHzZt0/2G7zyFpcmKZRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778034683; c=relaxed/simple;
	bh=kL7gjYEt+3pamSHe4Z8BP9Yb1oQFZ0WCVB+SU02m5p4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R/smYd0OMvSsSmL6/7xkQVJHR9NY9BWT4Vv4oVVPKuhJdnbwL+oPFL+aKBulZVzRBs0UJKc8ovZRvnSsGM3qw/ElCmszxwALilOB91YXKUbwwS9wi/1M42YAtCE04ln+7TQjsagSQAUACRqLwIOV2buJcGB3Re4yoQa6iq54ugY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qhg85Uzs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285B5C2BCB4;
	Wed,  6 May 2026 02:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778034683;
	bh=kL7gjYEt+3pamSHe4Z8BP9Yb1oQFZ0WCVB+SU02m5p4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qhg85UzsjUnFYVUa5dH5iPIC+mXntIm0WUlsqPHBjM8Vn9xvbILWXS7C5aZPt+o5i
	 D1tvVEVtPLUTE15Q1MVE5UfFKFc3EgtEktk8i7y3vaVVeDdPwYqJM+r3bF5SKStFIq
	 SPHT8xmqJuJ88aJTOk20DOiiuOi+AYtg18wj89PwXIerDXrF+3dLdDR0xzcFD3b1Lm
	 KjPqhGmWB29H17+iVx/4aWBvSlLTmtFpOds3yUsY7q7jXLVbjWXcjaDjLN3yBaJlpe
	 c7ovrRyhX+kEuSzdf0O9nHXPkIc0eBT7yo7e3XE45a2jAJqFzsVMxOR7Dxd185f+ho
	 a77yqCUxvJbGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF703930780;
	Wed,  6 May 2026 02:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] net: mana: Avoid queue struct allocation
 failure under memory fragmentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177803463304.2357425.6242248508065592109.git-patchwork-notify@kernel.org>
Date: Wed, 06 May 2026 02:30:33 +0000
References: <20260502074552.23857-1-gargaditya@linux.microsoft.com>
In-Reply-To: <20260502074552.23857-1-gargaditya@linux.microsoft.com>
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kotaranov@microsoft.com, horms@kernel.org, ssengar@linux.microsoft.com,
 jacob.e.keller@intel.com, dipayanroy@linux.microsoft.com,
 ernis@linux.microsoft.com, shirazsaleem@microsoft.com, kees@kernel.org,
 sbhatta@marvell.com, leitao@debian.org, netdev@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, gargaditya@microsoft.com
X-Rspamd-Queue-Id: 9EFB34D5AE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-10641-lists,linux-hyperv=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	RCPT_COUNT_TWELVE(0.00)[27];
	TO_DN_SOME(0.00)[]

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  2 May 2026 00:45:32 -0700 you wrote:
> The MANA driver can fail to load on systems with high memory
> utilization because several allocations in the queue setup paths
> require large physically contiguous blocks via kmalloc. Under memory
> fragmentation these high-order allocations may fail, preventing the
> driver from creating queues when opening the interface or when
> reconfiguring channels, ring parameters or MTU at runtime.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: mana: Use per-queue allocation for tx_qp to reduce allocation size
    https://git.kernel.org/netdev/net-next/c/d07efe5a6e64
  - [net-next,v3,2/2] net: mana: Use kvmalloc for large RX queue and buffer allocations
    https://git.kernel.org/netdev/net-next/c/3af0820c878e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



