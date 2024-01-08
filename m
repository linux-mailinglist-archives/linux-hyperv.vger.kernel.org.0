Return-Path: <linux-hyperv+bounces-1385-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D91E826ACB
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jan 2024 10:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E253B20E94
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jan 2024 09:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC971173D;
	Mon,  8 Jan 2024 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gS1kVwlA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2933611C88
	for <linux-hyperv@vger.kernel.org>; Mon,  8 Jan 2024 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704706536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8FqI91Plpg4t0tN2+40oiwSiAXoVjsNtxVtGTkjkFNk=;
	b=gS1kVwlA6GKErMRMpaP/Ki61MvKzMoUAICK++EBaaWBJ2rp47T8RDRJjUHUsuvUbRyOrv6
	5jjL/aDp4/A4K18P7zUDPw22/mlIBaqc2Kq8n5oSRdbBJ2DtwgE2Adg6IwCs469KvItej6
	1K3lO3YGIkRI0Zx/ZBjUh7IkfD8bHfg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-GWJr8BIjO5qf4u1iMnbf0g-1; Mon, 08 Jan 2024 04:35:34 -0500
X-MC-Unique: GWJr8BIjO5qf4u1iMnbf0g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33688a38636so1095855f8f.1
        for <linux-hyperv@vger.kernel.org>; Mon, 08 Jan 2024 01:35:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704706533; x=1705311333;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8FqI91Plpg4t0tN2+40oiwSiAXoVjsNtxVtGTkjkFNk=;
        b=qemWd4xCs+vdO++DEYzWplMRP5C6VmnjwFFx/8N4OpeK9d9Sh78OxAoBl7gyBV0Ahv
         3SguljUFoaOMjJYW4ZEwn9CU6cnOPoiJHjScuZlarhQZsMjph3X7dhAIwqCwUKLsrwSi
         PCBMnklwjZPzO9VxiK3D7qplUkXwh1ygpZZCvCsF1OM9l/WWnM0Ta7W3bndQpIS/E4P1
         /4lHdztxb1xATB4tSv2kn8mBCGtyQsow5QS6G/ut6I91sMdK8b146br2XVqGBiihp1Vz
         Jd+IFJuUNP0MEoWvoDYKfHtUJna35zvetyF5xRAvqG0x23Lk9MTCLjKnao6j1WUTUtK5
         HAbA==
X-Gm-Message-State: AOJu0YxPU5XWHIr1AlvxNWwvkFmSDbS0GBYvWRNczcoxFjeeKtWC51VI
	tsl7iPhkv58MO49A4qdRrGmgH5NQD72oiujWTqf0tG08vBE+JCeJGE0OoPyUe0d5Pf5/Zxq2UEB
	pYDvJ4/TvzkQFsYgIDKZucqJ7C5L3mudF
X-Received: by 2002:a05:600c:470a:b0:40d:8964:7eb4 with SMTP id v10-20020a05600c470a00b0040d89647eb4mr1648558wmo.35.1704706533648;
        Mon, 08 Jan 2024 01:35:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9LrFAdz2c0oUKOXqiCz9V6sA9/SRyB+6xOvPQWIK9QOb6WfX0qmqi60bY3HX68Bx+qm7YvA==
X-Received: by 2002:a05:600c:470a:b0:40d:8964:7eb4 with SMTP id v10-20020a05600c470a00b0040d89647eb4mr1648548wmo.35.1704706533379;
        Mon, 08 Jan 2024 01:35:33 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r14-20020a05600c35ce00b0040e48abec33sm1470139wmq.45.2024.01.08.01.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:35:33 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, drawat.floss@gmail.com,
 deller@gmx.de, decui@microsoft.com, wei.liu@kernel.org,
 haiyangz@microsoft.com, kys@microsoft.com, daniel@ffwll.ch,
 airlied@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 3/4] firmware/sysfb: Clear screen_info state after
 consuming it
In-Reply-To: <20240103102640.31751-4-tzimmermann@suse.de>
References: <20240103102640.31751-1-tzimmermann@suse.de>
 <20240103102640.31751-4-tzimmermann@suse.de>
Date: Mon, 08 Jan 2024 10:35:32 +0100
Message-ID: <874jfodv6j.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> After consuming the global screen_info_state in sysfb_init(), the
> created platform device maintains the firmware framebuffer. Clear
> screen_info to avoid conflicting access. Subsequent kexec reboots
> now ignore the firmware framebuffer.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


