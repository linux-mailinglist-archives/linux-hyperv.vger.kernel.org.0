Return-Path: <linux-hyperv+bounces-11249-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDagMEQUF2pf3QcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11249-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 17:56:52 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 213A75E747E
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 17:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D03043114870
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 15:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E748A42EED5;
	Wed, 27 May 2026 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ha5qHCIB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9153642EEC5
	for <linux-hyperv@vger.kernel.org>; Wed, 27 May 2026 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896526; cv=none; b=s/9jIhs40jmxusD1LBMcLmnCIWSWuXDeq3FPxlm/uGLZBgjzWHnUhA1BjjzdJftUbJMvgcEiH7RkOmHO6AC9c9gI4b+VgueGuXzI1Fb5c2uKZldKA9XwKCOfIIUCmHWOom5h7YZUE95hA/UqhemEBOJCpiI4TlVXjE6JZdb8uc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896526; c=relaxed/simple;
	bh=Il5TTgZZuPreqSAVntMqokXtSyvjn/lOmSjqhfOp1ac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i4SI1xAsAY+B42VvsWNKPGZLaTfTs/XQHhVQl8HFdyiFMJCFTE4AtBmkxI0urZgyA1CCi3dTcdg7HzlFJr7bketsEBKjBpjC3jQqqtdiBZEeZRLSlsigiFJGeWAoI1g0yZT8O5so6vrieXXu2ANZhDM2t68MnHE0X0htDyKPIrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ha5qHCIB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140101F000E9;
	Wed, 27 May 2026 15:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779896525;
	bh=lrWXyRCzhzKWlmuF/OpfVXL71RcRw4S8dM99HRM+OTM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ha5qHCIBnXEbrOrR8r3VlsBHJTOdgdM3xGUbZmnOdT8g4b9D6/ihamspWc3ukhtbx
	 RMMpzQhSkjw4xuhnstGb0Dvy+aa4bkWhAXuchorK6SqpyZsV2DkLRnaHUstgNyXEJM
	 gG3kaizIbgVW4sWR5MW50Ik+qcDMPqdH133/uEunhQwQqIZKhLvV0Mlo87umnpSYoH
	 Vq/2HGsNf491QO18DUvwiBoqtDpfsuGoKpwxms+FOpYmUDkg8UIpBO41VCnGFVoaxZ
	 XZJRp77jGLnnsfQl1qqWKeiDCehlZLebZvZuktNLqMhLBsoewKhdW9OWOdW4v5XnSC
	 0k004PdFHay4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/10] drm/appletbdrm: Allocate request/response
 buffers in begin_fb_access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260527145113.241595-6-tzimmermann@suse.de>
References: <20260527145113.241595-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 15:42:04 +0000
Message-Id: <20260527154205.140101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11249-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 213A75E747E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unbounded accumulation of damage clip sizes causes an integer =
overflow, resulting in an undersized buffer allocation and subsequent out-o=
f-bounds heap write.
- [High] The plane `atomic_update` callback incorrectly calls sleeping func=
tions, violating DRM atomic context guidelines.
- [High] Mismatched coordinate space intersection and inconsistent calculat=
ion ordering lead to uninitialized memory gaps and malformed hardware paylo=
ads.
--

commit fc37b98d4bfc3183056fa690c4e2e659894c67e7
Author: Thomas Zimmermann <tzimmermann@suse.de>
Date:   Wed May 27 14:46:24 2026 +0000

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
>  	DRM_FORMAT_XRGB8888, /* emulated */
>  };
> =20
> -static int appletbdrm_primary_plane_helper_atomic_check(struct drm_plane=
 *plane,
> -						   struct drm_atomic_commit *state)
> +static int appletbdrm_primary_plane_helper_begin_fb_access(struct drm_pl=
ane *plane,
> +							   struct drm_plane_state *new_plane_state)
>  {
>  	struct appletbdrm_plane_state *appletbdrm_state =3D to_appletbdrm_plane=
_state(new_plane_state);
> +	size_t frames_size =3D 0;
>  	struct drm_atomic_helper_damage_iter iter;
>  	struct drm_rect damage;
>  	size_t request_size;
> =20
> -	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, new_plane_st=
ate);
> +	drm_atomic_helper_damage_iter_init(&iter, NULL, new_plane_state);
>  	drm_atomic_for_each_plane_damage(&iter, &damage) {
>  		frames_size +=3D struct_size((struct appletbdrm_frame *)0, buf, rect_s=
ize(&damage));
>  	}

[Severity: Critical]
This is a pre-existing issue, but could the unbounded accumulation of damage
clip sizes cause an integer overflow?

The FB_DAMAGE_CLIPS property allows userspace to pass an unbounded number of
damage clips, limited only by the maximum DRM property blob size.

If millions of clips are provided, accumulating the sizes with:

    frames_size +=3D struct_size(...)

could wrap around size_t on 32-bit systems. Even if frames_size doesn't wra=
p,
the subsequent calculation:

    request_size =3D ALIGN(sizeof(...) + frames_size + sizeof(...), 16)

might easily wrap around to a small value, causing kvzalloc() to successful=
ly
allocate an undersized buffer.

When appletbdrm_flush_damage() iteratively processes the exact same clips,
could it trust the per-clip buf_size and copy pixel data into the undersized
buffer via drm_fb_memcpy(), resulting in an out-of-bounds heap write?

[Severity: High]
This is also a pre-existing issue, but does this allocation properly account
for the intersection calculations that happen later?

In appletbdrm_flush_damage(), buf_size is calculated before the intersectio=
n:

    buf_size =3D rect_size(&damage);
    if (!drm_rect_intersect(&dst_clip, &damage))
        continue;

If the intersection shrinks the damage rectangle, drm_fb_memcpy() copies fe=
wer
bytes than buf_size, leaving zeroed memory at the end of the frame buffer.
Since frame->buf_size was already set to the original size, the hardware wi=
ll
read these zeroes as pixel data.

Furthermore, dst_clip is in CRTC coordinates while damage is in Framebuffer
(SRC) coordinates. If userspace utilizes a framebuffer larger than the CRTC
and applies a source offset, the coordinate spaces will not overlap properl=
y.
This causes valid damage clips to be skipped entirely.

Since the begin_fb_access() helper factored these skipped clips into the to=
tal
frames_size allocation without performing the intersection, skipping them l=
ater
fails to advance the frame pointer.

Could this leave uninitialized gaps before the footer, corrupting the packed
payload structure sent to the hardware?

[ ... ]

> @@ -468,7 +474,7 @@ static int appletbdrm_flush_damage(struct appletbdrm_=
device *adev,
>  }
> =20
>  static void appletbdrm_primary_plane_helper_atomic_update(struct drm_pla=
ne *plane,
> -						     struct drm_atomic_commit *old_state)
> +							  struct drm_atomic_commit *old_state)
>  {
>  	struct appletbdrm_device *adev =3D drm_to_adev(plane->dev);
>  	struct drm_device *drm =3D plane->dev;

[Severity: High]
This is a pre-existing issue, but does this code execute sleeping functions
from an atomic context?

According to DRM atomic context guidelines, plane atomic update callbacks
execute in an atomic context where sleeping is forbidden.

The appletbdrm_primary_plane_helper_atomic_update() callback invokes
appletbdrm_flush_damage(), which subsequently calls:

    drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);

This function takes locks and can wait on fences. The flush function then
performs synchronous USB bulk transfers, which also sleep.

Could this break atomic context rules and cause system instability?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527145113.2415=
95-1-tzimmermann@suse.de?part=3D5

