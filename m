Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC562ECB62
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Jan 2021 09:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbhAGID6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Jan 2021 03:03:58 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40778 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbhAGID6 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Jan 2021 03:03:58 -0500
Received: from zn.tnic (p200300ec2f0e340062d4c7d6e370d23d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:3400:62d4:c7d6:e370:d23d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EF3C71EC04A6;
        Thu,  7 Jan 2021 09:03:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610006596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eh++UBFjyA0qQZ9PtbP+rTC8J3vRPWgH5i0rpNjICOQ=;
        b=S48lfb0NWfmw1PsK+xjBp6qZk4eTk2sINQxiXIyiZ5gvsBmmQWN2Qa3mVEszvuVUlL50WC
        o439ORINTzM/WsgpIeIXbWSLrrGYdvmoliFxy83fuaqRg/w4sboAJ05LcAoUgYsfB1ftSj
        mgkUAvQjt4YZInpqtOg25jdz76lena4=
Date:   Thu, 7 Jan 2021 09:03:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "\"H. Peter Anvin\"" <hpa@zytor.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] Hyper-V: pci: x64: Generalize irq/msi set-up and handling
Message-ID: <20210107080317.GE14697@zn.tnic>
References: <SN4PR2101MB08808404302E2E1AB6A27DD6C0AF9@SN4PR2101MB0880.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN4PR2101MB08808404302E2E1AB6A27DD6C0AF9@SN4PR2101MB0880.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jan 07, 2021 at 05:05:36AM +0000, Sunil Muthuswamy wrote:
> Currently, operations related to irq/msi in Hyper-V vPCI are
> x86-specific code. In order to support virtual PCI on Hyper-V for
> other architectures, introduce generic interfaces to replace the
> x86-specific ones. There are no functional changes in this patch.
> 
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>

What is this SoB chain supposed to say?

See:

  11) Sign your work - the Developer's Certificate of Origin
  12) When to use Acked-by:, Cc:, and Co-developed-by:
  13) Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:

sections in

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
