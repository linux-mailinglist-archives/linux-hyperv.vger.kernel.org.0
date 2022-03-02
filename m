Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8874CA1F8
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Mar 2022 11:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbiCBKRU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Mar 2022 05:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiCBKRU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 05:17:20 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B3415F8D4;
        Wed,  2 Mar 2022 02:16:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1276D139F;
        Wed,  2 Mar 2022 02:16:37 -0800 (PST)
Received: from e123427-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6BB53F70D;
        Wed,  2 Mar 2022 02:16:33 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Boqun Feng <boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sunil Muthuswamy <sunilmut@linux.microsoft.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-hyperv@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>
Subject: Re: [RFC PATCH v2] PCI: hv: Avoid the retarget interrupt hypercall in irq_unmask() on ARM64
Date:   Wed,  2 Mar 2022 10:16:25 +0000
Message-Id: <164621616889.27346.10460850825594773169.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220217034525.1687678-1-boqun.feng@gmail.com>
References: <20220217034525.1687678-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 17 Feb 2022 11:45:19 +0800, Boqun Feng wrote:
> On ARM64 Hyper-V guests, SPIs are used for the interrupts of virtual PCI
> devices, and SPIs can be managed directly via GICD registers. Therefore
> the retarget interrupt hypercall is not needed on ARM64.
> 
> An arch-specific interface hv_arch_irq_unmask() is introduced to handle
> the architecture level differences on this. For x86, the behavior
> remains unchanged, while for ARM64 no hypercall is invoked when
> unmasking an irq for virtual PCI devices.
> 
> [...]

Applied to pci/hv, thanks!

[1/1] PCI: hv: Avoid the retarget interrupt hypercall in irq_unmask() on ARM64
      https://git.kernel.org/lpieralisi/pci/c/d06957d7a6

Thanks,
Lorenzo
