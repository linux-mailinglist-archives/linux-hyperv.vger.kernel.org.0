Return-Path: <linux-hyperv+bounces-11032-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNqAI22+DGqJlgUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11032-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 21:47:57 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3CC5844FF
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 21:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 38CE0301426D
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 19:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FC038BF7A;
	Tue, 19 May 2026 19:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHlspYGq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D097521D5B0;
	Tue, 19 May 2026 19:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779220071; cv=none; b=gbm3oHwPhg8qyVNQh82PD7/PFV2V/9hdw7r1piahEb3iSTydsDAeDWtVmWpcPCX3v58UXjWZIruVwZ6PRL6hPo5Hjh5TQ9eTmGDVLpp058RJT/PvQmOkmG5GTvkqJr4s775geQbsxB+w3hbTXnSNMOSQoSFz2tTiIIRA/xYEArw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779220071; c=relaxed/simple;
	bh=hibSH1TJq9EjZ0miLmpVEFIML6wiPl4CLoOpFH8vsqY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RGBklLqLwzHVcq3aF9S5Z+J/C1KFNLVYaM2wklgsnv4K+2W6j0VxmSYcnHI0eZ7X1rpnK5Jus1VQIiVpi/Ue3fcOoFbN3wd7Y1hpPeS+7Qf1SbheqASMW1iYJP2ggwXpOOuDfcSlOznWfdSaVzBUUOJM0QlfuMILydgViU0GBpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHlspYGq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8491F00893;
	Tue, 19 May 2026 19:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779220069;
	bh=xg/Bgfg2V7Qde3egT/CC3jbGHjeFkDPHARcYSgsrPqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZHlspYGqfERzjf8PWYlkeut/KU6LPvFa/z666yzcrvMXQOPVqxO5lZ1oI3vASfXu0
	 TQ05+CXSIqeEKw0mrE5Kbd+3Z//IbUMxWG9NUGwptaADqpLdIY9KMBDdGRO5sHQ/Go
	 5N9+/UTQeypj7ocoDF+k/423utG8ikAkMxPP2teIYrFhDh1b2dxbDnMImveC10Gl0P
	 zY5DQL76q5J/xNWHkU8Jj0ACVLSK4ax1dbxNtzsaqB7+V1CaCqyBZaTtZVQCTMwcOC
	 wjHZMBToOnY3aVcM6pXZ1j+0vfJsbtCqsjUZ+xeIEhISV7wME4V3aZ8sj6IZH3OMtF
	 6CfYHc4nt9xbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/2] net: mana: Skip redundant detach in queue reset
 handler if already detached
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dipayaan Roy" <dipayanroy@linux.microsoft.com>
Cc: bpf@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260518194654.735580-3-dipayanroy@linux.microsoft.com>
References: <20260518194654.735580-3-dipayanroy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 19:47:49 +0000
Message-Id: <20260519194749.8C8491F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11032-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: 7A3CC5844FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch correctly prevents `mana_detach()` from running on an al=
ready-detached device in the reset handler, but identical bugs remain in `m=
ana_change_mtu()`, `mana_set_channels()`, `mana_set_ringparam()`, and `mana=
_bpf()`.
--

commit bac73a4812067e75feeec962b27ab9647e30ed9c
Author: Dipayaan Roy <dipayanroy@linux.microsoft.com>

net: mana: Skip redundant detach in queue reset handler if already detached

This commit adds a check for netif_device_present() in the queue reset
handler. If the device is already detached, it skips the redundant
mana_detach() call and proceeds directly to mana_attach().

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index 9e7e4bf526bf6..740f3c34db451 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -316,12 +316,19 @@ static void mana_per_port_queue_reset_work_handler(=
struct work_struct *work)
[ ... ]
> +	/* If already detached (indicates detach succeeded but attach failed
> +	 * previously). Now skip mana detach and just retry mana_attach.
> +	 */
> +	if (!netif_device_present(ndev))
> +		goto attach;
> +
>  	err =3D mana_detach(ndev, false);

The fix here correctly prevents mana_detach() from running on an already
detached device. However, do identical issues remain in mana_change_mtu(),
mana_set_channels(), mana_set_ringparam(), and mana_bpf()?

If mana_attach() previously failed (for example, due to out of memory),
the port is left with apc->port_is_up =3D false, but it preserves
apc->port_st_save =3D true, and calls netif_device_detach(ndev).

If an admin tries to recover the port by retrying a configuration command
like changing the MTU or attaching XDP, these functions appear to
unconditionally call mana_detach(ndev, false) without the
!netif_device_present(ndev) check added here.

Inside mana_detach(), apc->port_st_save =3D apc->port_is_up executes. Since
port_is_up is already false, port_st_save is overwritten to false,
permanently erasing the intent that the port should be up.

The subsequent call to mana_attach() would then see port_st_save =3D=3D fal=
se,
skip mana_alloc_queues(), set port_is_up =3D false, and successfully call
netif_device_attach(ndev).

Would this result in the configuration command returning 0 to userspace
while the port queues were never allocated, leaving the interface silently
broken until manually toggled down and up?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518194654.7355=
80-1-dipayanroy@linux.microsoft.com?part=3D2

