Return-Path: <linux-hyperv+bounces-1433-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB9182D01D
	for <lists+linux-hyperv@lfdr.de>; Sun, 14 Jan 2024 10:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F88D1C20DAE
	for <lists+linux-hyperv@lfdr.de>; Sun, 14 Jan 2024 09:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CCE1FA5;
	Sun, 14 Jan 2024 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WZh0HSUh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F741C17;
	Sun, 14 Jan 2024 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id DBD0720C80B9; Sun, 14 Jan 2024 01:24:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DBD0720C80B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1705224270;
	bh=8BKEv879DQ/t/fqtxbNzOd/OELYyxrygiQU/Tuj80Dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WZh0HSUhKTUM4BQXCarsMaJa6wUVji3H7VVPOAaABsvGyW3qFlRHZ4SUunxluj0HN
	 jJcGQl5AVyIWxHD9hUE4waVNe5EklQzgSMieGDRg1vNrhJz5bDNURtK6LA53/mi/Hj
	 skVs7KBhHHddFXCccvzW0Jv98dYjuQ9TVWDK7obc=
Date: Sun, 14 Jan 2024 01:24:30 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ssengar@microsoft.com" <ssengar@microsoft.com>
Subject: Re: [PATCH] x86/hyperv: Allow 15-bit APIC IDs for VTL platforms
Message-ID: <20240114092430.GA13684@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1704450566-26576-1-git-send-email-ssengar@linux.microsoft.com>
 <SN6PR02MB415740C3EE66618A37A658EED4692@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB415740C3EE66618A37A658EED4692@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Jan 10, 2024 at 05:10:47AM +0000, Michael Kelley wrote:
> From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Friday, January 5, 2024 2:29 AM
> > 
> > The current method for signaling the compatibility of a Hyper-V host
> > with MSIs featuring 15-bit APIC IDs relies on a synthetic cpuid leaf.
> > However, for higher VTLs, this leaf is not reported, due to the absence
> > of an IO-APIC.
> > 
> > As an alternative, assume that when running at a high VTL, the host
> > supports 15-bit APIC IDs. This assumption is now deemed safe, as no
> > architectural MSIs are employed at higher VTLs.
> 
> I'm trying to fully understand this last sentence.  It has the words
> "now" and "deemed" as qualifiers.  Can you say anything more about
> why "now" (implying it wasn't safe at some point in the past)?
> And what are the implications of "deemed"?  Or are both just
> wordiness, and it would be just as good to say "This assumption is safe,
> as Hyper-V does not employ any architectural MSIs at higher VTLs." ?
> 
> The code LGTM.

Thank you for your review. Your phrasing appears better to me. I will revise
the commit message as per your suggestions and submit V2.

- Saurabh

> 
> Michael
> 
> > 
> > This unblocks startup of VTL2 environments with more than 256 CPUs.
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  arch/x86/hyperv/hv_vtl.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> > index 539c7b5cfa2b..1c225362f88e 100644
> > --- a/arch/x86/hyperv/hv_vtl.c
> > +++ b/arch/x86/hyperv/hv_vtl.c
> > @@ -16,6 +16,11 @@
> >  extern struct boot_params boot_params;
> >  static struct real_mode_header hv_vtl_real_mode_header;
> > 
> > +static bool __init hv_vtl_msi_ext_dest_id(void)
> > +{
> > +	return true;
> > +}
> > +
> >  void __init hv_vtl_init_platform(void)
> >  {
> >  	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
> > @@ -39,6 +44,8 @@ void __init hv_vtl_init_platform(void)
> >  	x86_platform.legacy.warm_reset = 0;
> >  	x86_platform.legacy.reserve_bios_regions = 0;
> >  	x86_platform.legacy.devices.pnpbios = 0;
> > +
> > +	x86_init.hyper.msi_ext_dest_id = hv_vtl_msi_ext_dest_id;
> >  }
> > 
> >  static inline u64 hv_vtl_system_desc_base(struct ldttss_desc *desc)
> > --
> > 2.25.1
> > 
> 

