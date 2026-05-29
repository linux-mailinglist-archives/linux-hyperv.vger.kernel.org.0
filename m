Return-Path: <linux-hyperv+bounces-11385-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCx3DV4KGmo70wgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11385-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 23:51:26 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FB86090A2
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 23:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83D833000B3E
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 21:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D042DCF67;
	Fri, 29 May 2026 21:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="APPG1/ZP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oo1-f103.google.com (mail-oo1-f103.google.com [209.85.161.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACFE3644C5
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780091481; cv=none; b=Yz/USRhG6ED+KIW2YIj6RkCZ24OJMPxmMPWZuVOmFyfTnQoSkMpSw/91Gm913VEh6rf8xIG69rW0OmjHGR29t8IFPkiO44dwOUPP8rhSeVmHd5DzSNdTzoEd75ABVBn7Io3v4TUb9ThJDsiYJ1vJiGky1UGTfDLCFyRezPyCySo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780091481; c=relaxed/simple;
	bh=KSfD+jlaOX2ZS3qbMvDanJ+D8HvifPrOgAbhbEn/2lU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tPKWnSSrQp1b3FR29RvF37GGFyCxyv5p/XAatJ6RNSvUT1JLUPwAcw6vYwreLaapRCIJqkFKhf003wdJfHJ9uZpOklQeICWTR0sTHSBPzUP/XRXDcn56AwvpX90lrLPfrQkfHuUgZTwy7b7DMYs31lqT0i9W0pZM7ezrNQiKplc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=APPG1/ZP; arc=none smtp.client-ip=209.85.161.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f103.google.com with SMTP id 006d021491bc7-6969c864c89so7929459eaf.2
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 14:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780091478; x=1780696278;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3RThf4EA3uWeiihV1yWr80uSEElfaI8gTyAJWAkzr0=;
        b=f2ehG0vrhDzjKf+5cbDpFNRegFBtC+w/0Kkbprz54ZpC0QdHNg50C4+Ts2TEFV3IDn
         qmHZoYa1jBUOdAHOx18CgkrcBpuuLIMFjQSsPczQu/1GpHlxd/Y3pArYyOrSPpvTWQts
         82/OdL7dPpJSPo0INx5r1bEi6Rs3y7NFBA7/i8Dj/e8sEDrO+5CqKR0Eku8WnOSddTVV
         zWyrSQf2tcenkh+s7OlDs2F1zWnXxCk9OW2IS9Zl68o9gan/oFL1aCCrriz/LAJ1VIPv
         Eeo5jJoDDNkxTJdUwvEjGjCFpVOCYfPco/PR2zrFnLsPtx7nZC6oNFC8PSE0f+8mCyMJ
         ds9g==
X-Forwarded-Encrypted: i=1; AFNElJ8GDX1tDVG25gZYebt8yA+g9RAclJM1dSlebxtBa5DZba2YFCEac+DisFLI4bzo9B5HeNmi7ulHHmjUXpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxesDEldvmaQWXD3plvRaXuo5eEcAonjVeTsGG5i4f1KzdHNKWc
	hVfCz+1vvlTuTEihEAApf2uGmHumOXi5h7t9MsmyCFSkXIkbR+A1VS+pTWZTpr+sqRMAhkJ8z+P
	9T8JS3b9iYVDXX3Mu7nKKr1JDy9HgSROGpefvBrmmUHbD/wKy5rdpOz7M0RC0A/wsvTQvOqDQhf
	cyv2ZfDVXrDhL2PSlpKb2rFeTJPfQhqfXqx5FFTgqmJXmmYBN01gzXvCtNvYqkViAorwzMuyQ3a
	98OrwPcDSJGDRkluK8=
X-Gm-Gg: Acq92OFhwqY2JzpmEpBDWlUUqlqNZs9uAAyQiMavyczommj0nYmg5iavLja7nG+iUL8
	sP+uAlfWQFWDSt1W/ZMIs+eHgFxcTVyR69g9BkawuSfTMNL8ZSBBitnuYdLntsikdLUpAopLRW7
	VY2MwTwr/mJnERiE/4HPJ3qltR/Dw5fBD8Av+Q1WQmaqMZE4WeGLZk4GPsLN0KzfO+oFLNj6RBj
	9axJ/g09kPrwn8cLtR/S1KwHWkQKnOvwwXjKCky3XhXaWSjq4/UfNd35QkygDg7ikGvrxeCcxOB
	V5aSkp1nIneSg4EuwLQo3TuzXowTDi893zIBOuKtoePvA7Z+ml4m0EY+aB96+3diEQprzvliRF4
	9Ftzx+VhK6FANnBuh6Q7IL8+LLr9turZWM3Nh0Rc6WYLQdRSeUZCkdqXQfFbQw71p1C4D0t6ymp
	Koa4+7u49kuuCbP5nQdWhyKJlJCY9Ct36bqURQvsk2xc8kh/38V6pCgF7ZkJgFaIOHlhE=
X-Received: by 2002:a05:6820:214:b0:68a:f494:e8fc with SMTP id 006d021491bc7-69e103c1d63mr582114eaf.33.1780091478222;
        Fri, 29 May 2026 14:51:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-69e06951161sm165428eaf.20.2026.05.29.14.51.16
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2026 14:51:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5aa5a7e16afso633277e87.1
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 14:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1780091475; x=1780696275; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B3RThf4EA3uWeiihV1yWr80uSEElfaI8gTyAJWAkzr0=;
        b=APPG1/ZPo6/lsOoB+aoV0uE3eBQKcq0f9EXyiT67Vab899n/z9nmfRnbfFgM5J5Pa2
         jfnM8T1NtI7bXmHerO9laas02Cb3SZkJUnVU7haa44f22rXHn+TUI6QOq4b4SeoXuaHq
         /rgozkKi4HI+uWMftOJBKiD2bdLaYf0bZwjN0=
X-Forwarded-Encrypted: i=1; AFNElJ+PpuZlSFNo0jr8t5Ii8NbKm7vVXfDrn6M+yNtvMjj8c+d6AISuJZgYJT2KgV0jqzCNxpLhTcbprP3Gi94=@vger.kernel.org
X-Received: by 2002:a05:6512:612:20b0:5a8:e129:af6f with SMTP id 2adb3069b0e04-5aa59040f2cmr867393e87.23.1780091475116;
        Fri, 29 May 2026 14:51:15 -0700 (PDT)
X-Received: by 2002:a05:6512:612:20b0:5a8:e129:af6f with SMTP id
 2adb3069b0e04-5aa59040f2cmr867382e87.23.1780091474623; Fri, 29 May 2026
 14:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527145113.241595-1-tzimmermann@suse.de> <20260527145113.241595-11-tzimmermann@suse.de>
In-Reply-To: <20260527145113.241595-11-tzimmermann@suse.de>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Fri, 29 May 2026 17:51:02 -0400
X-Gm-Features: AVHnY4KIK2b_b8RVjZiB-AlL-VZmUXJwYKGs1uGNiJBm8qXQcz8OVNuVdL8kcUc
Message-ID: <CABQX2QOaFpmw=ytYM4NquqScTPL-gFeEAyufNP4jxHUx5sg1RQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] drm/vmwgfx: Remove unused field struct vmwgfx_du_update_plane.old_state
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, airlied@redhat.com, 
	airlied@gmail.com, simona@ffwll.ch, admin@kodeit.net, gargaditya08@proton.me, 
	paul@crapouillou.net, jani.nikula@linux.intel.com, mhklinux@outlook.com, 
	bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org, 
	linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, linux-mips@vger.kernel.org, 
	virtualization@lists.linux.dev
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000010c0170652fbd8a2"
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11385-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,outlook.com,broadcom.com,lists.freedesktop.org,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zack.rusin@broadcom.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,broadcom.com:email,broadcom.com:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C8FB86090A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000010c0170652fbd8a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 10:51=E2=80=AFAM Thomas Zimmermann <tzimmermann@sus=
e.de> wrote:
>
> Plane updates no longer require the old plane state. Remove the field
> from struct vmwgfx_du_update_plane and fix all callers.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.h  |  2 --
>  drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c | 12 ++----------
>  drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c | 11 ++---------
>  3 files changed, 4 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx=
/vmwgfx_kms.h
> index 2224d7d91d1b..8c2072b82062 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
> @@ -19,7 +19,6 @@
>  /**
>   * struct vmw_du_update_plane - Closure structure for vmw_du_helper_plan=
e_update
>   * @plane: Plane which is being updated.
> - * @old_state: Old state of plane.
>   * @dev_priv: Device private.
>   * @du: Display unit on which to update the plane.
>   * @vfb: Framebuffer which is blitted to display unit.
> @@ -102,7 +101,6 @@ struct vmw_du_update_plane {
>                                     struct drm_rect *bb);
>
>         struct drm_plane *plane;
> -       struct drm_plane_state *old_state;
>         struct vmw_private *dev_priv;
>         struct vmw_display_unit *du;
>         struct vmw_framebuffer *vfb;
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgf=
x/vmwgfx_scrn.c
> index c83061cf7455..fa84bc7ab5bb 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
> @@ -530,7 +530,6 @@ static uint32_t vmw_stud_bo_post_clip(struct vmw_du_u=
pdate_plane  *update,
>   */
>  static int vmw_sou_plane_update_bo(struct vmw_private *dev_priv,
>                                    struct drm_plane *plane,
> -                                  struct drm_plane_state *old_state,
>                                    struct vmw_framebuffer *vfb,
>                                    struct vmw_fence_obj **out_fence)
>  {
> @@ -538,7 +537,6 @@ static int vmw_sou_plane_update_bo(struct vmw_private=
 *dev_priv,
>
>         memset(&bo_update, 0, sizeof(struct vmw_du_update_plane_buffer));
>         bo_update.base.plane =3D plane;
> -       bo_update.base.old_state =3D old_state;
>         bo_update.base.dev_priv =3D dev_priv;
>         bo_update.base.du =3D vmw_crtc_to_du(plane->state->crtc);
>         bo_update.base.vfb =3D vfb;
> @@ -692,7 +690,6 @@ static uint32_t vmw_sou_surface_post_clip(struct vmw_=
du_update_plane *update,
>   */
>  static int vmw_sou_plane_update_surface(struct vmw_private *dev_priv,
>                                         struct drm_plane *plane,
> -                                       struct drm_plane_state *old_state=
,
>                                         struct vmw_framebuffer *vfb,
>                                         struct vmw_fence_obj **out_fence)
>  {
> @@ -700,7 +697,6 @@ static int vmw_sou_plane_update_surface(struct vmw_pr=
ivate *dev_priv,
>
>         memset(&srf_update, 0, sizeof(struct vmw_du_update_plane_surface)=
);
>         srf_update.base.plane =3D plane;
> -       srf_update.base.old_state =3D old_state;
>         srf_update.base.dev_priv =3D dev_priv;
>         srf_update.base.du =3D vmw_crtc_to_du(plane->state->crtc);
>         srf_update.base.vfb =3D vfb;
> @@ -721,7 +717,6 @@ static void
>  vmw_sou_primary_plane_atomic_update(struct drm_plane *plane,
>                                     struct drm_atomic_commit *state)
>  {
> -       struct drm_plane_state *old_state =3D drm_atomic_get_old_plane_st=
ate(state, plane);
>         struct drm_plane_state *new_state =3D drm_atomic_get_new_plane_st=
ate(state, plane);
>         struct drm_crtc *crtc =3D new_state->crtc;
>         struct vmw_fence_obj *fence =3D NULL;
> @@ -734,12 +729,9 @@ vmw_sou_primary_plane_atomic_update(struct drm_plane=
 *plane,
>                         vmw_framebuffer_to_vfb(new_state->fb);
>
>                 if (vfb->bo)
> -                       ret =3D vmw_sou_plane_update_bo(dev_priv, plane,
> -                                                     old_state, vfb, &fe=
nce);
> +                       ret =3D vmw_sou_plane_update_bo(dev_priv, plane, =
vfb, &fence);
>                 else
> -                       ret =3D vmw_sou_plane_update_surface(dev_priv, pl=
ane,
> -                                                          old_state, vfb=
,
> -                                                          &fence);
> +                       ret =3D vmw_sou_plane_update_surface(dev_priv, pl=
ane, vfb, &fence);
>                 if (ret !=3D 0)
>                         DRM_ERROR("Failed to update screen.\n");
>         } else {
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgf=
x/vmwgfx_stdu.c
> index f0df2b1c8465..474e3badb80f 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> @@ -1240,7 +1240,6 @@ vmw_stdu_bo_populate_update_cpu(struct vmw_du_updat=
e_plane  *update, void *cmd,
>   */
>  static int vmw_stdu_plane_update_bo(struct vmw_private *dev_priv,
>                                     struct drm_plane *plane,
> -                                   struct drm_plane_state *old_state,
>                                     struct vmw_framebuffer *vfb,
>                                     struct vmw_fence_obj **out_fence)
>  {
> @@ -1248,7 +1247,6 @@ static int vmw_stdu_plane_update_bo(struct vmw_priv=
ate *dev_priv,
>
>         memset(&bo_update, 0, sizeof(struct vmw_du_update_plane_buffer));
>         bo_update.base.plane =3D plane;
> -       bo_update.base.old_state =3D old_state;
>         bo_update.base.dev_priv =3D dev_priv;
>         bo_update.base.du =3D vmw_crtc_to_du(plane->state->crtc);
>         bo_update.base.vfb =3D vfb;
> @@ -1350,7 +1348,6 @@ vmw_stdu_surface_populate_update(struct vmw_du_upda=
te_plane  *update, void *cmd,
>   */
>  static int vmw_stdu_plane_update_surface(struct vmw_private *dev_priv,
>                                          struct drm_plane *plane,
> -                                        struct drm_plane_state *old_stat=
e,
>                                          struct vmw_framebuffer *vfb,
>                                          struct vmw_fence_obj **out_fence=
)
>  {
> @@ -1363,7 +1360,6 @@ static int vmw_stdu_plane_update_surface(struct vmw=
_private *dev_priv,
>
>         memset(&srf_update, 0, sizeof(struct vmw_du_update_plane));
>         srf_update.plane =3D plane;
> -       srf_update.old_state =3D old_state;
>         srf_update.dev_priv =3D dev_priv;
>         srf_update.du =3D vmw_crtc_to_du(plane->state->crtc);
>         srf_update.vfb =3D vfb;
> @@ -1424,12 +1420,9 @@ vmw_stdu_primary_plane_atomic_update(struct drm_pl=
ane *plane,
>                         DRM_ERROR("Failed to bind surface to STDU.\n");
>
>                 if (vfb->bo)
> -                       ret =3D vmw_stdu_plane_update_bo(dev_priv, plane,
> -                                                      old_state, vfb, &f=
ence);
> +                       ret =3D vmw_stdu_plane_update_bo(dev_priv, plane,=
 vfb, &fence);
>                 else
> -                       ret =3D vmw_stdu_plane_update_surface(dev_priv, p=
lane,
> -                                                           old_state, vf=
b,
> -                                                           &fence);
> +                       ret =3D vmw_stdu_plane_update_surface(dev_priv, p=
lane, vfb, &fence);
>                 if (ret)
>                         DRM_ERROR("Failed to update STDU.\n");
>         } else {
> --
> 2.54.0
>

LGTM

For the vmwgfx bits:
Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>

For the rest of the series:
Acked-by: Zack Rusin <zack.rusin@broadcom.com>

z

--00000000000010c0170652fbd8a2
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIK6T
M3hcwIG6U09NmUG4muHUYSOBWzNS3Wkx9wYnRHojMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDUyOTIxNTExNVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAEKPxb22TcQG2ccYaBfS+VbMq6HhQMeOQ+G6GB7h
uG2QNotr/CMDiERxZC7VoImSeIdZxccjxGdyWOuOtawNbek0BclLI21pZ4qV1B326XGmuVdSpUYZ
XITplE1iTHWIWVbQaaer+zDXFIfley57dLZw7Nm6KW9yul/MBzohNJCcZiolaGS/qH6menk4NOby
Nu0NxGfCwnFT8hRik4gtWEEBEMxeY/yY5NFvImONzZdqs/VC/WcTCrpI40GzSboPvn5pM5Yq6XYI
547GYJfx8g6ITD43rpsDewfuIeVR3/ZLapDI+U71y0jCMiKNXQkBrW4SFO6szmhu4xtpWTabp3U=
--00000000000010c0170652fbd8a2--

