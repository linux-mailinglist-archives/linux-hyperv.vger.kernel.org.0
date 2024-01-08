Return-Path: <linux-hyperv+bounces-1383-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A10826AAA
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jan 2024 10:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92AE1F218F1
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jan 2024 09:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB6F1170B;
	Mon,  8 Jan 2024 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aEVK8Oee"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F4C11709
	for <linux-hyperv@vger.kernel.org>; Mon,  8 Jan 2024 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704706052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zUbxtUWHK+UVvc38nQ4ZugcC7K2U909xpxfpjqV/w1A=;
	b=aEVK8OeeuikbjDVs8l2pDtYiGXfITnKIKwMSmt3E7uWuaVqLpIJw4KGCbFXbpCLpXO6U94
	elfR0q4/ll4vHr7RLIeYLMC3HpDpA4Jo2OUSZtF07GE3M+5s0VlVfE4NGlpYj1FaP6azlx
	XiNtb8tAVggt93dxsiuloP98KIn+jOE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-EZnW_6KoOamk8NV6V94Bkg-1; Mon, 08 Jan 2024 04:27:30 -0500
X-MC-Unique: EZnW_6KoOamk8NV6V94Bkg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e34df6fdcso12850545e9.1
        for <linux-hyperv@vger.kernel.org>; Mon, 08 Jan 2024 01:27:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704706048; x=1705310848;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zUbxtUWHK+UVvc38nQ4ZugcC7K2U909xpxfpjqV/w1A=;
        b=CO4iMVSPzTZENUQR0tOgw2ccNsunvvtmrpl8GaovGG+e1Me8Gd8c19V/LSYrI7j/KJ
         g/gZ+6RMVccBe69BEmuA9OOoeGWNe7N/VweooZvFINfJUB3zuwXRkvxzsQWP9lzoWFOH
         o420KOxFNynTvKczQrHv1Zra+AxqvzoLJShdJInfpd2pgNq56rz80z/aiOf9coroo6so
         ESQjfnSvCQQVckl/hBCSyGnp3a/J2rllUSEFiPeHtam6nYm+aO3C93vL0iX5x5HFKFtV
         STcGrUKcj5+tUojjBfD3W1OtNDWr+T90++nPwh/i3O8JKvRL4wpX+983djyBwb4jXgrz
         C18A==
X-Gm-Message-State: AOJu0Yyx54JluZ7ZmiHLGVWwRzkvZqB8Kms/ZcZ54Egdstjg9xDkokEp
	6r3t/OlgO0zmVXALH4c6+gHr3i0SPnMCsRC8QDUm1IteXpI/ilRA0MiOM5hGEd9hAvi9pen6EYL
	0FbKNrZPcgOFSeouMfRcMtGa39LKE2WAG1ZkyCY55
X-Received: by 2002:a05:600c:3b14:b0:40d:5cd1:1786 with SMTP id m20-20020a05600c3b1400b0040d5cd11786mr1571518wms.174.1704706048553;
        Mon, 08 Jan 2024 01:27:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJwTzEktgmk13wBG4wM5BWE4ZTFCnOS+vrwmv7XAHVX+yfsAAMJxd3rfnXO3a3bF11iERhJA==
X-Received: by 2002:a05:600c:3b14:b0:40d:5cd1:1786 with SMTP id m20-20020a05600c3b1400b0040d5cd11786mr1571507wms.174.1704706048095;
        Mon, 08 Jan 2024 01:27:28 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c4ecb00b0040d2d33312csm10353376wmq.2.2024.01.08.01.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:27:27 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, drawat.floss@gmail.com,
 deller@gmx.de, decui@microsoft.com, wei.liu@kernel.org,
 haiyangz@microsoft.com, kys@microsoft.com, daniel@ffwll.ch,
 airlied@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/4] fbdev/hyperv_fb: Remove firmware framebuffers with
 aperture helpers
In-Reply-To: <20240103102640.31751-3-tzimmermann@suse.de>
References: <20240103102640.31751-1-tzimmermann@suse.de>
 <20240103102640.31751-3-tzimmermann@suse.de>
Date: Mon, 08 Jan 2024 10:27:27 +0100
Message-ID: <877ckkdvk0.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Replace use of screen_info state with the correct interfaces from
> the aperture helpers. The state is only for architecture and firmware
> code. It is not guaranteed to contain valid data. Drivers are thus
> not allowed to use it.
>
> For removing conflicting firmware framebuffers, there are aperture
> helpers. Hence replace screen_info with the correct functions that will
> remove conflicting framebuffers for the hypervfb driver. For GEN1 PCI
> devices, the driver reads the framebuffer base and size from the PCI
> BAR, and uses the range for removing the firmware framebuffer. For
> GEN2 VMBUS devices no range can be detected, so the driver clears all
> firmware framebuffers.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


