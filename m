Return-Path: <linux-hyperv+bounces-11000-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFUcODfVCWpRrwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-11000-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 17 May 2026 16:48:23 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C50E561BE3
	for <lists+linux-hyperv@lfdr.de>; Sun, 17 May 2026 16:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58D923013272
	for <lists+linux-hyperv@lfdr.de>; Sun, 17 May 2026 14:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB50223DE9;
	Sun, 17 May 2026 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZjIhQiQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1AD2AEE1
	for <linux-hyperv@vger.kernel.org>; Sun, 17 May 2026 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779029265; cv=none; b=DZCuiXv5Zcl1ITp8Nu0eTPcpahwjCR6n2t6BhjP+LE4R3Avxow9CZiBzA5KCOMqiOOW1xvE785MkOTpNQXzZS0x/FNwz39y3h6S8aAsa4akcT9FvyVxBscSaFQC/3U95XlpfWDCrgnLGvwVNmKI+IPYzz/MqO0byDqwIojMEeLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779029265; c=relaxed/simple;
	bh=WuuKsRUc1xeNE/F9Tliu5ra1mI813UrbQsGtWShmNYk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f0tekbChSrf/GK5Bnck+rb81QqycfRmEfvAKg7i6xoPIWm15X/HJB8Cq2Ux4uPqHtroguZeB6vW6zW8bETvLAt8wX3MKeapnY99Tx1ZBoA5xbLBgfybqMRRqiARTVJ55RZoomf2+SeYenU7gD7NUZB00gPKx2POIH+JeKDFXlRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZjIhQiQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAFBC2BCB0;
	Sun, 17 May 2026 14:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779029264;
	bh=WuuKsRUc1xeNE/F9Tliu5ra1mI813UrbQsGtWShmNYk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=iZjIhQiQbxWKMll+NWzWv+AfeP1IceyRxQezbKXweSOQ65RasFtuJp5rDdHj0XDix
	 Dbt0/PD27s7AQuakiawptC3xnDm1ihJVpbZ4EPNWbETJYSPNPyTbN64dRB6ANO2dAz
	 RuD1Qkcb4BIrJ4luRjzkxyvB1IN1nph29EwzTXZWdZTz5KEUO31u3fdE0B/rJUtYNu
	 QzkRf90yuELNcbk1cqyt4a8uXau2mvkeFn3KsvAYBG0ehaL36Bhyg/UDxhiAbqQdHr
	 g0x8R1CW9XZ0inZ11mE0BIjET2FnIZ93vApcru9VzOuatZjeeRv6B0a/dQd7GLnbea
	 616tYMLqkmjig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] drm/hyperv: validate resolution_count and harden
 VSP request paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Berkant Koc" <me@berkoc.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260517-drm-hyperv-patch1-v2@berkoc.com>
References: <20260517-drm-hyperv-patch1-v2@berkoc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 14:47:44 +0000
Message-Id: <20260517144744.BCAFBC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 3C50E561BE3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL_FRESH15(3.00)[berkoc.com:email];
	MISSING_MIME_VERSION(2.00)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11000-lists,linux-hyperv=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
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
	NEURAL_SPAM(0.00)[0.533];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The fix for delayed VSP responses is incomplete, leaving a cri=
tical data race on the shared `hv->init_buf` that allows type confusion and=
 out-of-bounds memory reads.
--

commit 3d049f39a946f7898e25e92a422ae95b066e9989
Author: Berkant Koc <me@berkoc.com>

drm/hyperv: validate resolution_count and harden VSP request paths

This commit adds bounds checking for resolution_count when parsing
SYNTHVID_RESOLUTION_RESPONSE. It degrades gracefully to default
resolutions on failure, and adds reinit_completion() before VSP requests
to prevent consuming stale completions.

> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/=
hyperv/hyperv_drm_proto.c
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
[ ... ]
> @@ -383,6 +385,7 @@ static int hyperv_get_supported_resolution(struct hv_=
device *hdev)
>  		sizeof(struct synthvid_supported_resolution_req);
>  	msg->resolution_req.maximum_resolution_count =3D
>  		SYNTHVID_MAX_RESOLUTION_COUNT;
> +	reinit_completion(&hv->wait);
>  	hyperv_sendpacket(hdev, msg);

Does this reinit_completion() prevent a data race on the shared hv->init_bu=
f?

If a timed-out request's delayed response arrives while a new request is
being constructed, could hyperv_receive_sub() concurrently overwrite
hv->init_buf without holding any locks?

Since the buffer is used for both sending and receiving, if a delayed
response arrives exactly between the memset(msg, 0) and
hyperv_sendpacket(hdev, msg), could msg->vid_hdr.size be overwritten by
the host's response?

If a host provides a crafted size, could this cause an integer overflow in
totalbytes_towrite within hv_ringbuffer_write(), bypassing ring buffer
free-space checks and causing an out-of-bounds read of guest memory into
the VMBus ring buffer?

Additionally, if the delayed response triggers complete(&hv->wait), is
there a chance the driver parses a mismatched response because it does not
validate that msg->vid_hdr.type matches the expected response?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517-drm-hyperv=
-cover-v2@berkoc.com?part=3D1

