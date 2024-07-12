Return-Path: <linux-hyperv+bounces-2558-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DECE692FA39
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jul 2024 14:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93CA01F21F6F
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jul 2024 12:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCA616DEB9;
	Fri, 12 Jul 2024 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Co2V4BjM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6714516D9BE;
	Fri, 12 Jul 2024 12:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720787202; cv=none; b=MQZMdciSgkObMP6hl0kH94cBAXKZec0OxRlqAl0JXOw+nYtdGRFyn4xZvTs8YA1d/IZ926AsriWg+vBE801ia3atG6By07XTw+fGcIyoYjx6CvxqR8tWENCQC0RPw8EBbFvYuES6V0N4L0Ib8dEzRvTPFyXdpt7kHZmgrDGW0qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720787202; c=relaxed/simple;
	bh=W/JAWJhqwLQ1P0orQJWW1/8E04mwqXBgymBjcLudDdY=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AlyOCyjYeSEb4FEXjF2j2DvrwrPG9B54HFwHkggeFI8LGJlcZyW6PI8VL9q8g6bBMUshDdhXFj6YAFLXJQpiqEs2yrWAdJRNNaiwMDVhgHGYhNxTEsVGDrVc/KKCC9jhtHt7mijWSNgW+qzXznTsLka+gzy9FaNcLm/HJbH/Q/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Co2V4BjM; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1720787198;
	bh=y3aYzv3E08GfB0EpusXKM20MT9AQOoPQDNzGPOMTVdI=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=Co2V4BjMcX/7vgmwzvkEZr1aw14sUnlShzS9Kl4XYLI/CPlBJuzENWiJr0LaAUuQb
	 5Rq1q2rDPvbSJ1YAYgU08a4HZ3wXvPI3IjgetuU3olC8OnhS2LlTyoaPk9ym+pE58S
	 UObABJKdLCh2UwQqXCMD+iD/FUJIdJ9VVV9eLni4lXsif1Ole5T+oVEIc2MzvXRAkR
	 dZVfKo9PbCLDzZyRn2eaAZDq0nN9zt672hBIQcLnonXlMWFIBnGrEZ/ksdeICD5xpX
	 0vAu+ZIF8Ja30ubpJC+fE+b72H6qZ+2BavN1T8n0hkN11amwpuxhp0uuabUwALmEPr
	 LWDATLrj4zR2w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WL9nV3m8Hz4x1y;
	Fri, 12 Jul 2024 22:26:38 +1000 (AEST)
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
 <senozhatsky@chromium.org>, Jocelyn Falempe <jfalempe@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>, Jani Nikula <jani.nikula@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kefeng Wang
 <wangkefeng.wang@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Uros
 Bizjak <ubizjak@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] printk: Add a short description string to kmsg_dump()
In-Reply-To: <20240702122639.248110-1-jfalempe@redhat.com>
References: <20240702122639.248110-1-jfalempe@redhat.com>
Date: Fri, 12 Jul 2024 22:26:38 +1000
Message-ID: <87y1664wzl.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jocelyn Falempe <jfalempe@redhat.com> writes:
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
>  * Use a struct kmsg_dump_detail to hold the reason and description
>    pointer, for more flexibility if we want to add other parameters.
>    (Kees Cook)
>  * Fix powerpc/nvram_64 build, as I didn't update the forward
>    declaration of oops_to_nvram()
>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>  arch/powerpc/kernel/nvram_64.c             |  8 ++++----
>  arch/powerpc/platforms/powernv/opal-kmsg.c |  4 ++--

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

