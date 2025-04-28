Return-Path: <linux-hyperv+bounces-5188-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF204A9E58E
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 02:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDEC16DEAF
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 00:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC6C57C9F;
	Mon, 28 Apr 2025 00:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/3nVo38"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6337026ACB;
	Mon, 28 Apr 2025 00:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745801318; cv=none; b=eVDozvXccdI0qdNxjHkz2ADIaP8PRu6HsrbsiO8A+8lvhazcwDceJTkq9iTZme3tWEHGIuGZ/S+uj63DU7JdzyE2QQPRiuF8sMb/xN500te1Tu5rwtBlKflQKTRUcgm5T4+7c74IbXAq5Cs3KV6uAnORzTQQDV7wcOiu5TuOvaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745801318; c=relaxed/simple;
	bh=fkCESRWZBQKZ/tI+AA4cusg+RxlFdjJUD489HgwnmNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWSZ7ufp97kT1m1RLRpoEPf+a2hmtQ1wy5fma5CDVoSnKGdlD0YMxqFtZOzxtld2kU+J5TzYP8W0l9ZcWYxrvXnilFjx/A9T08BafP8POfsEfdvam0ueOR0mh+AGKXmmmXdDJhuauiU6VIasO6tXLjqat0FtCKRnk6945rggaR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/3nVo38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66467C4CEE9;
	Mon, 28 Apr 2025 00:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745801317;
	bh=fkCESRWZBQKZ/tI+AA4cusg+RxlFdjJUD489HgwnmNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D/3nVo38xBDCgIsChGqD9Ls5LNxsrlZoe1bGUiz6CuiaG/xfac6Z/iJno/LyDIRnc
	 L9/VqShP0vtaznhtiIY2SnsK0rp4Hwg6wBmO32U87u9j9N00syNecDbBqW5cfBIGS+
	 0rR4mj5+82AuW7l8woAi0ZWNpF7FJFOlyv6giEdfhrRslGDv86DFhjIrSnyA9pctEs
	 nUWuifM1tk5NGxcDu74xTOmarMcsQRaaSBRvlTwvOMXKd4GVObjlXcaZWf6mqGkKV1
	 Oy9k6TKiiSrWTlGdpZ6ugI4GMUul6IlmBnZNB7epwpM3EHZMMUvBGJt+cgRMT9FSDO
	 q1s1bmhZdw0Vg==
Date: Mon, 28 Apr 2025 00:48:36 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Roman Kisel <romank@linux.microsoft.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"mikelley@microsoft.com" <mikelley@microsoft.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"tiala@microsoft.com" <tiala@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"apais@microsoft.com" <apais@microsoft.com>,
	"benhill@microsoft.com" <benhill@microsoft.com>,
	"bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: Re: [PATCH hyperv-next] x86/hyperv: Fix APIC ID and VP ID confusion
 in hv_snp_boot_ap()
Message-ID: <aA7QZPFS7WWOsahp@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250424215746.467281-1-romank@linux.microsoft.com>
 <SN6PR02MB4157E849025C4A6B64933150D4842@SN6PR02MB4157.namprd02.prod.outlook.com>
 <8a235e4f-f4ce-445e-9714-380573033455@linux.microsoft.com>
 <SN6PR02MB41577E8A06C9F8BA66A8D68AD4842@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41577E8A06C9F8BA66A8D68AD4842@SN6PR02MB4157.namprd02.prod.outlook.com>

On Fri, Apr 25, 2025 at 04:55:42PM +0000, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, April 25, 2025 9:36 AM
> > 
> > On 4/25/2025 8:12 AM, Michael Kelley wrote:
> > > From: Roman Kisel <romank@linux.microsoft.com> Sent: Thursday, April 24, 2025 2:58 PM
> > >>
> > >> To start an application processor in SNP-isolated guest, a hypercall
> > >> is used that takes a virtual processor index. The hv_snp_boot_ap()
> > >> function uses that START_VP hypercall but passes as VP ID to it what
> > >> it receives as a wakeup_secondary_cpu_64 callback: the APIC ID.
> > >>
> > >> As those two aren't generally interchangeable, that may lead to hung
> > >> APs if VP IDs and APIC IDs don't match, e.g. APIC IDs might be sparse
> > >> whereas VP IDs never are.
> > >
> > > I agree that VP IDs (a.k.a. VP indexes) and APIC IDs don't necessary match,
> > > and that APIC IDs might be sparse. But I'm not aware of any statement
> > > in the TLFS about the nature of VP indexes, except that
> > >
> > >     "A virtual processor index must be less than the maximum number of
> > >     virtual processors per partition."
> > >
> > > But that maximum is the Hyper-V implementation maximum, not the
> > > maximum for a particular VM. So the statement does not imply
> > > denseness unless the number of CPUs in the VM is equal to the
> > > Hyper-V implementation max. In other parts of Linux kernel code,
> > > we assume that VP indexes might be sparse as well.
> > >
> > > All that said, this is just a comment about the precise accuracy of
> > > your commit message, and doesn't affect the code.
> > >
> > 
> > I appreciate your help with the precision. I used loose language,
> > agreed, would like to fix that. The patch was applied though but not yet
> > sent to the Linus'es tree as I understand. I'd appreciate guidance on
> > the process! Should I send a v2 nevertheless and explain the situation
> > in the cover letter?
> > 
> > IOW, how do I make this easier for the maintainer(s)?
> 
> Wei Liu should give his preferences. But in the past, I think he has
> just replaced a patch that was updated. If that's the case, you can 
> send a v2 without a lot of additional explanation.
> 

Normally if you need to send a new version because the original
patch is buggy, you can just update your patch.

If only a commit message or comment needs to be updated, I will let the
submitter know either to send a new version or not. Sometimes I will
just make the changes myself to save the submitter some time.

Wei.

