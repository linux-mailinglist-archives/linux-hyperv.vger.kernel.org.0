Return-Path: <linux-hyperv+bounces-9415-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Y1Q8ASS8tWlD4QAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9415-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Mar 2026 20:51:00 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9CF28EA8E
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Mar 2026 20:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA0DB302AD18
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Mar 2026 19:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7079134D4D2;
	Sat, 14 Mar 2026 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ck3kZJWS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6091A2545;
	Sat, 14 Mar 2026 19:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773517856; cv=none; b=IPJsdN0d1bAWUzQkgdgWMpkRRIy7M9MVUJu4pi3GjPrg8pxjEiPPxhVuBj23Sjluf/iM8tndGzuDRpbinJB9DZz9s92dbY7fCL8wr6UtM7V8ko0qZlBQuERTnpvBvw4C0/rGhMpxa1h32lrfNkvFwr1U672uvZ32D4bXY+N0T94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773517856; c=relaxed/simple;
	bh=x83of3pCZL5zt0JL1Vs+J0mJZUPe+x1bQnV5yZKxK/k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6gZYng9V+qFOTUKw+SbhK++fRsNQJlY6N6+Nz+pqqNqDNqHiOaOtIhTc09jJzKi580q1WpKGJX3v0vdkzvsQLkYDoKk8P68vi1aZsBEgAt/ia7npwP1YuUuAsHh9ziJxdxeg8O5JIEvQtoraXtyXhoGluGmumZHxMIgbrNZoIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ck3kZJWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAD8C116C6;
	Sat, 14 Mar 2026 19:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773517855;
	bh=x83of3pCZL5zt0JL1Vs+J0mJZUPe+x1bQnV5yZKxK/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ck3kZJWSzRE+ThVhaipuz+gu8TIY/DirFQgn8+akov6U4C9igeHq7zrvycfWE4vvv
	 +XGN83/OwtXZBsI8nuoSb3Q3oWSJQ33VQK84RqQ+M9QwuXm952WIPC+XbXrpN4iEZc
	 xYgdQjHJsyUfqkOwMurzh8vSFwD5icq0hUNbGV0B72hCRKcvNI6hgIm4ZL5rDb0nTx
	 MLSFykdS0qQbBrl/lFfP9mFXWiK0uty8S5Xk7mQbyqaN1xbmh3S+xSlecBrahoVZhM
	 e+vHlAV2z4W8hfK7mpom1qNSVbDFDbxNEeteoEi2jYQRyjh1wV51Uce47xsrj6jvO9
	 wmN1AxP/bW/qw==
Date: Sat, 14 Mar 2026 12:50:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 dipayanroy@microsoft.com
Subject: Re: [PATCH net-next, v3] net: mana: Force full-page RX buffers for
 4K page size on specific systems.
Message-ID: <20260314125053.41d6221b@kernel.org>
In-Reply-To: <abDo8XTu1EiQFC7T@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <abDo8XTu1EiQFC7T@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9415-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F9CF28EA8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 10 Mar 2026 21:00:49 -0700 Dipayaan Roy wrote:
> On certain systems configured with 4K PAGE_SIZE, utilizing page_pool
> fragments for RX buffers results in a significant throughput regression.
> Profiling reveals that this regression correlates with high overhead in the
> fragment allocation and reference counting paths on these specific
> platforms, rendering the multi-buffer-per-page strategy counterproductive.

Can you say more ? We could technically take two references on the page
right away if MTU is small and avoid some of the cost.

The driver doesn't seem to set skb->truesize accordingly after this
change. So you're lying to the stack about how much memory each packet
consumes. This is a blocker for the change.

> To mitigate this, bypass the page_pool fragment path and force a single RX
> packet per page allocation when all the following conditions are met:
>   1. The system is configured with a 4K PAGE_SIZE.
>   2. A processor-specific quirk is detected via SMBIOS Type 4 data.

I don't think we want the kernel to be in the business of carrying
matching on platform names and providing optimal config by default.
This sort of logic needs to live in user space or the hypervisor 
(which can then pass a single bit to the driver to enable the behavior)

> This approach restores expected line-rate performance by ensuring
> predictable RX refill behavior on affected hardware.
> 
> There is no behavioral change for systems using larger page sizes
> (16K/64K), or platforms where this processor-specific quirk do not
> apply.
-- 
pw-bot: cr

