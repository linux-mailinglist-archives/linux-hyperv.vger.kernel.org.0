Return-Path: <linux-hyperv+bounces-3473-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA49A9F0355
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Dec 2024 05:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B74F1887BB3
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Dec 2024 04:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AAB1459EA;
	Fri, 13 Dec 2024 04:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="tJTITDo4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E12D8F5E;
	Fri, 13 Dec 2024 04:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734062466; cv=none; b=YHn151e7fJsBaJ47IdFOyfTOLyA4ArgFF1DBo7krCiMyDNdKzuIeA2blo7r0HW5yBLVbTxvTjYLYyxKfkQv9HEx0ZNz+RqcrVAIZECjHo4pTu8q8v5d6Gl6ko3kvnDrpMJcDS1XioEVGFYZhN6MbHWq8PR8dJAaElsx+A2EvZtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734062466; c=relaxed/simple;
	bh=uRWriS9TmvnXTrrSW96FZuKyb0Hnk2OCoMoq9P6eFzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQiugdyWH0a5VPT8i5Ezsil73zTD8WvxHYvaLhPdtW/Hm9uBloZbbelpj4mFvZnRbsaXTKN2MyS0qkFK11O/PeDPpOGyyMv/7LYeu7IgcsZm4YARoV6PSIOu6hfMhRcnGnm16hCuzDN9+6cmI2Aj3doCrgwKxmq5P+d5tD7iXHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=tJTITDo4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 1544C204BA91; Thu, 12 Dec 2024 20:01:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1544C204BA91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734062462;
	bh=MpijeqXUNeUyOil+oVJz5PSoObnSGFyduR+sv5IfdIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tJTITDo4FrweMnVhObqQ4Ym2lHE+OWsC0S12rKPUZ4XU0yyXQs12zE3LBGIYwL8GQ
	 Afesvco6wsRZo3uj2DvZvgU+YNC6Jcn7UP0nvT8m/hevYZIWBwGiUukANAeLfVsPyJ
	 gFZdyLSmd2SCG0QuqbpIN9u5LeKp+5ZYqpAOr0jQ=
Date: Thu, 12 Dec 2024 20:01:02 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	ssengar@microsoft.com, avladu@cloudbasesolutions.com
Subject: Re: [PATCH] tools: hv: Fix cross-compilation
Message-ID: <20241213040102.GA28827@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1733992114-7305-1-git-send-email-ssengar@linux.microsoft.com>
 <Z1tsaJJhUsSilZqq@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1tsaJJhUsSilZqq@liuwe-devbox-debian-v2>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Dec 12, 2024 at 11:06:16PM +0000, Wei Liu wrote:
> On Thu, Dec 12, 2024 at 12:28:34AM -0800, Saurabh Sengar wrote:
> > Use the native ARCH only incase it is not set, this will allow
> > the cross complilation where ARCH is explicitly set. Add few
> > info prints as well to know what arch and toolchain is getting
> > used to build it.
> > 
> > Additionally, simplify the check for ARCH so that fcopy daemon
> > is build only for x86_64.
> > 
> > Fixes: 82b0945ce2c2 ("tools: hv: Add new fcopy application based on uio driver")
> > Reported-by: Adrian Vladu <avladu@cloudbasesolutions.com>
> > Closes: https://lore.kernel.org/linux-hyperv/Z1Y9ZkAt9GPjQsGi@liuwe-devbox-debian-v2/
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  tools/hv/Makefile | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/hv/Makefile b/tools/hv/Makefile
> > index 34ffcec264ab..d29e6be6309b 100644
> > --- a/tools/hv/Makefile
> > +++ b/tools/hv/Makefile
> > @@ -2,7 +2,7 @@
> >  # Makefile for Hyper-V tools
> >  include ../scripts/Makefile.include
> >  
> > -ARCH := $(shell uname -m 2>/dev/null)
> > +ARCH ?= $(shell uname -m 2>/dev/null)
> >  sbindir ?= /usr/sbin
> >  libexecdir ?= /usr/libexec
> >  sharedstatedir ?= /var/lib
> > @@ -20,18 +20,26 @@ override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
> >  override CFLAGS += -Wno-address-of-packed-member
> >  
> >  ALL_TARGETS := hv_kvp_daemon hv_vss_daemon
> > -ifneq ($(ARCH), aarch64)
> > +ifeq ($(ARCH), x86_64)
> 
> Technically speaking, you can also build this for x86 (32bit). Whether
> anybody uses it is another question.

My intention is to allow fcopy daemon build only for the arch it has
been tested. IMO its better than restricting only for arm64/aarch64.

I tried with gcc '-m32' switch which I believe is for 32 bit x86 compilation
I see problems with it on other (kvp daemon) daemons too. I think we never
cared about 32 bit.

saurabh@Saurabh:/work/linux-next/tools/hv$ make ARCH=x86 CFLAGS=-m32
make[1]: Entering directory '/work/linux-next/tools/hv'
  CC      hv_kvp_daemon.o
hv_kvp_daemon.c:25:10: fatal error: sys/poll.h: No such file or directory
   25 | #include <sys/poll.h>
      |          ^~~~~~~~~~~~
compilation terminated.
make[1]: *** [/work/linux-next/tools/build/Makefile.build:106: hv_kvp_daemon.o] Error 1
make[1]: Leaving directory '/work/linux-next/tools/hv'
make: *** [Makefile:37: hv_kvp_daemon-in.o] Error 2


I don't have any strong opinion here, if you want I can allow x86 compilation
for fcopy daemon as well.

Please let me know what is your preference.

> 
> >  ALL_TARGETS += hv_fcopy_uio_daemon
> >  endif
> >  ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
> >  
> >  ALL_SCRIPTS := hv_get_dhcp_info.sh hv_get_dns_info.sh hv_set_ifconfig.sh
> >  
> > -all: $(ALL_PROGRAMS)
> > +all: info $(ALL_PROGRAMS)
> >  
> >  export srctree OUTPUT CC LD CFLAGS
> >  include $(srctree)/tools/build/Makefile.include
> >  
> > +info:
> > +	@echo "---------------------"
> > +	@echo "Building for:"
> > +	@echo "CC $(CC)"
> > +	@echo "LD $(LD)"
> > +	@echo "ARCH $(ARCH)"
> > +	@echo "---------------------"
> 
> I don't think this is needed. Anyone who's building the kernel source
> should know what tool chain they are using and architecture they're
> building for.

I am fine removing it in V2.

- Saurabh


