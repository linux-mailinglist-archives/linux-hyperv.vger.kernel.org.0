Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D546B109C7D
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Nov 2019 11:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfKZKqx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 26 Nov 2019 05:46:53 -0500
Received: from foss.arm.com ([217.140.110.172]:60996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727858AbfKZKqx (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Nov 2019 05:46:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8997A30E;
        Tue, 26 Nov 2019 02:46:52 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2003F3F52E;
        Tue, 26 Nov 2019 02:46:50 -0800 (PST)
Date:   Tue, 26 Nov 2019 10:46:45 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Subject: Re: [PATCH v3 0/4] Enhance pci-hyperv to support hibernation, and 2
 misc fixes
Message-ID: <20191126104645.GA26274@e121166-lin.cambridge.arm.com>
References: <1574660034-98780-1-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574660034-98780-1-git-send-email-decui@microsoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Nov 24, 2019 at 09:33:50PM -0800, Dexuan Cui wrote:
> I suggest the patchset goes through the pci.git tree.
> 
> Patch #1: no functional change.
> Patch #2 enhances the pci-hyperv driver to support hibernation.
> Patch #3 is unrelated to hibernation.
> Patch #4 is unrelated to hibernation.
> 
> Changes in v3:
> Patch #1: Added Michael Kelley's Signed-off-by.
> Patch #2: Used a better commit log message from Michael Kelley.
> Patch #3: Added Michael Kelley's Signed-off-by.
> Patch #4: Used kzalloc() rather than get_zeroed_page()/kmemleak_alloc()/
>           kmemleak_free(), and added the necessary comments.
> 
> Michael, can you please review #2 and #4 again?
> 
> Dexuan Cui (4):
>   PCI: hv: Reorganize the code in preparation of hibernation
>   PCI: hv: Add the support of hibernation
>   PCI: hv: Change pci_protocol_version to per-hbus
>   PCI: hv: Avoid a kmemleak false positive caused by the hbus buffer
> 
>  drivers/pci/controller/pci-hyperv.c | 208 ++++++++++++++++++++++++----
>  1 file changed, 179 insertions(+), 29 deletions(-)

Applied to pci/hv, should be able to hit v5.5, thanks.

Lorenzo
