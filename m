Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC456A88C4
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Sep 2019 21:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfIDO1t (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 4 Sep 2019 10:27:49 -0400
Received: from foss.arm.com ([217.140.110.172]:56462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729809AbfIDO1s (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 4 Sep 2019 10:27:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8E7E1570;
        Wed,  4 Sep 2019 07:27:47 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F7E93F59C;
        Wed,  4 Sep 2019 07:27:46 -0700 (PDT)
Date:   Wed, 4 Sep 2019 15:27:37 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH v3] PCI: hv: Make functions static
Message-ID: <20190904142737.GA28184@e121166-lin.cambridge.arm.com>
References: <20190828221846.6672-1-kw@linux.com>
 <20190829091713.27130-1-kw@linux.com>
 <DM6PR21MB13372349374A473FF98AD7BCCAA20@DM6PR21MB1337.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR21MB13372349374A473FF98AD7BCCAA20@DM6PR21MB1337.namprd21.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 29, 2019 at 03:50:47PM +0000, Haiyang Zhang wrote:
> 
> 
> > -----Original Message-----
> > From: Krzysztof Wilczynski <kswilczynski@gmail.com> On Behalf Of Krzysztof
> > Wilczynski
> > Sent: Thursday, August 29, 2019 2:17 AM
> > To: Bjorn Helgaas <helgaas@kernel.org>
> > Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>; Stephen Hemminger
> > <sthemmin@microsoft.com>; Sasha Levin <sashal@kernel.org>; Lorenzo
> > Pieralisi <lorenzo.pieralisi@arm.com>; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-hyperv@vger.kernel.org
> > Subject: [PATCH v3] PCI: hv: Make functions static
> > 
> > Functions hv_read_config_block(), hv_write_config_block() and
> > hv_register_block_invalidate() are not used anywhere else and are local to
> > drivers/pci/controller/pci-hyperv.c,
> > and do not need to be in global scope, so make these static.
> > 
> > Resolve following compiler warning that can be seen when building with
> > warnings enabled (W=1):
> > 
> > drivers/pci/controller/pci-hyperv.c:933:5: warning:
> >  no previous prototype for ‘hv_read_config_block’
> >   [-Wmissing-prototypes]
> > 
> > drivers/pci/controller/pci-hyperv.c:1013:5: warning:
> >  no previous prototype for ‘hv_write_config_block’
> >   [-Wmissing-prototypes]
> > 
> > drivers/pci/controller/pci-hyperv.c:1082:5: warning:
> >  no previous prototype for ‘hv_register_block_invalidate’
> >   [-Wmissing-prototypes]
> > 
> > Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
> 
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

This patch should go via the net tree - the code it is fixing
is queued there, I will drop this patch from the PCI review
queue.

If it helps:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
