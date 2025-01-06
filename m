Return-Path: <linux-hyperv+bounces-3587-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC73EA030A2
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jan 2025 20:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF960164E14
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jan 2025 19:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC78D1CEADF;
	Mon,  6 Jan 2025 19:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fz8P8VJB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA5F8C1E;
	Mon,  6 Jan 2025 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736191972; cv=none; b=P2HUOYt8Oo+LIhQ5x+eYVeqbfgS5GoUSoYMYR2S5bfpfNlOWgiOiQYcWJiR5rI8MfC5PUFSIoQF6mCTGaNAkLz7BJxsh9CKXKY9octvFihCKP70Frkw12dnUpI4aHxKp2eWAJ42a05qQ6HWkL3bSmOvB8WqHw4lF0tv+AbKauX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736191972; c=relaxed/simple;
	bh=miX2B+w/AyZ0PQRA4c12UrykS+OhvXAscHrrrHL7ZgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzYWwliCSD4Y8annmrOwIwqEydCJpsdnIizTxRfFPC/D9WxF5knA5z7ADmMqXldZ9ohxzZTxdwilFZ/P2sunZaETmNhd98rnb/I9zGNTMYqjLtbzuJqZDU6Wu7PuDAWkvxwLz1tgfLAED6o9o+zUSoKE42VaFWugFsV8bEWxcco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fz8P8VJB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (c-98-225-44-166.hsd1.wa.comcast.net [98.225.44.166])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4719B204674C;
	Mon,  6 Jan 2025 11:32:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4719B204674C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736191970;
	bh=I0PvDWNLBJn5yO+gfPZhlrJXel1clhtXhZx/n2uWAiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fz8P8VJB8EgHShkzl//DZ9QKaQ60vpoJdE/KW0atn2od2kKEHaZIE+sL4sLnjEzoy
	 6qTqGEp3nICqtTDCl3v60meZhGQJN28z06E0Vvmz0T6xE9WM1M3Zegpm0DjLbqhAY+
	 Pf5JMgHeEwula24gE1ADqpwd1hPh3OKLgn3WNvE8=
Date: Mon, 6 Jan 2025 11:32:48 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	eahariha@linux.microsoft.com, haiyangz@microsoft.com,
	mingo@redhat.com, mhklinux@outlook.com,
	nunodasneves@linux.microsoft.com, tglx@linutronix.de,
	tiala@microsoft.com, wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, apais@microsoft.com, benhill@microsoft.com,
	ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v5 3/5] hyperv: Enable the hypercall output page for the
 VTL mode
Message-ID: <20250106193248.GB18346@skinsburskii.>
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-4-romank@linux.microsoft.com>
 <20250103192002.GA22059@skinsburskii.>
 <24594814-6b31-4dc9-83c3-2bafbd14e819@linux.microsoft.com>
 <20250106171114.GA18270@skinsburskii.>
 <a1577153-95c0-4791-8f6a-0ec00fae48f7@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1577153-95c0-4791-8f6a-0ec00fae48f7@linux.microsoft.com>

On Mon, Jan 06, 2025 at 10:11:16AM -0800, Roman Kisel wrote:
> 
> 
> On 1/6/2025 9:11 AM, Stanislav Kinsburskii wrote:
> > On Fri, Jan 03, 2025 at 01:39:29PM -0800, Roman Kisel wrote:
> > > 
> 
> [...]
> 
> > > 
> > 
> > The issue is that when you boot the same kernel in both VTL0 and VTL1+,
> > the pages will be allocated in any case (root or guest, VTL0 or VTL1+).
> 
> I think we share we same beliefs: use common code as much as possible.
> Strategically, one day, there will be the kernel being able to boot
> (or at the very minimum share the Hyper-V code for) VTL0, VTL1 (LVBS)
> and VTL2 (OpenHCL). It is not today, though: VTL0 relies on ACPI|BIOS,
> VTL2 relies on DeviceTree, and VTL1 boot configuration comes off as
> a bit ad-hoc from my read of https://github.com/heki-linux/lvbs-linux,
> and working with the LVBS folks on debugging that.
> 
> Can that day of the grand VTL code unification be tomorrow, or next
> week, or next month, or maybe next year, what is the option you leaning
> towards?
> 
> To me, it seems, that's not even the next month. Let us take a look
> at how much ink is being spent to just fix a garden variety function.
> On the meta-level that might mean some _fundamental work_ is needed to
> provide a _robust foundation_ to built upon, such as removing the if
> statements and #ifdef's we're debating about to let the general case
> shine through.
> 
> Tactically, imo, a staged approach might give more velocity and
> coverage instead of fixing the world in this small patch set. I would
> not want to increase the potential "blast radius" of the change.
> As it stands, it is pretty well-contained.
> 
> All told, it might be prudent to focus on the task at hand - fix the
> function in question to enable building on that, e.g. proposing the v4
> of the ARM64 VTL mode patches, and more of what we have in
> https://github.com/microsoft/OHCL-Linux-Kernel.
> 
> Once we take that small step to fix the hyperv-next tree, someone could
> propose removing the conditions for allocating the output page —-- or,
> perhaps, suggest an entirely new & vastly better solution to handling
> the hypercall output page. IMHO, that would enable adding features via
> relying on more generic code rather than further complicating the web
> of conditional statements and conditional compilation.
> 

From my POV a decision between a unified approach and interim solutions
in upstream should usually be resolved in favor of the former.
Given there are different stake holders in VTL code integration, I'd
suggest we step back a bit and think about how to proceed with the
overall design.

In my opinion, although I undestand why Underhill project decided to
come up with the original VTL kernels separation during build time, it's
time to reconsider this approach and to come up with a more generic
design, supporting booting the same kernel in different VTLs.

The major reason for this is that LVBS project relies on binary
compatibility of the kernels running in different VTLs.
The simplest way to provide such a guarantee in both development and
deployment is to run the same kernel in both VTLs.
Not having this ability will require carefull crafting of both the
kernels upon build, making kexec servicing of such kernels in production
complicated and error prone.

Thanks,
Stas

