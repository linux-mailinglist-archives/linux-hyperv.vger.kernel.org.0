Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47246E13E6
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Apr 2023 20:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDMSKi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 Apr 2023 14:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMSKh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 Apr 2023 14:10:37 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C769D30DA;
        Thu, 13 Apr 2023 11:10:36 -0700 (PDT)
Received: from skinsburskii.localdomain (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0BCD621779C8;
        Thu, 13 Apr 2023 11:10:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0BCD621779C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1681409436;
        bh=6YfKtjnCRgFmVE/Ca0ZyR4QZiE7Jis7k6H6rAsEAPZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S3Gvqc1RaHcz6snRbXHmQXTM0SYsvqF6oKohYBa/7Z3LmFcoJCmeLnxrr98lCB766
         3Msmz7+likaFw4hI6mtDPrDjYlo+Z1rG8z4f37PptiyClJvRc2351MYL1MKxdZBo17
         qwfYfpxymamCaFZQMh8xwCSViKCQS+f/fl6hiA2c=
Date:   Wed, 12 Apr 2023 09:36:16 -0700
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/hyperv: Expose an helper to map PCI interrupts
Message-ID: <20230412163616.GA1535@skinsburskii.localdomain>
References: <168079806973.14175.17999267023207421381.stgit@skinsburskii.localdomain>
 <168079870998.14175.16015623662679754647.stgit@skinsburskii.localdomain>
 <87o7nrzy9e.ffs@tglx>
 <20230412161951.GA894@skinsburskii.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412161951.GA894@skinsburskii.localdomain>
X-Spam-Status: No, score=-18.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 12, 2023 at 09:19:51AM -0700, Stanislav Kinsburskii wrote:
> On Thu, Apr 13, 2023 at 03:51:09PM +0200, Thomas Gleixner wrote:
> > On Thu, Apr 06 2023 at 09:33, Stanislav Kinsburskii wrote:
> > > This patch moves
> > 
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#submittingpatches
> > https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog
> > 
> 
> Thanks. I'll elaborate on the reationale in the next revision.
> 
> > > a part of currently internal logic into the new
> > > hv_map_msi_interrupt function and makes it globally available helper,
> > > which will be used to map PCI interrupts in case of root partition.
> > 
> > > -static int hv_map_msi_interrupt(struct pci_dev *dev, int cpu, int vector,
> > > -				struct hv_interrupt_entry *entry)
> > > +/**
> > > + * hv_map_msi_interrupt() - "Map" the MSI IRQ in the hypervisor.
> > 
> > So if you need to put "" on Map then maybe your function is
> > misnomed. Either it maps or it does not, right?
> > 
> 
> Thanks, I'll remove the quotation marks in the next update.
> 
> > > + * @data:      Describes the IRQ
> > > + * @out_entry: Hypervisor (MSI) interrupt entry (can be NULL)
> > > + *
> > > + * Map the IRQ in the hypervisor by issuing a MAP_DEVICE_INTERRUPT hypercall.
> > > + */
> > > +int hv_map_msi_interrupt(struct irq_data *data,
> > > +			 struct hv_interrupt_entry *out_entry)
> > >  {
> > > -	union hv_device_id device_id = hv_build_pci_dev_id(dev);
> > > +	struct msi_desc *msidesc;
> > > +	struct pci_dev *dev;
> > > +	union hv_device_id device_id;
> > > +	struct hv_interrupt_entry dummy, *entry;
> > > +	struct irq_cfg *cfg = irqd_cfg(data);
> > > +	const cpumask_t *affinity;
> > > +	int cpu, vector;
> > > +
> > > +	msidesc = irq_data_get_msi_desc(data);
> > > +	dev = msi_desc_to_pci_dev(msidesc);
> > > +	device_id = hv_build_pci_dev_id(dev);
> > > +	affinity = irq_data_get_effective_affinity_mask(data);
> > > +	cpu = cpumask_first_and(affinity, cpu_online_mask);
> > 
> > The effective affinity mask of MSI interrupts consists only of online
> > CPUs, to be accurate: it has exactly one online CPU set.
> > 
> > But even if it would have only offline CPUs then the result would be:
> > 
> >     cpu = nr_cpu_ids
> > 
> > which is definitely invalid. While a disabled vector targeted to an
> > offline CPU is not necessarily invalid.
> > 
> 
> Thank you for diving into this logic.
> 
> Although this patch only tosses the code and doens't make any functional
> changes, I guess if the fix for the the cpu is found has is required, it
> has to be in a separated patch.
> 
> Would you mind to elaborate more of the problem(s)?
> Do you mean that the result of cpumask_first_and has to be checked for not
> being >= nr_cpus_ids?
> Or do you mean there is no need to check the affinity against
> cpu_online_mask at all ans we can simply take any first bit from the
> effective affinity mask?
> 
> Also, could ou elaborate more on the disabled vector target to an
> offline CPU? Is there any use case for such scenario (in this case we
> might want to support it)?
> 
> I guess the goal of this code is to make sure that hypervisor on't be
> configured to deliver MSI to an online CPU.
> 

I'm sorry, there were a lot of typos.
Let me try again:

Thank you for diving into this logic.

Although this patch only tosses the code and doens't make any functional
changes, I guess if the fix for the used cpu id is required, it has to
be in a separated patch.

Would you mind to elaborate more of the problem(s)?
Do you mean that the result of cpumask_first_and has to be checked for not
being >= nr_cpus_ids?
Or do you mean that there is no need to check the irq affinity against
cpu_online_mask at all and we can simply take any first bit from the
effective affinity mask?

Also, could you elaborate more on the disabled vector targeting an
offline CPU? Is there any use case for such scenario (in this case we
might want to support it)?

I guess the goal of this code is to make sure that hypervisor won't be
configured to deliver an MSI to an offline CPU.

Thanks,
Stanislav

> Thanks,
> Stanislav
> 
> > Thanks,
> > 
> >         tglx
