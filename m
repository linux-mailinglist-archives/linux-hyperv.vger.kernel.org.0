Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5672B1EDC
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Nov 2020 16:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgKMPdn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 Nov 2020 10:33:43 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:39529 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMPdm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 Nov 2020 10:33:42 -0500
Received: by mail-wr1-f54.google.com with SMTP id o15so10352764wru.6;
        Fri, 13 Nov 2020 07:33:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gA1KPAigbuqo7QYg0x8mo1oWjdg2I5P+vvwNAb+YGgk=;
        b=G4U4jHlz7TMLlFkPOc2QNZdfT5hrEfFy8FvDXPl/nQaP+FOSd9FF6ejN3/WRf6RpOH
         I+TfomP/4IrrYMkoQwGkeNvl3PtYZTu40zp0Pio5lXZWA3NC8rCBYfIrpwWSkq/9tRCs
         UsFFSdimMR/QiwzFZ8yI30Grem8HapAoBFeRhTUDNj4k7IwtGGNDWMs/l2eJvWMP/8Gu
         rLZ7ckR9CmhjTcJZZc0gJRCf9NK5UuwnN9yFpb5hsixlTHLOCX9eNbaRrXGmRmjiCSk2
         ql/nZ8yLWi+j2PflQjIlT/JeRc2T9QPM7sM4bUFUNEmr7HqSVgC5ZtE7PRtpRMM81BhQ
         WU8g==
X-Gm-Message-State: AOAM532SESo6quYJe42Aj5SINQCMQmBcDph8RZP37xZ8UmbHO1ib3VlE
        ysTZk25tB6JRGxFY15LDKC0=
X-Google-Smtp-Source: ABdhPJzgHnYfKEQTelHs6ytElg4q8ljn/Vvj5EyLvy05cwv1SGzrFPy8D7LeJSA+015V0MjREJKZPw==
X-Received: by 2002:adf:8063:: with SMTP id 90mr4246564wrk.148.1605281615664;
        Fri, 13 Nov 2020 07:33:35 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id l16sm11234318wrx.5.2020.11.13.07.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 07:33:35 -0800 (PST)
Date:   Fri, 13 Nov 2020 15:33:33 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 08/17] x86/hyperv: handling hypercall page setup for
 root
Message-ID: <20201113153333.yt54enp5dbqjj5nu@liuwe-devbox-debian-v2>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-9-wei.liu@kernel.org>
 <874kluy3o2.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kluy3o2.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Nov 12, 2020 at 04:51:09PM +0100, Vitaly Kuznetsov wrote:
> Wei Liu <wei.liu@kernel.org> writes:
> 
> > When Linux is running as the root partition, the hypercall page will
> > have already been setup by Hyper-V. Copy the content over to the
> > allocated page.
> >
> > The suspend, resume and cleanup paths remain untouched because they are
> > not supported in this setup yet.
> 
> What about adding BUG_ONs there then?

I generally avoid cluttering code if I'm sure it definitely does not
work.

In any case, adding BUG_ONs is not the right answer. Both hv_suspend and
hv_resume can return an error code. I would rather just do

   if (hv_root_partition)
       return -EPERM;

in both places.

And also make hv_is_hibernation_supported return false when Linux is the
root partition.

> > +
> > +	if (hv_root_partition) {
> > +		struct page *pg;
> > +		void *src, *dst;
> > +
> > +		/*
> > +		 * For the root partition, the hypervisor will set up its
> > +		 * hypercall page. The hypervisor guarantees it will not show
> > +		 * up in the root's address space. The root can't change the
> > +		 * location of the hypercall page.
> > +		 *
> > +		 * Order is important here. We must enable the hypercall page
> > +		 * so it is populated with code, then copy the code to an
> > +		 * executable page.
> > +		 */
> > +		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> > +
> > +		pg = vmalloc_to_page(hv_hypercall_pg);
> > +		dst = kmap(pg);
> > +		src = memremap(hypercall_msr.guest_physical_address << PAGE_SHIFT, PAGE_SIZE,
> > +				MEMREMAP_WB);
> > +		BUG_ON(!(src && dst));
> > +		memcpy(dst, src, PAGE_SIZE);
> 
> Super-nit: while on x86 PAGE_SIZE always matches HV_HYP_PAGE_SIZE, would
> it be more accurate to use the later here?

Sure. That can be done.

Wei.
