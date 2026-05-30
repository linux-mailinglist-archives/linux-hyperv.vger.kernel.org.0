Return-Path: <linux-hyperv+bounces-11409-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCSYCg01G2qqAAkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11409-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 21:05:49 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB69612F9F
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 21:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7AFBF30089B0
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 19:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AC227A907;
	Sat, 30 May 2026 19:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhLaYZ93"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C3274B5C
	for <linux-hyperv@vger.kernel.org>; Sat, 30 May 2026 19:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780167946; cv=none; b=V81qTU/fTmW/IiYBwvcdXly6Sg0A4utLZdA+kknW2oLLV2C2gmg8+7BQ0DpyLXqKZZLJFUBc1C0AXiTeIiNBRV3oz0m/PDCQCiZ8iDYz0G4+TjGj9or7zc6aOHBLJ3vFnqXEgxLXHUHNoyqxDPoPN+O/wbWhVAHzrAjweK5fLps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780167946; c=relaxed/simple;
	bh=j3fpBnzUPjMWGCViG3mZkFdlc4CAqYdDUtf+Htf0IE4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cEbdfTDr6wCkoEtv5qnERjxoNsKxgnUgeBIWeKStJDD86NnRW+3Tcs2FMGX38ZIGPp052E5vPAaJ0LAS7UMFlCAE0noRdnl15FlLZFAuVY+FBM332quI+/rPz++MVHr7Xw3jb+/udSCsezGbFuj9wooHtM0WcwqiH8/OLXHv8s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhLaYZ93; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DCE1F00893;
	Sat, 30 May 2026 19:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780167944;
	bh=A5mYNdZeWkBpNH+GHgyjj1mj2sx7b5PkfSVHkRbvpNk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bhLaYZ93F8cotLKOkdgrVQijSx1LrHjXrc8yNlZ6n+9z9/Cvbn6IFp+crKO2SNYTD
	 CLyJuneVj5cgZCJvpE/594HM+xTrsRjxB429hXcqEUbaMePBNI13GxN7S7XFTk+cCt
	 q/4QSib9Y0MacS6XaFRHiOYEv9BSxVejh7hnG/9+TQDlS5KiLThWj47Kc1CiBVK2pu
	 Gdq0w1nsBkO5LKa7sLxnafL9lkC+T1MSd3bFzhOKMyeS/ccr8Y228tYZ5DtdAEyEnJ
	 SrLF0f0pJiBq2cG3RF6o4AP11l932WLTxvsgX8TmofjIANZdGu4IZFv2ILhljFMz09
	 z/bJDPf7er5+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/10] drm/ingenic: Remove calls to
 drm_atomic_helper_check_plane_damage()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260530185716.65688-4-tzimmermann@suse.de>
References: <20260530185716.65688-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 19:05:44 +0000
Message-Id: <20260530190544.C7DCE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11409-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,lists.linux.dev:replyto,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: AFB69612F9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Setting `crtc_state->mode_changed =3D true` inside `plane_atomic_c=
heck` without re-calling `drm_atomic_helper_check_modeset()` bypasses neces=
sary modeset validations and state updates, leading to incomplete modesets.
--

commit 0b5b8aa5c5b9f98bc80329fb6bac6de5430060f3
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/ingenic: Remove calls to drm_atomic_helper_check_plane_damage()

Atomic helpers call drm_atomic_helper_check_plane_damage() after the
atomic_check anyway. Remove the calls from the planes' atomic_check.

> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/=
ingenic/ingenic-drm-drv.c
> index 42c86f195c66b..e99b44e3ac923 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
[ ... ]
> @@ -519,9 +519,6 @@ static int ingenic_drm_plane_atomic_check(struct drm_=
plane *plane,
>  	     old_plane_state->fb->format->format !=3D new_plane_state->fb->form=
at->format))
>  		crtc_state->mode_changed =3D true;
> =20

[Severity: High]
This is a pre-existing issue, but does setting crtc_state->mode_changed to
true here in ingenic_drm_plane_atomic_check() bypass necessary validations?

The DRM core documentation notes that if drivers set mode_changed =3D true
during the plane check, they must re-call drm_atomic_helper_check_modeset().
Since the ingenic driver assigns drm_atomic_helper_check() directly to its
global .atomic_check hook, check_modeset() runs before check_planes().

If a modeset check is not re-evaluated after planes alter the modeset
requirement, affected connectors and bridges might never be added to the
atomic state via drm_atomic_add_affected_connectors().

Will this cause the display pipeline to skip bridge and encoder modesets
during the commit phase, potentially desynchronizing the output?

> -	if (priv->soc_info->map_noncoherent)
> -		drm_atomic_helper_check_plane_damage(state, new_plane_state);
> -
>  	return 0;
>  }

> diff --git a/drivers/gpu/drm/ingenic/ingenic-ipu.c b/drivers/gpu/drm/inge=
nic/ingenic-ipu.c
> index 56143a191f361..fd17c642c7ac5 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-ipu.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-ipu.c
[ ... ]
> @@ -611,7 +611,7 @@ static int ingenic_ipu_plane_atomic_check(struct drm_=
plane *plane,
>  		return -EINVAL;
> =20
>  	if (!osd_changed(new_plane_state, old_plane_state))
> -		goto out_check_damage;
> +		return 0;
> =20
>  	crtc_state->mode_changed =3D true;
> =20

[Severity: High]
This is also a pre-existing issue, but similar to the above, does setting
crtc_state->mode_changed to true here in ingenic_ipu_plane_atomic_check()
result in the same missing validation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530185716.6568=
8-1-tzimmermann@suse.de?part=3D3

