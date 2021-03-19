Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FE33425AD
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Mar 2021 20:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhCSTE3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 Mar 2021 15:04:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230379AbhCSTES (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 Mar 2021 15:04:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0F826197A;
        Fri, 19 Mar 2021 19:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616180658;
        bh=LSqZKtp+PvAiHpEQvEVRg2/MdvuPL2ZNVkwpLe8BAsE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Baa4m6LfUcdOSSJ5BI+s5XLe++NLRb3jutYCsta3tAXd0as58n47aBP8FJaUcEkEa
         6FIaNpk8kOwsrt7/ROyFbkZB+3vavM0UQ1wnJrWq3Z5n1UnY4nQhZWE9witc1gRDX1
         vsFttGRo1BaubuL0yP1uMV8s6h7TI0B2ySdtZerTaDwRf4P1FZtr2ETTZ4EyM6wyi3
         lyaIvvXzXqKvJoNjglUYtiQNvbuvRGxrkGEBtNmgh0dSPYtdVEOCVSZR01BoRQCMDA
         piQx7iP2EqLS42gJxGl1lWKFJmA7ytnou08ft1fj/rOMyDXX/U9ILuLaFAvWlHYqts
         zwut+H8P5lnag==
Date:   Fri, 19 Mar 2021 14:04:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Clint Sbisa <csbisa@amazon.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: Re: [RFC 0/2] PCI: Introduce pci_ops::use_arch_sysdata
Message-ID: <20210319190416.GA244767@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319161956.2838291-1-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Mar 20, 2021 at 12:19:54AM +0800, Boqun Feng wrote:
> Hi Bjorn,
> 
> I'm currently working on virtual PCI support for Hyper-V ARM64 guests.
> Similar to virtual PCI on x86 Hyper-V guests, the PCI root bus is not
> probed via ACPI (or of), it's probed from Hyper-V VMbus, therefore it

Prime example of why "OF" should be capitalized to prevent the
confusion of reading it as an English word, where it looks like a typo
and makes no sense.  Capitalizing it gives me and other uninitiates a
hint that it's an initialism.  Also applies to your commit logs and
code comments.

> doesn't have config window.
