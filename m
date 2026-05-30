Return-Path: <linux-hyperv+bounces-11412-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHhdCww2G2oXAQkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11412-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 21:10:04 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BCF612FBA
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 21:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9966C301E988
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 19:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85945248F66;
	Sat, 30 May 2026 19:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Em4IdOfh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1BC1427A
	for <linux-hyperv@vger.kernel.org>; Sat, 30 May 2026 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780168200; cv=none; b=pfMBlAAoDbhsJRbBv4ascm/BLumT0NN3R8D05w5XnIhkIDHPWXhvwHZM4DEpWEYkL4HC1pH7iaSp6nIv3NGLfjrUSF0Q7ySCE56NhRISsl98f0hJTBV2uLNxz5w9A5Nb76E83/pILwbUztH27XJIV99JVw0kmKs3aZum5biakpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780168200; c=relaxed/simple;
	bh=qZD2g5XbN9AQK11MYDJdlS9oCACvhhnZB0EAqF8cTPo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Liu1o5y4TWKkzQC/kueiWTxEubzDF4p7P2UN8W0JqEL8C6k+s2rroriX3Kqp5+Zz9+wcaNsqbhCWu6KRI5iZYeu34ynHyKvs0idkgi0vgTFoTjLpa9z4HdQLsfFhgq756oQyPfk9z1dMLeKAYOG9L2nmmJ3P5XfC5tZKHRKrIlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Em4IdOfh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22AF1F00893;
	Sat, 30 May 2026 19:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780168199;
	bh=ZDqFr6sudmLp+G+1/FtX5EivrjYuHA8cloRtffT9SkM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Em4IdOfhvdjYz7+40mmheyN3QxWvYDnIde+LxAlCR7edLVyBEVt9oc4U6D1C816iX
	 VWUVQu74WoBNwHQxj/iY8j35pVO0M1Ls64mUUX1P2t4Zxd8STLAP4E53rzXy9CSIII
	 tHWAy8I1+kFrBY7ib0TjmQ54MOqq6UbhuW7g5NzLz6/YRIqPX2jL7VGVbdfT2x6Fkx
	 v9NI2RyLzAcwbEAppzxrW/6BElVMEvpKLDS+XXCz2O6r2kEj4ttMVzpLegOjf+57+r
	 3AxD6mpmaAjsKq6rRTAF8oUUFLGgRjQjgndCgC2ebPIDrN4pQI0XhrnOEtTH1wMDyb
	 55yPjViAN34HA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/10] drm/appletbdrm: Allocate request/response
 buffers in begin_fb_access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260530185716.65688-5-tzimmermann@suse.de>
References: <20260530185716.65688-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 19:09:58 +0000
Message-Id: <20260530190958.D22AF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11412-lists,linux-hyperv=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: 98BCF612FBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Passing `NULL` as the `old_state` parameter to `drm_atomic_hel=
per_damage_iter_init()` causes a kernel panic due to a NULL pointer derefer=
ence.

Pre-existing issues:
- [Critical] Accumulating damage clip sizes in `frames_size` can overflow o=
n 32-bit platforms, causing an undersized buffer allocation and a subsequen=
t heap buffer overflow.
--

commit 72afced3e1b6baa294269874c7c4d9d05230889c
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/appletbdrm: Allocate request/response buffers in begin_fb_access

In atomic_check, damage handling is not fully evaluated. Another
atomic_check helper could trigger a full modeset and thus invalidate
damage clips.

Allocation of the request/response buffers in appletbdrm depends on
correct damage information. Otherwise it might allocate incorrectly
sized buffers. Allocate the buffers in the driver's begin_fb_access
helper. It runs early during the commit when damage clipping has been
fully evaluated.

> diff --git a/drivers/gpu/drm/tiny/appletbdrm.c b/drivers/gpu/drm/tiny/app=
letbdrm.c
> index cdd35af498920..b683dcb35b0be 100644
> --- a/drivers/gpu/drm/tiny/appletbdrm.c
> +++ b/drivers/gpu/drm/tiny/appletbdrm.c
> @@ -315,33 +315,16 @@ static const u32 appletbdrm_primary_plane_formats[]=
 =3D {

[ ... ]

> -	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, new_plane_st=
ate);
> +	drm_atomic_helper_damage_iter_init(&iter, NULL, new_plane_state);

[Severity: Critical]
Does passing NULL as the old_state parameter to
drm_atomic_helper_damage_iter_init() cause a kernel panic?

If userspace has provided damage clips,
drm_atomic_helper_damage_iter_init() evaluates
!drm_rect_equals(&state->src, &old_state->src) to check if the source
coordinates changed:

drivers/gpu/drm/drm_damage_helper.c:drm_atomic_helper_damage_iter_init() {
    ...
	if (!iter->clips || state->ignore_damage_clips ||
	    !drm_rect_equals(&state->src, &old_state->src)) {
    ...
}

This appears to pass the address of src offset from the NULL pointer to
drm_rect_equals(), which would immediately dereference it and trigger an
oops. This could allow any userspace process with display access to
trivially crash the system by attaching a damage clip.

I found the fix for this regression later in the patch series in the
commit 'drm/damage-helper: Remove old state from
drm_atomic_helper_damage_iter_init()', but I am reporting it here since
it breaks at this step in the git history.

>  	drm_atomic_for_each_plane_damage(&iter, &damage) {
>  		frames_size +=3D struct_size((struct appletbdrm_frame *)0, buf, rect_s=
ize(&damage));

[Severity: Critical]
This is a pre-existing issue, but can this unchecked accumulation overflow
frames_size on 32-bit platforms?

Because userspace can submit an arbitrary number of overlapping damage
clips up to the maximum property blob size, this unchecked addition could
wrap around a 32-bit size_t counter, causing kvzalloc() to allocate an
undersized buffer.

During appletbdrm_flush_damage(), the driver loops over the same clips
and uses drm_fb_memcpy() to write the full, un-overflowed volume of pixel
data into the undersized allocation:

drivers/gpu/drm/tiny/appletbdrm.c:appletbdrm_flush_damage() {
    ...
		switch (fb->format->format) {
		case DRM_FORMAT_XRGB8888:
			drm_fb_xrgb8888_to_bgr888(&dst, NULL, &shadow_plane_state->data[0], fb, =
&damage, &shadow_plane_state->fmtcnv_state);
			break;
		default:
			drm_fb_memcpy(&dst, NULL, &shadow_plane_state->data[0], fb, &damage);
			break;
		}
    ...
}

This causes an out-of-bounds heap write, which could potentially be exploit=
ed.

>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530185716.6568=
8-1-tzimmermann@suse.de?part=3D4

