Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978A51CD7DC
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2020 13:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgEKLVw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 May 2020 07:21:52 -0400
Received: from foss.arm.com ([217.140.110.172]:57666 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728574AbgEKLVw (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 May 2020 07:21:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCE1E101E;
        Mon, 11 May 2020 04:21:51 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 378E33F7B4;
        Mon, 11 May 2020 04:21:50 -0700 (PDT)
Date:   Mon, 11 May 2020 12:21:47 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Wei Hu <weh@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, robh@kernel.org, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, decui@microsoft.com,
        mikelley@microsoft.com
Subject: Re: [PATCH v3 0/2] Fix PCI HyperV device error handling
Message-ID: <20200511112147.GD24954@e121166-lin.cambridge.arm.com>
References: <20200507050126.10871-1-weh@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507050126.10871-1-weh@microsoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, May 07, 2020 at 01:01:26PM +0800, Wei Hu wrote:
> This series better handles some PCI HyperV error cases in general
> and for kdump case. Some of review comments from previous individual
> patch reviews, including splitting into separate patches, have already
> been incorporated. Thanks Lorenzo Pieralisi for the review and
> suggestions, as well as Michael Kelley's contribution to the commit
> log.
> 
> Thanks,
> Wei
> 
> 
> Wei Hu (2):
>   PCI: hv: Fix the PCI HyperV probe failure path to release resource
>     properly
>   PCI: hv: Retry PCI bus D0 entry when the first attempt failed with
>     invalid device state
> 
>  drivers/pci/controller/pci-hyperv.c | 60 ++++++++++++++++++++++++++---
>  1 file changed, 54 insertions(+), 6 deletions(-)

Applied to pci/hv, thanks.

Lorenzo
