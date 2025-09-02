Return-Path: <linux-hyperv+bounces-6688-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC3EB3F81A
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Sep 2025 10:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5430C7A7D2F
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Sep 2025 08:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086B52E7F14;
	Tue,  2 Sep 2025 08:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pcd6bIBH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736A52E7160
	for <linux-hyperv@vger.kernel.org>; Tue,  2 Sep 2025 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800869; cv=none; b=b2Z6y4gZQFYtL4C9c195WFpYjxMn2kgt8hNV4YRZUUl6AXvKa5n3JZ9ugVm1WWuv+acE2O8N/nxETQZGw4d5LFtaWRq66mH9tCXmw40QmkUGLsblyi7/9TVrMCrctV/umGAvkj/+8R7ASHypcEFoD09GmFupOzWFTuo1Y1edL6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800869; c=relaxed/simple;
	bh=tLuKOnLOfe/QgxTL1sd6vt9BdNjKPPloDvVuD5eI208=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nTsi7xi7dB9N/B66Y5zxaXTlWuOoWj0NdJoyBKTshmRS2buqxa4qKuEI0Jokkn6XFURVIvSiLixGXs5QgocUbIVLhjSWoQWRwioQFKlRp9K7sY++7rrINVlaJ8GLhCKC1lPXJ+oy/JYCoU5e2X+4KxWZZG4kK+srxU4KjWfVmoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pcd6bIBH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756800867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7sjD/QRd0X/r3/hIK35g/NLILC2+ivFRe7H4S8czaX8=;
	b=Pcd6bIBHiU0MtxZbBLmORgsGQyYdRE0BXGpS42enu0ZXObw3gyQF2+oyh+3mRnkzcbrRa8
	G+klXwDyzJWAd8zcJBRMxaXlh1JWk/bes8YfR43K/5wKK18S6yOapKPeE+V1rzSvhic3WH
	g7YMPkKksuK3OdHEOw/zM0pY/tEVO7k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-3_w7y7YVPmCoChQE2pU8KA-1; Tue, 02 Sep 2025 04:14:25 -0400
X-MC-Unique: 3_w7y7YVPmCoChQE2pU8KA-1
X-Mimecast-MFC-AGG-ID: 3_w7y7YVPmCoChQE2pU8KA_1756800864
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b869d3572so8389645e9.1
        for <linux-hyperv@vger.kernel.org>; Tue, 02 Sep 2025 01:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756800864; x=1757405664;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sjD/QRd0X/r3/hIK35g/NLILC2+ivFRe7H4S8czaX8=;
        b=S/93vrTrRCprWOAvHsTvNWhAlXWAD4HddMtl5IR1lgQseb2PsKRNVcEupGujMkK9sr
         smtpB5JXUt124Yl1cxMoE3dhHLjtfNN1gtSJZi+OyNMlzpq6ySuFSQO/dQxrqr3RyKxU
         2VSH4fd1XbIm1uOG2QuIBytnSU03XAKu/slmtDmgcHu3sixezg5r+trThPK3hY+gWyuC
         vqzf7dJN49IRaO+knyi9hYcnImDntOdEINIcqrnlIDf4FYM2YO3pB45Cn0oCkE3Y/+im
         EqB1HPe+xn0kJjAT4nznMvx501IHKcdkWZQwkxt7ZyklnoKUEabmoEkxLYihw0JgO79p
         tN7A==
X-Forwarded-Encrypted: i=1; AJvYcCXigOyoPlv+b6JT0X2F0MCNzIUfQYK7Yjz4lWmsTAWpgrR2Pzn4wWYmC+rq4aZkmXarTEDNJOjyjqDDKLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUSz7I3Ewedg/uiSoxm4rNjkYtcW4bbTiofh+h+vDeujAprd86
	T1oWAV2G+HXvbyu0a+uaIP+XcXqgofeQkiOdu32rRBhtUgYMihM5FChSLs6DhGjhXthabm1Pwho
	L0aI7HFEd/FPvkWeOXOVfd1wAJ0EyOe8lxWZ3Hg0jI2C+cifRfI+/ki/vgGmwXBcK3g==
X-Gm-Gg: ASbGnctZPq6WCZQ3t8oLoRwgsGHjg8NyxGVne8Gg8UC/dtX3K9p7t84k+tJ3QFZqaD9
	MuKx+NfZLD9ChEB1VB/3xD76Zxi5lBK3Kdg9nsGKq6i2iYpSPHQQb96V/dg/mTkzzGkCqTdtnMB
	A7ZVnzSqltfGOVbeSfBZAbI+mG6CzS1nAVXYO9HQkUPvvghDwkMCLivfQxA2PtQJcI9q8ql87Ph
	Cs3RhRiQ05xOiNg6NrjHCYqmhY5K3GRGFvNk4QJasLn8LPlvoyiEl0o7MqitcEdIUOcvPvqLZFZ
	sGKei+v44bqYWsgYFmHThfWYscPeGDb4a+zwpCad7LuuGj7LUwjmBCCJKr1O9vsEJg==
X-Received: by 2002:a05:600c:4f0b:b0:459:d821:a45b with SMTP id 5b1f17b1804b1-45b87bf56e3mr84719865e9.9.1756800864456;
        Tue, 02 Sep 2025 01:14:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSE9BbGoAU9QWUHXjPbgLFfuEZvjJTrv5W5hVxfxt5ez8sFPvU3aLh4xjk4Nk3CockqCwCUw==
X-Received: by 2002:a05:600c:4f0b:b0:459:d821:a45b with SMTP id 5b1f17b1804b1-45b87bf56e3mr84719555e9.9.1756800864077;
        Tue, 02 Sep 2025 01:14:24 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9ab7c7dbsm7829315e9.11.2025.09.02.01.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 01:14:23 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, louis.chauvet@bootlin.com,
 drawat.floss@gmail.com, hamohammed.sa@gmail.com, melissa.srw@gmail.com,
 mhklinux@outlook.com, simona@ffwll.ch, airlied@gmail.com,
 maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 2/4] drm/vblank: Add CRTC helpers for simple use cases
In-Reply-To: <20250901111241.233875-3-tzimmermann@suse.de>
References: <20250901111241.233875-1-tzimmermann@suse.de>
 <20250901111241.233875-3-tzimmermann@suse.de>
Date: Tue, 02 Sep 2025 10:14:22 +0200
Message-ID: <87frd5fezl.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Implement atomic_flush, atomic_enable and atomic_disable of struct
> drm_crtc_helper_funcs for vblank handling. Driver with no further
> requirements can use these functions instead of adding their own.
> Also simplifies the use of vblank timers.
>
> v2:
> - fix docs
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

You could mention (as you do for the first patch) that the helpers' code
have been adopted from vkms. Since the CRTC enable/disable callbacks are
the same and the flush is mostly the same (minus the vkms specific bits
that touches the struct vkms_output).

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


