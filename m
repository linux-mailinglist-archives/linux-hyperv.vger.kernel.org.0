Return-Path: <linux-hyperv+bounces-11529-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g0H8GCJgJmpvVgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11529-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 08 Jun 2026 08:24:34 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C23326531AA
	for <lists+linux-hyperv@lfdr.de>; Mon, 08 Jun 2026 08:24:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cAO55EA1;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11529-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11529-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A31523023DDA
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jun 2026 06:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4C038655C;
	Mon,  8 Jun 2026 06:23:12 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB20738655B;
	Mon,  8 Jun 2026 06:23:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780899792; cv=none; b=fyOuAhIcKeJxX6CD1zNz6SjlCNG/sFQTMLnP1MSoWnZ16Il9JPSmTf/bPop3F9HJNX/6CPzWOdMDwb2d70oDFqkgkhxLjQfIWU3y6jzjoJo/BPpXMXK5ZQuw+DooCTlaOEj0uhMCDnVSttMNsi7xZyBMMafCqkmp0T4oS5Rm8cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780899792; c=relaxed/simple;
	bh=sLbbapxx5knd8eLyOeTPCOr66TwYR0V604yjuCPGqKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWbucBQrreAZGgeDkxLXQnlmVH8b1cWUjwgM4RJ5Y89aeB8VnYsL825XvIubgiAJoCesH0EM9weHdTOANYuC1aMAngimt0Dj/GQQ6vahN1MXuv7xobJClepKxJYwgzwNb9Opkva4ZQZ/BM3Hl5zzPPas4ppPur4dO7riLKxxEFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAO55EA1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFD41F00893;
	Mon,  8 Jun 2026 06:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780899791;
	bh=RQGf1lSBmKpeXq7jOLNmJYdpuC32jgEBLtXYO4Qpex4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cAO55EA1OMz/ZP0K/d2DaTSmBjcCi5tDWN/v+lCJTprHkmEjKv7hal0AazoMy6i2Q
	 w2uLAU8qdU4KNaJm7kP9DLR5gX8XxOAQ3iuwsb+HMYD6a6cPHzM1wJAL2RzjkLXyI8
	 sftB0NeagPh0vR1nkliLbgDpgGac7xDkssIcw6pcGh2laguMgX6qxGvpzOIdua+3KE
	 mV+FJryvqvwP6vgr+5zhgoRG33bRqQrLeqX1kGVWPog73LQ4OBlH4qRguL0xeAJY/K
	 EJe55wA8nthLQEPKCKiuRqFDjC/6UmvCTUfJbqjnb6qD9Q6aVW25d76vKswuAxqeb2
	 I5MAiW9inc8zQ==
Date: Sun, 7 Jun 2026 23:23:10 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Jinank Jain <jinankjain@microsoft.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Muminul Islam <muislam@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: Re: [PATCH] Drivers: hv: mshv: add bounds check on vp_index in
 mshv_intercept_isr()
Message-ID: <20260608062310.GC1555293@liuwe-devbox-debian-v2.local>
References: <SYBPR01MB7881B8B5D35E02A0E8404E4FAF232@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBPR01MB7881B8B5D35E02A0E8404E4FAF232@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11529-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:moonafterrain@outlook.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:jinankjain@microsoft.com,m:prapal@linux.microsoft.com,m:mrathor@linux.microsoft.com,m:nunodasneves@linux.microsoft.com,m:anrayabh@linux.microsoft.com,m:romank@linux.microsoft.com,m:muislam@microsoft.com,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:skinsburskii@linux.microsoft.com,m:danisjiang@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,linux.microsoft.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,outlook.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C23326531AA

On Thu, Apr 16, 2026 at 10:18:05PM +0800, Junrui Luo wrote:
> mshv_intercept_isr() extracts vp_index from the hypervisor message
> payload and uses it directly to index into pt_vp_array without
> validation. handle_bitset_message() and handle_pair_message() already
> validate vp_index against MSHV_MAX_VPS before array access.
> 
> A vp_index exceeding MSHV_MAX_VPS leads to an out-of-bounds read from
> pt_vp_array.
> 
> Add the same MSHV_MAX_VPS bounds check for consistency with the other
> message handlers.
> 
> Fixes: 621191d709b1 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Like other places say, the hypervisor shouldn't give us an out-of-bound
index. It has many different ways to screw with the root kernel, so I'm
not overly concerned about this.

That said, having a bit more consistency and defensive programming
doesn't hurt. I have applied this patch. Thanks.

Wei

> ---
>  drivers/hv/mshv_synic.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> index 43f1bcbbf2d3..5bceb8122981 100644
> --- a/drivers/hv/mshv_synic.c
> +++ b/drivers/hv/mshv_synic.c
> @@ -384,6 +384,10 @@ mshv_intercept_isr(struct hv_message *msg)
>  	 */
>  	vp_index =
>  	       ((struct hv_opaque_intercept_message *)msg->u.payload)->vp_index;
> +	if (unlikely(vp_index >= MSHV_MAX_VPS)) {
> +		pr_debug("VP index %u out of bounds\n", vp_index);
> +		goto unlock_out;
> +	}
>  	vp = partition->pt_vp_array[vp_index];
>  	if (unlikely(!vp)) {
>  		pr_debug("failed to find VP %u\n", vp_index);
> 
> ---
> base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
> change-id: 20260416-fixes-693196e52f93
> 
> Best regards,
> -- 
> Junrui Luo <moonafterrain@outlook.com>
> 

