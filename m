Return-Path: <linux-hyperv+bounces-11244-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLqHLoALF2pB2AcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11244-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 17:19:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B78955E6BF1
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 17:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7285230015B2
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 15:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9899E428462;
	Wed, 27 May 2026 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAftXAK9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60E13BE635
	for <linux-hyperv@vger.kernel.org>; Wed, 27 May 2026 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894605; cv=none; b=PC5/zUDmrcISzQ5VcSSMoWGCC3lBLXjbqwJNb0Gg6emltyPnxboX68aK83tedrjcLyD4ZUlrXNoNquw0QaXfYKgmlNtoUCJbUAchc4c8oEe/BHj7Fsj/hxuaTmXg81bFKO/ZNYPEWOwqe62Re++vYH/+elVYv+PIM//OND4iALM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894605; c=relaxed/simple;
	bh=ngjW2Za4K7Dz9t+hgsPxUIGzpI6rksXQ2TgwajtdiJk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=raDJhDyHBGyz1LSQjeqz894W/cPOllhVV5Q1hHjbgDUg5ScqleTHXQBIP1aZg64SX+Hus4JGk0dL3hWWEN8wWzVFhBLwpE5CFXFxpv3cD9S7JPracP1k7xv38b7usJ4KihDUhWCVql0AMahzLxk6EXrB79xUZHQdIWuJ5ei292o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAftXAK9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F25D1F000E9;
	Wed, 27 May 2026 15:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779894603;
	bh=Fs5ONwIJ7g3LdUkaZgI4GS3oHvc5MLp0ofzzGtV7kQk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kAftXAK9qd/Bs9iWVt/s6POVvx1t1bjRgM1QSC1RcJC8OORtJaOwdukXVqRMehpM1
	 iOPzmoKUBcLCF6FWclLEurQVwEA0aSgD9RUwFZwzFWRxihhdEsbpJnd4it+MyGO3hf
	 r1c0Dib7KA5kTaPQF8ip60Zv3omfiUvIO4J7+ZIiMq4XMz++UYSuJVeri1tznATbLf
	 nMYvXoEK+Q5/VKYuVetrsrxVXL/knmtPtNo6PpTVAZl6HvbdJwy5bz5R2aRI4G5WYP
	 rOvWvsbC8qauN0oeLLjoFGSOV1NIK4sj5Bz1hy4cg61KWwK8eMTDZwfYstEBscpPh+
	 B1kN1Kyzog3iQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/10] drm/damage-helper: Remove old state from
 drm_atomic_helper_damage_merged()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260527145113.241595-8-tzimmermann@suse.de>
References: <20260527145113.241595-8-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 15:10:02 +0000
Message-Id: <20260527151003.4F25D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11244-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,lists.linux.dev:replyto,suse.de:email,sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B78955E6BF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the plane atomic=
 update callback `gm12u320_pipe_update` executes a path that acquires a mut=
ex. Plane atomic update callbacks run in atomic context during non-blocking=
 commits, making the use of sleeping locks unsafe.
- [High] This problem wasn't introduced by this patch, but the plane atomic=
 update callback `repaper_pipe_update` executes a path that performs a memo=
ry allocation with `GFP_KERNEL`. Plane atomic update callbacks run in atomi=
c context, where allocations that may sleep are strictly prohibited.
--

commit da86f07c371224a54756c1f750c01c663a2a7a86
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/damage-helper: Remove old state from drm_atomic_helper_damage_merged()

This patch removes the unused old_state parameter from=20
drm_atomic_helper_damage_merged() and updates all callers. It also cleans up
the old_plane_state variable in caller functions where it is no longer=20
needed.

[ ... ]

> diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u=
320.c
> --- a/drivers/gpu/drm/tiny/gm12u320.c
> +++ b/drivers/gpu/drm/tiny/gm12u320.c
> @@ -582,7 +582,7 @@ static void gm12u320_pipe_update(struct drm_simple_di=
splay_pipe *pipe,
>  	struct drm_shadow_plane_state *shadow_plane_state =3D to_drm_shadow_pla=
ne_state(state);
>  	struct drm_rect rect;
> =20
> -	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
> +	if (drm_atomic_helper_damage_merged(state, &rect))

[Severity: High]
This is a pre-existing issue, but does gm12u320_pipe_update() safely execute
in an atomic context?

This function acts as the simple display pipe's plane atomic update callbac=
k,
which runs in atomic context during non-blocking commits. However, it calls
gm12u320_fb_mark_dirty(), which acquires a mutex:

drivers/gpu/drm/tiny/gm12u320.c:gm12u320_fb_mark_dirty() {
    ...
    mutex_lock(&gm12u320->fb_update.lock);
    ...
}

Since mutex_lock() is a sleeping function, could this lead to deadlocks or
kernel warnings when called from an atomic context?

>  		gm12u320_fb_mark_dirty(state->fb, &shadow_plane_state->data[0], &rect);
>  }

[ ... ]

> diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repape=
r.c
> --- a/drivers/gpu/drm/tiny/repaper.c
> +++ b/drivers/gpu/drm/tiny/repaper.c
> @@ -837,7 +837,7 @@ static void repaper_pipe_update(struct drm_simple_dis=
play_pipe *pipe,
>  	if (!pipe->crtc.state->active)
>  		return;
> =20
> -	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
> +	if (drm_atomic_helper_damage_merged(state, &rect))

[Severity: High]
This isn't a bug introduced by this patch, but is it safe for
repaper_pipe_update() to trigger allocations with GFP_KERNEL?

Like the issue above, this acts as the plane atomic update callback. It cal=
ls
repaper_fb_dirty(), which performs a memory allocation that may sleep:

drivers/gpu/drm/tiny/repaper.c:repaper_fb_dirty() {
    ...
    buf =3D kmalloc(fb->width * fb->height / 8, GFP_KERNEL);
    ...
    ret =3D drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
    ...
}

Because plane atomic update callbacks run in atomic context, allocations th=
at
may sleep (like GFP_KERNEL) and sleeping functions like
drm_gem_fb_begin_cpu_access() are strictly prohibited. Is there a plan to
shift these sleeping operations to a workqueue or use non-sleeping
allocations?

>  		repaper_fb_dirty(state->fb, shadow_plane_state->data,
>  				 &shadow_plane_state->fmtcnv_state);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527145113.2415=
95-1-tzimmermann@suse.de?part=3D7

