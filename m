Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A826E351E49
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Apr 2021 20:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237540AbhDASh4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Apr 2021 14:37:56 -0400
Received: from foss.arm.com ([217.140.110.172]:46726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240340AbhDASaH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Apr 2021 14:30:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4AD3D6E;
        Thu,  1 Apr 2021 04:27:53 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.56.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D3193F694;
        Thu,  1 Apr 2021 04:27:49 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Michal Simek <michal.simek@xilinx.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>, linux-pci@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thierry Reding <treding@nvidia.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-hyperv@vger.kernel.org, Will Deacon <will@kernel.org>,
        kernel-team@android.com, Michael Kelley <mikelley@microsoft.com>,
        linux-kernel@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 00/14] PCI/MSI: Getting rid of msi_controller, and other cleanups
Date:   Thu,  1 Apr 2021 12:27:42 +0100
Message-Id: <161727636757.32506.11592578621890085687.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210330151145.997953-1-maz@kernel.org>
References: <20210330151145.997953-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 30 Mar 2021 16:11:31 +0100, Marc Zyngier wrote:
> This is a respin of the series described at [1].
> 
> * From v2 [2]:
>   - Fixed the Xilinx driver, thanks to Bharat for testing it
>   - Dropped the no_msi attribute, and solely rely on msi_domain, which
>     has the same effect for the only platform that was using it.
>   - Fixed compilation on architectures that do not select the generic
>     MSI support
> 
> [...]

I have applied it to pci/msi and should be moved into -next shortly
for further testing/visibility, thanks a lot for putting it together.

[01/14] PCI: tegra: Convert to MSI domains
        https://git.kernel.org/lpieralisi/pci/c/973a28677e
[02/14] PCI: rcar: Don't allocate extra memory for the MSI capture address
        https://git.kernel.org/lpieralisi/pci/c/c244dc15dc
[03/14] PCI: rcar: Convert to MSI domains
        https://git.kernel.org/lpieralisi/pci/c/516286287d
[04/14] PCI: xilinx: Don't allocate extra memory for the MSI capture address
        https://git.kernel.org/lpieralisi/pci/c/cc8cf90738
[05/14] PCI: xilinx: Convert to MSI domains
        https://git.kernel.org/lpieralisi/pci/c/b66873599e
[06/14] PCI: hv: Drop msi_controller structure
        https://git.kernel.org/lpieralisi/pci/c/65b131816a
[07/14] PCI/MSI: Drop use of msi_controller from core code
        https://git.kernel.org/lpieralisi/pci/c/54729d2a7a
[08/14] PCI/MSI: Kill msi_controller structure
        https://git.kernel.org/lpieralisi/pci/c/27278a3fac
[09/14] PCI/MSI: Kill default_teardown_msi_irqs()
        https://git.kernel.org/lpieralisi/pci/c/f68f571db9
[10/14] PCI/MSI: Let PCI host bridges declare their reliance on MSI domains
        https://git.kernel.org/lpieralisi/pci/c/419150a4ff
[11/14] PCI/MSI: Make pci_host_common_probe() declare its reliance on MSI domains
        https://git.kernel.org/lpieralisi/pci/c/98be0634c8
[12/14] PCI: mediatek: Advertise lack of built-in MSI handling
        https://git.kernel.org/lpieralisi/pci/c/77cbd88c90
[13/14] PCI/MSI: Document the various ways of ending up with NO_MSI
        https://git.kernel.org/lpieralisi/pci/c/44ec480daf
[14/14] PCI: Refactor HT advertising of NO_MSI flag
        https://git.kernel.org/lpieralisi/pci/c/18d56e5afe

Thanks,
Lorenzo
