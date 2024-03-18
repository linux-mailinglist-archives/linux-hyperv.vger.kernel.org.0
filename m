Return-Path: <linux-hyperv+bounces-1773-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5EB87ED6C
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Mar 2024 17:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181B31F23D1E
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Mar 2024 16:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC4853397;
	Mon, 18 Mar 2024 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Zu+bx1dT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D0B53379
	for <linux-hyperv@vger.kernel.org>; Mon, 18 Mar 2024 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710778890; cv=none; b=ID/U10mAZj9HwbY4ltdUlF0e7mw4XB6b6F8LrUOHkjhY+p3fKfcBnhvH0TmhoDnlZ3bVWtxXCInVHGPFz5Xg1z8/ekvY8TJHc3T6JrHh9POIO1aFjN7YM3C3rexHKElVffBr07gTwP75H4rvul95M0Uq1XOTsnYEOaamPNLYIxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710778890; c=relaxed/simple;
	bh=6WeCp8GijdpnuCQ+sffQKEk5gbPAvA4L3ngoVd7au3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1xvu1kGq8T4f/Vdwf3lNI18sUAfnK7D6QNL0DEFO5oJYPOD8WJKsqtNvNaSzJXg/5OU16NzLBWg9HbTiZAXEwrCtJTq5Q6SpC4feqBXztGgv0ZQhquLAPZ0sDGCkV8bAUdRfGVtN9wAp0dQMLU0QoFtZk/R72/SPVTPYRF3qI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Zu+bx1dT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id A132A20B74C0; Mon, 18 Mar 2024 09:21:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A132A20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710778888;
	bh=f/MVg+5revsLPYZx/P62/ij4QD0OB0ib7k/KPBwqo7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zu+bx1dTeEKc7SocJUxZ1+w7yULy+4oOgrk/diYxwb4iMVyw1/NSOey3cdSwWGv9A
	 csA6r6YiRfmi1VJOB+2gvaLnJZJaWM8BF/wBW2kWzoKFmQGtBQiDv7sLNhmgcXBEzV
	 oCZd9CwHjpOAaTYCfOIFdpzp9E3XbGoeYbvUkfEc=
Date: Mon, 18 Mar 2024 09:21:28 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, linux-hyperv@vger.kernel.org,
	paekkaladevi@microsoft.com
Subject: Re: [PATCH] x86/hyperv: Cosmetic changes for hv_spinlock.c
Message-ID: <20240318162128.GA17252@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1710763751-14137-1-git-send-email-paekkaladevi@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1710763751-14137-1-git-send-email-paekkaladevi@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Mar 18, 2024 at 05:09:11AM -0700, Purna Pavan Chandra Aekkaladevi wrote:
> Fix issues reported by checkpatch.pl script for hv_spinlock.c file.
> - Place __initdata after variable name
> - Add missing blank line after enum declaration
> 
> No functional chagnes intended.

s/chagnes/changes/

with this,
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

> 
> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_spinlock.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
> index 737d6f7a6155..151e851bef09 100644
> --- a/arch/x86/hyperv/hv_spinlock.c
> +++ b/arch/x86/hyperv/hv_spinlock.c
> @@ -16,7 +16,7 @@
>  #include <asm/paravirt.h>
>  #include <asm/apic.h>
>  
> -static bool __initdata hv_pvspin = true;
> +static bool hv_pvspin __initdata = true;
>  
>  static void hv_qlock_kick(int cpu)
>  {
> @@ -64,6 +64,7 @@ __visible bool hv_vcpu_is_preempted(int vcpu)
>  {
>  	return false;
>  }
> +
>  PV_CALLEE_SAVE_REGS_THUNK(hv_vcpu_is_preempted);
>  
>  void __init hv_init_spinlocks(void)
> -- 
> 2.34.1
> 

