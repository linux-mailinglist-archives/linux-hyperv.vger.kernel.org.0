Return-Path: <linux-hyperv+bounces-3905-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13679A31589
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Feb 2025 20:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC0D166967
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Feb 2025 19:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EF926E62B;
	Tue, 11 Feb 2025 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rdhuyFbn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B7726E621;
	Tue, 11 Feb 2025 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302978; cv=none; b=mkGV4GAsQezAruTh7egk8UD9uv0MPyO5+7UQ0x7SY1GDRSF9WYpHukhIx9Hg5VEUIAbO9VOZYlxCRkfyOvW3l/tf3ZTK4Qc0+lWrXxHQPvPJbmsQw6/7vjSwie+1pJElI/vaHDLkQY3hs9NLqplNoz0enNmJj83wow8V5DuX09w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302978; c=relaxed/simple;
	bh=IHhxWXT1FOwYCqIslvFFpVw9mwFoPH1F8k03tEAgYvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2lT4bLhR3rYGuJLWPsy3yxyee3Ox1L6yEGbtnBedPnO/X56n6t79ad17euuw7VIuYAZ0STeRqlPoVSdmqdTY1m2uVJcSqP7VlsfwC2O4ri93k5SR18amFDHfcNZk4i437mDxhQ4yCuJlP7/gZPX16dYQtvJuCUIIouLT4UyQ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rdhuyFbn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from hm-sls2 (bras-base-toroon4332w-grc-32-142-114-216-132.dsl.bell.ca [142.114.216.132])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4BBF82107AAF;
	Tue, 11 Feb 2025 11:42:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4BBF82107AAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739302976;
	bh=ZpkrAC4MG3Uo4nr6GgwInChmw1npVWavzLIZPCr1iTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rdhuyFbnAbmv0yTHVSkEsl+sFszEo1U88an2pjy+RQ56vBKE+b7ZPJvfHmVmdbDnK
	 nbxoGGy7S5jRYT6iN2d5G5ZKKvqDEBAsJtlZhGeRkn5NkXU4abNmzuRrj8GiCKxhkx
	 s/1irtFTFGyE1n7tOQlMmqWe6g9Sv3TQHWwm3URw=
Date: Tue, 11 Feb 2025 14:42:47 -0500
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] cpu: export lockdep_assert_cpus_held()
Message-ID: <Z6uoNyg72p8bDNE_@hm-sls2>
References: <20250117203309.192072-1-hamzamahfooz@linux.microsoft.com>
 <SN6PR02MB41574DAE9F22C9D67D66B5F7D4E12@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41574DAE9F22C9D67D66B5F7D4E12@SN6PR02MB4157.namprd02.prod.outlook.com>

ping?

On Wed, Jan 22, 2025 at 03:37:44PM +0000, Michael Kelley wrote:
> From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Friday, January 17, 2025 12:33 PM
> > 
> > If CONFIG_HYPERV=m, lockdep_assert_cpus_held() is undefined for HyperV.
> > So, export the function so that GPL drivers can use it more broadly.
> > 
> > Cc: Michael Kelley <mhklinux@outlook.com>
> > Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> > ---
> > v5: new to the series
> > ---
> >  kernel/cpu.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index b605334f8ee6..d3c848d66908 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -526,6 +526,7 @@ void lockdep_assert_cpus_held(void)
> > 
> >  	percpu_rwsem_assert_held(&cpu_hotplug_lock);
> >  }
> > +EXPORT_SYMBOL_GPL(lockdep_assert_cpus_held);
> > 
> >  #ifdef CONFIG_LOCKDEP
> >  int lockdep_is_cpus_held(void)
> > --
> > 2.47.1
> 
> This series should have been posted as "v6" since "v5" was posted on
> January 16th.  That notwithstanding,
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> 

