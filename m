Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C4842715E
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Oct 2021 21:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhJHTY5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Oct 2021 15:24:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231316AbhJHTY4 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Oct 2021 15:24:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BED7D60FF2;
        Fri,  8 Oct 2021 19:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633720981;
        bh=IBIkC1hOHMKAeBXPbuyx1mvQIerxGedPt5TpcHEBaWs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tWZ8SCUJW1H2UTAct6/czodPn6X6XJveHgRpuD2xf/5tSPt8P5EXymwTzkeKxnN9v
         yjvkKOwFrHjYWyvAT3Rx/s5ZzEY7o+yaBujEiTgWQfcaYyTdBLCx/fmkbhYEETdzZV
         YLvwfSoJHQoh3agxYbmiDGqJcnJOeNo7YZ3wfeJIBIB0GqNDJB0ocr2fC3bACPFAOD
         bcM9Fpm0RlFVbmn+oY3lJwUrg1BGkaE3z6HVYgL9rZs5ddtt/2lPurHBy7lRuTXpCV
         zgrMYE1GaOpVGYQcOJLJN1Ec6GKAw+0Gb49KIDkM2P6I6YPZvWmdaU/VB1FkomuU1c
         wl6wyz+lWQ9hg==
Date:   Fri, 8 Oct 2021 14:22:59 -0500
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
Subject: Re: [PATCH v2 2/2] PCI: hv: Support for Hyper-V vPCI for ARM64
Message-ID: <20211008192259.GA1366435@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR21MB2002619B2F7EEB9B1C4F5712C0B29@MW4PR21MB2002.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Subject line should start with a verb telling us what this does.

On Fri, Oct 08, 2021 at 05:21:29PM +0000, Sunil Muthuswamy wrote:
> This patch adds support for Hyper-V vPCI by adding a PCI MSI
> IRQ domain specific to Hyper-V that is based on SPIs. The IRQ
> domain parents itself to the arch GIC IRQ domain for basic
> vector management.

Same "This patch adds ..." comment as for patch 1/2.  You could say
something like "Add support ...".  It would also be good to include
"ARM64" since I think that's the point here.

> +	/* Delivery mode: Fixed */
> +	*delivery_mode = 0;

Why not APIC_DELIVERY_MODE_FIXED as you used for x86?

Bjorn
