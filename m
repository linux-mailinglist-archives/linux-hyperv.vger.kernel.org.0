Return-Path: <linux-hyperv+bounces-11413-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEsGEEo2G2oXAQkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11413-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 21:11:06 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB19612FC2
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 21:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64AC33004060
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 19:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23030274B5C;
	Sat, 30 May 2026 19:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNc1GzFp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121821427A
	for <linux-hyperv@vger.kernel.org>; Sat, 30 May 2026 19:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780168261; cv=none; b=Q9fnQuBkBAbSK7LWOyRa9lcnHGTjImeH/wm6a83KoDan1J5D5cy1ZWKgJBpAIwPu8dnEtDnZzDLkPLEBXFcKpwk59Ga6CxDHXehDK5PLMuPHbsO8i0eFikjyVrOaNxIMEyX1bdMZC+taQt+5e0mCxt8qsNTmknYLr6CAfcySeLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780168261; c=relaxed/simple;
	bh=jdq+t7iTMf/e47vtT/yi3ElfSB906zkt/4xi423C6MA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lu9JcPDC4fk3HLPymQ1RmQ7EF28PyE5AGGDb+r65PAN9o1ZXmxE2yByDB3sjF+AwvbUDkDlXZGojq0mOlSnW3HEm4x0bYuT2SFpR5UUuk/g6Z1LByryqtGrxIyoPopuH/EXfcLnFtD7C1slvHQfXhGVzf4UaJxjfevZnOXvgteU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNc1GzFp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAB21F00893;
	Sat, 30 May 2026 19:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780168259;
	bh=h7Qf+4faeMOgu6XMcxGNhHULad2PF5zPzTTw1W40jWA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kNc1GzFpPKwP+6JhdGtDMW1ZnYqjc9NogbomHgsI+KKBVAKOChm1ClsOt9s9fb/Uw
	 EV0kBqJpCVB7XJErW7sUbr2p4IjbTLgAIx1STfr51RfC/XSBCAyT/S75q1umpoKxIZ
	 x52WL8O35QQ+zU6LKnMfXDGpyXNnmqflJpkquW6fbJaloZJ3MSKZAe2pSkCwH2H3Hm
	 Zz9eeBboET8yOkmJ4oRUFp0cnnITiud71SWjQgvXm/b4e9p0W2+gESfvpsR760trtC
	 dQWJTIML+HMj4ijRob0vWJ336wHMhaJThANhuP8pJFS9+RQMd4zG+rn4TGj6YdP9ZT
	 J9jbaHdBSqV6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/10] drm/damage-helper: Do not alter damage clips
 on modeset, but ignore them
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260530185716.65688-2-tzimmermann@suse.de>
References: <20260530185716.65688-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 19:10:59 +0000
Message-Id: <20260530191059.7EAB21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11413-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,suse.de:email,smtp.kernel.org:mid,sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3DB19612FC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Drivers using raw damage clip getters bypass the newly introduced =
`ignore_damage_clips` flag, leading to partial screen updates during full m=
odesets.
--

commit 8480930644dc907381d0145f944fe144e2010b34
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/damage-helper: Do not alter damage clips on modeset, but ignore them

This commit changes the behavior of drm_atomic_helper_check_plane_damage()
to preserve fb_damage_clips during a modeset. Instead of clearing the clips,
it now sets a new ignore_damage_clips flag, which the damage iterator
respects.

> diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_da=
mage_helper.c
> index 74a7f4252ecff..945fac8dc27b6 100644
> --- a/drivers/gpu/drm/drm_damage_helper.c
> +++ b/drivers/gpu/drm/drm_damage_helper.c
[ ... ]
> @@ -78,10 +78,8 @@ void drm_atomic_helper_check_plane_damage(struct drm_a=
tomic_commit *state,
>  		if (WARN_ON(!crtc_state))
>  			return;
> =20
> -		if (drm_atomic_crtc_needs_modeset(crtc_state)) {
> -			drm_property_blob_put(plane_state->fb_damage_clips);
> -			plane_state->fb_damage_clips =3D NULL;
> -		}
> +		if (drm_atomic_crtc_needs_modeset(crtc_state))
> +			plane_state->ignore_damage_clips =3D true;
>  	}
>  }

[Severity: High]
Does this change cause a regression for drivers that use the raw damage clip
getters instead of the iterator?

Several drivers call drm_plane_get_damage_clips() and
drm_plane_get_damage_clips_count() directly. These raw getters return the
fb_damage_clips without evaluating the new ignore_damage_clips flag:

drivers/gpu/drm/drm_plane.c:drm_plane_get_damage_clips() {
    ...
    return __drm_plane_get_damage_clips(state);
}

Before this patch, fb_damage_clips was forced to NULL on modeset, which
caused drivers to correctly fall back to a full frame update. Now they will
see num_clips > 0 and attempt a partial screen update during a full modeset.

For example, in amdgpu, the full frame update fallback is skipped:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:fill_dc_dirty_rects() {
    ...
    num_clips =3D drm_plane_get_damage_clips_count(new_plane_state);
    clips =3D drm_plane_get_damage_clips(new_plane_state);
    ...
}

Similarly in vboxvideo:

drivers/gpu/drm/vboxvideo/vbox_mode.c:vbox_primary_atomic_update() {
    ...
    clips =3D drm_plane_get_damage_clips(new_state);
    num_clips =3D drm_plane_get_damage_clips_count(new_state);
    ...
}

And in vmwgfx:

drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c:vmw_ldu_primary_plane_atomic_update() {
    ...
    struct drm_mode_rect *damage_rects =3D drm_plane_get_damage_clips(new_s=
tate);
    u32 rect_count =3D drm_plane_get_damage_clips_count(new_state);
    ...
}

Should the raw getters be updated to check ignore_damage_clips, or should
these drivers be transitioned to use the damage iterator?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530185716.6568=
8-1-tzimmermann@suse.de?part=3D1

