Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142401C742E
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 May 2020 17:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgEFPVe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 May 2020 11:21:34 -0400
Received: from foss.arm.com ([217.140.110.172]:38946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729264AbgEFPVd (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 May 2020 11:21:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2E2CD6E;
        Wed,  6 May 2020 08:21:32 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BA333F68F;
        Wed,  6 May 2020 08:21:31 -0700 (PDT)
Date:   Wed, 6 May 2020 16:21:26 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Wei Hu <weh@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v2 1/2] PCI: hv: Fix the PCI HyperV probe failure path to
 release resource properly
Message-ID: <20200506152126.GA2911@e121166-lin.cambridge.arm.com>
References: <20200501053617.24689-1-weh@microsoft.com>
 <20200505150315.GA16228@e121166-lin.cambridge.arm.com>
 <SG2P153MB02136EA9764D340F3D81DF2DBBA40@SG2P153MB0213.APCP153.PROD.OUTLOOK.COM>
 <20200506110930.GA31068@e121166-lin.cambridge.arm.com>
 <SG2P153MB0213216D3C150AA4758FCBB8BBA40@SG2P153MB0213.APCP153.PROD.OUTLOOK.COM>
 <MW2PR2101MB1052F033623F91A0FF991DE4D7A40@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB1052F033623F91A0FF991DE4D7A40@MW2PR2101MB1052.namprd21.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, May 06, 2020 at 02:55:17PM +0000, Michael Kelley wrote:

[...]

> > Hv_pci_bus_exit() calls hv_send_resources_released() to release all child resources.
> > These child resources were allocated in hv_send_resources_allocated().
> > Hv_send_resources_allocated() could fail in the middle, leaving some child resources
> > allocated and rest not. Without adding this variable to record the highest slot number that
> > resource has been successfully allocated, calling hv_send_resources_released() could
> > cause spurious resource release requests being sent to hypervisor.
> > 
> > This had been fine since hv_pci_bus_exit() was never called in error path before this patch
> > was
> > introduced. To add this call to clean the pci state in the error path, we need to know the
> > starting
> > point in child device that resource has not been allocated. Hence this variable
> > is used in hv_send_resources_allocated() to record this point and in
> > hv_send_resource_released() to start deallocating child resources.
> > 
> > I can add to the commit log if you are fine with this explanation.
> > 
> 
> FWIW, I think of this patch as follows:
> 
> In some error cases in hv_pci_probe(), allocated resources are not
> freed.  Fix this by adding a field to keep track of the high water mark
> for slots that have resources allocated to them.  In case of an error, this
> high water mark is used to know which slots have resources that
> must be released.  Since slots are numbered starting with zero, a
> value of -1 indicates no slots have been allocated resources.  There
> may be unused slots in the range between slot 0 and the high
> water mark slot, but these slots are already ignored by the existing code
> in the allocate and release loops with the call to get_pcichild_wslot().

That's much clearer now - please add these bits of info to the commit
log, it is essential that developers can find an explanation for a
change like this one there IMO.

Overall the code changes are fine, I am not a big fan of the (void)
cast (I don't think error codes should be ignored) but it is acceptable,
in this context.

Thank you for taking some time to review the code together.

Lorenzo
