Return-Path: <linux-hyperv+bounces-11410-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACuJIc41G2oXAQkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11410-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 21:09:02 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8DD612FAB
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 21:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E39DE301DEE0
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 19:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816B01FBC8E;
	Sat, 30 May 2026 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAawvYJA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745CE1427A
	for <linux-hyperv@vger.kernel.org>; Sat, 30 May 2026 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780168138; cv=none; b=s0VQhkL5L+qBrWmXtSrPrS3y/7SOBD6BxhxjMG35O1Pu4qj/YCiW906hhwfG/T/wqqP62mgfl9pYfFzq/1X5oiuAb9LIE214YUqu1SOsTa0UM5BTANJloguudAtdsubcEdJ9pNDyZvFJGRIyHhhBcOHQiyyze/FFilt699R3ASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780168138; c=relaxed/simple;
	bh=q92Rf+4z/JCUuiQTzfallK5m7UQWMePeuncLL0zVXoo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ClTR9LJCG37WuODgtrmA+DDGVqieJPz3Im/yEl2e7ikqwROweAdfbgOAWuhbwFFDy+w0jhGe9TPi/0ABMeSrscLLgUOyFzRIw7lqSC/EaJzQxUhZuk5Db0kg6INzWJRa71ahI4IA+7FueCjRh+NFwueN9TDUiJyeCJhSnAbM4f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAawvYJA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E587F1F00893;
	Sat, 30 May 2026 19:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780168137;
	bh=ou5WvqDdB0wq1rpvwtmR21k/rYjQ1pfrVw9NTxTrQ/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QAawvYJAe5kzLJjR49SIeRB4G/qFXhG6yPOc06NvBe1PgKaCzwjvF2+fZFLf0SKyZ
	 fcm0zmCtshmCWlLbfn9uS9DcAXdH502fPMo5NEpyrPz/Jckgxg6e7VyKRX6VczFn8w
	 DnJ+xua62V2nMpNr+W7paNr6uwJdNwdv+saZRuud1XQvU1Q6AjXTx8v3K8HlOpgWjJ
	 zjPqnP5Ai7zK0MlDjoojUXg7NcWl7JOKljwys3OaSU0de+ZbeV5HScY2c+qPL+V61l
	 7owKvgeBz5vLM2Av0lXu/4dY7e2Ouh8z9vu/1BQwUjAtEggFeGszQyecZWLZ9aUiOk
	 2joSgiJ7A185w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/10] drm/atomic-helpers: Evaluate plane damage
 after atomic_check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260530185716.65688-3-tzimmermann@suse.de>
References: <20260530185716.65688-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 19:08:56 +0000
Message-Id: <20260530190856.E587F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11410-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: EC8DD612FAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Modifying `ignore_damage_clips` after `plane->atomic_check` runs i=
nvalidates resource allocations based on partial damage clips, leading to h=
eap buffer overflows.
--

commit 395f91f063087b27412023cba7e5d824633a9392
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/atomic-helpers: Evaluate plane damage after atomic_check

This commit evaluates damage clips after running the atomic_check helpers.
It adds a loop calling drm_atomic_helper_check_plane_damage() after the
driver's plane and CRTC atomic_check hooks have executed. This allows the
damage handling to account for full modesets triggered by the check hooks.

> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_at=
omic_helper.c
> index 51f39edc31edc..4c37299e8ccb7 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
[ ... ]
> @@ -1065,6 +1065,10 @@ drm_atomic_helper_check_planes(struct drm_device *=
dev,
>  		}
>  	}
> =20
> +	for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane=
_state, i) {
> +		drm_atomic_helper_check_plane_damage(state, new_plane_state);
> +	}
> +

[Severity: High]
Does modifying ignore_damage_clips after plane->atomic_check has already
run invalidate resource allocations in drivers that use partial damage clip=
s?

For example, in drivers/gpu/drm/tiny/appletbdrm.c:appletbdrm_primary_plane_=
helper_atomic_check(),
the driver sizes a buffer precisely to the damage clips evaluated during
atomic_check:

	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, new_plane_state=
);
	drm_atomic_for_each_plane_damage(&iter, &damage) {
		frames_size +=3D struct_size((struct appletbdrm_frame *)0, buf, rect_size=
(&damage));
	}
	...
	appletbdrm_state->request =3D kvzalloc(request_size, GFP_KERNEL);

If a modeset is triggered during the check hooks and this second loop sets
ignore_damage_clips to true, won't drm_atomic_helper_damage_iter_init() lat=
er
return a full-screen damage clip during atomic_update? Could this cause the
driver to copy full-screen damage into the buffer allocated only for partial
damage, resulting in a heap buffer overflow?

I understand this is explicitly acknowledged and fixed later in the patch
series by commit 72afced3e1b6baa294269874c7c4d9d05230889c ('drm/appletbdrm:
Allocate request/response buffers in begin_fb_access').

>  	return ret;
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_check_planes);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530185716.6568=
8-1-tzimmermann@suse.de?part=3D2

