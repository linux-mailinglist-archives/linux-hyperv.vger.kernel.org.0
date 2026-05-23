Return-Path: <linux-hyperv+bounces-11177-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MiBAqnCEWpDpgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11177-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 17:07:21 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0475BF8D8
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 17:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20C993005D25
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 15:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB9E2F7AD2;
	Sat, 23 May 2026 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XibI3nC9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAC330EF80
	for <linux-hyperv@vger.kernel.org>; Sat, 23 May 2026 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779548769; cv=none; b=XfFc+fXknDwDdvHBM1pZ4P3w103ilhCmvNS5JO/l74oT+SuUlGKqAxHgsdoI0xOjljoOzgF/Uq4AH2TVsTC+1GXgtgIAdne0hEO3sVFWY7lm2WeIfQkO4B+ht+B6zfLjuYhMuGha7/javev6akMwEbw/wmkgyzyoxn1rnb6YzNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779548769; c=relaxed/simple;
	bh=YIM4bW2BMZkR2GcqwKGaxZCEvgvurnJM5m1C6ITdtUU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YDU4Gtmc3FnfTnEZGiaqQF9Bate7mXl3sE+gy2zTW24xRgZfu5JlzPPg2EtVhjMNBUtVODNG3QdDLwdfejgSZ921AZStWgqEsOyMQDBBFhBEJ+0PGqUVYLbu7PAttk5OrlLGwHw0H7yMwqOtuqG2FPDUENxYkNiZgXl00D/GaDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XibI3nC9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6C71F000E9;
	Sat, 23 May 2026 15:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779548766;
	bh=DRedW4LZO65S4Q2frHKk35Du0FDdQScCsMjLs89maOk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XibI3nC99WuOI9nwWkhpINQLhZ9AoWRIEOhF8FPl6ojPhfwH5X6QyBkg7LUYaF+dZ
	 vgKofxMwt9/ojhx8DFYxBKTv1AeIimn1qUyFl84iHAQ+p++7ADTFHypVsqPKYHQ8eQ
	 FBPCrfvhhAmH6sKxwbkHuIxMAsvVnUcW2nMzBDogAJZHx+10BNa9INPpgFQizKQuWF
	 HtM9+sAlaLQuJ1698amJJKLSaKhYuSfvAUOVByyvIDu8BTmWIuscneWfgXbvBei9iE
	 D8A3nY4hr+ZiM+KXt20h+axzagdyoAH40HQ4TryqFMUUw5Ml8tkmSBnW1benj+zmxy
	 WUA+Tg90su3zQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] drm/hyperv: validate VMBus packet size in
 receive callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Berkant Koc" <me@berkoc.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <8200dbc199c7a9b75ac7e8af6c748d2189b5ebd5.1779542874.git.me@berkoc.com>
References: <8200dbc199c7a9b75ac7e8af6c748d2189b5ebd5.1779542874.git.me@berkoc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 15:06:05 +0000
Message-Id: <20260523150606.3C6C71F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11177-lists,linux-hyperv=lfdr.de];
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
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.994];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: 5A0475BF8D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing completion reinitialization allows unsolicited host respon=
ses to prematurely satisfy future waits.
- [High] Lack of message type verification after waiting causes type confus=
ion on mismatched responses.
- [High] Concurrent overwrites of the shared `hv->init_buf` by the receive =
handler cause a TOCTOU data race and data corruption.
--

commit 3d83b43936914ea3bbc3740ccb46ab0c33af0c7a
Author: Berkant Koc <me@berkoc.com>

drm/hyperv: validate VMBus packet size in receive callback

This patch adds validation for the received VMBus packet size to ensure
it covers the pipe and synthvid headers. It also computes the type-specific
payload size and ensures the copy length is properly bounded.

> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/=
hyperv/hyperv_drm_proto.c
> index c3d0ff229e3d0..4e6f703a1b334 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
[ ... ]
> @@ -420,30 +420,92 @@ static int hyperv_get_supported_resolution(struct h=
v_device *hdev)
>  	return 0;
>  }
> =20
> -static void hyperv_receive_sub(struct hv_device *hdev)
> +static void hyperv_receive_sub(struct hv_device *hdev, u32 bytes_recvd)
>  {
[ ... ]
> +	/*
> +	 * Shared completion path for the wait-event responses
> +	 * (VERSION_RESPONSE, RESOLUTION_RESPONSE, VRAM_LOCATION_ACK):
> +	 * require the type-specific payload before handing the buffer to
> +	 * the waiter.
> +	 */
> +	if (bytes_recvd < need) {
> +		drm_err_ratelimited(&hv->dev,
> +				    "synthvid packet too small for type %u: %u < %zu\n",
> +				    msg->vid_hdr.type, bytes_recvd, need);
> +		return;
>  	}
> +	memcpy(hv->init_buf, msg, bytes_recvd);

[Severity: High]
This is a pre-existing issue, but does the shared use of hv->init_buf creat=
e a
data race?

The driver uses the lockless hv->init_buf for both preparing outgoing reque=
sts
and receiving incoming responses.

If a malicious host sends an unsolicited response packet while the driver
thread is actively reading from or writing to hv->init_buf, could this
Time-of-Check to Time-of-Use (TOCTOU) overwrite cause the host to bypass
validations?

For example, could the host change resolution_count to exceed bounds after =
it
was checked in hyperv_get_supported_resolution()?

[Severity: High]
This isn't a bug introduced by this patch, but does the driver verify the
message type after waiting for the response?

Because hyperv_receive_sub() copies any of the three wait-driving message
types into hv->init_buf and completes the wait, a malicious host could send
a different response type (like SYNTHVID_VERSION_RESPONSE) than the one
requested.

The consumer (like hyperv_get_supported_resolution()) will then parse the
buffer as the expected type without checking msg->vid_hdr.type, reading
mismatched fields and bypassing the newly added length validations.

> +	complete(&hv->wait);

[Severity: High]
This isn't a bug introduced by this patch, but does the driver fail to
reinitialize the completion before waiting?

If a compromised or misbehaving host sends an unsolicited completion-driving
message, complete() will increment the internal counter.

When the driver subsequently sends its next request and calls
wait_for_completion_timeout(), it will return immediately without waiting
for the actual response, allowing the driver to proceed with mismatched or
leftover data.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779542874.gi=
t.me@berkoc.com?part=3D2

