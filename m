Return-Path: <linux-hyperv+bounces-6702-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1018B40952
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Sep 2025 17:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD9D200D4C
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Sep 2025 15:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0082302CAA;
	Tue,  2 Sep 2025 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fkht+A8h"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D135324B07
	for <linux-hyperv@vger.kernel.org>; Tue,  2 Sep 2025 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827680; cv=none; b=YsgeQzPPQvrWW/CfZIoNiHkaITCtOWIcqyUNvAsqyrv825hu10j4cZGOGkAQ49PInFTD8zm04psGC9IFeMRcf2THTX3O/0uqHahkOJeCCbTRavCHE731FsMMw5c7KU5zIa/u4XwOEJttfXKt/cXoTZr7TprR/1vyg6JZBIr9g6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827680; c=relaxed/simple;
	bh=u9/WJ8H8wK+rX59VtPKSIOii2LjopysuH7XoQJLy2gU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tl6D0VLJ71bCi3iy1ATgHdI+xbTlxLjcqZ3Ion4LpDbUIZ+PaLxKhsfwztPlOJQMCbCo0IN6l6xRCjNWbuIajE+bSZRt4Bcf2s7H17UA1OZRNoanxUCLSKVmjRTN+4cybiB2/NfLxf2AIsc15LAixyHDJEL5CvRHIndBTeFtTqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fkht+A8h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756827678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=echO+HV+RoGgUzEJvYwbm1BGQwTumJtaUPpghadBhaY=;
	b=Fkht+A8hNaAKUgd9JcVjoH5grIWwJ/ov6eFqlpDerpl8jXxswQp4qXAWPKpGW5IdgO+cc0
	Z1tNWSrdprCLEsiwOMR9VeQtMKeWoxgWRSppkwX1oMq8uIeBSN9AZn68kp8j8bRhbU6aCv
	Uv1tDubBpEt8gf+gDyNXgEEmXAzsaQ4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-oZfa3qIPOceaFqRAi_8LoA-1; Tue, 02 Sep 2025 11:41:16 -0400
X-MC-Unique: oZfa3qIPOceaFqRAi_8LoA-1
X-Mimecast-MFC-AGG-ID: oZfa3qIPOceaFqRAi_8LoA_1756827675
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3dbc72f8d32so157413f8f.3
        for <linux-hyperv@vger.kernel.org>; Tue, 02 Sep 2025 08:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756827675; x=1757432475;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=echO+HV+RoGgUzEJvYwbm1BGQwTumJtaUPpghadBhaY=;
        b=EsILZ3rn3hTeo2X2fnWKpgEnkZb/ROrHScON3hDKm6ZMzfjkMqvEEXF20TARbcz6o+
         Es/dIqnfmYYqcUZEl/KTQ00NMLbnD4ZGenH7At0JOWKNS5ujQfNy5LQBXL5+bWSnaUP1
         6S2/WyyrZ6IioKa64BMUYidC9/UCNt4gm/RXd8pDK0nWrBu7te37oqgP1Ya5587KufPE
         hJr7NIKFpxUJXv0tsXJi/T5Een4QfozfFCEcJ/FYFR7MAYgI5zMbL9ntY40i+pSmSyQ3
         ix9KDHBVz+ZxNBtVy/SSl4BD9yLrVlBhxVqKk7rluuHSUAEk+OzXt9EE9AK6DCs3pqdH
         BXmw==
X-Forwarded-Encrypted: i=1; AJvYcCV6w0bxL7MtboMkbmqQ+RJslvGFahvFtdWuPGkT0Q9laoosq8NL/YRGiBty24vsaI67+a7FFK/cIaColwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+yqaFLUoJU86cC4XVwoA7nsMtUV6HTVe4YRn35BC6R2ey3qhE
	LgeiUpknKaAkj+IvixuXKqZSs6zXuY/pbtav1LoB817OIKaKAVfZ+D8mEy+MelBLXMNG3tFbbGJ
	6PMrTcAQFKXegZB18llqjhQBVbV/e1BY5Z6gy0K8aWriAIqzzS1ZCNjFdap/lGrvvKQ==
X-Gm-Gg: ASbGncv9FC8fR1rSrW2dozCUOzdu2IxaMYZ/krpm1G4Oae2fBbavMSD3ikNvQ2VnBtg
	xRL3f5TISpxqciyfpTgJq3nDyAfmhgXNE1Vnng1pxaxZ28CHlIHXwQ7aI4EFbMQ/zQDwENqvuSd
	G2oaimElU2hgsVObd5I9pb0lZPqgz/1R0ji48Yv/QXUTTXaHFCZSVPmhdtwn491Ghc0Q6lIoqGj
	Ev3nz+7yyD7x1ZIw61qxSzLwD9j8QoMyZ/PFSdy87vWqytrd1nEcsGOftt3DYvmwkFUKK+77GnM
	hYrRKWmQuCjeHy8gIe2INGJPmiWN8cwMB9AUXvvQJu7wnL+d++CiMgjzELZqdTKqyA==
X-Received: by 2002:a05:6000:4282:b0:3cf:cb1a:c698 with SMTP id ffacd0b85a97d-3d1dfb11359mr8428997f8f.30.1756827675375;
        Tue, 02 Sep 2025 08:41:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgJhPGDWOK1avxYgWFCOEVvVTXVILBzYi6KjL76UC34Zomae+j073wyFWpMlXlr7dmrpap6Q==
X-Received: by 2002:a05:6000:4282:b0:3cf:cb1a:c698 with SMTP id ffacd0b85a97d-3d1dfb11359mr8428977f8f.30.1756827674944;
        Tue, 02 Sep 2025 08:41:14 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d60cf93cb2sm11223450f8f.12.2025.09.02.08.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 08:41:14 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, louis.chauvet@bootlin.com,
 drawat.floss@gmail.com, hamohammed.sa@gmail.com, melissa.srw@gmail.com,
 mhklinux@outlook.com, simona@ffwll.ch, airlied@gmail.com,
 maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v2 4/4] drm/hypervdrm: Use vblank timer
In-Reply-To: <5cd7f22d-e39a-4d37-8286-0194d6c9a818@suse.de>
References: <20250901111241.233875-1-tzimmermann@suse.de>
 <20250901111241.233875-5-tzimmermann@suse.de>
 <87a53dfe87.fsf@minerva.mail-host-address-is-not-set>
 <5cd7f22d-e39a-4d37-8286-0194d6c9a818@suse.de>
Date: Tue, 02 Sep 2025 17:41:12 +0200
Message-ID: <877bygg8vb.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

[...]

>>
>> I'm not familiar with hyperv to know whether is a problem or not for the
>> host to not be notified that the guest display is disabled. But I thought
>> that should raise this question for the folks familiar with it.
>
> The feedback I got at 
> https://lore.kernel.org/dri-devel/SN6PR02MB4157F630284939E084486AFED46FA@SN6PR02MB4157.namprd02.prod.outlook.com/ 
> is that the vblank timer solves the problem of excessive CPU consumption 
> on hypervdrm. Ans that's also the observation I had with other drivers. 
> I guess, telling the host about the disabled display would still make sense.
>

Yes, I read the other thread you referenced and that's why I said that
your patch is correct to solve the issue.

I just wanted to point out, since it could be that as a follow-up the
driver could need its own .atomic_disable instead of using the default
drm_crtc_vblank_atomic_disable(). Something like the following maybe:

+static void hyperv_crtc_helper_atomic_disable(struct drm_crtc *crtc,
+                                             struct drm_atomic_state *state)
+{
+       struct hyperv_drm_device *hv = to_hv(crtc->dev);
+       struct drm_plane *plane = &hv->plane;
+       struct drm_plane_state *plane_state = plane->state;
+       struct drm_crtc_state *crtc_state = crtc->state;
+
+       hyperv_hide_hw_ptr(hv->hdev);
+       /* Notify the host that the guest display is disabled */
+       hyperv_update_situation(hv->hdev, 0,  hv->screen_depth,
+                               crtc_state->mode.hdisplay,
+                               crtc_state->mode.vdisplay,
+                               plane_state->fb->pitches[0]);
+
+       drm_crtc_vblank_off(crtc);
+}
+
 static const struct drm_crtc_helper_funcs hyperv_crtc_helper_funcs = {
        .atomic_check = drm_crtc_helper_atomic_check,
        .atomic_flush = drm_crtc_vblank_atomic_flush,
        .atomic_enable = hyperv_crtc_helper_atomic_enable,
-       .atomic_disable = drm_crtc_vblank_atomic_disable,
+       .atomic_disable = hyperv_crtc_helper_atomic_disable,
 };

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


