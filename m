Return-Path: <linux-hyperv+bounces-2498-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A37F9917A54
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Jun 2024 10:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5CE91C238D8
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Jun 2024 08:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EC113D2A4;
	Wed, 26 Jun 2024 08:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WrSyL8/5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2772869A
	for <linux-hyperv@vger.kernel.org>; Wed, 26 Jun 2024 08:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719388850; cv=none; b=i/kQ1oybf6fxufToUrVUU3BtErSKoGYE4ead4kykU7PM0YMDABdfSk8FucFKtxAZLRuWChf21q/g54ZlmlR4JRjMCBq/ojH30gJWtv5IcaK6uOXWSsPoHSw/tZmvTRJ3V1WDCocJW2B/az2JGOYMld+kUeln1McRpnYEx110Xtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719388850; c=relaxed/simple;
	bh=x3JWCReIk4L301ENiFVZf4/DH2qQaKuD3zTUasYkt80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGlDG85pHk2pT8nZjYLZ0Y7wQv6r7S1Olc3Sw0czRYnozDCVNtFWLC6yTEBZ0gqIsg5NshgjqCQY3FbeOtXCWR3FMwO44MJocolHPmwPyqH3KXjAdBW7BR6Dtd1AawP4/DRWccYH6CqLj2tP/oZzp7xR1tNXRCMg4xTv4do5m4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WrSyL8/5; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso66293071fa.3
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Jun 2024 01:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719388846; x=1719993646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=whiJiQULxxjVU5JYMGY4dR9TuAgnrWcS7amyjh3Lhhk=;
        b=WrSyL8/51FJa9TdHwiZlPjdEXN2CvIvMagsgSlIQyVt9dLdE9desicy6T6X9Y7VNs1
         Ob5Vv+nJLgH3FAGj6NC7iSPRrSAK/CLbCGKDfyh8TA2MeJT4KYwl3PZF+sObbWtKgZ9c
         /szY44OyuzEqPMcv2EBTARrknZgqYGkRX+rs16WE39Ju/3V9GC1GJ6dptepw5P2xm0fQ
         Xhp6C2o2jfpNAu+XSNztbBAJ1x7PyYK8smQ9iQcX3WWK6T2MDStTGd/JVtfuAMpUQUnk
         PFMvAiXSqXB8R6YTg2q+F06r1Z02nWfjPeCHlYPLuhudmi/aDPOCtirDrJMfdZsqS0X2
         mM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719388846; x=1719993646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whiJiQULxxjVU5JYMGY4dR9TuAgnrWcS7amyjh3Lhhk=;
        b=nzKAOpL64lFqqOH2r4oH3IpV4bneyYDgSSuF7lXK/Q22D1+JbNM9DPybt94opNFBk8
         UUfN7UqJfwVj9pWQtFgRwhvpRY9yaOnWj3aHW6VEpBldo7dkpx8nN6l7eG/ediGMaoGd
         xRH03kZ2iMrePX/IRUJK41yF2lwCjgno20jCxz3wHzDpdHwJv3tLyO3CJx9W4Guqjf8E
         8SlWmKW/gZ+mrU7Cwt6gXB27CoxFlpa9TS+IGDM4sl7AbhB0bOURtsAyGJn6acnk9Ti4
         TtT3d0D1VBPkaPxe2PDr8fgZbfv458SEHw21BwFOYvdKTyQuuR5aAFhgnQBMY0ymyWUJ
         WXYg==
X-Forwarded-Encrypted: i=1; AJvYcCVnZSngmWs9CIt7UnC1OKrxWCoaX4voUoaigvNduyvr88w6jYDNdHGyT6tcDUkYC8oYpBJSRTKi501Sl7BrmoFltA0GIk9+A3OpRBT1
X-Gm-Message-State: AOJu0YzPc1oXLgaiQOMMWCYuaNd1PSunZB/bwwq9f/v70KFcNN0mPZeZ
	cxITF/L9qdcg6xt2plUneJbQIu5wZ3QOuGtxwwriRhwXMcyL74BoB+P7LH9cWE0=
X-Google-Smtp-Source: AGHT+IFNePKBHG9JpceEuNMrhp5ms+q4nwziDYVudYAAE2EIYWBHCuZo7vzBBRTi5aESxDL6rd8szA==
X-Received: by 2002:a2e:3a13:0:b0:2ec:5019:bec3 with SMTP id 38308e7fff4ca-2ec593e0cd9mr61741411fa.21.1719388846249;
        Wed, 26 Jun 2024 01:00:46 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70676a2113csm6032019b3a.214.2024.06.26.01.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 01:00:45 -0700 (PDT)
Date: Wed, 26 Jun 2024 10:00:23 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] printk: Add a short description string to kmsg_dump()
Message-ID: <ZnvKcnC9ruaIHYij@pathway.suse.cz>
References: <20240625123954.211184-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625123954.211184-1-jfalempe@redhat.com>

On Tue 2024-06-25 14:39:29, Jocelyn Falempe wrote:
> kmsg_dump doesn't forward the panic reason string to the kmsg_dumper
> callback.
> This patch adds a new parameter "const char *desc" to the kmsg_dumper
> dump() callback, and update all drivers that are using it.
> 
> To avoid updating all kmsg_dump() call, it adds a kmsg_dump_desc()
> function and a macro for backward compatibility.
> 
> I've written this for drm_panic, but it can be useful for other
> kmsg_dumper.
> It allows to see the panic reason, like "sysrq triggered crash"
> or "VFS: Unable to mount root fs on xxxx" on the drm panic screen.
>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>  arch/powerpc/kernel/nvram_64.c             |  3 ++-
>  arch/powerpc/platforms/powernv/opal-kmsg.c |  3 ++-
>  drivers/gpu/drm/drm_panic.c                |  3 ++-
>  drivers/hv/hv_common.c                     |  3 ++-
>  drivers/mtd/mtdoops.c                      |  3 ++-
>  fs/pstore/platform.c                       |  3 ++-
>  include/linux/kmsg_dump.h                  | 13 ++++++++++---
>  kernel/panic.c                             |  2 +-
>  kernel/printk/printk.c                     |  8 +++++---
>  9 files changed, 28 insertions(+), 13 deletions(-)

The parameter is added into all dumpers. I guess that it would be
used only drm_panic() because it is graphics and might be "fancy".
The others simply dump the log buffer and the reason is in
the dumped log as well.

Anyway, the passed buffer is static. Alternative solution would
be to make it global and export it like, for example, panic_cpu.

Best Regards,
Petr

