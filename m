Return-Path: <linux-hyperv+bounces-2932-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA533968DA1
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Sep 2024 20:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BD1DB22D4D
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Sep 2024 18:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9124A1C62A8;
	Mon,  2 Sep 2024 18:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dn/8QSmL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EE019CC11;
	Mon,  2 Sep 2024 18:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302339; cv=none; b=oOGIs+mkAM+aX6JUlF+aRORcqKa80Ok8xLN2w45sfxnlhd6RTOvVAkyQlJX0VqjOueye6A4ymOXVA2Dj2uwxYwmYAFhP70IvwFlJK8O6u7QJz8+jH546/3IZf73VxO6zht1ZsomAxeKTHZ4pPfqU+IcrApRjSG5HiOkKOm1Zd+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302339; c=relaxed/simple;
	bh=uk7adA90J4zwNHlHrRTqEAmyf+IwyLytRkqXXWSNIow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQcjCBungk5ylp+WLf25UCxNnQZRu9I7GFgVeyPH/BZr+GxfBcYQtpRliBbc5C0/5b48KHcH9j7StUPHOoDqvWjlladrJG03XyCt9X0COWAo0Pnve+I5aBOL3aLLr7CBK2s4Ngy+SPKGIqcReuRmR4WRtWa9JzF4F0l6MPg6Ng8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dn/8QSmL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 7402920B7177; Mon,  2 Sep 2024 11:38:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7402920B7177
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1725302337;
	bh=PG1sLYF4c+um3BXrI8d4Ov1RYDUMMEXzsGo9Niw5cZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dn/8QSmLpHZ3Q2aAG8NFkrFNoQrPo7WXssTerVeVnJ+Hme3L6EArT3cDLANqipUif
	 iLE8rB6+zLDsn2TwY8+4+IVmYnlxrTrL+ZQyQ2iN4d9ewqrum9oD6gHlnKvDSwduDE
	 XUWbsvvtR6sVqkr/F+6ewQpyqbLDpE4ZzOmg/k0A=
Date: Mon, 2 Sep 2024 11:38:57 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Yunhong Jiang <yunhong.jiang@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 5/9] x86/hyperv: Mark ACPI wakeup mailbox page as
 private
Message-ID: <20240902183857.GA11785@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240823232327.2408869-1-yunhong.jiang@linux.intel.com>
 <20240823232327.2408869-6-yunhong.jiang@linux.intel.com>
 <BN7PR02MB4148A328FA019239196CFB15D4922@BN7PR02MB4148.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN7PR02MB4148A328FA019239196CFB15D4922@BN7PR02MB4148.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Sep 02, 2024 at 03:35:18AM +0000, Michael Kelley wrote:
> From: Yunhong Jiang <yunhong.jiang@linux.intel.com> Sent: Friday, August 23, 2024 4:23 PM
> > 
> > Current code maps MMIO devices as shared (decrypted) by default in a
> > confidential computing VM. However, the wakeup mailbox must be accessed
> > as private (encrypted) because it's accessed by the OS and the firmware,
> > both are in the guest's context and encrypted. Set the wakeup mailbox
> > range as private explicitly.
> > 
> > Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > ---
> >  arch/x86/hyperv/hv_vtl.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> > index 04775346369c..987a6a1200b0 100644
> > --- a/arch/x86/hyperv/hv_vtl.c
> > +++ b/arch/x86/hyperv/hv_vtl.c
> > @@ -22,10 +22,26 @@ static bool __init hv_vtl_msi_ext_dest_id(void)
> >  	return true;
> >  }
> > 
> > +static inline bool within_page(u64 addr, u64 start)
> > +{
> > +	return addr >= start && addr < (start + PAGE_SIZE);
> > +}
> > +
> > +/*
> > + * The ACPI wakeup mailbox are accessed by the OS and the BIOS, both are in the
> > + * guest's context, instead of the hypervisor/VMM context.
> > + */
> > +static bool hv_is_private_mmio_tdx(u64 addr)
> > +{
> > +	return wakeup_mailbox_addr && within_page(addr, wakeup_mailbox_addr);
> > +}
> > +
> >  void __init hv_vtl_init_platform(void)
> >  {
> >  	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
> > 
> > +	if (hv_isolation_type_tdx())
> > +		x86_platform.hyper.is_private_mmio = hv_is_private_mmio_tdx;
> 
> hv_vtl_init_platform() is unconditionally called in
> ms_hyperv_init_platform(). So in the case of a normal TDX guest
> running with a paravisor on Hyper-V, the above code will overwrite
> the is_private_mmio function that was set in hv_vtom_init(). Then
> the mapping of the emulated IOAPIC and TPM provided by the
> paravisor won't be correct.
> 
> Michael

non-VTL Hyper-V platforms are expected to disable CONFIG_HYPERV_VTL_MODE,
that means for a normal TDX guest hv_vtl_init_platform will be an empty
stub. Have I missed anything ?

- Saurabh

