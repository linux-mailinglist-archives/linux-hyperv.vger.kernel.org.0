Return-Path: <linux-hyperv+bounces-2557-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 891B392FA35
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jul 2024 14:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F4E91F2293A
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jul 2024 12:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D5716DEB9;
	Fri, 12 Jul 2024 12:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ng02PIPv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FC315B548;
	Fri, 12 Jul 2024 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720787186; cv=none; b=PA7sgVPlsFaleC1y9gGjWYn6EqY4O3iXFvTCP39cVVuilPyyQjF1TE/CbcCBZzGpQ7p+OlndDEDFHN1mL+KQm8Ksg4yivszBV+4YL6VvlI/oEDU64gYrejnElVtXxF65gpOEnEoKDH7S6xjsP4MVSFn0P+/Yq9NFoKsIyjVU3cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720787186; c=relaxed/simple;
	bh=tfXsA2S8E9RUYO1hWBRGN2iW4Vj+y7Y65ZesH1bycHk=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jv1+Vq5YTkViQ8/ZBW0JmeAfPFRVau5F72LTTMPvdMAAVHwvTXnCbKK6j0idnSjK3XgGHrJVuDxk08hnvTGxjv6KzNTdf7rZaiHls2sabpCZ3ISKMSoobE0VgHnPQ++NVN6qeb496JXsq5OxVu1kFlTHCHbpGLDEmwIIOESDFDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=ng02PIPv; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1720787179;
	bh=61Rg5T54YsytFfb5o275tB/ve8FKKkyJzddzOl72DrU=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=ng02PIPvIHYkBYM9ZsmmArGNeKdmCARzvmV1GdYuE8JF5wHcuHAkUZRXXoUKWrREK
	 Sqdzpm78nub+p5+hVw+Fs54MEuC8BjISMwUSy0bEpSKSJRTnm/vw8Kp6tyQttl2WfA
	 r+vsHVW8rBMDW45AVQZCh+Do75llGY+c23Qcm6WtDJhVZRXzhAmVP4prhw4y9Ci0Lb
	 xYZ123Yp4K91FgHgv33mWxDZYdgVgZ8KWA5mOwG2/1e6nPxk2j30WY3naVG5OfK9UM
	 GgSqYHt980kdYyHus4Y9WAIrMsWLuIRruL/JTOpWKWWoXHx9wq/X9KFRIjXeDDYul7
	 wGpfHK9662J/Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WL9n21XgMz4x1y;
	Fri, 12 Jul 2024 22:26:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jocelyn Falempe <jfalempe@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Kees Cook <kees@kernel.org>, Tony Luck
 <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Petr
 Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, John
 Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>,
 Jani Nikula <jani.nikula@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] printk: Add a short description string to kmsg_dump()
In-Reply-To: <2d886ba5-950b-4dff-81ea-8748d7d67c55@redhat.com>
References: <20240702122639.248110-1-jfalempe@redhat.com>
 <2d886ba5-950b-4dff-81ea-8748d7d67c55@redhat.com>
Date: Fri, 12 Jul 2024 22:26:12 +1000
Message-ID: <871q3y6bkr.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jocelyn Falempe <jfalempe@redhat.com> writes:
> On 02/07/2024 14:26, Jocelyn Falempe wrote:
>> kmsg_dump doesn't forward the panic reason string to the kmsg_dumper
>> callback.
>> This patch adds a new struct kmsg_dump_detail, that will hold the
>> reason and description, and pass it to the dump() callback.
>> 
>> To avoid updating all kmsg_dump() call, it adds a kmsg_dump_desc()
>> function and a macro for backward compatibility.
>> 
>> I've written this for drm_panic, but it can be useful for other
>> kmsg_dumper.
>> It allows to see the panic reason, like "sysrq triggered crash"
>> or "VFS: Unable to mount root fs on xxxx" on the drm panic screen.
>> 
>> v2:
>>   * Use a struct kmsg_dump_detail to hold the reason and description
>>     pointer, for more flexibility if we want to add other parameters.
>>     (Kees Cook)
>>   * Fix powerpc/nvram_64 build, as I didn't update the forward
>>     declaration of oops_to_nvram()
>> 
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> ---
>>   arch/powerpc/kernel/nvram_64.c             |  8 ++++----
>>   arch/powerpc/platforms/powernv/opal-kmsg.c |  4 ++--
>>   arch/um/kernel/kmsg_dump.c                 |  2 +-
>>   drivers/gpu/drm/drm_panic.c                |  4 ++--
>>   drivers/hv/hv_common.c                     |  4 ++--
>>   drivers/mtd/mtdoops.c                      |  2 +-
>>   fs/pstore/platform.c                       | 10 +++++-----
>>   include/linux/kmsg_dump.h                  | 22 +++++++++++++++++++---
>>   kernel/panic.c                             |  2 +-
>>   kernel/printk/printk.c                     | 11 ++++++++---
>>   10 files changed, 45 insertions(+), 24 deletions(-)
>
...
> Gentle ping, I need reviews from powerpc, usermod linux, mtd, pstore and 
> hyperv, to be able to push it in the drm-misc tree.

For a simple mechanical change like that you don't need reviews from
every subsystem. As long as it's posted to each subsystem and there's
been a bit of time for folks to see it, and the build robots to build
it, that should be sufficient. Otherwise you could be waiting forever.

cheers

