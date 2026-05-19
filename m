Return-Path: <linux-hyperv+bounces-11043-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDNWMqTXDGp8oAUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11043-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 23:35:32 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6E05853EB
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 23:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F16443088B0D
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 21:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FD43E8686;
	Tue, 19 May 2026 21:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBRbdahB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCC13EC2DE
	for <linux-hyperv@vger.kernel.org>; Tue, 19 May 2026 21:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779226492; cv=none; b=RZJ+DfS55FudiYHC1kLmzdTX2E+W79xsGOM3bHCjmZ3yHqqx48PtREnlEykRE7YSNQQdfAdI61ZC+nmKWgyPJFt9Wjqebzg9AQIdqHwUiXJ9gRj1nCnEHnZ3Z66SGrOY7l18U+z2jvNFId1zoPj7R1EoVOllmM1lwlBiI0AmxJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779226492; c=relaxed/simple;
	bh=ka0tGfNNsykRDlck59HgUCJ/MCtqGm/Ny5IcZa1FZWo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IC8+8dlN0ABYEyLMd8TJb8mR8HyKpl/xeiAGlZVfhZRu4svwP9VM+oBOydBcmTRV3seRYGG7Vi1p6S2sTikVbj2Gl0dwWHXHoLHAEOm9tx6hGsouv7dyPcsrKYguRPHCMagbQrNDfRd47x+4cnvfB8BNEjMITUwI3LUMMMArJF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBRbdahB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E611F000E9;
	Tue, 19 May 2026 21:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779226490;
	bh=F8YRtpFmJgQZQ7uMTBzXaMpAAS7CdN1UOgTG79IjAOs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eBRbdahBglR5W1KKjLkd/VW63zUnCbLL3EXONGO1Uskr17sELUXval2JsDKiC/4cR
	 lu4yr9WSdH/COLmLFapLhAGnkRcJhcui5Y5dIffBT8ou+jI03f26FNS4DuVeygyfP0
	 Zk25mA+7bzXaIxzC/OLerAkclRiREruWG4+5MLXb/MZHEXz0MbIlU1QTBoKcHt3hvh
	 n7pbwuao0gTKRlYYegIi44uPJM+3FAMI5PgIQ/BXpBy2fauVOLcVJavbrYT9rOYJF7
	 oDmKO8Q0q4sVdnqt0/Dj5d5Y5ac6AP93qkArPcZ+U1xws0AglD+NWjrWxaIEU9Guwm
	 H/3+R520HHvlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] drm/hyperv: validate VMBus packet size in
 receive callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Berkant Koc" <me@berkoc.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <e6e63276cca2901641ab39029e4fd3d621b1ee92.1779221799.git.me@berkoc.com>
References: <e6e63276cca2901641ab39029e4fd3d621b1ee92.1779221799.git.me@berkoc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 21:34:49 +0000
Message-Id: <20260519213450.50E611F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11043-lists,linux-hyperv=lfdr.de];
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
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_SPAM(0.00)[0.997];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,berkoc.com:email,lists.linux.dev:replyto,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4C6E05853EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] Using `bytes_recvd` for `memcpy()` without checking `vmbus_rec=
vpacket()` return value leads to a massive heap buffer overflow.
- [High] Strict sizeof() validation incorrectly rejects dynamically-sized S=
YNTHVID_RESOLUTION_RESPONSE packets.

Pre-existing issues:
- [High] Concurrent lockless write to `hv->init_buf` from VMBus callback al=
lows a malicious host to overwrite data while the guest is validating it.
- [High] Missing `reinit_completion()` before reusing the shared `hv->wait`=
 completion object.
--

commit 8035423b95c9b24007478019421c5f94fe1179ce
Author: Berkant Koc <me@berkoc.com>
Subject: drm/hyperv: validate VMBus packet size in receive callback

This patch passes bytes_recvd into hyperv_receive_sub() to validate that
packets cover the pipe and synthvid headers as well as the type-specific
payload. The memcpy operation is also modified to use bytes_recvd.

Cc: stable@vger.kernel.org # 5.14+

> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/=
hyperv/hyperv_drm_proto.c
> index c3d0ff229e3d0..12d3feb4f88ac 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
[ ... ]
> @@ -420,26 +420,62 @@ static int hyperv_get_supported_resolution(struct h=
v_device *hdev)
>  	return 0;
>  }
> =20
> -static void hyperv_receive_sub(struct hv_device *hdev)
> +static void hyperv_receive_sub(struct hv_device *hdev, u32 bytes_recvd)
>  {
[ ... ]
>  	if (msg->vid_hdr.type =3D=3D SYNTHVID_VERSION_RESPONSE ||
>  	    msg->vid_hdr.type =3D=3D SYNTHVID_RESOLUTION_RESPONSE ||
>  	    msg->vid_hdr.type =3D=3D SYNTHVID_VRAM_LOCATION_ACK) {
> -		memcpy(hv->init_buf, msg, VMBUS_MAX_PACKET_SIZE);
> +		size_t need =3D hdr_size;
> +
> +		switch (msg->vid_hdr.type) {
> +		case SYNTHVID_VERSION_RESPONSE:
> +			need +=3D sizeof(struct synthvid_version_resp);
> +			break;
> +		case SYNTHVID_RESOLUTION_RESPONSE:
> +			need +=3D sizeof(struct synthvid_supported_resolution_resp);

[Severity: High]
Does this strict sizeof() check correctly handle dynamically-sized packets?

If the host sends a response sized only for the active elements (up to
resolution_count) rather than the maximum 64 elements, bytes_recvd will
be less than need. Will this cause valid packets to be falsely rejected
and break the driver initialization sequence?

> +			break;
> +		case SYNTHVID_VRAM_LOCATION_ACK:
> +			need +=3D sizeof(struct synthvid_vram_location_ack);
> +			break;
> +		}
> +		if (bytes_recvd < need) {
> +			drm_err_ratelimited(&hv->dev,
> +					    "synthvid packet too small for type %u: %u < %zu\n",
> +					    msg->vid_hdr.type, bytes_recvd, need);
> +			return;
> +		}
> +		memcpy(hv->init_buf, msg, bytes_recvd);

[Severity: High]
This is a pre-existing issue, but does this pattern allow a malicious host
to overwrite data while the guest is validating it?

The callback unconditionally copies incoming response packets into
hv->init_buf via memcpy() and calls complete().

Since the waiting thread processes hv->init_buf in process context without
copying it to isolated local memory, can an untrusted host send a second
packet immediately after validation to trigger a time-of-check to
time-of-use (TOCTOU) data race?

>  		complete(&hv->wait);

[Severity: High]
This isn't a bug introduced by this patch, but does the driver need to call
reinit_completion(&hv->wait) before sending a new request?

If a prior request times out and its response arrives late, the completion
counter is incremented. Will the next wait immediately consume the
completion counter and process stale data left in hv->init_buf?

>  		return;
>  	}
[ ... ]
> @@ -466,7 +502,7 @@ static void hyperv_receive(void *ctx)
>  				       &bytes_recvd, &req_id);
>  		if (bytes_recvd > 0 &&
>  		    recv_buf->pipe_hdr.type =3D=3D PIPE_MSG_DATA)
> -			hyperv_receive_sub(hdev);
> +			hyperv_receive_sub(hdev, bytes_recvd);

[Severity: Critical]
If vmbus_recvpacket() encounters a packet larger than VMBUS_MAX_PACKET_SIZE
(16KB), it returns -ENOBUFS and sets bytes_recvd to the required packet
length.

Since ret =3D=3D 0 is only checked in the while condition, does this pass an
unbounded bytes_recvd into the callback? If recv_buf still contains the
header from a previous successful iteration, it looks like
memcpy(hv->init_buf, msg, bytes_recvd) will copy more than 16KB into
hv->init_buf, causing a heap buffer overflow.

>  	} while (bytes_recvd > 0 && ret =3D=3D 0);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779221339.gi=
t.me@berkoc.com?part=3D2

