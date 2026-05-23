Return-Path: <linux-hyperv+bounces-11176-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPe9K6e7EWo5pQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11176-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 16:37:27 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 508465BF6CD
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 16:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E9CD30010D0
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 14:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA562DC32E;
	Sat, 23 May 2026 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ujz9qfZu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6015E2D1F44
	for <linux-hyperv@vger.kernel.org>; Sat, 23 May 2026 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779547043; cv=none; b=epAOZcCofTLOx+9HHKFsMHN7SxicWFFSutMpu1Klm84NtVtGlJ1cSTRQjie1uE0DiOeSNsCqk51tW/VuPfeEI9af6CjDPGP14swM/QHn0RRgI40I71EkNA5R1InPam75UP5/R+vne37txUJTIqgSSzU3dP2yjH+oOSfpG50cuOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779547043; c=relaxed/simple;
	bh=qiqaQQQPGXUYIskbzcPMgWfsZ329FRB0LdyTdghVTT4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p6BaonikBZdcC9S7VeTAVE4gM76jAeyo8A9hCQKvdr1+eq1TyuwF6LvGZj57HVsHaIIomSKjfteWBAs7uQ4uWmkVMKBIQSbNw9D6EiKbYPUxD0jj0StThj2xltjDI8iDi2MyDkmvpDOt2u2o7OiVxVri97pNNPHPzKzzFhmnTxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ujz9qfZu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D681F000E9;
	Sat, 23 May 2026 14:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779547042;
	bh=n8jqhn9EdTq6WjqfIiaoctrUoTHOVjfrtwJSuS5l20A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ujz9qfZudx8cnYq1CqCQLr001K9+2TOZflgv+EV/Kt9x2gVSlpk/N+My+suokhKmY
	 8Mnjtric92QqRaGx4w4nAf6H64tVyKYHlvcAePl5V5sgkFOef90FLAGKIGMy5xG2Mw
	 4YVPpW0AvS7oEsE655M94ly7o/+YMnyCBQXmssJ7GMZ6rvOTSQQ5nUluwlD7ghN8Bh
	 QuG2fXm5iksJaGg4Z1bJshclLIQ4fdcmn/Mf8+/TgvxNG9Y3SfuW+/pYxE1JgIfuSM
	 L/LfWNlbrnEKfIMACdgaM0g59tgmuMrN4owIZGZjCK89QOdOHPsKABqt86ZIOYHcc2
	 +QU+lcNZKw7Ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] drm/hyperv: validate resolution_count and fix
 WIN8 fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Berkant Koc" <me@berkoc.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <6945b22419c7d404b4954a113de2ac9c900dba93.1779542874.git.me@berkoc.com>
References: <6945b22419c7d404b4954a113de2ac9c900dba93.1779542874.git.me@berkoc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 14:37:21 +0000
Message-Id: <20260523143721.E3D681F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11176-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.993];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 508465BF6CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] State Machine Desynchronization and Type Confusion due to missing =
reinit_completion()
--

commit 75355159caa20ef4cf6b36266c2aa7dcbac0177d
Author: Berkant Koc <me@berkoc.com>

drm/hyperv: validate resolution_count and fix WIN8 fallback

This commit bounds the resolution_count in SYNTHVID_RESOLUTION_RESPONSE
to avoid out-of-bounds array access. It also adds a unified fallback
for WIN8 default resolutions when the probe fails or max dimensions
are left unpopulated.

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
This is a pre-existing issue, but does reusing hv->wait without calling
reinit_completion() risk state machine desynchronization?

If a prior request like hyperv_negotiate_version() times out, a delayed
response could trigger complete(&hv->wait) and leave the completion
signaled. When wait_for_completion_timeout() is called in this function,
would it return immediately without waiting for the actual response?

If a WIN10 version negotiation times out and falls back to WIN8, could a
delayed WIN10 response satisfy the subsequent WIN8 wait, leading the driver
to mistakenly assume the hypervisor agreed to the WIN8 protocol?

Since there is no validation of msg->vid_hdr.type after waking up, could
this lead to type confusion where a delayed response from an earlier
request is incorrectly interpreted as the current response?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779542874.gi=
t.me@berkoc.com?part=3D1

