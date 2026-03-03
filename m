Return-Path: <linux-hyperv+bounces-9105-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COYuEDG4pmk7TAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9105-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 11:30:09 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFB61ECAC2
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 11:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03306301DD84
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Mar 2026 10:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7789539B975;
	Tue,  3 Mar 2026 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zp4hDVu4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DF239B964;
	Tue,  3 Mar 2026 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772533804; cv=none; b=hhf9ZtXQOPiDGmGXOn6zMe09FICjA8s5tKu8FYVrslMDTrle5OHvqUG9CD91ZPsCOcKPpR2EG9vs+hZ8usItpPUy4aPBzfBTckWLgjOpGSNQwwA+PGJjU3sDS9BTKvKSe9Kx8tkASRC39B0d2VQ1Zd0AGFKmd7Yr64MY85ILQrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772533804; c=relaxed/simple;
	bh=GaDJnvf4eHmmDEHwX/7rXkKBrLrxQ/AIs2w/z/b1Lwo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pGd5hWMzoNQq+sFuV9VmbF44XrR7Suj7rrg7F45uL6prQgNzktn8YlTHhQCudLvWkXesg4PEiEec9jwf1D9irabISueZOqbOg6O3XAIEsbObfOeu4CebopQgjLl4hupND3c6U9sXJyJQeU0ZLVnV/5uZiXBgk7heIHZ9pwSlsYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zp4hDVu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D078FC2BC87;
	Tue,  3 Mar 2026 10:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772533803;
	bh=GaDJnvf4eHmmDEHwX/7rXkKBrLrxQ/AIs2w/z/b1Lwo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zp4hDVu4RbZ280lWNLzD8Ezqj99uKUnUvlKozrRxLnAKdOIx++rzLCttbpwXzWsab
	 rgz9iALGd56VavzKIIQpbE8Pn4fLJcblGq6T70H3Lugw5N4yu7x3HNQ5DyEpaqzaQW
	 noC0TWCB9RlvIfhKdw50588GKemzvUQy+5tyQtYBb64veYLY/BOA2FmePZe3pByAzR
	 ket/z7PyR2ahOJ58OMsbWT+RFroC+O8V8yY/0GC0DtnY7plgfp3y9OtEPbZ2R1x1N/
	 tyGJZpHVjyQaQoYd8Wt5PmuF0qXuc7/HwX51E66yA3XoCDuuTtx53uYuvKnNmKWN+y
	 0e5dajRIU8BOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0C4380A961;
	Tue,  3 Mar 2026 10:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,
 v2] net: mana: Trigger VF reset/recovery on health
 check failure due to HWC timeout
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177253380531.787310.15467452212055546531.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 10:30:05 +0000
References: 
 <aaFShvKnwR5FY8dH@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: 
 <aaFShvKnwR5FY8dH@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 dipayanroy@microsoft.com
X-Rspamd-Queue-Id: 9FFB61ECAC2
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
	TAGGED_FROM(0.00)[bounces-9105-lists,linux-hyperv=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 27 Feb 2026 00:15:02 -0800 you wrote:
> The GF stats periodic query is used as mechanism to monitor HWC health
> check. If this HWC command times out, it is a strong indication that
> the device/SoC is in a faulty state and requires recovery.
> 
> Today, when a timeout is detected, the driver marks
> hwc_timeout_occurred, clears cached stats, and stops rescheduling the
> periodic work. However, the device itself is left in the same failing
> state.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: mana: Trigger VF reset/recovery on health check failure due to HWC timeout
    https://git.kernel.org/netdev/net-next/c/2b12ffb66955

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



