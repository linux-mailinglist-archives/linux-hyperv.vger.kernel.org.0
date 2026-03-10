Return-Path: <linux-hyperv+bounces-9272-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCO2IiUlsGnYgQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9272-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Mar 2026 15:05:25 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76094251501
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Mar 2026 15:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C6933153834
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Mar 2026 13:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4643A3E3154;
	Tue, 10 Mar 2026 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+z2LrtC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2022D33B6C4;
	Tue, 10 Mar 2026 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773147010; cv=none; b=NKcaOwyxPxmTmXoZV2iDrK0F3Hh3Nd3GqA6f0WNaM2HIRMFIjDwQaxFiB+1122UsZyn337qdItFv0iF/2n9MWOngxUgbyg3lu77F5X1afr+DG8Gb4wULGvnNGU+iYmv/AVvkj/jzQR8vNnZT62XK8szJOqVwJVDZ0L2pKxFWIWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773147010; c=relaxed/simple;
	bh=6nzgzuyEmJtzi+mALa1difNFw8fG3ZBIhax6V+8GNA0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UFNBl+SveD/WJkj/jP2+AcdxvOWb9AqWTX1Fw1EC725Y6ghzLBkiZ/4P0LUg18w2UfFYK55pbJcvdzd003uyUxPShW8TX+rWft0ibsNVbJs67lInzyQTXAeT7ZS72jm0IiDvxOc2sEbmWM96PRYaK4DCP5B9x6A8DhKXDzd3ncQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+z2LrtC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0B7C2BC86;
	Tue, 10 Mar 2026 12:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773147009;
	bh=6nzgzuyEmJtzi+mALa1difNFw8fG3ZBIhax6V+8GNA0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q+z2LrtCIKX6h+2UUUrqLGw/6kFwrSiSw1GjdaYnmlSYBB1FzpCaVmmyF5c4zkkIO
	 dNbrXmLxNDq4mnBhgLTw/h74C2AhJAkoZIkhzvXGXLTOFUv2LdVZ2IkePdEsXp1iJj
	 2zN0Qc6hYTXPL7xpQCQa+HUYRJlX4NM6rMXpe6bYudfa8Y2R+HskpfIVb+guMpz3bz
	 MrYYathTaU8s7Z8SinzTzGGyUbVvOGFGmJgAbbJWbPJrHLelwvBbDJ1BSJWgBYhnY0
	 q2MShAXBMT6RalJJzg1honmpj22CSJ2/4eanBH1TOPp/isZnSBKdxxSE7+g29qzqc2
	 vcN5Wfu6a+87Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0683808200;
	Tue, 10 Mar 2026 12:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mana: hardening: Validate doorbell ID from
 GDMA_REGISTER_DEVICE response
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177314700605.2274408.12987784829211108904.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 12:50:06 +0000
References: <20260306211212.543376-1-ernis@linux.microsoft.com>
In-Reply-To: <20260306211212.543376-1-ernis@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, yury.norov@gmail.com, kees@kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
X-Rspamd-Queue-Id: 76094251501
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
	TAGGED_FROM(0.00)[bounces-9272-lists,linux-hyperv=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  6 Mar 2026 13:12:06 -0800 you wrote:
> As a part of MANA hardening for CVM, add validation for the doorbell
> ID (db_id) received from hardware in the GDMA_REGISTER_DEVICE response
> to prevent out-of-bounds memory access when calculating the doorbell
> page address.
> 
> In mana_gd_ring_doorbell(), the doorbell page address is calculated as:
>   addr = db_page_base + db_page_size * db_index
>        = (bar0_va + db_page_off) + db_page_size * db_index
> 
> [...]

Here is the summary with links:
  - [net-next] net: mana: hardening: Validate doorbell ID from GDMA_REGISTER_DEVICE response
    https://git.kernel.org/netdev/net-next/c/89fe91c65992

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



