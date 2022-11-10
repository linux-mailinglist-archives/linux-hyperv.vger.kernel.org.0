Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340B4624D39
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Nov 2022 22:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiKJVoC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 10 Nov 2022 16:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiKJVn7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Nov 2022 16:43:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF1859843;
        Thu, 10 Nov 2022 13:43:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5164361E59;
        Thu, 10 Nov 2022 21:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5999DC433C1;
        Thu, 10 Nov 2022 21:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668116636;
        bh=kKquFmuXBOIGicNY7LEzCSBfF1TG/cQb/2yjsvua2Us=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=n/ZX/36XPKKKkd/W1HZpB7VqbGL9dDlDO6QJ3gukp/T0y0Y1tbIRvbew21yWMOiDd
         n1PmE6WT2KoloMR532hGxMDTv4NMUC6/JRie+co4XyK+sRj+4jRiBuqCU4k2XBsnMS
         E1LZ1M2D1AXg8j+EjhMrmww1e7CIMZVWXCCHOHaxTaOrMoQ3O3ryI7QfqEVrPMO0wi
         6Sbyaw/gkRkaXGMrQkZD1a2WtBWdflcKXpMSKla5Mz48LTQObfdjcdgkmp8URIe5av
         wROFh6G/xpJbotJ5oFi8Ujzl0n1z0h9JMV/PsbJn8eP8m425EBl+BIu3Z++tMD40yJ
         QfmvMmtgSvXrA==
Date:   Thu, 10 Nov 2022 15:43:54 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     quic_jhugo@quicinc.com, quic_carlv@quicinc.com, wei.liu@kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        lpieralisi@kernel.org, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        robh@kernel.org, kw@linux.com, alex.williamson@redhat.com,
        boqun.feng@gmail.com, Boqun.Feng@microsoft.com
Subject: Re: [PATCH v3] PCI: hv: Only reuse existing IRTE allocation for
 Multi-MSI
Message-ID: <20221110214354.GA674181@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104222953.11356-1-decui@microsoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Nov 04, 2022 at 03:29:53PM -0700, Dexuan Cui wrote:
> Jeffrey added Multi-MSI support to the pci-hyperv driver by the 4 patches:
> 08e61e861a0e ("PCI: hv: Fix multi-MSI to allow more than one MSI vector")
> 455880dfe292 ("PCI: hv: Fix hv_arch_irq_unmask() for multi-MSI")
> b4b77778ecc5 ("PCI: hv: Reuse existing IRTE allocation in compose_msi_msg()")
> a2bad844a67b ("PCI: hv: Fix interrupt mapping for multi-MSI")
> 
> It turns out that the third patch (b4b77778ecc5) causes a performance
> regression because all the interrupts now happen on 1 physical CPU (or two
> pCPUs, if one pCPU doesn't have enough vectors). When a guest has many PCI
> devices, it may suffer from soft lockups if the workload is heavy, e.g.,
> see https://lwn.net/ml/linux-kernel/20220804025104.15673-1-decui@microsoft.com/
> 
> Commit b4b77778ecc5 itself is good. The real issue is that the hypercall in
> hv_irq_unmask() -> hv_arch_irq_unmask() ->
> hv_do_hypercall(HVCALL_RETARGET_INTERRUPT...) only changes the target
> virtual CPU rather than physical CPU; with b4b77778ecc5, the pCPU is
> determined only once in hv_compose_msi_msg() where only vCPU0 is specified;
> consequently the hypervisor only uses 1 target pCPU for all the interrupts.
> 
> Note: before b4b77778ecc5, the pCPU is determined twice, and when the pCPU
> is determinted the second time, the vCPU in the effective affinity mask is

s/determinted/determined/

> used (i.e., it isn't always vCPU0), so the hypervisor chooses different
> pCPU for each interrupt.
> 
> The hypercall will be fixed in future to update the pCPU as well, but
> that will take quite a while, so let's restore the old behavior in
> hv_compose_msi_msg(), i.e., don't reuse the existing IRTE allocation for
> single-MSI and MSI-X; for multi-MSI, we choose the vCPU in a round-robin
> manner for each PCI device, so the interrupts of different devices can
> happen on different pCPUs, though the interrupts of each device happen on
> some single pCPU.
> 
> The hypercall fix may not be backported to all old versions of Hyper-V, so
> we want to have this guest side change for ever (or at least till we're sure

s/for ever/forever/

> the old affected versions of Hyper-V are no longer supported).
> 
> Fixes: b4b77778ecc5 ("PCI: hv: Reuse existing IRTE allocation in compose_msi_msg()")
> Co-developed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Co-developed-by: Carl Vanderlip <quic_carlv@quicinc.com>
> Signed-off-by: Carl Vanderlip <quic_carlv@quicinc.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> 
> ---
> 
> v1 is here:
>   https://lwn.net/ml/linux-kernel/20220804025104.15673-1-decui@microsoft.com/
> 
> Changes in v2:
>   round-robin the vCPU for multi-MSI.
>   The commit message is re-worked.
>   Added Jeff and Carl's Co-developed-by and Signed-off-by.
> 
> Changes in v3:
>   Michael Kelley kindly helped to make a great comment, and I added the
>   comment before hv_compose_msi_req_get_cpu(). Thank you, Michael!
> 
>   Rebased to Hyper-V tree's "hyperv-fixes" branch:
>       https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-fixes
> 
>   Bjorn, Lorenzo, it would be great to have your Ack. The patch needs to go
>   through the Hyper-V tree because it's rebased to another hv_pci patch (which
>   only exists in the Hyper-V tree for now):
>       e70af8d040d2 ("PCI: hv: Fix the definition of vector in hv_compose_msi_msg()") 

Fine with me, but it's Lorenzo's area so I don't want to preemptively
ack it.
