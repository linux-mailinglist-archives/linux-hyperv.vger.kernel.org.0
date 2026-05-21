Return-Path: <linux-hyperv+bounces-11154-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOW4MfeBD2pdMwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11154-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2026 00:06:47 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F5B5AC471
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2026 00:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7364301F9C4
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 22:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473BC31F982;
	Thu, 21 May 2026 22:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5mB+fdi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132A8332EBD
	for <linux-hyperv@vger.kernel.org>; Thu, 21 May 2026 22:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779401205; cv=none; b=SUg+Bn5AIQcP/nLGmZl1YDEbAoYJPwQPtA4E+nT7hHKw14IvIieFq2HpDKru74G9i2zLXAjFq30ogPBHFci5HNT0YfZTViw1OjDnfn/UALvaE2oB9tooCEDT7dPvkuUtm2RsN0ctLAyE38rW6Y+rLmSB6PcXTP6nXQX01cSXFcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779401205; c=relaxed/simple;
	bh=XpRE0VC4sKgmbJMSIPotXcV33O1wTXitFPZFglQsWYE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FlSm8FgvbVJ/n9uJUSQmyE8EfwHETzUui943tDz1aEl70ZCezhS6B+7vRaB0R/x9XPh+W+u5+Q+bdfq2IVLVevjDc4PjXi/gujBpjskux/FmE8bI6Yi78eSCvV3KDpZXhWlps6UA1Fy5KpmzbzIri8KTR5b2i5L2rN1wRdCaqPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5mB+fdi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E301F000E9;
	Thu, 21 May 2026 22:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779401203;
	bh=FsDflHE0BvAK673/DA79TmM4iffkAlZBAmieO3lFuOs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M5mB+fdiC6X5vvxUlpE8Ac+FzKEj+wT3mHmYYtbGMIDh18LLzLyv0TadciNs5SGEU
	 KzZfFLrgqqq+ieGGx2SAleTob9KO675xG1Ldty60UsKZ6/ugNZigPbFPcTfYeWbBBl
	 7j6cLGxLMv8coUqAxVOvdJ+KdCP/KUJnhSZPQRWkGIelYPyk/4l/TrA2nLdYKRVR3d
	 Nt1jdsqmcf5gUHQ9qrcqsLalGtgQ9kzBcEbrEhMEkQ35yTZ85xkhBIijKa//tB7MVX
	 yRQmX1tLUIPbVTYa6xb62TdQFg4GHV5UJZ7+ktNit2a1/1Mj6+FsHu95eoow+/HiME
	 wmaPpRdoxSnkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] drm/hyperv: validate VMBus packet size in
 receive callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Berkant Koc" <me@berkoc.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <6e5d1d57a3afc4c5ea0d2a3d62be58c90741a869.1779396074.git.me@berkoc.com>
References: <6e5d1d57a3afc4c5ea0d2a3d62be58c90741a869.1779396074.git.me@berkoc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 22:06:43 +0000
Message-Id: <20260521220643.A4E301F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11154-lists,linux-hyperv=lfdr.de];
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
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_SPAM(0.00)[0.994];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 26F5B5AC471
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The completion `hv->wait` is not re-initialized before sending a n=
ew request, leading to premature completions and use of stale data.
- [High] The wait thread unconditionally trusts that the received message i=
n `hv->init_buf` matches the expected response type without validating `vid=
_hdr.type`.
- [High] If the host sends a packet larger than VMBUS_MAX_PACKET_SIZE, the =
channel becomes permanently wedged.
- [High] Unprotected concurrent access to `hv->init_buf` causes outbound re=
quest corruption.
--

commit 6ae2d5d611e1bfae5ccaf2facc0f88f11136806d
Author: Berkant Koc <me@berkoc.com>
Date:   Tue May 19 20:08:53 2026 +0000

drm/hyperv: validate VMBus packet size in receive callback

This commit validates the size of received VMBus packets to prevent
reading past the end of the receive buffer. It requires specific
payload sizes based on the message type. It also prevents copying
when vmbus_recvpacket() returns an error.

Cc: stable@vger.kernel.org # 5.14+

> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/=
hyperv/hyperv_drm_proto.c
> index c3d0ff229e3d0..48054b6078f54 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> @@ -420,26 +420,81 @@ static int hyperv_get_supported_resolution(struct h=
v_device *hdev)

[ ... ]

>  	/* Complete the wait event */
>  	if (msg->vid_hdr.type =3D=3D SYNTHVID_VERSION_RESPONSE ||
>  	    msg->vid_hdr.type =3D=3D SYNTHVID_RESOLUTION_RESPONSE ||
>  	    msg->vid_hdr.type =3D=3D SYNTHVID_VRAM_LOCATION_ACK) {
> -		memcpy(hv->init_buf, msg, VMBUS_MAX_PACKET_SIZE);
> +		size_t need =3D hdr_size;
> +

[ ... ]

> +		if (bytes_recvd < need) {
> +			drm_err_ratelimited(&hv->dev,
> +					    "synthvid packet too small for type %u: %u < %zu\n",
> +					    msg->vid_hdr.type, bytes_recvd, need);
> +			return;
> +		}
> +		memcpy(hv->init_buf, msg, bytes_recvd);

[Severity: High]
This isn't a bug introduced by this patch, but does the receive callback
overwrite hv->init_buf concurrently while process-context functions are usi=
ng
it to construct outbound requests?

For example, if hyperv_get_supported_resolution() is building a request in
hv->init_buf, and a delayed response from a previous request arrives, this
memcpy() will overwrite the buffer.

[Severity: High]
This is a pre-existing issue, but does the wait thread unconditionally trust
that the message in hv->init_buf matches its expected response type?

Since this callback completes the wait for multiple message types, an unexp=
ected
or delayed message could cause the waiting thread to awaken and parse overl=
apping
union fields incorrectly.

>  		complete(&hv->wait);

[Severity: High]
This is a pre-existing issue, but is the completion hv->wait ever
re-initialized before being reused?

If a request times out and the host responds later, complete() will be call=
ed,
leaving the completion signaled. The next request calling
wait_for_completion_timeout() will return immediately, leading to
desynchronization. Should callers use reinit_completion() before sending a
request?

>  		return;
>  	}

[ ... ]

> @@ -464,9 +519,9 @@ static void hyperv_receive(void *ctx)
>  		ret =3D vmbus_recvpacket(hdev->channel, recv_buf,
>  				       VMBUS_MAX_PACKET_SIZE,
>  				       &bytes_recvd, &req_id);
> -		if (bytes_recvd > 0 &&
> +		if (!ret && bytes_recvd > 0 &&

[Severity: High]
This is a pre-existing issue, but if vmbus_recvpacket() returns -ENOBUFS
because the host sends a packet larger than VMBUS_MAX_PACKET_SIZE, does the
channel become permanently wedged?

The loop condition will exit, and the oversized packet remains in the ring
buffer. Subsequent interrupts will continue to fail with -ENOBUFS, resulting
in a permanent channel stall.

>  		    recv_buf->pipe_hdr.type =3D=3D PIPE_MSG_DATA)
> -			hyperv_receive_sub(hdev);
> +			hyperv_receive_sub(hdev, bytes_recvd);
>  	} while (bytes_recvd > 0 && ret =3D=3D 0);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779396074.gi=
t.me@berkoc.com?part=3D2

