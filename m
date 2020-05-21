Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C9F1DD49E
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2020 19:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgEURmR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 21 May 2020 13:42:17 -0400
Received: from foss.arm.com ([217.140.110.172]:50902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbgEURmR (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 May 2020 13:42:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F0CE30E;
        Thu, 21 May 2020 10:42:14 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE2803F68F;
        Thu, 21 May 2020 10:42:12 -0700 (PDT)
Date:   Thu, 21 May 2020 18:42:10 +0100
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
Subject: Re: [PATCH v3 0/2] Fix PCI HyperV device error handling
Message-ID: <20200521174210.GB29590@e121166-lin.cambridge.arm.com>
References: <20200507050126.10871-1-weh@microsoft.com>
 <20200511112147.GD24954@e121166-lin.cambridge.arm.com>
 <MW2PR2101MB1052A57E7BE9634821E29E4FD7B70@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB1052A57E7BE9634821E29E4FD7B70@MW2PR2101MB1052.namprd21.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, May 21, 2020 at 02:39:58AM +0000, Michael Kelley wrote:
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> Sent: Monday, May 11, 2020 4:22 AM
> > 
> > On Thu, May 07, 2020 at 01:01:26PM +0800, Wei Hu wrote:
> > > This series better handles some PCI HyperV error cases in general
> > > and for kdump case. Some of review comments from previous individual
> > > patch reviews, including splitting into separate patches, have already
> > > been incorporated. Thanks Lorenzo Pieralisi for the review and
> > > suggestions, as well as Michael Kelley's contribution to the commit
> > > log.
> > >
> > > Thanks,
> > > Wei
> > >
> > >
> > > Wei Hu (2):
> > >   PCI: hv: Fix the PCI HyperV probe failure path to release resource
> > >     properly
> > >   PCI: hv: Retry PCI bus D0 entry when the first attempt failed with
> > >     invalid device state
> > >
> > >  drivers/pci/controller/pci-hyperv.c | 60 ++++++++++++++++++++++++++---
> > >  1 file changed, 54 insertions(+), 6 deletions(-)
> > 
> > Applied to pci/hv, thanks.
> > 
> 
> Lorenzo -- 
> 
> Will you be bringing these fixes into 5.7?  The main fix is the 2nd patch, but
> there wasn't a clear "Fixes:" tag to add because the problem is due more to
> how Hyper-V operates than a bug in a previous Linux commit.  We have a
> customer experiencing the problem, so getting the fix into the main tree
> sooner rather than later is helpful.

We usually send fixes at -rc* if the bug was introduced in the previous
release, at the moment this is v5.8 material not planned for such a late
-rc* (ie -rc7). We can send patches to stable and/or apply a Fixes: tag
if that can help when the commits hit mainline.

Lorenzo
