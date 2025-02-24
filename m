Return-Path: <linux-hyperv+bounces-4035-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF07A42E6F
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Feb 2025 21:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF833176AC3
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Feb 2025 20:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EA5264A95;
	Mon, 24 Feb 2025 20:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="a9roizhM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8A6264A76;
	Mon, 24 Feb 2025 20:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740430666; cv=none; b=VUdwpGmCd2TtvF/oEDRIlc5xBEX8HU+TVqCFFJ0RflPgzGmBmXqbS3b0iJ49xCYD+8E5vIE0FTPYfivQVOZ5ZylFpxbnCqKvbDjTY+E3N+vFwJMD40ewTBopv5dWnd3l5HCB3AvgLi792OWnZ63R1n9n0zXPtfQp52deqf7f+Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740430666; c=relaxed/simple;
	bh=tHp3CW8WUqBJOuJ+M5ldr4pd47GY+B/nMBanKd5tldo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkhFl/cZJJbcJ1OLXxwWs4TrCFBtM48cgdx/j8fyymYsGTtMPsOd8T+WJ/NOptjC9DWIKk9+4Sx4ilgtOWPPwUYVsEQPuZTX/vHTwJC4IwrUmeTP695m9PG3EUEzRRNGPTD3nUJ0REDe9Z61EYsw1S1Aq/Plh4PFVhlYONqWR30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=a9roizhM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from hm-sls2 (unknown [142.114.216.132])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1B547203CDE1;
	Mon, 24 Feb 2025 12:57:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B547203CDE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740430664;
	bh=Xuh6Gw8WVBag6u3aATPx+1OicXMDLi528DsAZL28/pQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a9roizhMqR+1018jc5Z9vNNa0fYhQKVbujlDLHaX3mq0rxvAIJ2awA0we5jGyKbLz
	 v7I66zdrp0b/q1YGhkGQglJ0kQJ5H2add1506CciBN6065ha53/JETOuuETW90tAiV
	 mCXJ/pQmg7pWakO5YA7VCK9u2hP8e0j5WSWid7RU=
Date: Mon, 24 Feb 2025 15:57:31 -0500
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Petr Mladek <pmladek@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	John Ogness <john.ogness@linutronix.de>,
	Jani Nikula <jani.nikula@intel.com>, Baoquan He <bhe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ryo Takakura <takakura@valinux.co.jp>
Subject: Re: [PATCH v2] panic: call panic handlers before
 panic_other_cpus_shutdown()
Message-ID: <Z7zdO6WSoTyrS_B0@hm-sls2>
References: <20250221213055.133849-1-hamzamahfooz@linux.microsoft.com>
 <SN6PR02MB4157D993CCE04F2D46E2B8A1D4C72@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z7yGv_ZyeyUueXLz@hm-sls2>
 <BN7PR02MB41481BB6067A7265A459AF69D4C02@BN7PR02MB4148.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN7PR02MB41481BB6067A7265A459AF69D4C02@BN7PR02MB4148.namprd02.prod.outlook.com>

On Mon, Feb 24, 2025 at 07:59:28PM +0000, Michael Kelley wrote:
> From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Monday, February 24, 2025 6:49 AM
> > 
> > On Fri, Feb 21, 2025 at 11:01:09PM +0000, Michael Kelley wrote:
> > > From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Friday, February
> > 21, 2025 1:31 PM
> > > >
> > > > Since, the panic handlers may require certain cpus to be online to panic
> > > > gracefully, we should call them before turning off SMP. Without this
> > > > re-ordering, on Hyper-V hv_panic_vmbus_unload() times out, because the
> > > > vmbus channel is bound to VMBUS_CONNECT_CPU and unless the crashing cpu
> > > > is the same as VMBUS_CONNECT_CPU, VMBUS_CONNECT_CPU will be offlined by
> > > > crash_smp_send_stop() before the vmbus channel can be deconstructed.
> > >
> > > Hamza -- what specifically is the problem with the way vmbus_wait_for_unload()
> > > works today? That code is aware of the problem that the unload response comes
> > > only on the VMBUS_CONNECT_CPU, and that cpu may not be able to handle
> > > the interrupt. So the code polls the message page of each CPU to try to get the
> > > unload response message. Is there a scenario where that approach isn't working?
> > >
> > 
> > It doesn't work on arm64 (if the crashing cpu isn't VMBUS_CONNECT_CPU), it
> > always ends up at "VMBus UNLOAD did not complete" without fail. It seems
> > like arm64's crash_smp_send_stop() is more aggressive than x86's.
> 
> FWIW, I tested on a D16plds_v6 arm64 VM in Azure, running Ubuntu 20.04 with
> a linux-next20252021 kernel. I caused a panic using "echo c >/proc/sysrq-trigger"
> using "taskset" to make sure the panic is triggered on a CPU other than CPU 0.
> I didn't see any problem. The panic code path completely quickly, and there were
> no messages from vmbus_wait_for_unload(), including none of the periodic
> "Waiting for unload" messages . I tried initiating the panic on several different
> CPUs (4, 7, and 15) with the same result. I tested with kdump disabled and with
> kdump enabled, both with no problems.
> 
> So I think the current vmbus_wait_for_unload() code works on arm64, as least
> in some ordinary scenarios. Any key differences in the configuration or test
> environment when you see the "did not complete" message?

Can you try on a Standard_D16pls_v5 with the stock ubuntu image and
kernel crash dump (i.e. linux-crashdump) installed and setup?

> 
> Michael

