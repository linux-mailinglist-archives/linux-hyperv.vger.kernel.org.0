Return-Path: <linux-hyperv+bounces-11248-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD6kGGENF2oR2gcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11248-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 17:27:29 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7835E6DAC
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 17:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA79C30422DF
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 15:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D7635F180;
	Wed, 27 May 2026 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAZpYVt8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525FE423A80
	for <linux-hyperv@vger.kernel.org>; Wed, 27 May 2026 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895324; cv=none; b=WH0s64iMI/+5DmK4H2EXN62WC5wDXwTWKf1H1ykUFCC6uuDJTAaQQhJq9CfQo0XkaP7FqfXDXFa7ADIv65QBsKeJJ+tiINuGSjwgB+LxX+gva1PSkbJQByPYmKMEFzaoyPiUelF9s6IoQz7YBByQZ/1qubF8l912aA5Ka8A+Jnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895324; c=relaxed/simple;
	bh=iGLrbUC7V0PH4BQ97Ko8S5LhjhnxRjItScmiUwAfJho=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QW7wA4xtt9ZnbHyQZbVp2o44CjM50pmMC6xoKNQTMZB6LD4wK1/61GKKHtBGcZkj8dog0FbCgA4EbJv4on5tCNOh0JVda2yjv8vJH1C2cbVUGdm2KSl5eky0xfDUOqkcXI2c4mNuw2VMt01FehRaUXU2H8tggCYVXw2iSEN3Oo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAZpYVt8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F49F1F000E9;
	Wed, 27 May 2026 15:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779895320;
	bh=+Jj/uuMIJAZYhW6SsSmHA74OlMVhhMt//vmT5hLwJ2Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WAZpYVt8DYQ/ed+jVaxBVdFVTj34+mJcHxokH5lLQqjilo9PzltgoOH4CtNheOBE4
	 GI5i6/qFHP/0zI0u0eIXXJFYw4ppn4IflPl7QMuZG9qWnngxARFAQE1oUZT6fpAXqQ
	 wBSLOHvCIYdwPAUfB8aT5WpPq158d7xK/o7395D6oG3Q0Tq18U8lJCv6GGzghvRvWU
	 Scrz+/PpvPJeZwmvvClo0AU478IbAz9qNkoVxUicL9GmdfBLeNWNIMkDA/Rve+7IKt
	 i95SSKh6U/VMsO4Q0sVNUHWjTPc5tInzZqU4rsPOqoyoOvbZFy1IZHzliYZvtQy8+H
	 SLVmiLaVYVz9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/10] drm/vmwgfx: Remove unused field struct
 vmwgfx_du_update_plane.old_state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260527145113.241595-11-tzimmermann@suse.de>
References: <20260527145113.241595-11-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 15:22:00 +0000
Message-Id: <20260527152200.9F49F1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11248-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: CF7835E6DAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Plane atomic_update callbacks indirectly call sleeping functions (=
mutex_lock/mutex_lock_interruptible) from an atomic context.
--

commit deccb03fba43ed6006d88ae9933240eb52b52fee
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/vmwgfx: Remove unused field struct vmwgfx_du_update_plane.old_state

This commit removes the unused old_state field from the
vmw_du_update_plane structure and updates all caller functions to
accommodate this change.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgf=
x/vmwgfx_scrn.c
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
[ ... ]
> @@ -721,7 +717,6 @@ static void
>  vmw_sou_primary_plane_atomic_update(struct drm_plane *plane,
>  				    struct drm_atomic_commit *state)
>  {
> -	struct drm_plane_state *old_state =3D drm_atomic_get_old_plane_state(st=
ate, plane);
>  	struct drm_plane_state *new_state =3D drm_atomic_get_new_plane_state(st=
ate, plane);
>  	struct drm_crtc *crtc =3D new_state->crtc;
>  	struct vmw_fence_obj *fence =3D NULL;
> @@ -734,12 +729,9 @@ vmw_sou_primary_plane_atomic_update(struct drm_plane=
 *plane,
>  			vmw_framebuffer_to_vfb(new_state->fb);
> =20
>  		if (vfb->bo)
> -			ret =3D vmw_sou_plane_update_bo(dev_priv, plane,
> -						      old_state, vfb, &fence);
> +			ret =3D vmw_sou_plane_update_bo(dev_priv, plane, vfb, &fence);
>  		else
> -			ret =3D vmw_sou_plane_update_surface(dev_priv, plane,
> -							   old_state, vfb,
> -							   &fence);
> +			ret =3D vmw_sou_plane_update_surface(dev_priv, plane, vfb, &fence);

[Severity: High]
This is a pre-existing issue, but does this code path end up calling sleepi=
ng
functions from an atomic context?

Looking at the call chain, vmw_sou_primary_plane_atomic_update() is a plane
atomic update callback, which runs in atomic context where sleeping is
forbidden. However, it calls vmw_sou_plane_update_surface(), which assigns a
mutex pointer to the update structure:

vmw_sou_plane_update_surface()
  srf_update.base.mutex =3D &dev_priv->cmdbuf_mutex;
  vmw_du_helper_plane_update(&srf_update.base);

This closure is then passed down to vmw_du_helper_plane_update(), which cal=
ls
vmw_validation_prepare(). That function then takes the lock using
mutex_lock() or mutex_lock_interruptible().

Could this lead to system instability or deadlocks if the atomic commit runs
in a non-blocking path where sleeping is not allowed?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527145113.2415=
95-1-tzimmermann@suse.de?part=3D10

