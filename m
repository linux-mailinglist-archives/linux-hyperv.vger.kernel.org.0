Return-Path: <linux-hyperv+bounces-10989-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJ09ABPtB2rmPAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-10989-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 May 2026 06:05:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0726A55A1C8
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 May 2026 06:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 22DF03004609
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 May 2026 04:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B432823183C;
	Sat, 16 May 2026 04:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5JkgygP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EA412B143
	for <linux-hyperv@vger.kernel.org>; Sat, 16 May 2026 04:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778904333; cv=none; b=rVIkRnqdDXCjVgk1Fpl5YRPpaVZf46X9oMWd+A1uwBUmjz4FtuT8VkZwtH3QzydRai1c3/UJEkJd2mXEAw0HRPcwEi3uz14rcyWdupORAVW1HaA/yxZHYOVrY8ya9433PPpRPpxsWundyIi7nAb/F8fdxmnPpEBlU9/FS5z8nOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778904333; c=relaxed/simple;
	bh=1CcvnR0/8wmlUbSnrkM11/BPItaaz5jWzDmbxox5VlU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z3GIjO+fMk05+uEUeyYW4iLm9cf/pa2pjk2s8uqRIAuvTymdCimBAvjEPwGU2I2z8HngpZNwXmr0eqPiv2bWTyAvsG2GkREVcpwVe55F9dPv54PJeOaMsdBUiMazHiHZ6suUq3uTp8NPa09YOQmGk9Fy1qBxjSqy0NI6UTmhnAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5JkgygP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A678C2BCB7;
	Sat, 16 May 2026 04:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778904333;
	bh=1CcvnR0/8wmlUbSnrkM11/BPItaaz5jWzDmbxox5VlU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=M5JkgygPpE9Z8M1ki9xGk0cyJcp1+1RgO+33zMI0d3T6K4RvJn8WV9WqZoZchDCU1
	 s/jLjBDe5m94nQPp+407eaABdvfqrGQ722lJ/DTqz5C5U7C5QdvsG+Vk8/V7l8jj65
	 xjeCPTisewuflG+DZJw8j0UCZZdHO164O0DWfjrh7Dv/RGNIQdK/fY4XrL3I4RxeXk
	 H0dCr8tkoslNyKQGc7Inxe0+KqRuo0KstSqj4ll+mQWLQFO6QQhpYrZOuwG1+qWmq5
	 rq28lonKuvXFhcq0aJvZ3/HvxScorqnJ4FWhs1oWiF3WPH4obH2He0XUs5FvJBCtdU
	 cFlKyURtalDZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v10 2/6] net: mana: Query device capabilities
 and configure MSI-X sharing for EQs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260515040508.491748-3-longli@microsoft.com>
References: <20260515040508.491748-3-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 04:05:32 +0000
Message-Id: <20260516040533.2A678C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 0726A55A1C8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10989-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lists.linux.dev:replyto]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Per-vPort queue counts are not clamped across device resume, lea=
ding to MSI-X vector exhaustion and resume failure if available interrupts =
shrink.
--

commit 5d1fd25db612c4024c6a414d322389f154cfe998
Author: Long Li <longli@microsoft.com>
Date:   Fri May 15 04:05:04 2026 +0000

    net: mana: Query device capabilities and configure MSI-X sharing for EQs

This commit adjusts the maximum number of queues to allow dedicated MSI-X
vectors for each vPort, calculating per-vPort limits based on hardware
capabilities. It enables MSI-X sharing dynamically when there are not
enough vectors for dedicated allocation and ensures a minimum of one port
during probe.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index 18f8f653da3d4..d23b856f48f6f 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c

[ ... ]

> @@ -3426,9 +3431,9 @@ static int mana_probe_port(struct mana_context *ac,=
 int port_idx,
>  	apc =3D netdev_priv(ndev);
>  	apc->ac =3D ac;
>  	apc->ndev =3D ndev;
> -	apc->max_queues =3D gc->max_num_queues;
> +	apc->max_queues =3D gc->max_num_queues_vport;
>  	/* Use MANA_DEF_NUM_QUEUES as default, still honoring the HW limit */
> -	apc->num_queues =3D min(gc->max_num_queues, MANA_DEF_NUM_QUEUES);
> +	apc->num_queues =3D min(gc->max_num_queues_vport, MANA_DEF_NUM_QUEUES);
>  	apc->tx_queue_size =3D DEF_TX_BUFFERS_PER_QUEUE;

Does this code handle clamping apc->num_queues if the available MSI-X
vectors decrease during a suspend/resume cycle?

During a device resume, mana_gd_query_max_resources() might recalculate
a smaller gc->max_num_queues_vport if fewer MSI-X vectors are provided
by the system.

Since apc->num_queues is set here during the initial probe, it appears
to retain its previously configured size on resume. When mana_attach()
is called in the resume path for existing ports, could it try to allocate
the old, larger number of vectors from the newly undersized msi_bitmap,
exhausting the bitmap and failing the resume with -ENOMEM?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515040508.4917=
48-1-longli@microsoft.com?part=3D2

