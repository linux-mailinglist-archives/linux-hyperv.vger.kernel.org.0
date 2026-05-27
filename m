Return-Path: <linux-hyperv+bounces-11245-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIFPHv4KF2qH2QcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11245-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 17:17:18 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA405E6B87
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 17:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF2EA3042E5C
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 15:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976FF426D02;
	Wed, 27 May 2026 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeWgOHKT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFB91427A
	for <linux-hyperv@vger.kernel.org>; Wed, 27 May 2026 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894719; cv=none; b=bdnPxUpXf6nGEHPGce6VJ/MgvdB7g8SOZR+RJ4j6q+/SxlgQeIwhA26T71Wshs0uKa/F1EDr8WMBqGKQfcUaqXxhnG8ox1DdDsNvKve4acNElF3yX4B9vIbmmqwfVBOsrsq95gqqFhRngEHJVy+Hu7aHFavM7t4kf8Wy//6eUD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894719; c=relaxed/simple;
	bh=5T4gxjarj2RInId0VAEQvcnbrKrk3ZlrVlxTY/TQfwI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WLzS5M5XhUfsPPrgsd9eQOxysrcm+FsA3ZYpWjvxr4TxmYsDCpIjaGDp89NeqyLTOt7Kkamei8B4DvfbUNCyOihBzgMPcfHYHvUjYQsN4jaTnvByaT65AQ+ejZPXmGHOlAt9PPYjQ+EEJungizPHxp1o+2j5iFdPbm7nGV4FFS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeWgOHKT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79751F000E9;
	Wed, 27 May 2026 15:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779894717;
	bh=tlEXp8x3Bwxu5e/Bsi1R8NPLlzjpEltB5ppJTfwDcHw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KeWgOHKTARdbTdbGVkQ8BvZKUOb2PjuS5qYCv3seXhgI/Nz4+b5m6RG8nJAFRwRj6
	 vO0Pjw5X+fl2WKC2ajkfaL1q3X+bFxy23aUjj0nkFzboleIcZ9EcdJHyIYuMZRs/vy
	 06vrBnVLul/UPB5GfpaaoRSIV7yMKe13p5B/yVBAtiWvJOx6VxiVyETQg/1B2qFDfS
	 NwADjWE8HHCCNgqeTVW/Jy48FDTQbTPRXQh0XSX6VC8XTrB7aI3rW15/PfUYHA2woz
	 nZTGdxgwfafBw0+zHHft6H9DH9rcZDHwTUXUlAB1cfOY8qx3kca2EN+evdMAnIC3SP
	 KZC0GNBubb+yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/10] drm/damage-helper: Test src coord in
 drm_atomic_helper_check_plane_damage()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260527145113.241595-5-tzimmermann@suse.de>
References: <20260527145113.241595-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 15:11:57 +0000
Message-Id: <20260527151157.C79751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11245-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email,smtp.kernel.org:mid,sashiko.dev:url]
X-Rspamd-Queue-Id: BEA405E6B87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Comparing plane `src` coordinates before `atomic_check` clips th=
em causes unintended full frame updates for partially off-screen planes.
- [Low] Removal of unit tests for `src` coordinate changes without replacin=
g them causes a loss of critical test coverage.
--

commit 70283d9d64d3987145c43d7d6e7df2c84b0de6ae
Author: Thomas Zimmermann <tzimmermann@suse.de>
drm/damage-helper: Test src coord in drm_atomic_helper_check_plane_damage()

This commit evaluates plane source coordinate changes during the atomic che=
ck
phase instead of the atomic commit phase. It sets the ignore_damage_clips f=
lag
in the plane state if coordinates change and removes related unit tests.

> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_at=
omic_helper.c
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -1034,7 +1034,7 @@ drm_atomic_helper_check_planes(struct drm_device *d=
ev,
> =20
>  		drm_atomic_helper_plane_changed(state, old_plane_state, new_plane_stat=
e, plane);
> =20
> -		drm_atomic_helper_check_plane_damage(state, new_plane_state);
> +		drm_atomic_helper_check_plane_damage(state, old_plane_state, new_plane=
_state);

[Severity: Medium]
Is there a risk of unintended full frame updates for partially off-screen
planes here?

When userspace requests an update, the DRM core provides unclipped coordina=
tes
into new_plane_state->src. The old_plane_state->src retains the coordinates
from the previous commit, which were already clipped during that commit's
atomic check phase via drm_atomic_helper_check_plane_state().

Because drm_atomic_helper_check_plane_damage() now performs the
drm_rect_equals check before atomic_check scales and clips the new
coordinates, does it erroneously detect a change in src and permanently lat=
ch
ignore_damage_clips =3D true? This could cause any plane positioned partial=
ly
off-screen to continuously ignore damage clips and perform a full update on
every single frame.

Note: This regression is fixed later in the patch series by commit
"drm/atomic_helper: Do not evaluate plane damage before atomic_check".

> =20
>  		if (!funcs || !funcs->atomic_check)
>  			continue;

[ ... ]

> diff --git a/drivers/gpu/drm/tests/drm_damage_helper_test.c b/drivers/gpu=
/drm/tests/drm_damage_helper_test.c
> --- a/drivers/gpu/drm/tests/drm_damage_helper_test.c
> +++ b/drivers/gpu/drm/tests/drm_damage_helper_test.c

[ ... ]

> -static void drm_test_damage_iter_no_damage_src_moved(struct kunit *test)
> -{
> -	struct drm_damage_mock *mock =3D test->priv;
> -	struct drm_atomic_helper_damage_iter iter;
> -	struct drm_rect clip;
> -	u32 num_hits =3D 0;
> -
> -	/* Plane src moved since old plane state. */
> -	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
> -	set_plane_src(&mock->state, 10 << 16, 10 << 16,
> -		      (10 + 1024) << 16, (10 + 768) << 16);
> -	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->stat=
e);
> -	drm_atomic_for_each_plane_damage(&iter, &clip)
> -		num_hits++;
> -
> -	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1, "Should return plane src as dama=
ge.");
> -	check_damage_clip(test, &clip, 10, 10, 1034, 778);
> -}

[Severity: Low]
Does the removal of these unit tests cause a loss of valuable test coverage?

The commit message mentions there is a separate unit test for when
ignore_damage_clips is true, but without these removed tests, there are no
longer any tests ensuring that moving the src coordinates actually correctly
sets ignore_damage_clips =3D true via drm_atomic_helper_check_plane_damage(=
).

Instead of completely deleting these tests, could they have been adapted to
call drm_atomic_helper_check_plane_damage() prior to initializing the
iterator, preserving the validation of the source coordinate tracking logic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527145113.2415=
95-1-tzimmermann@suse.de?part=3D4

