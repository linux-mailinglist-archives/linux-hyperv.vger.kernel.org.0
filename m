Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FB122B3AC
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jul 2020 18:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgGWQgs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Jul 2020 12:36:48 -0400
Received: from foss.arm.com ([217.140.110.172]:48546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgGWQgs (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Jul 2020 12:36:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B7791FB;
        Thu, 23 Jul 2020 09:36:47 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA2C63F66F;
        Thu, 23 Jul 2020 09:36:45 -0700 (PDT)
Date:   Thu, 23 Jul 2020 17:36:43 +0100
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
Subject: Re: [PATCH v3] PCI: hv: Fix a timing issue which causes kdump to
 fail occasionally
Message-ID: <20200723163643.GB11749@e121166-lin.cambridge.arm.com>
References: <20200718034752.4843-1-weh@microsoft.com>
 <20200723111402.GA8120@e121166-lin.cambridge.arm.com>
 <SG2P153MB03774814C5D6450238CC4471BB760@SG2P153MB0377.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2P153MB03774814C5D6450238CC4471BB760@SG2P153MB0377.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jul 23, 2020 at 03:52:39PM +0000, Wei Hu wrote:
> > -----Original Message-----
> > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Kdump could fail sometime on Hyper-V guest over Accelerated Network
> > > interface. This is because the retry in hv_pci_enter_d0() relies on an
> > > asynchronous host event arriving before the guest calls
> > > hv_send_resources_allocated(). Fix the problem by moving retry to
> > > hv_pci_probe(), removing this dependency and making the calling
> > > sequence synchronous.
> > 
> > You have to explain why this code move fixes the problem
> 
> How about following commit message:
> 
> Kdump could fail sometime on Hyper-V guest over Accelerated Network
> nterface.

"Interface" and this is irrelevant if you don't explain why the
failure is caused by it and not any other piece of software,
ie why the failure happens explicitly on the Accelerated Network
Interface only.

> This is because the retry in hv_pci_enter_d0() relies on an
> asynchronous host event arriving before the guest calls
> hv_send_resources_allocated(). Fix the problem by moving retry to
> hv_pci_probe() and start the retry from hv_pci_query_relations() call. 
> This causes the host to generate an synchronous event, hence removing 
> this unreliable dependency.

It is a bit better but I am pretty sure it can be improved, for instance
by describing the failure path in relation to the asynchronous
notification, in other words what happens when things go wrong.

> > and you also have to
> > add a comment to the code so that anyone who has to fix it in the future can
> > understand why the code is where you are moving it to and why that's a
> > solution.
> 
> It already has the comment in the code as:
> +	 * The retry should start from hv_pci_query_relations() call.

Explain *why* it should restart from there, it is not that complicated.

> It would be a bug if the retry does not start from this according to the host
> Behaviour. So I think no further explanation would be needed.

It is needed, add it please.

> > > Fixes: c81992e7f4aa ("PCI: hv: Retry PCI bus D0 entry on invalid
> > > device state")
> > > Signed-off-by: Wei Hu <weh@microsoft.com>
> > 
> > Please carry tags and send patches -in-reply-to the previous version to allow
> > threading.
> > 
> 
> Do you mean to add review-by tags? If not would you please elaborate
> what 'carry tags' means? Sorry I am not familiar to this term.

It should not be me who applies Reviewed-by tags added on previous patch
versions, it should be you who add it to newer versions.

AKA Michael already reviewed it and I need to see his reviewed-by tag
to apply it.

Thanks,
Lorenzo
