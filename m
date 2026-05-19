Return-Path: <linux-hyperv+bounces-11042-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIH2HODODGrImQUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11042-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 22:58:08 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA785584F2B
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 22:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 915B03013AB5
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 20:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8153D330A;
	Tue, 19 May 2026 20:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeaRDe3n"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D323CEBB8
	for <linux-hyperv@vger.kernel.org>; Tue, 19 May 2026 20:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224158; cv=none; b=OVCehvalmUII+Z3SWSYTdFgUHLYQ+wcxjkvzuLqFSui63HslZq4uZYSI+3XCgmgip4fyNHAt+FiCg4qjd68lN+PpzQvBPTpzROCcXzID7lXOzPJSGBMfTWwvJCG+6ChKc236RCajHt30kCiqIayCCeEZZCn28/jFLinKPcIUzTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224158; c=relaxed/simple;
	bh=HcCZSIZeONc4cggeDPKduX2thxRS4VWT+2ca3BCAh1c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FMv4UjLWwf7MaOH9IDxuxH9SXDnEGuUxgAxBUbuWH105t2nJhN/E5wrWylgQ+QZHptki1BvfdHDFYHPqtEm9vKkYxq1QOYM9j8E28OYtcDcWsPAAsj22CsMy6PRi8hqEur0ZNy2D7JjLy9dSqEf7DFD2w9Ecro5ZltTu8WQN9JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeaRDe3n; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C52F1F000E9;
	Tue, 19 May 2026 20:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779224155;
	bh=TkA5JPRnrz2svL21qjskK7ZwaAz8rce7jZwuwOyzpvI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BeaRDe3nX/+ugCuQw2HGu9AwgvIMbeVjN4fOjNjxuSoA8PKzjmN0LYDmUF4i7J8nU
	 jCgMm6rtKeHSZluf7BDB7CVdXARz06WdduoNztbCRzNbGAFGkw8aAgPbCGsUtlZG/+
	 XVsK/ee1aEOCocRIhd+mo+DSoIjf0uuKAS8yADZcg1LDwilVmqU5DDDnNiuKe0czDo
	 wjLGsrgEor9LMkulI7RemCNfimsfChHSA8kIbObutPBGHcV5RFpvnHqP5LOC9fBEOe
	 li9jLuFJrZr3H1ZKeQizXVknBYJVT1RnSj6O+YBHuLDO1enic5GBNCA2lG85NZAxdf
	 V+QaMxWAB77SQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] drm/hyperv: validate resolution_count and fix
 WIN8 fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Berkant Koc" <me@berkoc.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <1b88bc7edeb2f0153475225b67f19aaca629eca8.1779221799.git.me@berkoc.com>
References: <1b88bc7edeb2f0153475225b67f19aaca629eca8.1779221799.git.me@berkoc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 20:55:54 +0000
Message-Id: <20260519205555.5C52F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL_FRESH15(3.00)[berkoc.com:email];
	MISSING_MIME_VERSION(2.00)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11042-lists,linux-hyperv=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20260515];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	TAGGED_RCPT(0.00)[linux-hyperv];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_SPAM(0.00)[0.997];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,berkoc.com:email,smtp.kernel.org:mid,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CA785584F2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unsynchronized access to the shared `hv->init_buf` introduces =
Double Fetch/TOCTOU vulnerabilities, allowing a malicious host to bypass bo=
unds checks and leak kernel memory.
- [High] The driver reuses the `hv->wait` completion for synchronous messag=
es without re-initializing it, which can cause spurious wakeups and synchro=
nization bypass.
--

commit dde0fd11b79967ca7df11b1049abebec363d25a5
Author: Berkant Koc <me@berkoc.com>

drm/hyperv: validate resolution_count and fix WIN8 fallback

Adds bounds checking for resolution_count to prevent walking past the
supported_resolution array. It also adds fallback handling to ensure WIN8
defaults are used when the resolution probe fails.

> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/=
hyperv/hyperv_drm_proto.c
> index 051ecc5268321..c3d0ff229e3d0 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> @@ -387,12 +387,15 @@ static int hyperv_get_supported_resolution(struct h=
v_device *hdev)
>  	hyperv_sendpacket(hdev, msg);
> =20
>  	t =3D wait_for_completion_timeout(&hv->wait, VMBUS_VSP_TIMEOUT);

[Severity: High]
This isn't a bug introduced by this patch, but does the driver need to call
reinit_completion(&hv->wait) before sending requests?

If a delayed or unsolicited response arrives, hyperv_receive_sub() calls
complete(&hv->wait), incrementing its internal counter.  When this function
is called later, wait_for_completion_timeout() will return immediately
without waiting for the actual response.

Could this cause the driver to erroneously parse its own outgoing request
buffer as a response?

>  	if (!t) {
>  		drm_err(dev, "Time out on waiting resolution response\n");
>  		return -ETIMEDOUT;
>  	}
> =20
> -	if (msg->resolution_resp.resolution_count =3D=3D 0) {
> -		drm_err(dev, "No supported resolutions\n");
> +	if (msg->resolution_resp.resolution_count =3D=3D 0 ||
> +	    msg->resolution_resp.resolution_count >
> +	    SYNTHVID_MAX_RESOLUTION_COUNT) {

[Severity: Critical]
This is a pre-existing issue, but does reading directly from the shared
hv->init_buf introduce a TOCTOU or Double Fetch problem here?

Since hv->init_buf is also used by the asynchronous hyperv_receive_sub()
callback, could a malicious host send a valid count to pass this check,
and then immediately overwrite hv->init_buf with a large value before the
subsequent for-loop evaluates i < msg->resolution_resp.resolution_count?

Additionally, when the driver prepares requests earlier in this function
(e.g., setting msg->vid_hdr.size), an unsolicited response could overwrite
hv->init_buf. Could this trick vmbus_sendpacket() into using a
host-controlled size and leaking kernel memory?

> +		drm_err(dev, "Invalid resolution count: %d\n",
> +			msg->resolution_resp.resolution_count);
>  		return -ENODEV;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779221339.gi=
t.me@berkoc.com?part=3D1

