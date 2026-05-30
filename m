Return-Path: <linux-hyperv+bounces-11414-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dqhkBXk3G2o5AQkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11414-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 21:16:09 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F451612FF2
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 21:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5C213004D3C
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 19:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1A7548EE;
	Sat, 30 May 2026 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzttGGnv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CB51E5B68
	for <linux-hyperv@vger.kernel.org>; Sat, 30 May 2026 19:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780168563; cv=none; b=WYlQv9tH+04WH8k2+RM0SPxOfaaCeMiMEGQic96uYXBiADskh4zX8lmMhNHdUKc6ws1LY7xjlD0jGnowMF9hlDkZT5SoOPNzTh1xiH8tsPh0ornu9/oTspbCwjerweQ5i8XIergtdQuVdwaOp2eFjaCEH/a5e7rWueFANmzZND8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780168563; c=relaxed/simple;
	bh=dLIYirniTfvcWHH7IgYs9CL81Lei56Dvskd6zK2/ouc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kC8zwcEwx3jgl3XDGlLZigESKg5i5cMY2YxB1C+NNEUHeJyrbAz30Gh9pnweLs33Z/BzgCoBIZ+zHoVz9SJZMkn9UoDzc0p1U8nNkwlwGLf7LaxxOxMJZCVRs0wpmsoSzi8ap2ebuq0lg1LXP3iAEQASAxXUyApm7ncUfBqRqzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzttGGnv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550E61F00893;
	Sat, 30 May 2026 19:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780168562;
	bh=hLNzsf6kvmNixpRJve+lXC7OSXV/qvoCNbNCq0pDzEw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BzttGGnv/j9xK9+JbGbCaHzMuaSav97PVbpW7lOiDb6atr5d1hK8EkLAril9jG8pW
	 bcRa7fuYtLQLxeHtAal7INNL9eVpxhiiQNeF/EkhReRlseCMWoh10620CRjOQNvvUz
	 nwy8xnTvv90D3Y3uJacFre0+IFnVIK/lMrcTs+DWNi1UJbLbz2i+x11Wtx5PQy1ohm
	 xYX3ir2KmmfMDAAI1QyifbXfOLVZdUWzuL/JW4US4kfVPjLEZwDUNZuV+Jbv7H1Pk+
	 ZqGLa/pQIZZ50EkkBS482JR4lUMy3HytcTuQUUyxs7D1xPyx7arKIBaDuGLOkBqjfi
	 yD12hPloal+Ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/10] drm/damage-helper: Remove old state from
 drm_atomic_helper_damage_merged()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260530185716.65688-9-tzimmermann@suse.de>
References: <20260530185716.65688-9-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 19:16:01 +0000
Message-Id: <20260530191602.550E61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11414-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lists.linux.dev:replyto,smtp.kernel.org:mid,sashiko.dev:url,suse.de:email]
X-Rspamd-Queue-Id: 0F451612FF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The i915 driver fails to perform full plane updates when source co=
ordinates change (e.g., panning or cropping), leading to visual corruption.
--

commit 020ae3c303979cf114157a7b95370725231ed90b
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/damage-helper: Remove old state from drm_atomic_helper_damage_merged()

Nothing in drm_atomic_helper_damage_merged() requires the old plane state.
Remove the parameter and mass-convert callers. Most callers now no longer
require the old plane state in their plane's atomic_update helper.

> diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm=
/i915/display/intel_plane.c
> index 2a52b36c646c7..3560e222a3eae 100644
> --- a/drivers/gpu/drm/i915/display/intel_plane.c
> +++ b/drivers/gpu/drm/i915/display/intel_plane.c
[ ... ]
> @@ -346,7 +346,6 @@ static void intel_plane_clear_hw_state(struct intel_p=
lane_state *plane_state)
> =20
>  static void
>  intel_plane_copy_uapi_plane_damage(struct intel_plane_state *new_plane_s=
tate,
> -				   const struct intel_plane_state *old_uapi_plane_state,
>  				   const struct intel_plane_state *new_uapi_plane_state)
>  {
>  	struct intel_display *display =3D to_intel_display(new_plane_state);
> @@ -356,10 +355,9 @@ intel_plane_copy_uapi_plane_damage(struct intel_plan=
e_state *new_plane_state,
>  	if (DISPLAY_VER(display) < 12)
>  		return;
> =20
> -	if (!drm_atomic_helper_damage_merged(&old_uapi_plane_state->uapi,
> -					     &new_uapi_plane_state->uapi,
> +	if (!drm_atomic_helper_damage_merged(&new_uapi_plane_state->uapi,
>  					     damage))

[Severity: High]
Does this code risk missing full plane updates when source coordinates chan=
ge?

It appears that with the removal of the old state, the fallback checking
for source coordinate changes (like panning) was also removed from the
damage iterators. The DRM core now expects drivers to call
drm_atomic_helper_check_plane_damage() to set ignore_damage_clips =3D true
when the source changes.

Because i915 implements a custom atomic check phase in intel_atomic_check()
that does not call drm_atomic_helper_check_planes() or
drm_atomic_helper_check_plane_damage(), ignore_damage_clips remains unset.

Will drm_atomic_helper_damage_merged() incorrectly return only partial
damage here when the plane is panned, missing the full update?

> -		/* Incase helper fails, mark whole plane region as damage */
> +		/* In case the helper fails, mark whole plane region as damage */
>  		*damage =3D drm_plane_state_src(&new_uapi_plane_state->uapi);
>  }
[ ... ]
> diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i=
915/display/intel_psr.c
> index e138982dc91f6..22bab263d85d4 100644
> --- a/drivers/gpu/drm/i915/display/intel_psr.c
> +++ b/drivers/gpu/drm/i915/display/intel_psr.c
[ ... ]
> @@ -3018,8 +3018,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic=
_state *state,
>  		src =3D drm_plane_state_src(&new_plane_state->uapi);
>  		drm_rect_fp_to_int(&src, &src);
> =20
> -		if (!drm_atomic_helper_damage_merged(&old_plane_state->uapi,
> -						     &new_plane_state->uapi, &damaged_area))
> +		if (!drm_atomic_helper_damage_merged(&new_plane_state->uapi, &damaged_=
area))

[Severity: High]
Can this cause severe visual corruption for PSR2 selective fetch?

If intel_psr2_sel_fetch_update() no longer forces a full update on source
coordinate changes, it seems this might only fetch the small damaged area
(such as a blinking cursor) while leaving the rest of the panned screen
stale.

>  			continue;
> =20
>  		damaged_area.y1 +=3D new_plane_state->uapi.dst.y1 - src.y1;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530185716.6568=
8-1-tzimmermann@suse.de?part=3D8

