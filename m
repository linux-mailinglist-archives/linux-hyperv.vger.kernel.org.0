Return-Path: <linux-hyperv+bounces-11411-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJnQCtg1G2oXAQkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11411-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 21:09:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D87D612FB2
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 21:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99809301F4A2
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 19:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0AE1427A;
	Sat, 30 May 2026 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W41Ubj0n"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D08F1FBC8E
	for <linux-hyperv@vger.kernel.org>; Sat, 30 May 2026 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780168149; cv=none; b=RWkk/sTWStNl1BaVfDxRvcmIrTZCghuLPT0uCFzXBHzE6ytbw/lroQkSjXLy9Cw5//+mgjLW6AZFZQjZZ3qqI1EkVSpUWVxq93OjSAIr4tKazRhpsSyjHyToFb1lwcv/uDOGDdHwTgMVVHHKMKl60BDuMUygrKYqmU41hFMq/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780168149; c=relaxed/simple;
	bh=gdJb23LBIAqAbg1eZZEhThKUIpPmuU9VUbljv0Qp9bI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GBkU6yBpR8dn0H7RAcB3xAPbC/La6hHSCa09XFF0IeBaKv/8uSbG7EQgXcfc12Z/OaMtAPAc1wy10SM4peQKpAaczDpFIEcaVHZv73YRZvaaXuiNCd1V+kXc0nxWLoYrlMIZ9RSUox3FsW9z+XEqukTCuJeIkXcdurEX3V3//P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W41Ubj0n; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC991F00893;
	Sat, 30 May 2026 19:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780168147;
	bh=h+d3nV2MHTCE8LtH0/Ha56jzUVHSVwiIZIL9Z2iZT5M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W41Ubj0nzv0su8SfnuDOPV6vQlLTLGND5IxonfUgSqU8GmgGgVNBUL9P08Y3C7Sze
	 3T70aJJ5tbRTnmh++BxzxGyHehWSiXSDmmveceBO2zTWJHJGj4NfzsRUaYQvWd+tvE
	 20qVQmr7tgtFl5CO+FtnE4yMvu1FivurHfaFtT6m/jlf0ylaHXpGXJ9p5NzFpbKE5V
	 ZorJwyU9nRx5cLykxfmLr3aPwpaYdpdqKJFAOmrfGYc9EZ66mR7+6TUjwcn1g1UTCO
	 OE4tLXrcjCbdJw7do/Qud5F8M6/Ed9XmErNoRQPA/K8HlhckrWjRgaewR+l+E2/1HD
	 C0j/ZbIvZqB3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/10] drm/damage-helper: Test src coord in
 drm_atomic_helper_check_plane_damage()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260530185716.65688-7-tzimmermann@suse.de>
References: <20260530185716.65688-7-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 19:09:07 +0000
Message-Id: <20260530190907.8CC991F00893@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11411-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 9D87D612FB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Accessor functions `drm_plane_get_damage_clips()` and `drm_plane_g=
et_damage_clips_count()` return outdated partial clips instead of forcing a=
 full update when `ignore_damage_clips` is set, causing drivers to skip ful=
l plane updates during modesets and `src` coordinate changes.
--

commit 18363d38b23996b07f12d04823d811d72b0f24d4
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/damage-helper: Test src coord in drm_atomic_helper_check_plane_damage()

This commit updates drm_atomic_helper_check_plane_damage() to evaluate if
the source coordinates change across atomic commits. If they do, it sets the
ignore_damage_clips flag in the plane state to force a full update, and
removes this check from drm_atomic_helper_damage_iter_init().

> diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_da=
mage_helper.c
> index 945fac8dc27b6..f492a59edbeb5 100644
> --- a/drivers/gpu/drm/drm_damage_helper.c
> +++ b/drivers/gpu/drm/drm_damage_helper.c

[ ... ]

> @@ -67,19 +68,23 @@ static void convert_clip_rect_to_rect(const struct dr=
m_clip_rect *src,
>   * &drm_plane_state.src as damage.
>   */
>  void drm_atomic_helper_check_plane_damage(struct drm_atomic_commit *stat=
e,
> -					  struct drm_plane_state *plane_state)
> +					  const struct drm_plane_state *old_plane_state,
> +					  struct drm_plane_state *new_plane_state)
>  {
>  	struct drm_crtc_state *crtc_state;
> =20
> -	if (plane_state->crtc) {
> +	if (!drm_rect_equals(&new_plane_state->src, &old_plane_state->src))
> +		new_plane_state->ignore_damage_clips =3D true;
> +

[Severity: High]
Will this cause display corruption in drivers that manually read the damage
clips?

The accessors drm_plane_get_damage_clips_count() and
__drm_plane_get_damage_clips() in drivers/gpu/drm/drm_plane.c do not check
the ignore_damage_clips flag.=20

If a driver calls them directly, such as AMDGPU in fill_dc_dirty_rects():

    num_clips =3D drm_plane_get_damage_clips_count(new_plane_state);
    clips =3D drm_plane_get_damage_clips(new_plane_state);

won't it receive the stale or partial user-provided damage clips instead of
performing a full update when the src coordinates change or during a full
modeset?=20

> +	if (new_plane_state->crtc) {
>  		crtc_state =3D drm_atomic_get_new_crtc_state(state,
> -							   plane_state->crtc);
> +							   new_plane_state->crtc);
> =20
>  		if (WARN_ON(!crtc_state))
>  			return;
> =20
>  		if (drm_atomic_crtc_needs_modeset(crtc_state))
> -			plane_state->ignore_damage_clips =3D true;
> +			new_plane_state->ignore_damage_clips =3D true;
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530185716.6568=
8-1-tzimmermann@suse.de?part=3D6

