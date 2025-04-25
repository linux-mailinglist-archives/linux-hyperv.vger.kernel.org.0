Return-Path: <linux-hyperv+bounces-5113-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 781E0A9BF9C
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 09:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849833A95A4
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 07:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D2122F75F;
	Fri, 25 Apr 2025 07:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Btoo6R0R"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4D81B3930
	for <linux-hyperv@vger.kernel.org>; Fri, 25 Apr 2025 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745565342; cv=none; b=j2yp0uiCvx7sED5eYtusSXIy0CB6a0kvPFGTo0SkROc6QdSVNxAVjVUKtJcQ5rGej1+q6FpkzWUCQ6TWqQgfV6ak7f1Rj0vRSYgqQ4A0tn8JMFIDk6aVi/QD5rg9OkWQkhQKXuwRzoPaiKVR/xK4Z6eD8ndb5daqgj42wV3wq/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745565342; c=relaxed/simple;
	bh=Z0yNmKrBiTY5ZX2EKRFyzFZhdWxcMonxd/cXfY84SHw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HAFtI6sa9eIRwYgr+gnErb7eT5fHL1jpT9LCyOVbmwdXqwhVPOPEtkkr4mRf7jCn/CyE0eyewAHvUiRD8Owlmhka8xEzjqAzWCWVe4ugX+fFy9QOTPciB4vspn7TeVBe6bG/BdVMUYYZdI+kj+Y7yPah40xTBKpL4wodZh/FAQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Btoo6R0R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745565336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T7r2z4B/7Mbfi0IDabIkh3LojKAky8fE2btyGmdHAwA=;
	b=Btoo6R0RtoRTPNV7S+w+7t2W6bpU1Oq0sBdGts3NiOq+UBw8aznwxyVxRD/MeM+igFas7s
	VOofYhOfrmEKiAWosTMX4U4hDobCw+rBcxwTA/HYkCQjwYT+2HYP1UZktgssyRQtfj31Nj
	nOit9oCLcs0ez6+17bTaE0m7DYToYFQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-ngCky00-ObiExDKA9uWuMw-1; Fri, 25 Apr 2025 03:15:33 -0400
X-MC-Unique: ngCky00-ObiExDKA9uWuMw-1
X-Mimecast-MFC-AGG-ID: ngCky00-ObiExDKA9uWuMw_1745565332
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39ef89b862dso953356f8f.0
        for <linux-hyperv@vger.kernel.org>; Fri, 25 Apr 2025 00:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745565332; x=1746170132;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7r2z4B/7Mbfi0IDabIkh3LojKAky8fE2btyGmdHAwA=;
        b=cZRCT+r3snSBeoOfzjhaS2e4phXqItFXtknnlTlSCoO4A6FNc+y3bcNBAKx6qBpTxY
         TVsSCqThlKIPW4KxGuCVly95t46q3NnfvA3Do6FIqVDlwUasyHtbYYyAgHthgdLyG5R9
         tQ8o8hPd8Bs74xfYDKQQpcrhD1xb/jW3bGFVYbcSrDRc8aAFg2tMVhCFaqjJnLheqmEM
         N2tSO3vUUp0XRSlgiX/ynM4s66FlIst7soMypavv75V/W11nfQUBt/ZnqtbBDhEuHRfB
         1u/n261lNE0/RxJAXCI9DfEXisZrtigFfqF2CdwOVxpqQJ0bc2JtiCbEeLpo5cHBuHHs
         9bUA==
X-Forwarded-Encrypted: i=1; AJvYcCWFC3y/wz0kG6b6IVyUlz03vbSrC17b+pNs9V2GBAQK0/09k+feW3EfpPorNihBmA8bD207KYWDyBHUZdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkjfwDLWudWpPRHaZ9q/54EsSeILZYPbq0NO75jG4cSqadSrOU
	N9Ao5CgBrco/xDCUqv5ItuApjfUaYKkERr/2vv3kBNc00roqkW3+6A3iz/lJKVCTpyx1gMPqhdP
	/gwZmEnyoq1uoWN7aCLaTxBA9QKs4EFWX0G9LmpfD6q7Um7QEOcus6/Kt9GYgww==
X-Gm-Gg: ASbGncuzRKso92Ay3mSAXclU0LbxyHleB2VIUGy/CsF3LM2tkyWkhIvMCpByFa8KXuy
	cwy4Bv5o8DfR8TyxCxGNy61Q2RZTk+QHNQEtv07rrrkEwUlSeQZKmE8dZDH30LwPwZytFeJassZ
	3uw1jrgYvejIAnOQ1SBvFBD6YmUfeNq5LPS/8Qvp/bEnNOIhQz1u327w5El4XAiATK8aeWgEOf6
	C6zhEMQ7fKBzvAaB9P9UyZRvSDnBtLlKzRuabgpn4zylH3unS6MJ88B+LHFlPyUEFeZM1Qw5h4D
	PQCelXy/1byeBRdtDmwOKom9x0avCkhdC0ICvIObgC8r6mi9K/4nHZ6+UPOcL42bSr+4dA==
X-Received: by 2002:a05:6000:186c:b0:39f:fcb:3bf6 with SMTP id ffacd0b85a97d-3a074e0dfccmr653955f8f.2.1745565332262;
        Fri, 25 Apr 2025 00:15:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKjltySyoEEsZUoyQAjvToSkGsH8mjTJtTxmkBO665sLQSkBEEV6kyM0pGb2qhN8WQSJn6fQ==
X-Received: by 2002:a05:6000:186c:b0:39f:fcb:3bf6 with SMTP id ffacd0b85a97d-3a074e0dfccmr653934f8f.2.1745565331871;
        Fri, 25 Apr 2025 00:15:31 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ca543bsm1492506f8f.34.2025.04.25.00.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 00:15:31 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, drawat.floss@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 jfalempe@redhat.com
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH drm-next v2] drm/hyperv: Replace simple-KMS with regular
 atomic helpers
In-Reply-To: <20250425063234.757344-1-ryasuoka@redhat.com>
References: <20250425063234.757344-1-ryasuoka@redhat.com>
Date: Fri, 25 Apr 2025 09:15:29 +0200
Message-ID: <87wmb8yani.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ryosuke Yasuoka <ryasuoka@redhat.com> writes:

Hello Ryosuke,

> Drop simple-KMS in favor of regular atomic helpers to make the code more
> modular. The simple-KMS helper mix up plane and CRTC state, so it is
> obsolete and should go away [1]. Since it just split the simple-pipe
> functions into per-plane and per-CRTC, no functional changes is
> expected.
>
> [1] https://lore.kernel.org/lkml/dae5089d-e214-4518-b927-5c4149babad8@suse.de/
>
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>



> -static void hyperv_pipe_enable(struct drm_simple_display_pipe *pipe,
> -			       struct drm_crtc_state *crtc_state,
> -			       struct drm_plane_state *plane_state)
> +static const uint32_t hyperv_formats[] = {
> +	DRM_FORMAT_XRGB8888,
> +};
> +
> +static const uint64_t hyperv_modifiers[] = {
> +	DRM_FORMAT_MOD_LINEAR,
> +	DRM_FORMAT_MOD_INVALID
> +};
> +

I think the kernel u32 and u64 types are preferred ?

> +static void hyperv_crtc_helper_atomic_enable(struct drm_crtc *crtc,
> +					     struct drm_atomic_state *state)
>  {
> -	struct hyperv_drm_device *hv = to_hv(pipe->crtc.dev);
> -	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
> +	struct hyperv_drm_device *hv = to_hv(crtc->dev);
> +	struct drm_plane *plane = &hv->plane;
> +	struct drm_plane_state *plane_state = plane->state;
> +	struct drm_crtc_state *crtc_state = crtc->state;
>  
>  	hyperv_hide_hw_ptr(hv->hdev);
>  	hyperv_update_situation(hv->hdev, 1,  hv->screen_depth,
>  				crtc_state->mode.hdisplay,
>  				crtc_state->mode.vdisplay,
>  				plane_state->fb->pitches[0]);
> -	hyperv_blit_to_vram_fullscreen(plane_state->fb, &shadow_plane_state->data[0]);
>  }
>  
> -static int hyperv_pipe_check(struct drm_simple_display_pipe *pipe,
> -			     struct drm_plane_state *plane_state,
> -			     struct drm_crtc_state *crtc_state)
> +static void hyperv_crtc_helper_atomic_disable(struct drm_crtc *crtc,
> +					      struct drm_atomic_state *state)
> +{ }
> +

Why do you need an empty CRTC atomic disable callback? Can you just not
set it instead?

>  
> -static void hyperv_pipe_update(struct drm_simple_display_pipe *pipe,
> -			       struct drm_plane_state *old_state)
> +static void hyperv_plane_atomic_update(struct drm_plane *plane,
> +						      struct drm_atomic_state *old_state)
>  {
> -	struct hyperv_drm_device *hv = to_hv(pipe->crtc.dev);
> -	struct drm_plane_state *state = pipe->plane.state;
> +	struct drm_plane_state *old_pstate = drm_atomic_get_old_plane_state(old_state, plane);
> +	struct hyperv_drm_device *hv = to_hv(plane->dev);
> +	struct drm_plane_state *state = plane->state;

You should never access the plane->state directly, instead the helper
drm_atomic_get_new_plane_state() should be used. You can also rename
the old_state paramete to just state, since it will be used to lookup
both the old and new atomic states.

More info is in the following email from Ville:

https://lore.kernel.org/dri-devel/Yx9pij4LmFHrq81V@intel.com/

>  	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
>  	struct drm_rect rect;
>  
> -	if (drm_atomic_helper_damage_merged(old_state, state, &rect)) {
> +	if (drm_atomic_helper_damage_merged(old_pstate, state, &rect)) {

I know that most of the simple-KMS drivers do this but since this driver
enables FB damage clips support, it is better to iterate over the damage 
areas. For example:

	struct drm_atomic_helper_damage_iter iter;
        struct drm_rect dst_clip;
	struct drm_rect damage;

	drm_atomic_helper_damage_iter_init(&iter, old_pstate, state);
	drm_atomic_for_each_plane_damage(&iter, &damage) {
		dst_clip = state->dst;

		if (!drm_rect_intersect(&dst_clip, &damage))
			continue;

                hyperv_blit_to_vram_rect(state->fb, &shadow_plane_state->data[0], &damage);
                hyperv_update_dirt(hv->hdev, &damage);
        }


Other than these small comments, the patch looks good to me. So if you take
into account my suggestions, feel free to add:

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


