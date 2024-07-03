Return-Path: <linux-hyperv+bounces-2532-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 556EE92661D
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2024 18:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D042EB217FB
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2024 16:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178A41822D0;
	Wed,  3 Jul 2024 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rwd9e7kl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFC72BD19;
	Wed,  3 Jul 2024 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720024026; cv=none; b=kP+yhL7reQ74DWcW30tLJy0H5d9j8xdLOrptYxdKv5JrgJTW2yY4zY2pT09b61Tr/RCnE5kkKs4jvU2p4nCAJ4Lxbp4FeELc3ejUztYMsaKbTU9IX9f+j13tj0eJoKTG7J3BO0oftRBpXmUP5sDyeW16YtFDeZtSQGqKFgQd4lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720024026; c=relaxed/simple;
	bh=iqYxlC1bhe/7ALpkNeE5phKu3N9aTBnG3R0HukiaLws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1yBaJAbyPHG/aPd/2DutaH1s7uc8gB7Zrl17/T8/AiLKI0QLe3uMiu9iswLxQSYhNMFwuiEUFAL/gnAfAAfu1zenH7rvEhQ5e95+mZsoFourDBa1TLBNnoJkktqHZtB9hHBouo775gcCkjDDphLGjDQtFYSsHs3yxSUN/UtPMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rwd9e7kl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC89C2BD10;
	Wed,  3 Jul 2024 16:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720024025;
	bh=iqYxlC1bhe/7ALpkNeE5phKu3N9aTBnG3R0HukiaLws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rwd9e7kliYyzi9FQPgDbHOkyrNE+y0jJRVWnOdmXhAkVOD1ALZD0O10DjNWFdt3yC
	 ofb8OUs3AK4tJ1ETzauW/+3t+eb/4uqnz3ZVD6XWlRjMjQGvlP8UR9uBfs+9//130N
	 CeN/pC1bgOCnO1VB1B+hlwcVy289AeM/esB0ht8j55bH9Y8nSprZ7wpAtbvdTbz9AL
	 iL/UQJKak4mdUS3H81Mn47L1q38rjm7FaAXhIo9ngCEgZjFb3ikj1ZDBhqbVK8SiJr
	 HZg0QGdZ9zMNJD8lbhhVjPqYxuorXhgrPYWZkHunA9J73aHALa3eQQyUQIz2HvRh3j
	 HNWAuSbLQR1RA==
Date: Wed, 3 Jul 2024 09:27:04 -0700
From: Kees Cook <kees@kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
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
Message-ID: <202407030926.D5DA9B901D@keescook>
References: <20240702122639.248110-1-jfalempe@redhat.com>
 <202407021326.E75B8EA@keescook>
 <10ea2ea1-e692-443e-8b48-ce9884e8b942@redhat.com>
 <ZoUKM9-RiOrv0_Vf@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoUKM9-RiOrv0_Vf@pathway.suse.cz>

On Wed, Jul 03, 2024 at 10:22:11AM +0200, Petr Mladek wrote:
> On Wed 2024-07-03 09:57:26, Jocelyn Falempe wrote:
> > 
> > 
> > On 02/07/2024 22:29, Kees Cook wrote:
> > > On Tue, Jul 02, 2024 at 02:26:04PM +0200, Jocelyn Falempe wrote:
> > > > kmsg_dump doesn't forward the panic reason string to the kmsg_dumper
> > > > callback.
> > > > This patch adds a new struct kmsg_dump_detail, that will hold the
> > > > reason and description, and pass it to the dump() callback.
> > > 
> > > Thanks! I like this much better. :)
> > > 
> > > > 
> > > > To avoid updating all kmsg_dump() call, it adds a kmsg_dump_desc()
> > > > function and a macro for backward compatibility.
> > > > 
> > > > I've written this for drm_panic, but it can be useful for other
> > > > kmsg_dumper.
> > > > It allows to see the panic reason, like "sysrq triggered crash"
> > > > or "VFS: Unable to mount root fs on xxxx" on the drm panic screen.
> > > > 
> > > > v2:
> > > >   * Use a struct kmsg_dump_detail to hold the reason and description
> > > >     pointer, for more flexibility if we want to add other parameters.
> > > >     (Kees Cook)
> > > >   * Fix powerpc/nvram_64 build, as I didn't update the forward
> > > >     declaration of oops_to_nvram()
> > > 
> > > The versioning history commonly goes after the "---".
> > 
> > ok, I was not aware of this.
> > > 
> > > > [...]
> > > > diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
> > > > index 906521c2329c..65f5a47727bc 100644
> > > > --- a/include/linux/kmsg_dump.h
> > > > +++ b/include/linux/kmsg_dump.h
> > > > @@ -39,6 +39,17 @@ struct kmsg_dump_iter {
> > > >   	u64	next_seq;
> > > >   };
> > > > +/**
> > > > + *struct kmsg_dump_detail - kernel crash detail
> > > 
> > > Is kern-doc happy with this? I think there is supposed to be a space
> > > between the "*" and the first word:
> > > 
> > >   /**
> > >    * struct kmsg...
> > > 
> > > 
> > Good catch, yes there is a space missing.
> > 
> > I just checked with "make htmldocs", and in fact include/linux/kmsg_dump.h
> > is not indexed for kernel documentation.
> > And you can't find the definition of struct kmsg_dumper in the online doc.
> > https://www.kernel.org/doc/html/latest/search.html?q=kmsg_dumper
> > 
> > > Otherwise looks good to me!
> > > 
> > 
> > Thanks.
> > 
> > As this patch touches different subsystems, do you know on which tree it
> > should land ?
> 
> Andrew usually takes patches against kernel/panic.c.
> 
> Or you could take it via the DRM tree, especially if you already have the code
> using the string.
> 
> Also I could take it via the printk tree. The only complication is
> that I am going to be away the following two weeks and would come
> back in the middle of the merge window. I do not expect much problems
> with this change but...

If DRM doesn't want to carry it, I can put it in through the pstore
tree. Let me know! :)

-- 
Kees Cook

