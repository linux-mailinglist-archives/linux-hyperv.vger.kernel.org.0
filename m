Return-Path: <linux-hyperv+bounces-11392-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGjkMxA0Gmp+2AgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11392-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 02:49:20 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC10660A623
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 02:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24FD03042360
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 00:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE58287257;
	Sat, 30 May 2026 00:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOc+Wk2A"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7116B231832;
	Sat, 30 May 2026 00:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102062; cv=none; b=imjXQdusASZS2+UPBfifCQ/FZC+Taqcq7zRv89mKjSbofDuBDCiZV8IVZlfo7mgrp4P9511K7mgDQeWf5YLt7tJrIv0YsBnnz5p10PIoeOep1oLibcbytuqyJbDSTBbFVP76jGoTqGGH82rojUU+d9ZXq46LQYsQZS/natmowRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102062; c=relaxed/simple;
	bh=bDsGNSy1fiAmCecekWnWNhgmZ6g5zC4KdXlZtzwmEdU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bHofVNim4HhEHTtQXE7nxNheNsV8Edh26I6zZX5QWumC3/TjzI+52iTJsQG5W48Pq2cghTWfvhxSXvC7Ak6JQkcuKYKXcujPO6AEqiJqVfON5N7LXx8wFRbyu2np6jSgdvZkiy6k3x4NCz4nJxcF76eijpKPMh/6M2yEwDuNOKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOc+Wk2A; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1BC1F00898;
	Sat, 30 May 2026 00:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102061;
	bh=v9Q6IFyBc7j84yh4j06iBvmsXKIWQ0VZOpPfEq7GDoM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dOc+Wk2AdK+/DkHNfHVieiKg6tWpDDrY9dGX9ZjT5kcYXUwj+lkRPewFpCmydStf8
	 3fBPpBV9QbWYzxLN8RKtJppwAtTt5RWb2Avp4l6iyqHYJvpCcsSkBZJrOnIW097rt/
	 whLqoK4uEl14cUmSjcbTB6Muy36MlFwSVgrMESflhJLjgMMsXMwFwrROx2EfPuiAjS
	 bsQvqe6oeDhyhGjObw1wtyDSIiRr7cOeLdFmBrsaJc80G0n9A76pF+18wzC4yaBZWI
	 n3ITLC+Ccb10cU5qMNnEhhuY8l1EPxXvGVjcVg+INxRJI0RmPBgAoOsuN2dw1MKr12
	 ul0ESKVHbTW9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 2/2] net: mana: Skip redundant detach on
 already-detached port
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dipayaan Roy" <dipayanroy@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260525081129.1230035-3-dipayanroy@linux.microsoft.com>
References: <20260525081129.1230035-3-dipayanroy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:47:40 +0000
Message-Id: <20260530004741.3D1BC1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11392-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BC10660A623
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] State machine corruption in mana_detach leads to permanently brick=
ed port.
- [Medium] The commit message falsely claims the patch fixes a NULL pointer=
 dereference, indicating a misdiagnosis of the original bug.
--

commit 9693e5b39c52406711e627ad84a6eb7471551a72
Author: Dipayaan Roy <dipayanroy@linux.microsoft.com>

net: mana: Skip redundant detach on already-detached port

This commit adds an early exit to mana_detach() to prevent redundant teardo=
wn
when a port is already detached due to a previous failed attach.

>     When mana_per_port_queue_reset_work_handler() runs after a previous
>     detach succeeded but attach failed, the port is left in a detached
>     state with apc->tx_qp and apc->rxqs already freed. Calling
>     mana_detach() again unconditionally leads to NULL pointer dereferences
>     during queue teardown.

[Severity: Medium]
Is this description of the crash accurate? Looking at the unpatched code, if
mana_attach() fails, apc->port_is_up is left as false. If mana_detach() is
called again, apc->port_st_save is set to apc->port_is_up (which is false).=
=20

Because mana_dealloc_queues() is guarded by if (apc->port_st_save), queue
teardown would be entirely skipped. Could the actual issue with the old code
be that apc->port_st_save was incorrectly cleared, preventing future
mana_attach() retries from allocating queues and recovering the port, rather
than a NULL pointer dereference?

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index 9e7e4bf526bf6..c9b1df1ed1098 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -3350,6 +3350,12 @@ int mana_detach(struct net_device *ndev, bool from=
_close)
> =20
>  	ASSERT_RTNL();
> =20
> +	/* If already detached (indicates detach succeeded but attach failed
> +	 * previously). Now skip mana detach and just retry mana_attach.
> +	 */
> +	if (!from_close && !netif_device_present(ndev))
> +		return 0;
> +

[Severity: High]
Can this early return cause state machine corruption by bypassing the updat=
es
to apc->port_st_save?

Consider this sequence:
1. queue_reset_work runs, mana_detach() succeeds (apc->port_st_save =3D tru=
e,
   apc->port_is_up =3D false), but mana_attach() fails.
2. The admin brings the interface down (ip link set dev eth0 down), skipping
   mana_close() since apc->port_is_up is false.
3. The admin changes the MTU, triggering mana_change_mtu() which calls
   mana_detach() followed by mana_attach().
4. mana_detach() hits this new early return, preserving
   apc->port_st_save =3D=3D true.

When mana_attach() runs, it sees apc->port_st_save =3D=3D true and allocates
queues, setting apc->vport_use_count =3D 1 and apc->port_is_up =3D true, ev=
en
though the interface is administratively down.

If the admin then brings the interface up, mana_open() will unconditionally
call mana_alloc_queues(). That function calls mana_cfg_vport(), which will
return -EBUSY because apc->vport_use_count is already 1.

This leaves mana_open() failing and the interface down. Since the interface
is already down, trying to bring it down again is a no-op, meaning
mana_close() is never called to clean up the orphaned queues.

Does this sequence permanently brick the port until the driver is reloaded?

>  	apc->port_st_save =3D apc->port_is_up;
>  	apc->port_is_up =3D false;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525081129.1230=
035-1-dipayanroy@linux.microsoft.com?part=3D2

