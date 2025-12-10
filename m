Return-Path: <linux-hyperv+bounces-8005-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F405CCB25EC
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Dec 2025 09:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6DE430133B3
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Dec 2025 08:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98752D2388;
	Wed, 10 Dec 2025 08:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/YKt0Ah"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0EB27EFE9;
	Wed, 10 Dec 2025 08:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765354479; cv=none; b=sKUenF3b9GRx1IzjhVZG2EHHkcVlyWv5VyLEfpaoW/1zUyPL/dmfiCz3h0Vnu/+dQvSvIyk0/grCAJNN33T/+DTw5xWIXA577kpgNWKStMKYglHtzTyeQgiJG99+a0D2omoaCl5beaaUhA2pOpuLuHuP8CUUwE9RNaebTMvo3nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765354479; c=relaxed/simple;
	bh=YReR8mWxFXbLWLVA6P4Sxk0KKPMnBXIaX4d5Fdnpp/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDY6ND4xg9zmsibPTj8geRLmEmXX5MYq8ZFFydeZQbMjH9DXDLQ+W1hCXE5ZQLevnlCQX6VVSf5Zt3+uQaAjtxujPgh1syrad7PfAb2n6rnWh4gWTruyZySYz+qyVKBsNuKvJzcwu+6+oWuo4zlIkKB0YDoCeoTOI3iSl8mEGfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/YKt0Ah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E452AC4CEF1;
	Wed, 10 Dec 2025 08:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765354479;
	bh=YReR8mWxFXbLWLVA6P4Sxk0KKPMnBXIaX4d5Fdnpp/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a/YKt0AhrB6gmulaCcgIatEOOKe9ET1HFmyO8ck4Zxk4oj2Blx2VMfKqvULBUkUON
	 +40B4Loap1syCBWWgVaNPtu6lu+RErMzjFYVcrz3YhtV8ugUufhkSaxoX4I710f/dx
	 g0mf+RA3guuOE7Yw13k684GcqA1jepXdmVfxS/55whKekvE/vdFymVNOI5sXpvH0Ca
	 AGe6hj5Ta4ciQYeS2jc6Mny9SrhefdvkfLkMgbBuD0KQW6U8ijXeCmEcp0FiZ6qYY4
	 8G7233KcFOCqYYmo5kDhFt8rzKfCwTkzNObYKy25e8MGxYjVRp9rrDN98Xm6uhU0iP
	 ugEHpgcc2Es/Q==
Date: Wed, 10 Dec 2025 17:14:33 +0900
From: Nathan Chancellor <nathan@kernel.org>
To: Praveen K Paladugu <prapal@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, arnd@arndb.de, anbelski@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	nunodasneves@linux.microsoft.com, skinsburskii@linux.microsoft.com
Subject: Re: [PATCH v7 0/4] Add support for clean shutdown with MSHV
Message-ID: <20251210081433.GA1238677@ax162>
References: <20251205201721.7253-1-prapal@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205201721.7253-1-prapal@linux.microsoft.com>

Hi Praveen,

On Fri, Dec 05, 2025 at 02:17:04PM -0600, Praveen K Paladugu wrote:
...
>   hyperv: Use reboot notifier to configure sleep state
>   hyperv: Cleanly shutdown root partition with MSHV

These two patches result in warnings (that get upgraded to errors with
CONFIG_WERROR=y / W=e) on arm64:

  $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- clean defconfig

  $ scripts/config -e HYPERV -e MSHV_ROOT

  $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- olddefconfig drivers/hv/mshv_common.o
  drivers/hv/mshv_common.c:210:6: warning: no previous prototype for 'hv_sleep_notifiers_register' [-Wmissing-prototypes]
    210 | void hv_sleep_notifiers_register(void)
        |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/hv/mshv_common.c:224:6: warning: no previous prototype for 'hv_machine_power_off' [-Wmissing-prototypes]
    224 | void hv_machine_power_off(void)
        |      ^~~~~~~~~~~~~~~~~~~~

The prototypes for these functions are only available for x86.

Cheers,
Nathan

