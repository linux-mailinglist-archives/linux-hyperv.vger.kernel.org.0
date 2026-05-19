Return-Path: <linux-hyperv+bounces-11045-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFWmExjrDGq9pwUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11045-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 00:58:32 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FC5585E40
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 00:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19E1D309545F
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 22:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9B63B52EA;
	Tue, 19 May 2026 22:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMfYXFX6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F223373C1E;
	Tue, 19 May 2026 22:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779231364; cv=none; b=X/Xki5W9dgynMTFtsEjaYgQkccLs8TZqbhvQ8Zx77y6ShB+xxxZUByawgptxjP1WfkPFqPCLCewmyMJoabw3QO9GBa1LqVPXBUznt4IBC7JBIl9MRXbBCHkxkWeoQzU5RW0J+0lMnF1RlsQ3dk4oiAPJ+LyDTTWA4dOID9kNEBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779231364; c=relaxed/simple;
	bh=QM5FMHHm++AknD1r9z3aFr5seHTml9EIHn+s7uS8KwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFoJKb+PZ9RefgWln6XaTO9X6PcLaNUZQISORtOcA14o88XFs1kZA3fkzps0lwm9WvVx3nNBKbHxEd6ozzTbARKzUxI3haYfCUGlbLS7sNKYJTb+u8NR4WvNMhYdycr/oKOqwsw2eJ3ckvnnv1raEP1t+2AONj4HZWRZ+88HXw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMfYXFX6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59691F00893;
	Tue, 19 May 2026 22:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779231361;
	bh=Ju/T6dr7tnzbHkBsBfFbYbB7NVyyfDZAOl1owW3rAJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MMfYXFX6PzYqZig4fP7heX9bolmzbam+Ez/+CCI5rJNKvCu76yNTc26XeUeWOfV6f
	 76yv86BhY4CnUd1d+CF+8MeKTgF8Az6M13Rel7tLRKceUbwzI7ZaZLG7ddC0Sh0O+G
	 OpGSYA3c7bnMfWd4PozIH6adolxs9O7hCJTeHUE4fTOLSPnhG9c6s0uXmfP1jyy6he
	 /+5D5p8IgablTI20XeiafXKQ5YsInH/h3vTiwnlHEY5x2livNflhYkggqIBaNFysCb
	 JfaqpT5w+l7pQqv5v7WiYLodJhRURvpkZq6X7M30GwX47mj9ul446ScUZzCKGziXdu
	 bNiGRDDDnMRrQ==
From: Jakub Kicinski <kuba@kernel.org>
To: dipayanroy@linux.microsoft.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	leon@kernel.org,
	longli@microsoft.com,
	kotaranov@microsoft.com,
	horms@kernel.org,
	shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	stephen@networkplumber.org,
	jacob.e.keller@intel.com,
	dipayanroy@microsoft.com,
	leitao@debian.org,
	kees@kernel.org,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	sdf@fomichev.me,
	yury.norov@gmail.com
Subject: Re: [PATCH net 2/2] net: mana: Skip redundant detach in queue reset handler if already detached
Date: Tue, 19 May 2026 15:55:59 -0700
Message-ID: <20260519225559.3939235-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518194654.735580-3-dipayanroy@linux.microsoft.com>
References: <20260518194654.735580-3-dipayanroy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[34];
	TAGGED_FROM(0.00)[bounces-11045-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A0FC5585E40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: mana: Skip redundant detach in queue reset handler if already detached

This commit adds a check for netif_device_present() in the queue reset
handler. If the device is already detached, it skips the redundant
mana_detach() call and proceeds directly to mana_attach().

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 9e7e4bf526bf6..740f3c34db451 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -316,12 +316,19 @@ static void mana_per_port_queue_reset_work_handler(struct work_struct *work)
[ ... ]
> +	/* If already detached (indicates detach succeeded but attach failed
> +	 * previously). Now skip mana detach and just retry mana_attach.
> +	 */
> +	if (!netif_device_present(ndev))
> +		goto attach;
> +
>  	err = mana_detach(ndev, false);

The fix here correctly prevents mana_detach() from running on an already
detached device. However, do identical issues remain in mana_change_mtu(),
mana_set_channels(), mana_set_ringparam(), and mana_bpf()?

If mana_attach() previously failed (for example, due to out of memory),
the port is left with apc->port_is_up = false, but it preserves
apc->port_st_save = true, and calls netif_device_detach(ndev).

If an admin tries to recover the port by retrying a configuration command
like changing the MTU or attaching XDP, these functions appear to
unconditionally call mana_detach(ndev, false) without the
!netif_device_present(ndev) check added here.

Inside mana_detach(), apc->port_st_save = apc->port_is_up executes. Since
port_is_up is already false, port_st_save is overwritten to false,
permanently erasing the intent that the port should be up.

The subsequent call to mana_attach() would then see port_st_save == false,
skip mana_alloc_queues(), set port_is_up = false, and successfully call
netif_device_attach(ndev).

Would this result in the configuration command returning 0 to userspace
while the port queues were never allocated, leaving the interface silently
broken until manually toggled down and up?

