Return-Path: <linux-hyperv+bounces-11205-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFGnCLEJFmpNhAcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11205-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 22:59:29 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B03CC5DC879
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 22:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1DE2530144D8
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 20:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419C62D662F;
	Tue, 26 May 2026 20:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQWLEhLb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131723C1977
	for <linux-hyperv@vger.kernel.org>; Tue, 26 May 2026 20:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779829167; cv=none; b=cVSi17qCa475fEaD3Dgctdo8SVLlASC2rvI2W32+oJU5IcBHvPUmMaH2xXXuZbUMotP3Qk5erglrx4yPVyIZqnVPJxZHi4awHMkJAiboNNbDZuNDe6Amkt5sCVkVu4Rzm8qT9QB2DsqLPDKmLNaYXMUIuBTOxnnrr3L1tNbj/T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779829167; c=relaxed/simple;
	bh=15DCJZHSjTGhnSBlkAE2tiv1E4OByWs+v7p9gctWZrU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dHBLVkWs2bLB7GaGB+HNLPTBJ9C+Xz/vDEPSO8OARdRQibc5vaEHVrnOb1qhmQJacc8qSg6by61k270aNdoIfJlRoD+7VhRU+N9nnX6x10/dh376vGAmv9KSomPK/MHKJi0WqRNknh31fAbwlR/ZyBC5Tm4PtaNU5tc1yPkWRHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQWLEhLb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B371F000E9;
	Tue, 26 May 2026 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779829165;
	bh=CUKONWBO44BVWMjzq86NPCV/M2QDqVFhjO22h6NtvC4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JQWLEhLbol+YCMvDf1QKUO5jxefPGCfuE8QyIzIcC5qvblDNznASXgwTN2NJFd/Yl
	 13fIIeDY4HJFUHzhMwzkAn/crmgPqrm+/oQCp6H1YV0B1XaB/29zIWjS+SsQjlRQCL
	 fMp59Jhc3GNB2vyEYc16dmKWJI5amMWvwaGNkF03jrtunCNMTn50YSFcaZAsXy6bo7
	 JgxVvZRwEaAg+VP65QA7TmsH064AomgSTpJAAQur1tN7J2kfG3aZgYM0KFls4xxDGL
	 tjtlULid9Ibu5yRgUiYyPTt7k8yyK/KFnYtPkMt+vhvpX6uTz+XgIlBHw0iPupLGcs
	 yEjVdwBOThSPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] drm/hyperv: Replace "hyperv_" with "hvdrm_" as
 symbol name prefix
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Kelley" <mhklkml@zohomail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260526205239.1509-1-mhklkml@zohomail.com>
References: <20260526205239.1509-1-mhklkml@zohomail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 20:59:24 +0000
Message-Id: <20260526205925.78B371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11205-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,smtp.kernel.org:mid,sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B03CC5DC879
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential NULL pointer dereference in `hvdrm_crtc_helper_atomic_en=
able` when accessing `plane_state->fb->pitches`.
--

commit 9e40bbf4c669c839b0568d52b603d410d08dde6c
Author: Michael Kelley <mhklinux@outlook.com>
drm/hyperv: Replace "hyperv_" with "hvdrm_" as symbol name prefix

This commit mechanically replaces the "hyperv_" prefix with "hvdrm_" across
functions and structures in the Hyper-V DRM driver. This renaming prevents
namespace collisions with core Hyper-V and VMBus code, and addresses an
initcall conflict that prevents using initcall_blacklist.

> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/dr=
m/hyperv/hyperv_drm_modeset.c
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
[ ... ]
> @@ -107,14 +107,14 @@ static const uint64_t hyperv_modifiers[] =3D {
> -static void hyperv_crtc_helper_atomic_enable(struct drm_crtc *crtc,
> +static void hvdrm_crtc_helper_atomic_enable(struct drm_crtc *crtc,
>  					     struct drm_atomic_commit *state)
>  {
> -	struct hyperv_drm_device *hv =3D to_hv(crtc->dev);
> +	struct hvdrm_drm_device *hv =3D to_hv(crtc->dev);
>  	struct drm_plane *plane =3D &hv->plane;
>  	struct drm_plane_state *plane_state =3D plane->state;
>  	struct drm_crtc_state *crtc_state =3D crtc->state;
> =20
> -	hyperv_hide_hw_ptr(hv->hdev);
> -	hyperv_update_situation(hv->hdev, 1,  hv->screen_depth,
> +	hvdrm_hide_hw_ptr(hv->hdev);
> +	hvdrm_update_situation(hv->hdev, 1,  hv->screen_depth,
>  				crtc_state->mode.hdisplay,
>  				crtc_state->mode.vdisplay,
>  				plane_state->fb->pitches[0]);

[Severity: High]
This is a pre-existing issue, but could this cause a NULL pointer
dereference?

In the DRM atomic API, userspace can configure a CRTC to be active without =
an
attached framebuffer on its primary plane, which means plane_state->fb can =
be
NULL.

If the CRTC is enabled while the primary plane lacks a framebuffer, it looks
like dereferencing plane_state->fb->pitches[0] here will crash the kernel.

> =20
>  	drm_crtc_vblank_on(crtc);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526205239.1509=
-1-mhklkml@zohomail.com?part=3D1

