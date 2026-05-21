Return-Path: <linux-hyperv+bounces-11151-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ46FJd6D2rLMgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11151-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 23:35:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F265AC21F
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 23:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9D4F3002D0E
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 21:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C6C27FD4B;
	Thu, 21 May 2026 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMerA9lz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF31390C81
	for <linux-hyperv@vger.kernel.org>; Thu, 21 May 2026 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779398785; cv=none; b=Ca2UJwA0V9/Nd5gLa1c1/sYOAplmva4XmRJD3QuJUL3m0LvD+efIv4t9KbER01SAVYjPcfOW4mUo5mUDfrmIKQqrKW5+8E64EuLXvZll1ZoeoCGs49ahRXuUU44yiGDRXTBolmOVyP6dE2ekX0feTcxzA68a5S4GYe5rrd6pBac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779398785; c=relaxed/simple;
	bh=l2vxgdMpzQKolV1RUYn56vNxvAKWbZC0t3vkFbEB1Uo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tTpwNvx/fs1cZNeNbx49iCWoHwiSAc372BljiLQ1Gd1dKYAZXYVuzwYy6cu2uRLuThZ60cE0y2tIx3QLLp4OnRUhcMYZ9ZGra1lV/QBXIn66f+QIYAvvIX8eaHanyF5acqRulMxnCWsb9ir5rYCOOWSlJ0LXVuUUxkEyK0Su1vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMerA9lz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36C91F000E9;
	Thu, 21 May 2026 21:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779398783;
	bh=eRgXmf8TpoH2ubx1pSTqtSyLvtyjvUdOkEm9t834jg8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UMerA9lzVCgdZzW3CoXHGdKvXfi4zqUBKQ2yl6poCXC+qg5zuOf3oILgZ3eHzx0rR
	 roCC9UFtBb9y1Bueeg333JzUrU7VtBFdot79sj7mlSbR3nMlJsnxG0Tnq8ijxhjKNW
	 ZMJrf/VFNXD1XoFGMqaiJ/IK7isCRyUM+nuh5cgmb77wf+PbzIU2u2goGdOcb6zTDB
	 cS993DaxfciReEJakSO1hDbkU1X/3Z4iblAxIEm555FWKrSONwI/7Nkb/lgSMZ+xeu
	 WkDXYzzlW6N7NycsibAUEucQBNcO+NiCaZOngvzDODL71V6GUUzU5YlqigIzXWKI2U
	 X784uX/PsFIFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] drm/hyperv: validate resolution_count and fix
 WIN8 fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Berkant Koc" <me@berkoc.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <6945b22419c7d404b4954a113de2ac9c900dba93.1779396074.git.me@berkoc.com>
References: <6945b22419c7d404b4954a113de2ac9c900dba93.1779396074.git.me@berkoc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 21:26:23 +0000
Message-Id: <20260521212623.C36C91F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11151-lists,linux-hyperv=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20260515];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	TAGGED_RCPT(0.00)[linux-hyperv];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_SPAM(0.00)[0.997];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,smtp.kernel.org:mid,sashiko.dev:url]
X-Rspamd-Queue-Id: 52F265AC21F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing Completion Reinitialization causes state machine desynchro=
nization.
- [High] Missing Message Type Validation allows parsing of incorrect respon=
se payloads.
--

commit e5968f0d509475850afc95a1bf9a982ea5002949
Author: Berkant Koc <me@berkoc.com>

drm/hyperv: validate resolution_count and fix WIN8 fallback

This commit bounds resolution_count against the array size to prevent walki=
ng
past the supported_resolution array in the parse loop. It also provides a
single post-probe fallback to ensure userspace framebuffers are not rejected
when the WIN10 resolution probe fails.

> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/=
hyperv/hyperv_drm_proto.c
> index 051ecc5268321..c3d0ff229e3d0 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> @@ -391,8 +391,11 @@ static int hyperv_get_supported_resolution(struct hv=
_device *hdev)
>  		return -ETIMEDOUT;
>  	}

[Severity: High]
This is a pre-existing issue, but is it possible for the state machine to
become desynchronized here if a timeout occurs?

The driver uses wait_for_completion_timeout() for synchronous VMBUS request=
s.
If the host is slow and the wait times out, the hv->wait completion counter=
 is
not decremented since it returns early.

If the host responds after the timeout, hyperv_receive_sub() calls
complete(&hv->wait), incrementing the counter. Because the driver never cal=
ls
reinit_completion(&hv->wait) before sending a new request, the next transac=
tion
could consume the late completion from the previous request immediately.

For example, a timeout during hyperv_get_supported_resolution() followed by=
 a
late response could cause a subsequent hyperv_update_vram_location() to
complete immediately before the host has actually acknowledged the VRAM
location, which might lead to memory corruption or VM crashes.

> =20
> -	if (msg->resolution_resp.resolution_count =3D=3D 0) {
> -		drm_err(dev, "No supported resolutions\n");
> +	if (msg->resolution_resp.resolution_count =3D=3D 0 ||
> +	    msg->resolution_resp.resolution_count >
> +	    SYNTHVID_MAX_RESOLUTION_COUNT) {

[Severity: High]
This isn't a bug introduced by this patch, but should the code verify the
message type before accessing the payload?

The driver uses a single wait completion (hv->wait) and a single response
buffer (hv->init_buf) for multiple VMBUS message types. In
hyperv_receive_sub(), receiving any valid response type (e.g.,
SYNTHVID_VERSION_RESPONSE, SYNTHVID_RESOLUTION_RESPONSE,
SYNTHVID_VRAM_LOCATION_ACK) will trigger complete(&hv->wait).

Functions waiting for responses, like hyperv_get_supported_resolution(), ap=
pear
to assume the payload in hv->init_buf is the correct response type without
verifying msg->vid_hdr.type.

If the state machine is desynchronized (e.g., due to a previous timeout) or=
 a
buggy host sends an unsolicited response, could the driver misinterpret the
payload by reading fields like resolution_count from stale memory or data
belonging to a different response type?

> +		drm_err(dev, "Invalid resolution count: %d\n",
> +			msg->resolution_resp.resolution_count);
>  		return -ENODEV;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779396074.gi=
t.me@berkoc.com?part=3D1

