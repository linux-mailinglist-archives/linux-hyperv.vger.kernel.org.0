Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53FA517977C
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2020 19:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbgCDSGn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 4 Mar 2020 13:06:43 -0500
Received: from foss.arm.com ([217.140.110.172]:38130 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728926AbgCDSGn (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 4 Mar 2020 13:06:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1E5831B;
        Wed,  4 Mar 2020 10:06:42 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CDEC3F6C4;
        Wed,  4 Mar 2020 10:06:41 -0800 (PST)
Date:   Wed, 4 Mar 2020 18:06:35 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Dexuan Cui <decui@microsoft.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: hv: Replace zero-length array with flexible-array
 member
Message-ID: <20200304180635.GA21844@e121166-lin.cambridge.arm.com>
References: <20200213005048.GA9662@embeddedor.com>
 <HK0P153MB0148FB68FCBAE908CA5991C3BF1A0@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
 <20200304175509.dwhn63omfzewaukv@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304175509.dwhn63omfzewaukv@debian>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 04, 2020 at 05:55:09PM +0000, Wei Liu wrote:
> On Thu, Feb 13, 2020 at 03:43:40AM +0000, Dexuan Cui wrote:
> > > From: linux-hyperv-owner@vger.kernel.org
> > > <linux-hyperv-owner@vger.kernel.org> On Behalf Of Gustavo A. R. Silva
> > > Sent: Wednesday, February 12, 2020 4:51 PM
> > >  ...
> > > The current codebase makes use of the zero-length array language
> > > extension to the C90 standard, but the preferred mechanism to declare
> > > variable-length types such as these ones is a flexible array member[1][2],
> > > introduced in C99:
> > > 
> > > struct foo {
> > >         int stuff;
> > >         struct boo array[];
> > > };
> > > 
> > > By making use of the mechanism above, we will get a compiler warning
> > > in case the flexible array does not occur last in the structure, which
> > > will help us prevent some kind of undefined behavior bugs from being
> > > inadvertently introduced[3] to the codebase from now on.
> > > 
> > > Also, notice that, dynamic memory allocations won't be affected by
> > > this change:
> > > 
> > > "Flexible array members have incomplete type, and so the sizeof operator
> > > may not be applied. As a quirk of the original implementation of
> > > zero-length arrays, sizeof evaluates to zero."[1]
> > > 
> > > This issue was found with the help of Coccinelle.
> > 
> > Looks good to me. Thanks, Gustavo!
> >  
> > Reviewed-by: Dexuan Cui <decui@microsoft.com>
> > 
> 
> Lorenzo, will you be picking up this patch? It seems to me you've been
> handling patches to pci-hyperv.c. This patch is not yet in pci/hv branch
> in your repository.
> 
> Let me know what you think.

I shall pick it up, I checked patchwork and it was erroneously
assigned to Bjorn, that's why I have not taken it yet.

Fixed now, apologies, I will merge it shortly.

Lorenzo
