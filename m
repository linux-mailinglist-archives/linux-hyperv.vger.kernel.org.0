Return-Path: <linux-hyperv+bounces-3471-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEE29EFFD0
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Dec 2024 00:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC40286A23
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Dec 2024 23:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778281D7E5F;
	Thu, 12 Dec 2024 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9Bs+p30"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB011D63E0;
	Thu, 12 Dec 2024 23:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734044781; cv=none; b=RGvJQ68haUF3zZDdCBZLknafshaSaycoBE8Y30EHVXfXKiA14TxuHoYZlCIb1zdJQEIUU5ugbAKZEAejcgUAuGuGXzPhqvLqiuhKSOnQ0yNIAcWrt1e0ee7P1YtI2FDpDqBt+N3ZsW+50Yw2OY1+39MQhtIo7GNeOsS3EWOZ4P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734044781; c=relaxed/simple;
	bh=1QyYg9px6x+Do7hzdoQd9Z7TnY5QYoK9ZJS1lww/lvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDHUGYSpmwMj+ognuGWzfANbS9+XHfzwQRmFzTBDkCENxNOYJAgFfhTg7uRgN1Rr7KXFCldXm2pfgGEJyC1/XkX2ierm7tL9THTO+ila+iRq3M81Yrv4sICRwXUGBQP3ygoVXVNEbt1labuxanQDRi2K3y4cokF6HRIqDA07Atc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9Bs+p30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FDFC4CECE;
	Thu, 12 Dec 2024 23:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734044777;
	bh=1QyYg9px6x+Do7hzdoQd9Z7TnY5QYoK9ZJS1lww/lvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U9Bs+p30ZZ6reALiJiX5gpny44mJKU9bDfpcA06V+h7IXpnb8V59zwE+lPBf7Xby5
	 kldZsBooIz0fj0O2di1A6rXZM+J4PlQ2y50gmpwgP8W/UUOK9zRLjg/5wRXP6Ail61
	 X+Vrd9Nof1Uyoj7oFjFZSycoZqfsmQzWhcHbV2S41ac5w7mJjubwd4OP7/64CnRFwH
	 z0F2jjBsKudO5QvKYw+RpVRYtAVcuzyTLxzgjk/pJw26Djr1+QhFopOJqtr9sJcpcX
	 PXhLy1Q4MR3SeRPQTxgkWDWeH6F0p1JO7MOVrWSQYtokZlV67aMGYcISDZJC1FB8u7
	 Nb3qlmh2zUT7A==
Date: Thu, 12 Dec 2024 23:06:16 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, ssengar@microsoft.com,
	avladu@cloudbasesolutions.com
Subject: Re: [PATCH] tools: hv: Fix cross-compilation
Message-ID: <Z1tsaJJhUsSilZqq@liuwe-devbox-debian-v2>
References: <1733992114-7305-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1733992114-7305-1-git-send-email-ssengar@linux.microsoft.com>

On Thu, Dec 12, 2024 at 12:28:34AM -0800, Saurabh Sengar wrote:
> Use the native ARCH only incase it is not set, this will allow
> the cross complilation where ARCH is explicitly set. Add few
> info prints as well to know what arch and toolchain is getting
> used to build it.
> 
> Additionally, simplify the check for ARCH so that fcopy daemon
> is build only for x86_64.
> 
> Fixes: 82b0945ce2c2 ("tools: hv: Add new fcopy application based on uio driver")
> Reported-by: Adrian Vladu <avladu@cloudbasesolutions.com>
> Closes: https://lore.kernel.org/linux-hyperv/Z1Y9ZkAt9GPjQsGi@liuwe-devbox-debian-v2/
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  tools/hv/Makefile | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/hv/Makefile b/tools/hv/Makefile
> index 34ffcec264ab..d29e6be6309b 100644
> --- a/tools/hv/Makefile
> +++ b/tools/hv/Makefile
> @@ -2,7 +2,7 @@
>  # Makefile for Hyper-V tools
>  include ../scripts/Makefile.include
>  
> -ARCH := $(shell uname -m 2>/dev/null)
> +ARCH ?= $(shell uname -m 2>/dev/null)
>  sbindir ?= /usr/sbin
>  libexecdir ?= /usr/libexec
>  sharedstatedir ?= /var/lib
> @@ -20,18 +20,26 @@ override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
>  override CFLAGS += -Wno-address-of-packed-member
>  
>  ALL_TARGETS := hv_kvp_daemon hv_vss_daemon
> -ifneq ($(ARCH), aarch64)
> +ifeq ($(ARCH), x86_64)

Technically speaking, you can also build this for x86 (32bit). Whether
anybody uses it is another question.

>  ALL_TARGETS += hv_fcopy_uio_daemon
>  endif
>  ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
>  
>  ALL_SCRIPTS := hv_get_dhcp_info.sh hv_get_dns_info.sh hv_set_ifconfig.sh
>  
> -all: $(ALL_PROGRAMS)
> +all: info $(ALL_PROGRAMS)
>  
>  export srctree OUTPUT CC LD CFLAGS
>  include $(srctree)/tools/build/Makefile.include
>  
> +info:
> +	@echo "---------------------"
> +	@echo "Building for:"
> +	@echo "CC $(CC)"
> +	@echo "LD $(LD)"
> +	@echo "ARCH $(ARCH)"
> +	@echo "---------------------"

I don't think this is needed. Anyone who's building the kernel source
should know what tool chain they are using and architecture they're
building for.

Thanks,
Wei.

> +
>  HV_KVP_DAEMON_IN := $(OUTPUT)hv_kvp_daemon-in.o
>  $(HV_KVP_DAEMON_IN): FORCE
>  	$(Q)$(MAKE) $(build)=hv_kvp_daemon
> -- 
> 2.43.0
> 

