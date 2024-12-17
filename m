Return-Path: <linux-hyperv+bounces-3488-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1299F567E
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Dec 2024 19:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551831892D7F
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Dec 2024 18:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5E71F8AD5;
	Tue, 17 Dec 2024 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqPiLuG2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731A71F8AD0;
	Tue, 17 Dec 2024 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734461379; cv=none; b=TO+QnFEAGWvASGjX+RzDbMXABdtTe8BlgBtnWQEDbmO3keIWFU1juMVs//PIPx6tWloPdNqrYnZckiY7M8B+Lt2xLqVaL3r2o6UWFp40AvV32wkE5Yxm3BE2TlaxwkUBnmURuCmisti9tCpBaeLzVZJiSsF5gSZvxyyuAl48E+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734461379; c=relaxed/simple;
	bh=ttW1ztqu1hCU9exDxWTyu+4ylc226xEK1pCskpFHxcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxEruiuUgC9YegbtoNkPZk0ovdmlR6bZI8/DkTpdEJ2e2skLLXViWetp+0s37KyCN3EIs8qgCR/QJCa+8BjqYWJeNCucs/2uh+Bfuf6Ky4+6zuQkQj5HpXrapAKP/RJWAHnbtujUmqcYzKOohrL6rAhKi3YhWQEQEjl1QuGGm+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqPiLuG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2916C4CED3;
	Tue, 17 Dec 2024 18:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734461378;
	bh=ttW1ztqu1hCU9exDxWTyu+4ylc226xEK1pCskpFHxcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hqPiLuG2HFYCnhdy87ycuvMdDYTCNv/jAjSIOPWTEB1Dv8EExDMGPCUAMPFyf6ByP
	 Sl+7Bk8pSZl6pI5tDW0kikOpwCIZJO90fzqsptIEN+5d1JfIrzwnojlPUneA7TgByD
	 ZzbHbXjMtnHmtjFk7NSFVKrMvUtGyaKIilGDor4jViKwVZ3697Eiq8bH18upP24sJY
	 0HkDIwGOatLfPfNAZyUBCxl5G588K0xKOc+zv+b59tY0jtNNKDtuM0H4Vt9fGxm9oy
	 0XrJ4RhUvznBs/txMbrJ+UYjt/iBVf6/+MUC/rn2jOt992mHG4VJmsOGf0QDdyfmbO
	 NxziUYYhxysxg==
Date: Tue, 17 Dec 2024 18:49:37 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, kys@microsoft.com, haiyangz@microsoft.com,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, ssengar@microsoft.com,
	avladu@cloudbasesolutions.com
Subject: Re: [PATCH] tools: hv: Fix cross-compilation
Message-ID: <Z2HHwboni5wjNTY8@liuwe-devbox-debian-v2>
References: <1733992114-7305-1-git-send-email-ssengar@linux.microsoft.com>
 <Z1tsaJJhUsSilZqq@liuwe-devbox-debian-v2>
 <20241213040102.GA28827@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213040102.GA28827@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Thu, Dec 12, 2024 at 08:01:02PM -0800, Saurabh Singh Sengar wrote:
> On Thu, Dec 12, 2024 at 11:06:16PM +0000, Wei Liu wrote:
> > On Thu, Dec 12, 2024 at 12:28:34AM -0800, Saurabh Sengar wrote:
> > > Use the native ARCH only incase it is not set, this will allow
> > > the cross complilation where ARCH is explicitly set. Add few
> > > info prints as well to know what arch and toolchain is getting
> > > used to build it.
> > > 
> > > Additionally, simplify the check for ARCH so that fcopy daemon
> > > is build only for x86_64.
> > > 
> > > Fixes: 82b0945ce2c2 ("tools: hv: Add new fcopy application based on uio driver")
> > > Reported-by: Adrian Vladu <avladu@cloudbasesolutions.com>
> > > Closes: https://lore.kernel.org/linux-hyperv/Z1Y9ZkAt9GPjQsGi@liuwe-devbox-debian-v2/
> > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > ---
> > >  tools/hv/Makefile | 14 +++++++++++---
> > >  1 file changed, 11 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/tools/hv/Makefile b/tools/hv/Makefile
> > > index 34ffcec264ab..d29e6be6309b 100644
> > > --- a/tools/hv/Makefile
> > > +++ b/tools/hv/Makefile
> > > @@ -2,7 +2,7 @@
> > >  # Makefile for Hyper-V tools
> > >  include ../scripts/Makefile.include
> > >  
> > > -ARCH := $(shell uname -m 2>/dev/null)
> > > +ARCH ?= $(shell uname -m 2>/dev/null)
> > >  sbindir ?= /usr/sbin
> > >  libexecdir ?= /usr/libexec
> > >  sharedstatedir ?= /var/lib
> > > @@ -20,18 +20,26 @@ override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
> > >  override CFLAGS += -Wno-address-of-packed-member
> > >  
> > >  ALL_TARGETS := hv_kvp_daemon hv_vss_daemon
> > > -ifneq ($(ARCH), aarch64)
> > > +ifeq ($(ARCH), x86_64)
> > 
> > Technically speaking, you can also build this for x86 (32bit). Whether
> > anybody uses it is another question.
> 
> My intention is to allow fcopy daemon build only for the arch it has
> been tested. IMO its better than restricting only for arm64/aarch64.
> 
> I tried with gcc '-m32' switch which I believe is for 32 bit x86 compilation
> I see problems with it on other (kvp daemon) daemons too. I think we never
> cared about 32 bit.
> 
> saurabh@Saurabh:/work/linux-next/tools/hv$ make ARCH=x86 CFLAGS=-m32
> make[1]: Entering directory '/work/linux-next/tools/hv'
>   CC      hv_kvp_daemon.o
> hv_kvp_daemon.c:25:10: fatal error: sys/poll.h: No such file or directory
>    25 | #include <sys/poll.h>
>       |          ^~~~~~~~~~~~
> compilation terminated.
> make[1]: *** [/work/linux-next/tools/build/Makefile.build:106: hv_kvp_daemon.o] Error 1
> make[1]: Leaving directory '/work/linux-next/tools/hv'
> make: *** [Makefile:37: hv_kvp_daemon-in.o] Error 2
> 
> 
> I don't have any strong opinion here, if you want I can allow x86 compilation
> for fcopy daemon as well.
> 
> Please let me know what is your preference.

We can leave the code as-is. If and when someone wants to build this for
32-bit x86, they can fix the code.

I think the number of people who want to build this for 32-bit x86 is
diminishing by the day -- it there was a large group in the first place.

Thanks,
Wei.

