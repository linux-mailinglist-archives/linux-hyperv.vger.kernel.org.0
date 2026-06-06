Return-Path: <linux-hyperv+bounces-11517-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7zMqBpBwI2rytwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11517-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 06 Jun 2026 02:57:52 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B04A64C0E3
	for <lists+linux-hyperv@lfdr.de>; Sat, 06 Jun 2026 02:57:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=g6hW9KvJ;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11517-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11517-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDF9B3015CA3
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Jun 2026 00:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9091917CD;
	Sat,  6 Jun 2026 00:57:49 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866B01C2AA
	for <linux-hyperv@vger.kernel.org>; Sat,  6 Jun 2026 00:57:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780707469; cv=none; b=cGLZQlOnX9faflUdsDyTERJgPSV6VHnHC6A1ZD6yMyyuZxSHiHLgjLkfIxdvuMSLWOERDi5jHzqCLRG1jjc2FUgFxeaqRfifhXB44gFSMqA4jXKm5wrlqD9pLvxChpQw0qIPq6ysISDrbrC5/pvv0io5VyBShaeGSs0nJPmCYCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780707469; c=relaxed/simple;
	bh=84yIb7Yc2jK8e8Py5Qr8BTk2XgWMqzPEBSZj0UyCv9Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kzotrRqw1l08KcXL9vyYSziXp4dfMvBSXwzD+G6REwYaeUTvue+2Gzr4YSdoMh03eR+hqHyv4P5KRFGsnWFGfS//cE6v+oH+cbP8E+f4arPcJWS555EqoFvzZpxeDRZFPfygyQ7SbHDz1t2Q2pLAbyFSou1IQbpm/TslcM20a2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6hW9KvJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139881F00893;
	Sat,  6 Jun 2026 00:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780707468;
	bh=01WNRnhrWk3YSQuy4Coa25FiHPrjLDTxnabBGs8+x0g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g6hW9KvJVOavgspO4KN6ZyRCIraR5AQik6khjYPKmbpc30ZbUICT4KeBGFxpGCbjx
	 Ua6ZOuFBASUnEdyhHCHFF4mxXeO1SU981cvI3CDbNcZBQWbi2KwDm84F2M+9ZprooB
	 G/U0COoqTSsSfJW+UzzVdUUb14vm74hcL9L3Bl7Mevt6Iq4FgNAKDTtds7QKOVI5Kv
	 V5XF6wY0m4dWpSoZT0bjdz/YulhNMNPdJ5ZjgqenWghcbAnt+r5V0Cd+yYrzSmYKph
	 apLUsT6eMnVaS+wCjjLOXO9ccIx/11E0p2yvWKv9zgIW8o1IqgDXeJ7Dihgb3oL87x
	 R7JMOSKD9mIRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v12 2/6] net: mana: Query device capabilities
 and configure MSI-X sharing for EQs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260605005717.2059954-3-longli@microsoft.com>
References: <20260605005717.2059954-3-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 00:57:47 +0000
Message-Id: <20260606005748.139881F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11517-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:longli@microsoft.com,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B04A64C0E3

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Permanent downward clamping of maximum queues (`apc->max_queues`=
) across suspend/resume cycles.
--

commit ae1648776d10be5e3fd6640d34f239a82e77a213
Author: Long Li <longli@microsoft.com>
Subject: net: mana: Query device capabilities and configure MSI-X sharing f=
or EQs

This commit adjusts the max number of queues to allow dedicated MSI-X
vectors for each vPort and configures MSI-X sharing when resources are
scarce. It also updates port initialization to clamp the queue counts
to the recomputed per-vPort maximums.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index ed60cc15fe78d..3ec8e94e7c17e 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
[ ... ]
> @@ -3208,6 +3213,8 @@ static int mana_init_port(struct net_device *ndev)
>  	max_queues =3D min_t(u32, max_txq, max_rxq);
>  	if (apc->max_queues > max_queues)
>  		apc->max_queues =3D max_queues;
> +	if (apc->max_queues > gc->max_num_queues_vport)
> +		apc->max_queues =3D gc->max_num_queues_vport;

[Severity: Medium]
Will this result in a permanent downward clamping of the maximum queues acr=
oss
suspend and resume cycles?

Because gc->max_num_queues_vport is dynamically recalculated on every
suspend/resume cycle based on current hardware state (such as the number of
online CPUs and available MSI-X vectors), it might temporarily shrink.

If a system resumes with fewer vectors, this logic reduces apc->max_queues.

However, if the system subsequently resumes again with the original number =
of
vectors restored, apc->max_queues cannot recover because this clamping only
ever reduces the value and the original allocation limit is permanently
overwritten.=20

Should we be clamping a temporary runtime variable instead of permanently
modifying the device's capability maximums here?

> =20
>  	if (apc->num_queues > apc->max_queues)
>  		apc->num_queues =3D apc->max_queues;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605005717.2059=
954-1-longli@microsoft.com?part=3D2

