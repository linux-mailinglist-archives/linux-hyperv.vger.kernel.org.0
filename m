Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBE51C6EEF
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 May 2020 13:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgEFLJw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 May 2020 07:09:52 -0400
Received: from foss.arm.com ([217.140.110.172]:34104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728052AbgEFLJv (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 May 2020 07:09:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EC111FB;
        Wed,  6 May 2020 04:09:50 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 196F23F71F;
        Wed,  6 May 2020 04:09:48 -0700 (PDT)
Date:   Wed, 6 May 2020 12:09:39 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Wei Hu <weh@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v2 1/2] PCI: hv: Fix the PCI HyperV probe failure path to
 release resource properly
Message-ID: <20200506110930.GA31068@e121166-lin.cambridge.arm.com>
References: <20200501053617.24689-1-weh@microsoft.com>
 <20200505150315.GA16228@e121166-lin.cambridge.arm.com>
 <SG2P153MB02136EA9764D340F3D81DF2DBBA40@SG2P153MB0213.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SG2P153MB02136EA9764D340F3D81DF2DBBA40@SG2P153MB0213.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, May 06, 2020 at 05:36:46AM +0000, Wei Hu wrote:
> Hi Lorenzo,
> 
> Thanks for your review. Please see my comments inline. 
> 
> > -----Original Message-----
> > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Sent: Tuesday, May 5, 2020 11:03 PM
> > To: Wei Hu <weh@microsoft.com>
> > Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> > wei.liu@kernel.org; robh@kernel.org; bhelgaas@google.com; linux-
> > hyperv@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Dexuan Cui <decui@microsoft.com>; Michael Kelley
> > <mikelley@microsoft.com>
> > Subject: Re: [PATCH v2 1/2] PCI: hv: Fix the PCI HyperV probe failure path to
> > release resource properly
> > 
> > On Fri, May 01, 2020 at 01:36:17PM +0800, Wei Hu wrote:
> > > Some error cases in hv_pci_probe() were not handled. Fix these error
> > > paths to release the resourses and clean up the state properly.
> > 
> > This patch does more than that. It adds a variable to store the number of slots
> > actually allocated - I presume to free only allocated on slots on the exit path.
> > 
> > Two patches required I am afraid.
> 
> Well, adding this variable is needed to make the call of "(void) hv_pci_bus_exit(hdev, true)" 

I don't understand why - it is not clear from the commit log and the
code, please explain it since it is not obvious.

> at the end to work and clean up the PCI state in the failure path. Just adding this variable
> would not make any changes. So I think it may be better to put them in single patch?
> 
> > 
> > > Signed-off-by: Wei Hu <weh@microsoft.com>
> > > ---
> > >  drivers/pci/controller/pci-hyperv.c | 20 ++++++++++++++++----
> > >  1 file changed, 16 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pci-hyperv.c
> > > b/drivers/pci/controller/pci-hyperv.c
> > > index e15022ff63e3..e6fac0187722 100644
> > > --- a/drivers/pci/controller/pci-hyperv.c
> > > +++ b/drivers/pci/controller/pci-hyperv.c
> > > @@ -480,6 +480,9 @@ struct hv_pcibus_device {
> > >
> > >  	struct workqueue_struct *wq;
> > >
> > > +	/* Highest slot of child device with resources allocated */
> > > +	int wslot_res_allocated;
> > 
> > I don't understand why you need an int rather than a u32.
> > 
> > Furthermore, I think a bitmap is more appropriate for what this variable is used
> > for.
> 
> So it can use a negative value (-1 in this case) to indicated none of any resources
> has been allocated. Currently value between 0-255 indicating some resources 
> have been allocated. Of course I can use 0xffffffff to indicate that if it were u32. But
> it wouldn't make much difference, would it?

It is fine by me - I would not have written it this way but it does
not matter.

> It would take 32 bytes for total 256 child slots in bitmap, while it only takes 4 bytes 
> using int. It is not in critical path so scanning from the location one by one is not a big
> deal.

I suggested a bitmap for correctness - a slot number may include slots
that as far as I can read the code failed get_pcichild_slot().

It is not clear what this patch is doing in this loop, that's certain.

> > 
> > > +
> > >  	/* hypercall arg, must not cross page boundary */
> > >  	struct hv_retarget_device_interrupt retarget_msi_interrupt_params;
> > >
> > > @@ -2847,7 +2850,7 @@ static int hv_send_resources_allocated(struct
> > hv_device *hdev)
> > >  	struct hv_pci_dev *hpdev;
> > >  	struct pci_packet *pkt;
> > >  	size_t size_res;
> > > -	u32 wslot;
> > > +	int wslot;
> > >  	int ret;
> > >
> > >  	size_res = (hbus->protocol_version < PCI_PROTOCOL_VERSION_1_2)
> > @@
> > > -2900,6 +2903,8 @@ static int hv_send_resources_allocated(struct hv_device
> > *hdev)
> > >  				comp_pkt.completion_status);
> > >  			break;
> > >  		}
> > > +
> > > +		hbus->wslot_res_allocated = wslot;
> > >  	}
> > >
> > >  	kfree(pkt);
> > > @@ -2918,10 +2923,10 @@ static int hv_send_resources_released(struct
> > hv_device *hdev)
> > >  	struct hv_pcibus_device *hbus = hv_get_drvdata(hdev);
> > >  	struct pci_child_message pkt;
> > >  	struct hv_pci_dev *hpdev;
> > > -	u32 wslot;
> > > +	int wslot;
> > >  	int ret;
> > >
> > > -	for (wslot = 0; wslot < 256; wslot++) {
> > > +	for (wslot = hbus->wslot_res_allocated; wslot >= 0; wslot--) {
> > >  		hpdev = get_pcichild_wslot(hbus, wslot);
> > >  		if (!hpdev)
> > >  			continue;
> > > @@ -2936,8 +2941,12 @@ static int hv_send_resources_released(struct
> > hv_device *hdev)
> > >  				       VM_PKT_DATA_INBAND, 0);
> > >  		if (ret)
> > >  			return ret;
> > > +
> > > +		hbus->wslot_res_allocated = wslot - 1;
> > 
> > Do you really need to set it at every loop iteration ?
> > 
> > Moreover, I think a bitmap is better suited for what you are doing, given that
> > you may skip some loop indexes on !hpdev.
> >
> The value is set in the loop whenever a resource was successfully released. It could
> happen that it failed in the next iteration so the last one which had succeeded would be
> recorded in this variable. It is needed  at the end of loop when this 
> iteration succeeds. 

Ok understood.

> Once again since it is not in the critical path, just using an signed integer is straightforward, 
> less error prone and a bit easier to maintain than bitmap in my opinion. 😊
>  

Less error prone, not sure, see above - it is your code so you choose
but please explain this change better, it is not obvious.

> > >  	}
> > >
> > > +	hbus->wslot_res_allocated = -1;
> > > +
> > >  	return 0;
> > >  }
> > >
> > > @@ -3037,6 +3046,7 @@ static int hv_pci_probe(struct hv_device *hdev,
> > >  	if (!hbus)
> > >  		return -ENOMEM;
> > >  	hbus->state = hv_pcibus_init;
> > > +	hbus->wslot_res_allocated = -1;
> > >
> > >  	/*
> > >  	 * The PCI bus "domain" is what is called "segment" in ACPI and
> > > other @@ -3136,7 +3146,7 @@ static int hv_pci_probe(struct hv_device
> > > *hdev,
> > >
> > >  	ret = hv_pci_allocate_bridge_windows(hbus);
> > >  	if (ret)
> > > -		goto free_irq_domain;
> > > +		goto exit_d0;
> > >
> > >  	ret = hv_send_resources_allocated(hdev);
> > >  	if (ret)
> > > @@ -3154,6 +3164,8 @@ static int hv_pci_probe(struct hv_device *hdev,
> > >
> > >  free_windows:
> > >  	hv_pci_free_bridge_windows(hbus);
> > > +exit_d0:
> > > +	(void) hv_pci_bus_exit(hdev, true);
> > 
> > Remove the (void) cast.
> > 
> 
> Some tools (maybe lint?) could generate error/warning messages assuming the code fails 
> to check the return value without such cast. Leaving the cast in place just indicates that
> the return value is deliberately ignored.  

I understand that - the question is why it is OK to ignore it in this
specific case.

Maybe adding a wrapper around hv_pci_bus_exit() can help, I am fine with
it, just trying to help.

Lorenzo
