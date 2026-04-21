Return-Path: <linux-hyperv+bounces-10283-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAxxNA6s52kM/AEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10283-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 18:55:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7512243D9FF
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 18:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94ED6302F249
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 16:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C0E37F8D2;
	Tue, 21 Apr 2026 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOMhhA76"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D07337F750;
	Tue, 21 Apr 2026 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776790207; cv=none; b=j0Tg+wd76v5GFKcOHYwzIN/NLF8vjz4FoTnzYqW+r2frdb1oTz9j/MPR4sBJUFx95AxKhbrYVsAAtkV5DRV/76fNYEWJamxV3NcD/jj91Bvv6wwj0s+68fV6MWLFRZstWZRTU79AUh09nA5leKAlr6csdVsz2oHrXSVX3n/Hmkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776790207; c=relaxed/simple;
	bh=CoMhLpwVG0jVFApz/YL+XHTw2i7jLI/6miVP0Tx0oEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQIeDiIFy1un+gIX8hl0iTTqcUPYApqPcIiGDYDfWz9b3Ek29lQLRCQgw69/UK2IyvwyKI4uoG0DoulqKzoBlc/di9SOSdvj+PaL9ieWTw6Gb138nrg36EJw7N/rwMkHitxPOnWhL6KVC+zds1RtvWhcplcPlWQA/yq6U70oUCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOMhhA76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486D5C2BCB0;
	Tue, 21 Apr 2026 16:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776790206;
	bh=CoMhLpwVG0jVFApz/YL+XHTw2i7jLI/6miVP0Tx0oEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SOMhhA76UDz+DX38Ahe6YXyGUk1dhBoBAKb4AOSlE7c7+Q8Mbuczu/kjAUg7lFjnD
	 +FdAIZichS5QNQX8X2HRXXO+wKmNFBJ8aqF17FtWzNrOvaT8dpcHc5dzrUyJ/7C/gb
	 nb9AuEM7EB3GqBSAjq1E/ODkzQL943gfRujr40V7EGS9qqAQPmyNSl+qkq4e71zjhR
	 gF/lEQrv/DvC9fGPCnmFfgzSoAs0xyzkxj8ll9Qndp7sWz7zg33g/O0NTik/S+Hde7
	 MUMi5kgQnjTDmgSL+NrI+dl3mJcF6ij5GYePMGm/Igj13LWaVna4yedf4p9yq91j3v
	 cOiDYFS/7AhXg==
Date: Tue, 21 Apr 2026 17:49:59 +0100
From: Simon Horman <horms@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ssengar@linux.microsoft.com,
	dipayanroy@linux.microsoft.com, gargaditya@linux.microsoft.com,
	shirazsaleem@microsoft.com, kees@kernel.org,
	kotaranov@microsoft.com, leon@kernel.org, shacharr@microsoft.com,
	stephen@networkplumber.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 0/5] net: mana: Fix probe/remove error path bugs
Message-ID: <20260421164959.GH651125@horms.kernel.org>
References: <20260420124741.1056179-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420124741.1056179-1-ernis@linux.microsoft.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10283-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7512243D9FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 05:47:34AM -0700, Erni Sri Satya Vennela wrote:
> Fix five bugs in mana_probe()/mana_remove() error handling that can
> cause warnings on uninitialized work structs, NULL pointer dereferences,
> masked errors, and resource leaks when early probe steps fail.
> 
> Patches 1-2 move work struct initialization (link_change_work and
> gf_stats_work) to before any error path that could trigger
> mana_remove(), preventing WARN_ON in __flush_work() or debug object
> warnings when sync cancellation runs on uninitialized work structs.
> 
> Patch 3 guards mana_remove() against double invocation. If PM resume
> fails, mana_probe() calls mana_remove() which sets gdma_context and
> driver_data to NULL. A failed resume does not unbind the driver, so
> when the device is eventually unbound, mana_remove() is called again
> and dereferences NULL, causing a kernel panic. An early return on
> NULL gdma_context or driver_data makes the second call harmless.
> 
> Patch 4 prevents add_adev() from overwriting a port probe error,
> which could leave the driver in a broken state with NULL ports while
> reporting success.
> 
> Patch 5 changes 'goto out' to 'break' in mana_remove()'s port loop
> so that mana_destroy_eq() is always reached, preventing EQ leaks when
> a NULL port is encountered.
> ---
> Changes in v4:
> * Correct Fixes tag from ca9c54d2d6a5 to 635096a86edb
> * Correct Fixes tag from ced82fce77e9 to a69839d4327d

Thanks for the updates.

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>


I see that Sashiko provided feedback on patch 4/5.
However, as it notes, the issue it flags is addressed in patch 5/5.
No further action required AFAICS.


