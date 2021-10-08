Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1115E4270FC
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Oct 2021 20:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239913AbhJHSyK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Oct 2021 14:54:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239650AbhJHSyG (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Oct 2021 14:54:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DDAE60F3A;
        Fri,  8 Oct 2021 18:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633719130;
        bh=njO5hv03OnrmJzSBoYpKmkfrNid/AyLiEQdwwNkuqok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qkuK9xGMhNG+5sm3CApJQjrxLqb1q1J9iggn5HmtkVh1PAYoAXdaMgIl+sBTrzgqU
         maBxISU3GIpJF4FyXWlECwmxsmlnYtscvc+FyoU4i4xgYLxfW0uORp7Ukf4/WNdcgB
         X1+g61VJZcWzZZAyNWZ9J7C/bhcsExlLuEKBrMyNIAATQqFqpX3AbP7BcSimC7HfiX
         jnxJ+timIddxQMpez+t548H26qc6Z4vBYXFUTMfXjiqSJni50x9PdEcOyPiCAxTmjI
         BmsdzPRRUZe3YmBUJBDl8BzK7+u9TplLr1a8Q7/xil+rRxeTLQmVyWCHCRFgGTKiv1
         iKpHo05VUvPVA==
Date:   Fri, 8 Oct 2021 13:52:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "\"H. Peter Anvin\"" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] PCI: hv: Hyper-V vPCI for ARM64
Message-ID: <20211008185209.GA1362885@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR21MB200217CCFBC351FD12D68DF0C0B29@MW4PR21MB2002.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Oct 08, 2021 at 05:19:53PM +0000, Sunil Muthuswamy wrote:
> Current Hyper-V vPCI code only compiles and works for x64. There are
> some hardcoded assumptions about the architectural IRQ chip and other
> arch defines.
> 
> This patch series adds support for Hyper-V vPCI for ARM64 by first
> breaking the current hard coded dependency in the vPCI code and
> making it arch neutral. That is in the first patch. The second
> patch introduces a Hyper-V vPCI MSI IRQ chip for allocating SPI
> vectors.
> 
> changes in v2:
>  - Moved the irqchip implementation to drivers/pci as suggested
>    by Marc Zyngier
>  - Addressed Multi-MSI handling issues identified by Marc Zyngier
>  - Addressed lock/synchronization primitive as suggested by Marc
>    Zyngier
>  - Addressed other code feedback from Marc Zyngier
> 
> Sunil Muthuswamy (2):
>   PCI: hv: Make the code arch neutral
>   PCI: hv: Support for Hyper-V vPCI for ARM64

If you have occasion to post a v3, note that this is not correctly
threaded with patches as responses to the cover letter.  Thereore,
"b4 am MW4PR21MB200217CCFBC351FD12D68DF0C0B29@MW4PR21MB2002.namprd21.prod.outlook.com"
does not work to download this series.  See

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/5.Posting.rst?id=v5.14#n320
