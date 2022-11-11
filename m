Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02C16265A6
	for <lists+linux-hyperv@lfdr.de>; Sat, 12 Nov 2022 00:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbiKKXkh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Nov 2022 18:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbiKKXkh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Nov 2022 18:40:37 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FEE56EEE;
        Fri, 11 Nov 2022 15:40:35 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id v1so8213115wrt.11;
        Fri, 11 Nov 2022 15:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlcGK8A42uTLjnC4qIGq0gSLwjbRDelBmakeUFtzO1A=;
        b=FYKyKK7LTKSEoGge36tqgsyjyhdfsQ0+6dLTuQWHBzSG8tWLY/o1uguUHL+JxAxL6v
         0jC36LaUsMOOs6Nd7ymrY2f+JwHNhgucKKJrVYVfNym1NlkDifMnWbCV8uDtK50vg3Lv
         fdLns0uQZhYjAInpspiDcds+JRl2QrDE4D0m8qtpg/TC6IqIaD26fh/UH9eXYUDzPd06
         lBOg8FQfPCXRfnWUY8CJDYGRo4ih7GHGiy9fT9cmsXe2uXbvsrzm8gSrt9PG3FdRwewu
         0ekB5khnyHbevk7KGM0qeBNfYbJ78PGG7CednQVoZ083RIINQYMXrQ2YpGGqwD2e9GPG
         SPcA==
X-Gm-Message-State: ANoB5pmhgzpy62skxM66tsNMOrGQmAoGn7uPwzU+wvA3CiRXjeifMqEM
        AmqhsuPmj5SgZCSUk9ltmQ4=
X-Google-Smtp-Source: AA0mqf63qOKFM80R6/HcnYCshIFh+n0i7zBPgoH1oIFFPzAgbcL3WY+tAO/luOB3EFkDLFvZkstD1g==
X-Received: by 2002:adf:e308:0:b0:234:2620:1785 with SMTP id b8-20020adfe308000000b0023426201785mr2574238wrj.275.1668210034305;
        Fri, 11 Nov 2022 15:40:34 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c7-20020a1c3507000000b003c6f1732f65sm9295511wma.38.2022.11.11.15.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 15:40:33 -0800 (PST)
Date:   Fri, 11 Nov 2022 23:40:31 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Dexuan Cui <decui@microsoft.com>, quic_jhugo@quicinc.com,
        quic_carlv@quicinc.com, wei.liu@kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, robh@kernel.org, kw@linux.com,
        helgaas@kernel.org, alex.williamson@redhat.com,
        boqun.feng@gmail.com, Boqun.Feng@microsoft.com
Subject: Re: [PATCH v3] PCI: hv: Only reuse existing IRTE allocation for
 Multi-MSI
Message-ID: <Y27db98OD9Kpjcoe@liuwe-devbox-debian-v2>
References: <20221104222953.11356-1-decui@microsoft.com>
 <Y24cTE9+bqXtHics@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y24cTE9+bqXtHics@lpieralisi>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Nov 11, 2022 at 10:56:28AM +0100, Lorenzo Pieralisi wrote:
> On Fri, Nov 04, 2022 at 03:29:53PM -0700, Dexuan Cui wrote:
> > Jeffrey added Multi-MSI support to the pci-hyperv driver by the 4 patches:
> > 08e61e861a0e ("PCI: hv: Fix multi-MSI to allow more than one MSI vector")
> > 455880dfe292 ("PCI: hv: Fix hv_arch_irq_unmask() for multi-MSI")
> > b4b77778ecc5 ("PCI: hv: Reuse existing IRTE allocation in compose_msi_msg()")
> > a2bad844a67b ("PCI: hv: Fix interrupt mapping for multi-MSI")
> > 
> > It turns out that the third patch (b4b77778ecc5) causes a performance
> > regression because all the interrupts now happen on 1 physical CPU (or two
> > pCPUs, if one pCPU doesn't have enough vectors). When a guest has many PCI
> > devices, it may suffer from soft lockups if the workload is heavy, e.g.,
> > see https://lwn.net/ml/linux-kernel/20220804025104.15673-1-decui@microsoft.com/
> > 
> > Commit b4b77778ecc5 itself is good. The real issue is that the hypercall in
> > hv_irq_unmask() -> hv_arch_irq_unmask() ->
> > hv_do_hypercall(HVCALL_RETARGET_INTERRUPT...) only changes the target
> > virtual CPU rather than physical CPU; with b4b77778ecc5, the pCPU is
> > determined only once in hv_compose_msi_msg() where only vCPU0 is specified;
> > consequently the hypervisor only uses 1 target pCPU for all the interrupts.
> > 
> > Note: before b4b77778ecc5, the pCPU is determined twice, and when the pCPU
> > is determinted the second time, the vCPU in the effective affinity mask is
> > used (i.e., it isn't always vCPU0), so the hypervisor chooses different
> > pCPU for each interrupt.
> > 
> > The hypercall will be fixed in future to update the pCPU as well, but
> > that will take quite a while, so let's restore the old behavior in
> > hv_compose_msi_msg(), i.e., don't reuse the existing IRTE allocation for
> > single-MSI and MSI-X; for multi-MSI, we choose the vCPU in a round-robin
> > manner for each PCI device, so the interrupts of different devices can
> > happen on different pCPUs, though the interrupts of each device happen on
> > some single pCPU.
> > 
> > The hypercall fix may not be backported to all old versions of Hyper-V, so
> > we want to have this guest side change for ever (or at least till we're sure
> > the old affected versions of Hyper-V are no longer supported).
> > 
> > Fixes: b4b77778ecc5 ("PCI: hv: Reuse existing IRTE allocation in compose_msi_msg()")
> > Co-developed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > Co-developed-by: Carl Vanderlip <quic_carlv@quicinc.com>
> > Signed-off-by: Carl Vanderlip <quic_carlv@quicinc.com>
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > 
> > ---
> > 
> > v1 is here:
> >   https://lwn.net/ml/linux-kernel/20220804025104.15673-1-decui@microsoft.com/
> > 
> > Changes in v2:
> >   round-robin the vCPU for multi-MSI.
> >   The commit message is re-worked.
> >   Added Jeff and Carl's Co-developed-by and Signed-off-by.
> > 
> > Changes in v3:
> >   Michael Kelley kindly helped to make a great comment, and I added the
> >   comment before hv_compose_msi_req_get_cpu(). Thank you, Michael!
> > 
> >   Rebased to Hyper-V tree's "hyperv-fixes" branch:
> >       https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-fixes
> > 
> >   Bjorn, Lorenzo, it would be great to have your Ack. The patch needs to go
> >   through the Hyper-V tree because it's rebased to another hv_pci patch (which
> >   only exists in the Hyper-V tree for now):
> >       e70af8d040d2 ("PCI: hv: Fix the definition of vector in hv_compose_msi_msg()") 
> > 
> >   BTW, Michael has some other hv_pci patches, which would also need go through
> >       the Hyper-V tree:
> >       https://lwn.net/ml/linux-kernel/1666288635-72591-1-git-send-email-mikelley%40microsoft.com/
> > 
> > 
> >  drivers/pci/controller/pci-hyperv.c | 90 ++++++++++++++++++++++++-----
> >  1 file changed, 75 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index ba64284eaf9f..fa5a1ba35a82 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -1613,7 +1613,7 @@ static void hv_pci_compose_compl(void *context, struct pci_response *resp,
> >  }
> >  
> >  static u32 hv_compose_msi_req_v1(
> > -	struct pci_create_interrupt *int_pkt, const struct cpumask *affinity,
> > +	struct pci_create_interrupt *int_pkt,
> >  	u32 slot, u8 vector, u16 vector_count)
> >  {
> >  	int_pkt->message_type.type = PCI_CREATE_INTERRUPT_MESSAGE;
> > @@ -1631,6 +1631,35 @@ static u32 hv_compose_msi_req_v1(
> >  	return sizeof(*int_pkt);
> >  }
> >  
> > +/*
> > + * The vCPU selected by hv_compose_multi_msi_req_get_cpu() and
> > + * hv_compose_msi_req_get_cpu() is a "dummy" vCPU because the final vCPU to be
> > + * interrupted is specified later in hv_irq_unmask() and communicated to Hyper-V
> > + * via the HVCALL_RETARGET_INTERRUPT hypercall. But the choice of dummy vCPU is
> > + * not irrelevant because Hyper-V chooses the physical CPU to handle the
> > + * interrupts based on the vCPU specified in message sent to the vPCI VSP in
> > + * hv_compose_msi_msg(). Hyper-V's choice of pCPU is not visible to the guest,
> > + * but assigning too many vPCI device interrupts to the same pCPU can cause a
> > + * performance bottleneck. So we spread out the dummy vCPUs to influence Hyper-V
> > + * to spread out the pCPUs that it selects.
> > + *
> > + * For the single-MSI and MSI-X cases, it's OK for hv_compose_msi_req_get_cpu()
> > + * to always return the same dummy vCPU, because a second call to
> > + * hv_compose_msi_msg() contains the "real" vCPU, causing Hyper-V to choose a
> > + * new pCPU for the interrupt. But for the multi-MSI case, the second call to
> > + * hv_compose_msi_msg() exits without sending a message to the vPCI VSP, so the
> 
> Why ? Can't you fix _that_ ? Why can't the initial call to
> hv_compose_msi_msg() determine the _real_ target vCPU ?

Dexuan, any comment on this?

> 
> > + * original dummy vCPU is used. This dummy vCPU must be round-robin'ed so that
> > + * the pCPUs are spread out. All interrupts for a multi-MSI device end up using
> > + * the same pCPU, even though the vCPUs will be spread out by later calls
> > + * to hv_irq_unmask(), but that is the best we can do now.
> > + *
> > + * With current Hyper-V, the HVCALL_RETARGET_INTERRUPT hypercall does *not*
> 
> "current" Hyper-V means nothing, remove it or provide versioning
> information. Imagine yourself reading this comment some time
> in the future.
> 

And this?

Wei.
