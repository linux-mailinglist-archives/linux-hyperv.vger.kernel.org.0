Return-Path: <linux-hyperv+bounces-6687-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 646C4B3F7CA
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Sep 2025 10:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2531B20A4D
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Sep 2025 08:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354F72E9EDD;
	Tue,  2 Sep 2025 08:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmsLm7IV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A622E9756
	for <linux-hyperv@vger.kernel.org>; Tue,  2 Sep 2025 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800553; cv=none; b=kYZaTgG9ipbKo2di8Udo1dQPDs5zYRMDq3okrKWQVyQHER5omwOU95I79g6NBt2TnzmwJy/umRSCKFiT8OoLu81GmGTFdirgCPm6vEC4MkM+8xJOK7n0oiHjyq5G7eWQ6fO88y1DPOzno7OTNoDNtxcHc6/LSS+2zwi2KNYyUec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800553; c=relaxed/simple;
	bh=qiNEZ68MzQUVkfWTAoYl1tW3fY35Ml5+qTzz/J8wvnU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fb2+dNCpEToWCVbitZ8+jCypgkfpE2ZQeUoz8xtC87U/vPWsW6Hw+tt6cFOnq+nmrC0G/Z42WA4+vLz7DbGydYjtLYXPdxJV5V/5LdUU+Vf1RE6M0sD/k3MKJqfuKFauidMMp9tTxzy2gp1zFrO1yiW4VDT0ARe2WK8+IshWu8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NmsLm7IV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756800549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2OhQYE6+zAbUaMelqyE0wxDBwF42vTEkThKnSoTAqWA=;
	b=NmsLm7IV5PTD3b+p34UAb2fpDfwdFQzqZCMxW/heWBs6OxXrSqu7WH1LH8jUk7GCOe/206
	ezkEhsC9SLJ6VG2PBWzb1hdb3f4OdLoOgUrx3mJ2UBNL0dusCpuOYfWOl4HtWEqXb6po5a
	+fAimiAVg7EiTQ+mtlJk5nM3XFA2Ht0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-y-4zUk5HPWGgqcvkFlbAfw-1; Tue, 02 Sep 2025 04:09:08 -0400
X-MC-Unique: y-4zUk5HPWGgqcvkFlbAfw-1
X-Mimecast-MFC-AGG-ID: y-4zUk5HPWGgqcvkFlbAfw_1756800547
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b8dde54c1so10216595e9.1
        for <linux-hyperv@vger.kernel.org>; Tue, 02 Sep 2025 01:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756800547; x=1757405347;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OhQYE6+zAbUaMelqyE0wxDBwF42vTEkThKnSoTAqWA=;
        b=h29ukU4qssbAL0PK71KNwSjQcyrnH+JgqbBAkGnEhKdrGC2h6px2bXxr1u+Ysa++58
         XlG+iuiED1Uq0Gb8O9f4qqS6QEp9RPgYTDcQwBwW62owgn/1n/PLkqhlvpG6Rkv4qYgd
         u/IOYBFDsmQKs4pMmIQJDKspuTqZJUwNDi8I21Ulmz/4DYXfCSkqwqAzpIOK3OUzMy5K
         retbMtvmc7CUnV47om95rZDFzykR9pyMcv7XAQZdiVtxX1C1ShasCGg7hrrdM0iYubHD
         wnz8jfqBCN6Lfn1Ch1SoYRXn+MWZZc2FawEpwM5MwXMU4Gwcm91oyGslnCnfXSanoj9V
         hCAw==
X-Forwarded-Encrypted: i=1; AJvYcCVnQJ7yxh5vWdiZtYl1XCJd3WA4U9gABSkeuhdFwRBCWgM3ZyqyRykpx7EUEVprElRY21eaweLHd7R100A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFSAEQIFtagF5laO5GFiZvkIM+aB6cq33HRzL38Xu/9MpE3j58
	6HChNf/9rDDvSfSgBgShLneYnK7JxfcjIHP3xVe3i4c87xPI7ENrYNd6I+coXiOz77PdW0JqXub
	qGc5tg8HOtmygFvNvlxgoGLubMclNnrWG72wlD9fjI4vADYndq5PNyav0ELomtoTE8A==
X-Gm-Gg: ASbGncsqzV6lgo68dguDjj36ropCJtxUFd9gpZ9paMqv+QmEkypZ9WP26v+oF60UUh6
	AmWGsYaVwop9IqA6Hlv7fzueYvZ+37rbBtkARik86N+zW38IzKw6ZCTqOZZYCVkcFxf5nnbjTB2
	2yTFZSaSZYXXiC+DCE+mTekJ+Ppel0lM546e0sUjL0e9OQXqXzz1AbnJcX87U9FqL4AMVeuK6fq
	QJPjgoP2eH0Xbn5rZP/l6Jo+XpYrRF5ZaxqdsRxQdAphefkMAFQ12LPQxJMRwfzoEH2JBByI1G7
	pj3hDvIByz9C2+sM26u5RNGCezd1SInXp7O/kRpcix1E6NBrK2HUJkcpzd3K37KcYQ==
X-Received: by 2002:a05:600c:1c92:b0:45b:9906:e1cd with SMTP id 5b1f17b1804b1-45b9906e531mr8098325e9.13.1756800546914;
        Tue, 02 Sep 2025 01:09:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/VpL8irUiMZ+51HF+UjS7DWzVHhCgZjxmNAmQZbWxJxQmRyWxfPkgR2t2/4l9ukH5cuWMrg==
X-Received: by 2002:a05:600c:1c92:b0:45b:9906:e1cd with SMTP id 5b1f17b1804b1-45b9906e531mr8097925e9.13.1756800546404;
        Tue, 02 Sep 2025 01:09:06 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b8f6cd502sm30099075e9.1.2025.09.02.01.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 01:09:05 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, louis.chauvet@bootlin.com,
 drawat.floss@gmail.com, hamohammed.sa@gmail.com, melissa.srw@gmail.com,
 mhklinux@outlook.com, simona@ffwll.ch, airlied@gmail.com,
 maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 1/4] drm/vblank: Add vblank timer
In-Reply-To: <20250901111241.233875-2-tzimmermann@suse.de>
References: <20250901111241.233875-1-tzimmermann@suse.de>
 <20250901111241.233875-2-tzimmermann@suse.de>
Date: Tue, 02 Sep 2025 10:09:04 +0200
Message-ID: <87iki1ff8f.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The vblank timer simulates a vblank interrupt for hardware without
> support. Rate-limits the display update frequency.
>
> DRM drivers for hardware without vblank support apply display updates
> ASAP. A vblank event informs DRM clients of the completed update.
>
> Userspace compositors immediately schedule the next update, which
> creates significant load on virtualization outputs. Display updates
> are usually fast on virtualization outputs, as their framebuffers are
> in regular system memory and there's no hardware vblank interrupt to
> throttle the update rate.
>
> The vblank timer is a HR timer that signals the vblank in software.
> It limits the update frequency of a DRM driver similar to a hardware
> vblank interrupt. The timer is not synchronized to the actual vblank
> interval of the display.
>
> The code has been adopted from vkms, which added the funtionality
> in commit 3a0709928b17 ("drm/vkms: Add vblank events simulated by
> hrtimers").
>
> The new implementation is part of the existing vblank support,
> which sets up the timer automatically. Drivers only have to start
> and cancel the vblank timer as part of enabling and disabling the
> CRTC. The new vblank helper library provides callbacks for struct
> drm_crtc_funcs.
>
> The standard way for handling vblank is to call drm_crtc_handle_vblank().
> Drivers that require additional processing, such as vkms, can init
> handle_vblank_timeout in struct drm_crtc_helper_funcs to refer to
> their timeout handler.
>
> v2:
> - implement vblank timer entirely in vblank helpers
> - downgrade overrun warning to debug
> - fix docs
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Tested-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


