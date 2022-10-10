Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F155FA269
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Oct 2022 19:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJJRFl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 10 Oct 2022 13:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJJRFk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 10 Oct 2022 13:05:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503A118389
        for <linux-hyperv@vger.kernel.org>; Mon, 10 Oct 2022 10:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665421537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PIyB/HY40+8TeBToBpv65MXDYl/DWNxmK/k3JvGCIiE=;
        b=TzQW09gh3Q3ICHuHAwjmKdu1VEPcmuMmwCbYsqtFcA1WR+hVs/quPKSdMLTlsFqqlGL6N1
        izCDRXG/WuVPwS7d/hV20rP4Z+O0unbE5vK2M6vbTjx5u4jQuOOuLmmhSfIFhej735TayX
        pBBVsmJH6zuoR3jEsZfho8gN3nLSxDk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-231-7DDLQY7KNlaDNZ0LjZ59mQ-1; Mon, 10 Oct 2022 13:05:36 -0400
X-MC-Unique: 7DDLQY7KNlaDNZ0LjZ59mQ-1
Received: by mail-wm1-f70.google.com with SMTP id v191-20020a1cacc8000000b003bdf7b78dccso7265965wme.3
        for <linux-hyperv@vger.kernel.org>; Mon, 10 Oct 2022 10:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PIyB/HY40+8TeBToBpv65MXDYl/DWNxmK/k3JvGCIiE=;
        b=Tft8K8FniycnQH9eVGTQvsrKXcpIV62DFI3CdFZLAldr0EwS293hiIJ/jEEOeWOcJL
         AICCIPn7Q6RVglf0ZL9+nxABlFMrc/EoaohIAx7FWJ7gmKgQbvOH/3htRzrrfNTl0PYk
         lYOascPVImKjpQkCffEU/UTsKIlPAzCh0pziETwYsBbE2yj1Kf8pHGqusu/Z8ZC2dAXw
         utooP24S1PIpIlJc1gfYyBvR2RcE1vlGQdnMmFBv0sVT97Dryqb3/ro6NzDDBzwO4tfy
         MYi4VU16YEoCe0pAE35UZN5UXkfRQmCDd2B0mxYnG68pwXOZBCr2jEn3FJIZyqbv/OWm
         UNHw==
X-Gm-Message-State: ACrzQf0MQbm9FACAbrCGGW2w6u2DwMnWRL3asPrNlPpcK9ko2qwwZlqX
        LWlsDQF+Suphe6XOGi1hxD+4bDpNKuBBJLpq6jb0MetPwvt/sewxDLQeOMWdt+L7LOc2mIB49dI
        /Se3zmUQ6v9if40Y/mehd/h5A
X-Received: by 2002:a05:6000:551:b0:22e:4499:a478 with SMTP id b17-20020a056000055100b0022e4499a478mr12211618wrf.459.1665421535012;
        Mon, 10 Oct 2022 10:05:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6MDzV9L01F029gTj1ssLnHEx3xEyweFq79VqCpbwfJHiOCzNf0Eeex8rsDJwqhIumi3/kkGQ==
X-Received: by 2002:a05:6000:551:b0:22e:4499:a478 with SMTP id b17-20020a056000055100b0022e4499a478mr12211606wrf.459.1665421534723;
        Mon, 10 Oct 2022 10:05:34 -0700 (PDT)
Received: from redhat.com ([2.55.183.131])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c089300b003c5571c27a1sm7263313wmp.32.2022.10.10.10.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 10:05:34 -0700 (PDT)
Date:   Mon, 10 Oct 2022 13:05:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Alexander Graf <graf@amazon.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ajay Kaher <akaher@vmware.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "jailhouse-dev@googlegroups.com" <jailhouse-dev@googlegroups.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2] x86/PCI: Prefer MMIO over PIO on all hypervisor
Message-ID: <20221010130413-mutt-send-email-mst@kernel.org>
References: <9FEC6622-780D-41E6-B7CA-8D39EDB2C093@vmware.com>
 <87zgf3pfd1.fsf@redhat.com>
 <B64FD502-E794-4E94-A267-D690476C57EE@vmware.com>
 <87tu4l9cfm.fsf@redhat.com>
 <04F550C5-786A-4B8E-9A88-EBFBD8872F16@vmware.com>
 <f1a7e603-2e64-fd2a-1100-f2898060e3f7@amazon.com>
 <DF8775A4-5332-412C-9359-749E96E83907@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DF8775A4-5332-412C-9359-749E96E83907@vmware.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Oct 04, 2022 at 06:48:11PM +0000, Nadav Amit wrote:
> On Oct 4, 2022, at 1:22 AM, Alexander Graf <graf@amazon.com> wrote:
> 
> > ⚠ External Email
> > 
> > Hey Nadav,
> > 
> > On 03.10.22 19:34, Nadav Amit wrote:
> >> On Oct 3, 2022, at 8:03 AM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >> 
> >>> Not my but rather PCI maintainer's call but IMHO dropping 'const' is
> >>> better, introducing a new global var is our 'last resort' and should be
> >>> avoided whenever possible. Alternatively, you can add a
> >>> raw_pci_ext_ops_preferred() function checking somethin within 'struct
> >>> hypervisor_x86' but I'm unsure if it's better.
> >>> 
> >>> Also, please check Alex' question/suggestion.
> >> Here is my take (and Ajay knows probably more than me):
> >> 
> >> Looking briefly on MCFG, I do not see a clean way of using the ACPI table.
> >> The two options are either to use a reserved field (which who knows, might
> >> be used one day) or some OEM ID. I am also not familiar with
> >> PCI_COMMAND.MEMORY=0, so Ajay can hopefully give some answer about that.
> >> 
> >> Anyhow, I understand (although not relate) to the objection for a new global
> >> variable. How about explicitly calling this hardware bug a “bug” and using
> >> the proper infrastructure? Calling it explicitly a bug may even push whoever
> >> can to resolve it.
> > 
> > 
> > I am a lot more concerned with how we propagate it externally than
> > within Linux. If we hard code that all Linux kernels 6.2+ that are
> > running in VMware prefer ECAM over PIO, we lock ourselves into that
> > stance for better or worse, which means:
> > 
> > * All past and future versions of any VMware hypervisor product have to
> > always allow ECAM access for any PCIe config space write
> > * No other hypervisor benefits from any of this without upstream code change
> > * No real hardware platform benefits from this without upstream code change
> > 
> > By moving it into MCFG, we can create a path for the outside environment
> > to tell the OS whether it's safe to use ECAM always. This obviously
> > doesn't work with MCFG as it stands today, we'd have to propose an MCFG
> > spec change to the PCI SIG's "PCI Firmware Specification" to add the
> > respective field. Future VMware versions could then always expose the
> > flag - and if you find it broken, remove it again.
> > 
> > Putting all of the logic on which system potentially prefers ECAM over
> > PIO config space access into Linux is just a big hack that we should
> > avoid as much as possible.
> 
> Thanks Alex. You raise important points. Let me try to break down your
> concerns slightly differently:
> 
> 1. Enabling MMIO access should be selective, and potentially controlled by
> the hypervisor. The very least a "chicken-bit” is needed.
> 
> 2. PCI SIG would change its specifications to address unclear hardware bug.
> 
> I think (1) makes sense and we can discuss different ways of addressing it.
> But (2) would not happen in a reasonable timeline and seems to me as an
> unnecessary complication.
> 
> But before we discuss how to address the issue, perhaps we need to first
> understand it better. I am not sure that I understand this MMIO bug, and so
> far nobody was able to provide exact details.
> 
> So I went to have a look. It might not be super helpful, but for the record,
> here is what I collected.
> 
> First, we have commit d6ece5491ae71d ("i386/x86-64 Correct for broken MCFG
> tables on K8 systems”). It tried to "try to discover all devices on bus 0
> that are unreachable using MM and fallback for them.” Interestingly, it
> seems similar to FreeBSD code (commit 2d10570afe2b3e) that also mentions K8
> and has similar detection logic in FreeBSD’s pcie_cfgregopen().
> 
> Then commit a0ca9909609470 ("PCI x86: always use conf1 to access config
> space below 256 bytes”). The correspondence [1] mentions some bugs: ATI
> chipset, VIA chipset, Intel 3 Series Express chipset family and some reports
> on Nvidia. It turned out some devices had problem probing - to figure out if
> MMIO is broken - the way the previous patch did.

There's also a statement by Linus that MCFG might not cover all buses
in that thread.  I didn't think the implications through yet ...

> All of these bugs are circa 2008, of course. And note that FreeBSD did not
> take a similar path. The correspondence around Linux patch is endless. I
> admit that I did not understand whether eventually the issues were found to
> be per-bus or per-device.
> 
> 
> Back to the matter at hand. The benefit of using the MCFG approach that you
> propose is that it can enable native systems to use MMIO as well. However,
> since the list of bugs is unclear and the problems might be device-specific,
> it is not clear what information BIOSes have that Linux doesn’t. In other
> words, the benefit of getting it into the specifications is questionable,
> and the complexity+time is high.
> 
> Can we agree that the feature would be enabled explicitly by the hypervisor
> and Linux would enable it based on the hypervisor input (through some
> channel?)
> 
> Thanks,
> Nadav
> 
> [1] https://lore.kernel.org/all/20080112144030.GA19279@jurassic.park.msu.ru/T/#u

