Return-Path: <linux-hyperv+bounces-2505-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A83991C3E8
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jun 2024 18:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BF8284EE0
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jun 2024 16:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1442A1C9EB9;
	Fri, 28 Jun 2024 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEL1phH9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D880D1BF332;
	Fri, 28 Jun 2024 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719592928; cv=none; b=Q/QRZDXQW05pNT65xMCUOBX8jwZ1UzKEfDiGwvDUuJ8ODE+EyK4+U+DxSj0E0/gvcfZp3ebpWEvTlbkjwwhk3H1i9/XRGjfcMiR0hDvsMvMazki0ubunABtcOICYbhenxelR3Bb9+Set7l73Op7e36LV0BVmbdquWTiRr0C08Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719592928; c=relaxed/simple;
	bh=KowZk1jQy1Io4XMkPQkUk3h3DaEtKMWS+HxwXGTr01o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vcmhk4UbPWevH+CEZKCz22E1SFlnwV2xrQj4P40XG9Wh7n2SeBPjUVeVlVd3gygobbPNl0WQ4ckXVchKXXQjI/jynz9WPhmXIaqjWTpX5svy+v6zv7iK7VnGKzPFKE0lzG3dHT+upCYQg4XCnLZP+KCUzIVZfQUYdeoYSATLpr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEL1phH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57651C116B1;
	Fri, 28 Jun 2024 16:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719592927;
	bh=KowZk1jQy1Io4XMkPQkUk3h3DaEtKMWS+HxwXGTr01o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nEL1phH9XyJOO3v5dFvk1S+J59xlUQRD8neWizW6JlnwyBnug2Weefv24q6bhf95i
	 MhJi3bl2YjtM8xZk8U9WUvau7ojskQzgheACXDON+bH3NKQAn9wXIJPMCkj7/9bGDf
	 R4UbdFho4lINQQtH5ChOH8HsTK811XPOD+LD6FmH9tYWQGwsUnyAuAJZ1SHvD1/zxC
	 qCZ9dyykQhO/2OKHN0U1BCDGqGVpGlzwCawRLy9UAV91om/bWQO0aKBPH3k9JFpEjH
	 6BfpIoKU2FK6V3/TI+77El/aFCx9qvSMlxwjTWOO4nwtAudMQWkn8emj4920X/MgVI
	 Zi51CngzY6Q5A==
Date: Fri, 28 Jun 2024 09:42:06 -0700
From: Kees Cook <kees@kernel.org>
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
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Petr Mladek <pmladek@suse.com>,
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
Message-ID: <202406280938.2D7BB97C@keescook>
References: <20240625123954.211184-1-jfalempe@redhat.com>
 <202406260906.533095B1@keescook>
 <06899fda-de75-4d44-bda5-dcbb3e35d037@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06899fda-de75-4d44-bda5-dcbb3e35d037@redhat.com>

On Fri, Jun 28, 2024 at 09:13:11AM +0200, Jocelyn Falempe wrote:
> It is present in the kdump log, but before all the register dumps.
> So to retrieve it you need to parse the last 30~40 lines of logs, and search
> for a line starting with "Kernel panic - not syncing".
> https://elixir.bootlin.com/linux/v6.10-rc5/source/kernel/panic.c#L341
> But I think that's a bit messy, and I prefer having a kmsg_dump parameter.

Yeah, I totally agree: it should be easy to access the panic reason. I
just wanted to double-check that from pstore's perspective there wasn't
any "new" information here that should be captured somehow.

Thanks!

-- 
Kees Cook

