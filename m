Return-Path: <linux-hyperv+bounces-2572-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0228D933C00
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Jul 2024 13:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6552DB22DC6
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Jul 2024 11:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC1B17F4E8;
	Wed, 17 Jul 2024 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SE3AWkhA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A264A17F398
	for <linux-hyperv@vger.kernel.org>; Wed, 17 Jul 2024 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721214856; cv=none; b=F85R7BiZQpuwIZpRV1XmPQYCcwtUUSio0EHNFwF+IvhInZw9w+HYf87ZvPziKV1i4aGTBw/8qjFMof7+OX0nhW4BS7qnz+ePuxzE6wZDJfzCgH2H/tX4YEPLicXg9hQWrb0pugmU5lNAcJpZgQNmrC7iOoNzNJB3duvO2u63Ezc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721214856; c=relaxed/simple;
	bh=sQzUg2Q/1MYsGWnhU/zaTOxAtlBYe1TRtcDNO8bXWyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q1VKvh6V+oxt3D2s89rfOzHky1Xzer/nj0lqqgQKzUAntL7NUf+jnhV8hWjhUEVNfGjLaX10dMIHpBVNGYxqaemuDU9aJGxfn4Sj2trIp4dh5MpUW0GKPaxrQ9z0e2oK+QTj7pWxlxkq+DM4IuzqlM8FR4hjvlLVBokfr9wGRwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SE3AWkhA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721214852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RAGmeywEZ/JgSZ6hAqPsmz089vwWWyWA+lKvknqNmtE=;
	b=SE3AWkhA+4UZaCJekQMUNxUI9cKBoZAZXU1LGG3dxjhyaSgB06lZJDVczgpoPTNGwYLf1r
	s+8nBGvPnKI2f6rg6xfsnAfOVIYhOEP0yOX4kPdcXT6zDidvGMhkUih5aKUN9cWP2p/UoY
	go16Wgh0r/ACUqZjOL6XvY1btn+ijxM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-WldJXrwlP2abVJKBJCxw2Q-1; Wed, 17 Jul 2024 07:14:11 -0400
X-MC-Unique: WldJXrwlP2abVJKBJCxw2Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-36805bfd95aso3551291f8f.3
        for <linux-hyperv@vger.kernel.org>; Wed, 17 Jul 2024 04:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721214850; x=1721819650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAGmeywEZ/JgSZ6hAqPsmz089vwWWyWA+lKvknqNmtE=;
        b=FHeJ1H21xyDOgvgzXtrT1UxZq29hsL+ZEVrOgHW5TkzhafhK4Nm7a0bUFVm3bgHInu
         fuBm0pVgnT7nZbJtXjD2L3CVVD7hLjiSXyfq7ZMR1aVNR7FFxzAgyk5iai0MqVTey9wx
         sq+zyr2OmOn/KBYxz1CE4kiIm5aMsdANHOac4j/lM8VCngozPt8H+fWcURuyc+prmI9i
         bxQbT+JdK50hWcF9hUFu+efgDkjVvz2MRIxV5+0wpF6MSmvwjshbTKQHFgYfjReVHT1b
         0IwT9IMiPaVQXhfEcDXsCnagF3NY450dXv0P2I46OedyKHaQqR1pJFXHaBB3aHJ3JWOm
         OkqA==
X-Forwarded-Encrypted: i=1; AJvYcCX5YfKX1i+UdjXkbudqn9O9ZGVKZzRxnoBH49W4A0L8kHUZtP0vMmTSAnb3qXmcpp+VtFrJwySUHU1RFzpSOKBPl6OnDbCaR2HabtiR
X-Gm-Message-State: AOJu0YxAJzjF79zwKmIIK7T2Dz2O5b/vN2r+pAF7qU7cUk/bbDgn/UOj
	85y/6UCr3ARl6e2pfhhH3IRmwbT6C+MPo6OS6/AXpqzg9Cz48JFoA2Nsg5qa6gAHo7TYAZpJOJQ
	t9UQgwn1RIZ16DHwHxlk1sExEo9kt3qK8/vk6F5Q9QEmgPr1SFE9iFwcya2weSw==
X-Received: by 2002:a5d:5f8c:0:b0:367:943e:f436 with SMTP id ffacd0b85a97d-36831652b7cmr1395245f8f.30.1721214850122;
        Wed, 17 Jul 2024 04:14:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkv5VJxD9qI1kB5PB9WhCMM3ozFKBNBC+x5bcWuyaH6WTwCYKMg89QMw7W+wtEnk2KMCsWzg==
X-Received: by 2002:a5d:5f8c:0:b0:367:943e:f436 with SMTP id ffacd0b85a97d-36831652b7cmr1395208f8f.30.1721214849630;
        Wed, 17 Jul 2024 04:14:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbec3sm11450684f8f.85.2024.07.17.04.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 04:14:09 -0700 (PDT)
Message-ID: <f559a33a-6d2e-476d-87f6-cb1887e99b62@redhat.com>
Date: Wed, 17 Jul 2024 13:14:07 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] printk: Add a short description string to kmsg_dump()
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Petr Mladek
 <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jani Nikula <jani.nikula@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-hardening@vger.kernel.org
References: <20240702122639.248110-1-jfalempe@redhat.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20240702122639.248110-1-jfalempe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 02/07/2024 14:26, Jocelyn Falempe wrote:
> kmsg_dump doesn't forward the panic reason string to the kmsg_dumper
> callback.
> This patch adds a new struct kmsg_dump_detail, that will hold the
> reason and description, and pass it to the dump() callback.
> 
> To avoid updating all kmsg_dump() call, it adds a kmsg_dump_desc()
> function and a macro for backward compatibility.
> 
> I've written this for drm_panic, but it can be useful for other
> kmsg_dumper.
> It allows to see the panic reason, like "sysrq triggered crash"
> or "VFS: Unable to mount root fs on xxxx" on the drm panic screen.
> 
> v2:
>   * Use a struct kmsg_dump_detail to hold the reason and description
>     pointer, for more flexibility if we want to add other parameters.
>     (Kees Cook)
>   * Fix powerpc/nvram_64 build, as I didn't update the forward
>     declaration of oops_to_nvram()
> 
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>   arch/powerpc/kernel/nvram_64.c             |  8 ++++----
>   arch/powerpc/platforms/powernv/opal-kmsg.c |  4 ++--
>   arch/um/kernel/kmsg_dump.c                 |  2 +-
>   drivers/gpu/drm/drm_panic.c                |  4 ++--
>   drivers/hv/hv_common.c                     |  4 ++--
>   drivers/mtd/mtdoops.c                      |  2 +-
>   fs/pstore/platform.c                       | 10 +++++-----
>   include/linux/kmsg_dump.h                  | 22 +++++++++++++++++++---
>   kernel/panic.c                             |  2 +-
>   kernel/printk/printk.c                     | 11 ++++++++---
>   10 files changed, 45 insertions(+), 24 deletions(-)
> 

[...]

I pushed it to drm-misc-next, with the whitespace change in kmsg_dump.h

Thanks all for your reviews and comments.

Best regards,

-- 

Jocelyn


