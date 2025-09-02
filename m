Return-Path: <linux-hyperv+bounces-6690-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0F4B3F866
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Sep 2025 10:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93F337A71D5
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Sep 2025 08:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A405549659;
	Tue,  2 Sep 2025 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyuYdJf3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080A732F74D
	for <linux-hyperv@vger.kernel.org>; Tue,  2 Sep 2025 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801855; cv=none; b=Tsf18IqRhU0OlStzxVXJ2p7PNs5BSox61nxR4Ld0Bb0T9s/6LrSKJQn00QG2HTeD9uBDdQruUQ59/AC9PWNRiwUM1LwWU2+IKYnlw2FTyKIsgVr3cU0lS5pZd4rp5luSTz2Bn5JGMoVcZwDoLQTsc8UAJcNlngYiBSOW2fWmtjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801855; c=relaxed/simple;
	bh=J0FOKw18bQqiZndUX3/kl4FB3MnJG3tsw14gKEkqYrM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ys5R8uM9az7JwkszMnYH+NOBI8+FAQp6P3rmgxw29GwAlfBwBzzh9mImz8JfoiNsYAjI1DGt+LLmxnYSBGtp+eXkAuMXR6Fzbbo3VZqmi/MMufa5Ifnn+OYGj3Q2eO2pWTiolJEmJyn2yBNV6R5Zddyq9A/DUoroA6iZ7Tz3Ig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VyuYdJf3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756801852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wBDSSqe7FlRUs9+SC96WEURGCZ4RIAlgXMeG6XQaDTc=;
	b=VyuYdJf3zuSpTCdlfAlfJmuosNHlfjAklAO4KzhwFDML8bhjESsD+fHyG0NvL4XYj8MIAA
	iZzwYi/i+FTDwf8a19HbpzExQQqbjze3MKCRSkBYvzpuZI7QcMPFH9/xN0e0YFAcAWd2Qj
	De4hAo5KTvw26geL+iPtxXXX9JhlSyk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-IqQxkQpmNkSCf-6btZm7YA-1; Tue, 02 Sep 2025 04:30:51 -0400
X-MC-Unique: IqQxkQpmNkSCf-6btZm7YA-1
X-Mimecast-MFC-AGG-ID: IqQxkQpmNkSCf-6btZm7YA_1756801850
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b986a7b8aso3281405e9.0
        for <linux-hyperv@vger.kernel.org>; Tue, 02 Sep 2025 01:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756801850; x=1757406650;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBDSSqe7FlRUs9+SC96WEURGCZ4RIAlgXMeG6XQaDTc=;
        b=OrWEgHNNTLruMlfIHq+67C7YqHWALmow2gllksRlI1FCjvP7s305p/hcYiFz3n9sS/
         bXRhkrtEkquGz+gTvBKdGhFLWGDfTs9k+SXn0T1NhtLWJwc8hQPOIyzTGmtZZ8PvwQXn
         c/G3N/9C/Z2PdRjungg7xfm6vVGcKlPdGVIXUVrgfvR6FRXqYO3vP5lNq0tWBXrq/rPk
         Y7Kp9falID7C4RU3g7q7junbik7C5ERIa+F4SFvxQ0gebtb1oybT37TmRJpBO6w4LF1f
         NzY2rRRNZsqSw/kAaO9Rz3jbqmIVmGsvDcK6NYgJw1NG3gD+60WQ/dXWznCF37LZrB8a
         Uo5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTmCsFbzwZm8nDS9vZ9mfzinGPbjHs0/PY6PEQnyHmbrufsI51RSgEozuLvr2fBOSQJKH5c6DwBQVKujE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5/vNGZdm+ItaVEcxuQSMHBG/jxeWXXiUfZGcaZ32oNJzmFt54
	112Uk0jwjeQ2duLL6OKcdSumAwcDD3q3AQq6LEsrqbwYimkQlr+duCSidHqwWVTzopHi5F9rbQe
	gey1huIM9tQJtINDLnWiNZF4F5lYfyhw5WQmtDwqyqiRLP/PLn5aQxYdzj4X0BC2U+Q==
X-Gm-Gg: ASbGnct7rl8tw7LbEmVciTTuDS7UQICx24+bhceYMgyViLsYIV94vYX5tMpjHXdzaxx
	n2TpQRNigi8jJcYSJ7pwapb9by/HLWJYkI8DC9oTJiGnNWY4tECUlIlwiWZobPrHxBrag0+KVZW
	w+tVrojP1ZxhOgx5n5Og0lWLsRBgbblan1TyC17w6hZK2POjdv21OvEy6No4S2xbBDGdAy5lnth
	DRtULcDca1f35Z9TIb+4P6iZRvsQf1xSzz7VuLIsrmFRk+wNGqUN3AAP26HxeK0SlP60ej82k5a
	GHHxXrbx+AVDotr2AeWXEA1IfIV49LMY06BLnMDuzaZw8AZdXgJoGGYNlfoGTd3krQ==
X-Received: by 2002:a05:600c:3546:b0:459:dc99:51bf with SMTP id 5b1f17b1804b1-45b8557b680mr79201925e9.25.1756801850432;
        Tue, 02 Sep 2025 01:30:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWmHoeM9KLNr4xLRGpC+I67NSwblsrUmvfFZ3jbasJi4/F9OPw9jkHBjQ2+LXy77Bbp1fslA==
X-Received: by 2002:a05:600c:3546:b0:459:dc99:51bf with SMTP id 5b1f17b1804b1-45b8557b680mr79201735e9.25.1756801850013;
        Tue, 02 Sep 2025 01:30:50 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e68c83asm200349405e9.20.2025.09.02.01.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 01:30:49 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, louis.chauvet@bootlin.com,
 drawat.floss@gmail.com, hamohammed.sa@gmail.com, melissa.srw@gmail.com,
 mhklinux@outlook.com, simona@ffwll.ch, airlied@gmail.com,
 maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 4/4] drm/hypervdrm: Use vblank timer
In-Reply-To: <20250901111241.233875-5-tzimmermann@suse.de>
References: <20250901111241.233875-1-tzimmermann@suse.de>
 <20250901111241.233875-5-tzimmermann@suse.de>
Date: Tue, 02 Sep 2025 10:30:48 +0200
Message-ID: <87a53dfe87.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> HyperV's virtual hardware does not provide vblank interrupts. Use a
> vblank timer to simulate the interrupt. Rate-limits the display's
> update frequency to the display-mode settings. Avoids excessive CPU
> overhead with compositors that do not rate-limit their output.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

[...]

>  
> @@ -111,11 +113,15 @@ static void hyperv_crtc_helper_atomic_enable(struct drm_crtc *crtc,
>  				crtc_state->mode.hdisplay,
>  				crtc_state->mode.vdisplay,
>  				plane_state->fb->pitches[0]);
> +
> +	drm_crtc_vblank_on(crtc);
>  }
>  
>  static const struct drm_crtc_helper_funcs hyperv_crtc_helper_funcs = {
>  	.atomic_check = drm_crtc_helper_atomic_check,
> +	.atomic_flush = drm_crtc_vblank_atomic_flush,
>  	.atomic_enable = hyperv_crtc_helper_atomic_enable,
> +	.atomic_disable = drm_crtc_vblank_atomic_disable,
>  };
>  

I think your patch is correct due the driver not having an .atomic_disable
callback. But looking at the driver, I see that its .atomic_enable does:

static void hyperv_crtc_helper_atomic_enable(struct drm_crtc *crtc,
                                             struct drm_atomic_state *state)
{
...
        hyperv_update_situation(hv->hdev, 1,  hv->screen_depth,
                                crtc_state->mode.hdisplay,
                                crtc_state->mode.vdisplay,
                                plane_state->fb->pitches[0]);
}

and this function in turn does:

int hyperv_update_situation(struct hv_device *hdev, u8 active, u32 bpp,
                            u32 w, u32 h, u32 pitch)
{
...
        msg.situ.video_output[0].active = active;
...
}

So I wonder if it should instead have a custom .atomic_disable that calls:

        hyperv_update_situation(hv->hdev, 0,  hv->screen_depth,
                                crtc_state->mode.hdisplay,
                                crtc_state->mode.vdisplay,
                                plane_state->fb->pitches[0]);

I'm not familiar with hyperv to know whether is a problem or not for the
host to not be notified that the guest display is disabled. But I thought
that should raise this question for the folks familiar with it.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


