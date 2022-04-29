Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAAF514667
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Apr 2022 12:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbiD2KSq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 29 Apr 2022 06:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357277AbiD2KSp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 29 Apr 2022 06:18:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 311013A5F4;
        Fri, 29 Apr 2022 03:15:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F9301063;
        Fri, 29 Apr 2022 03:15:26 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.10.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 732BD3F73B;
        Fri, 29 Apr 2022 03:15:23 -0700 (PDT)
Date:   Fri, 29 Apr 2022 11:15:17 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        robh@kernel.org, kw@linux.com, jakeo@microsoft.com
Subject: Re: [PATCH] PCI: hv: Do not set PCI_COMMAND_MEMORY to reduce VM boot
 time
Message-ID: <Ymu6tYItgM6dtNdd@lpieralisi>
References: <20220419220007.26550-1-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419220007.26550-1-decui@microsoft.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 19, 2022 at 03:00:07PM -0700, Dexuan Cui wrote:
> A VM on Azure can have 14 GPUs, and each GPU may have a huge MMIO BAR,
> e.g. 128 GB. Currently the boot time of such a VM can be 4+ minutes, and
> most of the time is used by the host to unmap/map the vBAR from/to pBAR
> when the VM clears and sets the PCI_COMMAND_MEMORY bit: each unmap/map
> operation for a 128GB BAR needs about 1.8 seconds, and the pci-hyperv
> driver and the Linux PCI subsystem flip the PCI_COMMAND_MEMORY bit
> eight times (see pci_setup_device() -> pci_read_bases() and
> pci_std_update_resource()), increasing the boot time by 1.8 * 8 = 14.4
> seconds per GPU, i.e. 14.4 * 14 = 201.6 seconds in total.
> 
> Fix the slowness by not turning on the PCI_COMMAND_MEMORY in pci-hyperv.c,
> so the bit stays in the off state before the PCI device driver calls
> pci_enable_device(): when the bit is off, pci_read_bases() and
> pci_std_update_resource() don't cause Hyper-V to unmap/map the vBARs.
> With this change, the boot time of such a VM is reduced by
> 1.8 * (8-1) * 14 = 176.4 seconds.

I believe you need to clarify this commit message. It took me a while
to understand what you are really doing.

What this patch is doing is bootstrapping PCI devices with command
memory clear because there is no need to have it set (?) in the first
place and because, if it is set, the PCI core layer needs to toggle it
on and off in order to eg size BAR regions, which causes the slow down
you are reporting.

I assume, given the above, that there is strictly no need to have
devices with command memory set at kernel startup handover and if
there was it would not be set in the PCI Hyper-V host controller
driver (because that's what you are _removing_).

I think this should not be merged as a fix and I'd be careful
about possible regressions before sending it to stable kernels,
if you wish to do so.

It is fine by me to go via the Hyper-V tree even though I don't
see why that's better, unless you want to send it as a fix and
I think you should not.

You can add my tag but the commit log should be rewritten and
you should add a Link: to the discussion thread.

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> Tested-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: Jake Oshins <jakeo@microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index d270a204324e..f9fbbd8d94db 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2082,12 +2082,17 @@ static void prepopulate_bars(struct hv_pcibus_device *hbus)
>  				}
>  			}
>  			if (high_size <= 1 && low_size <= 1) {
> -				/* Set the memory enable bit. */
> -				_hv_pcifront_read_config(hpdev, PCI_COMMAND, 2,
> -							 &command);
> -				command |= PCI_COMMAND_MEMORY;
> -				_hv_pcifront_write_config(hpdev, PCI_COMMAND, 2,
> -							  command);
> +				/*
> +				 * No need to set the PCI_COMMAND_MEMORY bit as
> +				 * the core PCI driver doesn't require the bit
> +				 * to be pre-set. Actually here we intentionally
> +				 * keep the bit off so that the PCI BAR probing
> +				 * in the core PCI driver doesn't cause Hyper-V
> +				 * to unnecessarily unmap/map the virtual BARs
> +				 * from/to the physical BARs multiple times.
> +				 * This reduces the VM boot time significantly
> +				 * if the BAR sizes are huge.
> +				 */
>  				break;
>  			}
>  		}
> -- 
> 2.17.1
> 
