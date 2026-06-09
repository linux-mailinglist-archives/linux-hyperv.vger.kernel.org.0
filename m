Return-Path: <linux-hyperv+bounces-11548-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J5AKARX3J2q36QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11548-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 13:20:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE6865F6E8
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 13:20:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UYe936jy;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11548-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11548-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D4EA3023348
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jun 2026 11:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D3C3FE641;
	Tue,  9 Jun 2026 11:20:09 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230483FDC14;
	Tue,  9 Jun 2026 11:20:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781004009; cv=none; b=lvUNzP7R6lacPsknyrWATVgq14jJZhTrD6pXR9HV6Id4NfCsCn0HDSRGZNpcBZKAJ0kin3/zklJU/yAgomXyUgHhlZjYygDELqbMKVvNCP0moEsbEc12YThjIt/jFsGg28f78FuQgQ5mMkpB07owyYaGojsJ6ocgE97E8qsknB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781004009; c=relaxed/simple;
	bh=MBFAi68cJtixTUTtV59+COSQ13IaoHt2+pFDOEIsZ18=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=njYtxYVD4YLp/CuSx41avndFrBWJMc3sej5ma4YI4w6NjAV0iCFt98N+CJFWCvnhoxTbzIEYz4rQAMPx4IRVJZe/x29Lsvjwmeh9vo5wtILrf7TjT3VQOi0airo18Zi/1WkvOTklAQndwrGSIYwtONP+TtsW/Lx79Ohv56pI0ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYe936jy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44AB1F00898;
	Tue,  9 Jun 2026 11:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781004007;
	bh=B+0wrW3LJMtKIonMBpQtLyzYJHDYU4NBKPOvxGEYvMw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UYe936jyRJW2+aafPUtPauKXAaeI3cXoBE1GRAj2h103ItuHEZOBZuqbk6Ob8TE8l
	 O2Pcc0ZkQ6h9MBuA+xzTnYSf8qjuSkE8bTSXw/DCxmPEwwE1DOqEaZr8J2lJ753h84
	 iWePXc63msI4+r+P/x+CjNPSQBr5nOQemGUhRCC24emzDS9gKKgqFTqm9u+Gg56Q4g
	 uN2t09RPf/fi28CmJVADKP1xDGYrTae8C9tecdB0ZTBAdnuBHu9YWBRz5pKNWaD9Uq
	 dRGDnm4wwGJAKBkMj7XTEXAOMskcggjajwitr16ujo9iRlzTXS5zJjMJXQykHnsevG
	 C4kD5vIR10A2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5691039308A0;
	Tue,  9 Jun 2026 11:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] hv_netvsc: use kmap_local_page in
 netvsc_copy_to_send_buf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178100400590.1968131.4057700163237910047.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 11:20:05 +0000
References: <20260604165938.32033-1-leontyevantony@gmail.com>
In-Reply-To: <20260604165938.32033-1-leontyevantony@gmail.com>
To: Anton Leontev <leontyevantony@gmail.com>
Cc: netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
 haiyangz@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11548-lists,linux-hyperv=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leontyevantony@gmail.com,m:netdev@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:haiyangz@microsoft.com,m:kys@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CE6865F6E8

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  4 Jun 2026 19:59:38 +0300 you wrote:
> netvsc_copy_to_send_buf() copies page buffer entries into the VMBus
> send buffer using phys_to_virt() on the entry PFN. Entries for the
> RNDIS header and the skb linear data come from kmalloc'd memory and
> are always in the kernel direct map, but entries for skb fragments
> reference page cache or user pages, which on 32-bit x86 with
> CONFIG_HIGHMEM=y can live above the LOWMEM boundary. For such a page
> phys_to_virt() returns an address outside the direct map and the
> subsequent memcpy() faults on the transmit softirq path, which is
> fatal.
> 
> [...]

Here is the summary with links:
  - [net,v3] hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf
    https://git.kernel.org/netdev/net/c/004e9ecfe6c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



