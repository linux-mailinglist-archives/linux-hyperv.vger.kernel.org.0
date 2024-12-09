Return-Path: <linux-hyperv+bounces-3433-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679129E88BF
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Dec 2024 01:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8BE163F21
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Dec 2024 00:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8850D4409;
	Mon,  9 Dec 2024 00:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GW4V9KYa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640F128691
	for <linux-hyperv@vger.kernel.org>; Mon,  9 Dec 2024 00:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733705064; cv=none; b=fa8lqHiByUUXLKgVvLJpOxJgIEw/P23krx2uQMQmAsHhBwP5FyR/QYQ8xBpYb42/w1ZYuEgqZw08tyRoswkJA34u5Y7/v0acjnl8/np9UE1ZOSS1nJxyGco/OV7SXJ6bESoz2WBdZd+ORZwYhzvvQYlAXchdoy/RXf57DWudtXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733705064; c=relaxed/simple;
	bh=cUpkCA3bgy/yYwiIpZnze+0JtOTyE4QbgeOHxEtpPOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcS1+15jCjzQ/1VRreqZqEZ9PEzjE7St7ym9prcosxCJ7RCxyTrNVUxkCbM4Q0fzo6IPa2/WImfvklcUQzTpMU9aCSrtwsAK4/u+O26hx49ZdlrgQq6FKI2gkNpNSBfWmPbhKFvdNRWm1uN3ENZtGlFXf8LJwvRnMTctCz+iaOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GW4V9KYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAACC4CED2;
	Mon,  9 Dec 2024 00:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733705063;
	bh=cUpkCA3bgy/yYwiIpZnze+0JtOTyE4QbgeOHxEtpPOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GW4V9KYaZdsvo7BIgT9p/X5FsgW2svlnu0EW9OkgJzXKSGR5ct2uWLBNgIDQ1Ewu1
	 INO1mvveltJsC9L933MAD1K9xLspxfUzSTsS3j0vB0dY5gGa5mVkEud5IqYyHYPAoC
	 pZ4fs5YKuuOJlbNQJizIZ2aSzoPOz8GX4guh2I12AJEg5bdylJlCjqh+Qc7zKCMkmV
	 Hdn0M27gMTlAdtAdWGzDTOJjmSnEft7Nq+GKwOkcW8vDK2pncmFS6A13u4mbNrpWPG
	 Mf7Om7Ndk3RNZo//K/RhGhPDSywv0yD8ZG2C1x+3O5JbiqduwGHYZZRftA8u7m3XaU
	 LJnq43QUnim5Q==
Date: Mon, 9 Dec 2024 00:44:22 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Adrian Vladu <avladu@cloudbasesolutions.com>,
	ssengar@linux.microsoft.com
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	Alessandro Pilotti <apilotti@cloudbasesolutions.com>,
	Mathieu Tortuyaux <mtortuyaux@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>
Subject: Re: kernel: fix hv tools build for arm64 when cross-built
Message-ID: <Z1Y9ZkAt9GPjQsGi@liuwe-devbox-debian-v2>
References: <PR3PR09MB54119DB2FD76977C62D8DD6AB04D2@PR3PR09MB5411.eurprd09.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PR3PR09MB54119DB2FD76977C62D8DD6AB04D2@PR3PR09MB5411.eurprd09.prod.outlook.com>

On Wed, Oct 23, 2024 at 02:01:12PM +0000, Adrian Vladu wrote:
> Hello,
> 
> While trying to build the LIS daemons for Flatcar Container Linux for
> ARM64 (https://www.flatcar.org/), as we are doing Gentoo based
> cross-building from X64 boxes, there was an error while building those
> daemons, because the cross-compile scenario was not working, as ` ARCH
> := $(shell uname -m 2>/dev/null)` always returns `x86_64`.
> 
> I have a working patch for the Linux kernel here that was already
> applied in the Flatcar context and it works:
> https://github.com/flatcar/scripts/blob/94b1df1b19449eb5aa967fd48ba4c1f4a6d5f415/sdk_container/src/third_party/coreos-overlay/sys-kernel/coreos-sources/files/6.10/z0008-tools-hv-fix-cross-compilation-for-ARM64.patch
> 
> Raw patch link here:
> https://raw.githubusercontent.com/flatcar/scripts/94b1df1b19449eb5aa967fd48ba4c1f4a6d5f415/sdk_container/src/third_party/coreos-overlay/sys-kernel/coreos-sources/files/6.10/z0008-tools-hv-fix-cross-compilation-for-ARM64.patch
> 
> Sorry for the delivery method via github link, but I cannot send
> proper patches from my work email address currently, as the email
> server does not support it.
> 
> Please let me know if I need to send the patch via the recommended way
> or if the patch can be used directly.
> 
> Also, maybe there is a better way to address the cross-compilation
> issue, I just wanted to report the bug and also provide a possible
> fix.

Saurabh added the ARCH variable. He's CCed.

BTW I think your patch can be simplified by using
  ARCH ?= $(shell uname -m 2>/dev/null)
instead of the ifeq test in your patch.

I don't think that's correct. ARCH will be set to the correct value by
Kbuild. 

Saurabh and Adrian, can you test the following patch?

Thanks,
Wei.

From e6a1827887617c08172e2d0ee0d60549f5ccad65 Mon Sep 17 00:00:00 2001
From: Wei Liu <wei.liu@kernel.org>
Date: Mon, 9 Dec 2024 00:32:50 +0000
Subject: [PATCH] tools/hv: fix cross-compilation issue in hv tools

The Kbuild system sets ARCH to the correct value.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 tools/hv/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/hv/Makefile b/tools/hv/Makefile
index 34ffcec264ab..9008223279df 100644
--- a/tools/hv/Makefile
+++ b/tools/hv/Makefile
@@ -2,7 +2,6 @@
 # Makefile for Hyper-V tools
 include ../scripts/Makefile.include
 
-ARCH := $(shell uname -m 2>/dev/null)
 sbindir ?= /usr/sbin
 libexecdir ?= /usr/libexec
 sharedstatedir ?= /var/lib
@@ -20,7 +19,7 @@ override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
 override CFLAGS += -Wno-address-of-packed-member
 
 ALL_TARGETS := hv_kvp_daemon hv_vss_daemon
-ifneq ($(ARCH), aarch64)
+ifneq ($(ARCH), arm64)
 ALL_TARGETS += hv_fcopy_uio_daemon
 endif
 ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
-- 
2.45.2


