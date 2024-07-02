Return-Path: <linux-hyperv+bounces-2521-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B09924938
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Jul 2024 22:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360101C21D14
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Jul 2024 20:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727A9200133;
	Tue,  2 Jul 2024 20:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMULYvaR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4435E6E5ED;
	Tue,  2 Jul 2024 20:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719952167; cv=none; b=HEQDpZxAFckOj//h4xbCboClBaqfTuaq2zwm3U/kyEXn06p5jm2fJA2yaRy0yvJSG4ubepCvF8efSUBGfTtFKbfW4/LMQIMVwa58UEjZTjTX5h4MHW/hz6nlpye9pRIkLKIbGcwfvtBNYBSz3l2MbVcjpH5TOhaLYCtVDKz01O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719952167; c=relaxed/simple;
	bh=5Rxp/h9KApRPjvKzc6wYI/qk2q2v7qYfjqOFXP5VY/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpkSwJdvBDv7VLjirIusi49UfEjKPzY24KjtEZ4x/pxtvG5gfv00wJnKmMhQhYd9Zpmbcrxvq2NyUjvXmak+QRtHzU+StG+Z8JGTOzCabdcAdFAj9XG5ZtMKCzGQFYQmXVFyF2Up8KP63DItxa6J1rlcH9SszuI4OFaztuOE5lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMULYvaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D70C116B1;
	Tue,  2 Jul 2024 20:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719952166;
	bh=5Rxp/h9KApRPjvKzc6wYI/qk2q2v7qYfjqOFXP5VY/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aMULYvaRAq2JE1hDB7HqrZUGyX+NMgBOjzOLgQXT9im/iw7MRTrc/s0A7hzDEcviR
	 UzxKjOhwIylBFkuLvnYzmIrK+TWv6zvsM8M8z6oItamUsI2TGhrOmjUcLQcp+gIGQK
	 /gq3E4v1qpaTJK9ZdHKd+Khti22IGRZPmypbLGUPgL0+mjl3AWPBuYuCp4wB9bjV9D
	 a2GkHeFqh0f6BzpQjThX3VHhNKtDEKdi3lCfSL6LsTFXgSkyFPD5XK3zR0wJMkjY9K
	 TLQjwQzsZ15xqiR0vpGkwtPIL9GyLtFAy+YOUp+OJ0RYLfzQeN8vly6fFk5ixzZLfX
	 6ijdEMKRMyjMQ==
Date: Tue, 2 Jul 2024 13:29:26 -0700
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
Subject: Re: [PATCH v2] printk: Add a short description string to kmsg_dump()
Message-ID: <202407021326.E75B8EA@keescook>
References: <20240702122639.248110-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702122639.248110-1-jfalempe@redhat.com>

On Tue, Jul 02, 2024 at 02:26:04PM +0200, Jocelyn Falempe wrote:
> kmsg_dump doesn't forward the panic reason string to the kmsg_dumper
> callback.
> This patch adds a new struct kmsg_dump_detail, that will hold the
> reason and description, and pass it to the dump() callback.

Thanks! I like this much better. :)

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

The versioning history commonly goes after the "---".

> [...]
> diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
> index 906521c2329c..65f5a47727bc 100644
> --- a/include/linux/kmsg_dump.h
> +++ b/include/linux/kmsg_dump.h
> @@ -39,6 +39,17 @@ struct kmsg_dump_iter {
>  	u64	next_seq;
>  };
>  
> +/**
> + *struct kmsg_dump_detail - kernel crash detail

Is kern-doc happy with this? I think there is supposed to be a space
between the "*" and the first word:

 /**
  * struct kmsg...


Otherwise looks good to me!

-- 
Kees Cook

