Return-Path: <linux-hyperv+bounces-5162-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F603A9DA80
	for <lists+linux-hyperv@lfdr.de>; Sat, 26 Apr 2025 14:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8022F172101
	for <lists+linux-hyperv@lfdr.de>; Sat, 26 Apr 2025 12:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4946522FDE8;
	Sat, 26 Apr 2025 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZIhYvVC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7790121578D
	for <linux-hyperv@vger.kernel.org>; Sat, 26 Apr 2025 12:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745669599; cv=none; b=sBrJneOzz05mkq9/0zIyrFaVcMilF63OfoLG0+0k1xeI/hcUCBXTI/J6zz8ldHX9kxmcjubj/DZN59x3ctE+LE/JoQ6uCoUkBLB2N9BhQ2dp0awneqBBu4QSH/9UY1t90ZG9Q+GTUBiVO0V/p29irM9DtG/WeLr+dog1ZIZAPfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745669599; c=relaxed/simple;
	bh=53WPXHcZDRdCxH3dOJiupnW+3yRJeUva+6PJxzQa+fY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1nIZULHhZrG5OVWmeGj1innanJs/bHvzPt0sGnB4muyi9s9mtIX8KA4nbbn2S2EUhnG/1olkCMeKxEO9yTlbZ3Dh7LEraiveI4vzdmv6k3ArKNDqAST/kIjSl8cIZg3NvT311ODoZ9Tk5BfhSsm2HlCRiTbmWD9fvY5rfcgJFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZIhYvVC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745669595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8xTcAXMj4tAsirXSeiAXOoY8tnLHpYX9Lnnx10mXT5k=;
	b=GZIhYvVCpsEGoCki7U26BLQDzWYfUltlCl8HpNnv1ClqjQ8ZraSDcQDaDJi86qbGrwXbTl
	6WFP/A+RS2vuzOfe3uoqg6XOJa7N3v7v49qEho4W/PISaVzlFPFro/CWD9jXuLlryTPYum
	b62ScYlKifPGa1LwnHFFiczQyK8CGH4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-W2Bu2vb8MM2EJLBaxCC7SA-1; Sat, 26 Apr 2025 08:13:13 -0400
X-MC-Unique: W2Bu2vb8MM2EJLBaxCC7SA-1
X-Mimecast-MFC-AGG-ID: W2Bu2vb8MM2EJLBaxCC7SA_1745669592
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff8340d547so2601954a91.2
        for <linux-hyperv@vger.kernel.org>; Sat, 26 Apr 2025 05:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745669592; x=1746274392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xTcAXMj4tAsirXSeiAXOoY8tnLHpYX9Lnnx10mXT5k=;
        b=jvTORbIOvLSuUtFS/p6bd9dnJIHz565vlXIuWL95+/IWacsvBbWVWfc8wXFhY+uIXD
         JUHIjdz49WoqJ/5lYMSFWTLLkLKUndTP0bMKRFkoEf5K1fuh3y4VR/NkGs/QWJMGnvUU
         kQ+6TFuG+bSnsHPpT88o61DPYExsi9k5ryu4Oz0yhrON8gR7Rd6pfI7hl4Iq4e3z1fV3
         VkzQyAtpogBLDBjl9LGQnoznzHIxCilV75WHaHwxTvAcA+pW+MbnkDQyEvdwEbQNNPpZ
         pFSCWCH19zo/4xmHMDXtShIYynaYL74YuOjxkaS8qW1dVugxYN4pkBjfIyusqRogRRj8
         C7wA==
X-Forwarded-Encrypted: i=1; AJvYcCU+jW71rHjQX9JEXowIrRWCeYGk5OEAAKdgEemhovS7qqAiDc9rXwTwAzS5/dea8svS4PjdkmhjxwsmN1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSetp8FxSyZsy6vX/pWg590p87phAuYBZymyznbDD6FglFJebA
	LWSt+grcQBAqaKRnPg7ijJbrJN1KF9tZLfFTakhdReDPZPDcYQeDQG5W6ws/3JB9/Iir1ghe8WF
	MGzNNUDFPwViH0Cp6S5SnbQid2ij2+Y6Q0bi+J9i8ViFf9Hs+GwFK9TexF6jnQd7mdcdlSfPpSw
	WfUUIsFRQbrA9cC1OGXTnw4w2l4vOTnKTp0tUj
X-Gm-Gg: ASbGncsy8YdRfr3SLkJHU9oOC/CNwJuzbyJdKIQJJse/CpoXQ8+XWZ8niBxKyJtx3bV
	jREvwya/X3M3L8GYwBzNexELUznXTXoathD/Jmp6eYMg5h0JHfIR4oK7A1an177d0dVFXQ/6fPZ
	Fu/ZoHf+ze+Usl/NmxAY5Kw0Ja
X-Received: by 2002:a17:90a:e70b:b0:301:1d9f:4ba2 with SMTP id 98e67ed59e1d1-30a01398557mr4355667a91.28.1745669592378;
        Sat, 26 Apr 2025 05:13:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbEOQ7OJ1l+r0ODl6FuQUy8VHIQMHy0KMCDKAuggeFJa2xVPLoqb7dQAjINDCv4vafGglRIW52yLgCmTZ3urA=
X-Received: by 2002:a17:90a:e70b:b0:301:1d9f:4ba2 with SMTP id
 98e67ed59e1d1-30a01398557mr4355644a91.28.1745669592087; Sat, 26 Apr 2025
 05:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425063234.757344-1-ryasuoka@redhat.com> <87wmb8yani.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87wmb8yani.fsf@minerva.mail-host-address-is-not-set>
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
Date: Sat, 26 Apr 2025 21:13:00 +0900
X-Gm-Features: ATxdqUEw5zYtq3FD3jK20hIdBkgB26BvzEwuuPr00vWIGWH2Uh-jkXnoDtXz9Kg
Message-ID: <CAHpthZqJPKtXUjFiVRLP+LEmTKFowUKVHGDe9=NS4aGx7WWcMA@mail.gmail.com>
Subject: Re: [PATCH drm-next v2] drm/hyperv: Replace simple-KMS with regular
 atomic helpers
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: drawat.floss@gmail.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	jfalempe@redhat.com, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Javier,

On Fri, Apr 25, 2025 at 4:15=E2=80=AFPM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Ryosuke Yasuoka <ryasuoka@redhat.com> writes:
>
> Hello Ryosuke,
>
> > Drop simple-KMS in favor of regular atomic helpers to make the code mor=
e
> > modular. The simple-KMS helper mix up plane and CRTC state, so it is
> > obsolete and should go away [1]. Since it just split the simple-pipe
> > functions into per-plane and per-CRTC, no functional changes is
> > expected.
> >
> > [1] https://lore.kernel.org/lkml/dae5089d-e214-4518-b927-5c4149babad8@s=
use.de/
> >
> > Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> >
>
>
>
> > -static void hyperv_pipe_enable(struct drm_simple_display_pipe *pipe,
> > -                            struct drm_crtc_state *crtc_state,
> > -                            struct drm_plane_state *plane_state)
> > +static const uint32_t hyperv_formats[] =3D {
> > +     DRM_FORMAT_XRGB8888,
> > +};
> > +
> > +static const uint64_t hyperv_modifiers[] =3D {
> > +     DRM_FORMAT_MOD_LINEAR,
> > +     DRM_FORMAT_MOD_INVALID
> > +};
> > +
>
> I think the kernel u32 and u64 types are preferred ?

I'm not sure if I should fix this in this patch because I did not add these
variables. IMO, we need to split the commit if we fix them.

> > +static void hyperv_crtc_helper_atomic_enable(struct drm_crtc *crtc,
> > +                                          struct drm_atomic_state *sta=
te)
> >  {
> > -     struct hyperv_drm_device *hv =3D to_hv(pipe->crtc.dev);
> > -     struct drm_shadow_plane_state *shadow_plane_state =3D to_drm_shad=
ow_plane_state(plane_state);
> > +     struct hyperv_drm_device *hv =3D to_hv(crtc->dev);
> > +     struct drm_plane *plane =3D &hv->plane;
> > +     struct drm_plane_state *plane_state =3D plane->state;
> > +     struct drm_crtc_state *crtc_state =3D crtc->state;
> >
> >       hyperv_hide_hw_ptr(hv->hdev);
> >       hyperv_update_situation(hv->hdev, 1,  hv->screen_depth,
> >                               crtc_state->mode.hdisplay,
> >                               crtc_state->mode.vdisplay,
> >                               plane_state->fb->pitches[0]);
> > -     hyperv_blit_to_vram_fullscreen(plane_state->fb, &shadow_plane_sta=
te->data[0]);
> >  }
> >
> > -static int hyperv_pipe_check(struct drm_simple_display_pipe *pipe,
> > -                          struct drm_plane_state *plane_state,
> > -                          struct drm_crtc_state *crtc_state)
> > +static void hyperv_crtc_helper_atomic_disable(struct drm_crtc *crtc,
> > +                                           struct drm_atomic_state *st=
ate)
> > +{ }
> > +
>
> Why do you need an empty CRTC atomic disable callback? Can you just not
> set it instead?

OK. I'll fix it in my next patch.

> >
> > -static void hyperv_pipe_update(struct drm_simple_display_pipe *pipe,
> > -                            struct drm_plane_state *old_state)
> > +static void hyperv_plane_atomic_update(struct drm_plane *plane,
> > +                                                   struct drm_atomic_s=
tate *old_state)
> >  {
> > -     struct hyperv_drm_device *hv =3D to_hv(pipe->crtc.dev);
> > -     struct drm_plane_state *state =3D pipe->plane.state;
> > +     struct drm_plane_state *old_pstate =3D drm_atomic_get_old_plane_s=
tate(old_state, plane);
> > +     struct hyperv_drm_device *hv =3D to_hv(plane->dev);
> > +     struct drm_plane_state *state =3D plane->state;
>
> You should never access the plane->state directly, instead the helper
> drm_atomic_get_new_plane_state() should be used. You can also rename
> the old_state paramete to just state, since it will be used to lookup
> both the old and new atomic states.
>
> More info is in the following email from Ville:
>
> https://lore.kernel.org/dri-devel/Yx9pij4LmFHrq81V@intel.com/

OK. I'll fix it in my next patch. Thank you for sharing the url.

> >       struct drm_shadow_plane_state *shadow_plane_state =3D to_drm_shad=
ow_plane_state(state);
> >       struct drm_rect rect;
> >
> > -     if (drm_atomic_helper_damage_merged(old_state, state, &rect)) {
> > +     if (drm_atomic_helper_damage_merged(old_pstate, state, &rect)) {
>
> I know that most of the simple-KMS drivers do this but since this driver
> enables FB damage clips support, it is better to iterate over the damage
> areas. For example:
>
>         struct drm_atomic_helper_damage_iter iter;
>         struct drm_rect dst_clip;
>         struct drm_rect damage;
>
>         drm_atomic_helper_damage_iter_init(&iter, old_pstate, state);
>         drm_atomic_for_each_plane_damage(&iter, &damage) {
>                 dst_clip =3D state->dst;
>
>                 if (!drm_rect_intersect(&dst_clip, &damage))
>                         continue;
>
>                 hyperv_blit_to_vram_rect(state->fb, &shadow_plane_state->=
data[0], &damage);
>                 hyperv_update_dirt(hv->hdev, &damage);
>         }
>

OK. As you said, other drivers like mgag200 implement like this. I'll
fix them in my next patch.

> Other than these small comments, the patch looks good to me. So if you ta=
ke
> into account my suggestions, feel free to add:
>
> Acked-by: Javier Martinez Canillas <javierm@redhat.com>

Thank you for your review and comment. I'll fix them and add your ack.

Best regards,
Ryosuke

> --
> Best regards,
>
> Javier Martinez Canillas
> Core Platforms
> Red Hat
>


