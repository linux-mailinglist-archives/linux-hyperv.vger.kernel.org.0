Return-Path: <linux-hyperv+bounces-6103-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CABF5AF86CE
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Jul 2025 06:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45FD4189C778
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Jul 2025 04:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B832C19D8A7;
	Fri,  4 Jul 2025 04:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ietRwSSa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7fMAXDZL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76E71853;
	Fri,  4 Jul 2025 04:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751603581; cv=none; b=gpzqR+AY40rWDh1T9NWeI74SOC7BXsDz3BpF9PNRKWbAAtv+rVclqFRVCv709cNP83ay+x3+N3pjbQhmAA8uGaYarakou8LX7vp0yh78Gd5JQYXmYkqVGBOwbV3Y38sY/wTi2BV/gi3amYxhp6//CqhKyKW1Ej+Q6KBg37DDYEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751603581; c=relaxed/simple;
	bh=0EhyfsG7e1DiIpLNZmKVH2C4E2I/HFptCc49kB93dt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6LLW+TzcVYrmjSb3DCvc7dk1tdMX4vvnxJkEKXjdlJ2JyVUbGTWhXlPLEXMxTr4+4TRUdqLsKe84WpuMzsyq24Z6fxsAzNpbyLcvD3zGVbsIBcWowvQqNFpXPw8a64RQ2bzPiJ8j/PfoLf0HhmgUFrcA5pcZX9lVoJd827U3BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ietRwSSa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7fMAXDZL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 4 Jul 2025 06:32:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751603577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lu5UwG3gkU9yDfSYrynq/q3LHcvqLFRt2qUTkA3VXJ4=;
	b=ietRwSSaofHPYLX3xPHbQaRdwmhUvR0oG8Jl0ekizuf2VPs/EAlorh3boX28GKlEeceUNn
	VhpeW/GXutZoVkHxMSzLCoatSTmRx/nqXRYuTIyxAT0QqF9bqPjstMq67AaQvZd1qbGdVN
	X3N0QU6YDX0FoIUDwBw704MktK9Q7N+uT5gw7OJLt0Iv9w9AZx/MK2Rhh/rtKsPn7C2Omg
	kKxjyGuxpdrjagqrItkq6cwY+dflmv6h0qZ0LmPEmiJX7FIX7NZzYuK1i9xBimF3CYHdYI
	4GGQLFD6S5e3aP4UiR2M1E2S1J1Hq26eLabdb/UgzCr3SlmFRGh5AZbtW3kWUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751603577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lu5UwG3gkU9yDfSYrynq/q3LHcvqLFRt2qUTkA3VXJ4=;
	b=7fMAXDZLA+9VHQVCrhjUDQ7LNL/DeUPGCzycSMx6ONMfNd12NQ/irqPvP3F1XlTvENIrMK
	LKJgQV0TOcmWrbBA==
From: Nam Cao <namcao@linutronix.de>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Joyce Ooi <joyce.ooi@intel.com>, Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Michal Simek <michal.simek@amd.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-rpi-kernel@lists.infradead.org" <linux-rpi-kernel@lists.infradead.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 14/16] PCI: hv: Switch to msi_create_parent_irq_domain()
Message-ID: <20250704043255.JCK9HyRj@linutronix.de>
References: <cover.1750858083.git.namcao@linutronix.de>
 <024f0122314198fe0a42fef01af53e8953a687ec.1750858083.git.namcao@linutronix.de>
 <SN6PR02MB4157A6F9B2ABD3C69CE5B521D443A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87cyaht595.ffs@tglx>
 <SN6PR02MB41576745C28D8F49081B8E77D443A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87zfdlrmvr.ffs@tglx>
 <SN6PR02MB41573141969F6B3028099C65D442A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41573141969F6B3028099C65D442A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Fri, Jul 04, 2025 at 02:27:01AM +0000, Michael Kelley wrote:
> I haven't resolved the conflict. As a shortcut for testing I just
> removed the conflicting patch since it is for a Microsoft custom NIC
> ("MANA") that's not in the configuration I'm testing with. I'll have to
> look more closely to figure out the resolution.
> 
> Separately, this patch (the switch to misc_create_parent_irq_domain)
> isn't working for Linux VMs on Hyper-V on ARM64. The initial symptom
> is that interrupts from the NVMe controller aren't getting handled
> and everything hangs. Here's the dmesg output:
> 
> [   84.463419] hv_vmbus: registering driver hv_pci
> [   84.463875] hv_pci abee639e-0b9d-49b7-9a07-c54ba8cd5734: PCI VMBus probing: Using version 0x10004
> [   84.464518] hv_pci abee639e-0b9d-49b7-9a07-c54ba8cd5734: PCI host bridge to bus 0b9d:00
> [   84.464529] pci_bus 0b9d:00: root bus resource [mem 0xfc0000000-0xfc00fffff window]
> [   84.464531] pci_bus 0b9d:00: No busn resource found for root bus, will use [bus 00-ff]
> [   84.465211] pci 0b9d:00:00.0: [1414:b111] type 00 class 0x010802 PCIe Endpoint
> [   84.466657] pci 0b9d:00:00.0: BAR 0 [mem 0xfc0000000-0xfc00fffff 64bit]
> [   84.481923] pci_bus 0b9d:00: busn_res: [bus 00-ff] end is updated to 00
> [   84.481936] pci 0b9d:00:00.0: BAR 0 [mem 0xfc0000000-0xfc00fffff 64bit]: assigned
> [   84.482413] nvme nvme0: pci function 0b9d:00:00.0
> [   84.482513] nvme 0b9d:00:00.0: enabling device (0000 -> 0002)
> [   84.556871] irq 17, desc: 00000000e8529819, depth: 0, count: 0, unhandled: 0
> [   84.556883] ->handle_irq():  0000000062fa78bc, handle_bad_irq+0x0/0x270
> [   84.556892] ->irq_data.chip(): 00000000ba07832f, 0xffff00011469dc30
> [   84.556895] ->action(): 0000000069f160b3
> [   84.556896] ->action->handler(): 00000000e15d8191, nvme_irq+0x0/0x3e8
> [  172.307920] watchdog: BUG: soft lockup - CPU#6 stuck for 26s! [kworker/6:1H:195]

Thanks for the report.

On arm64, this driver relies on the parent irq domain to set handler. So
the driver must not overwrite it to NULL.

This should cures it:

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 3a24fadddb83..f4a435b0456c 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -577,8 +577,6 @@ static void hv_pci_onchannelcallback(void *context);
 
 #ifdef CONFIG_X86
 #define DELIVERY_MODE	APIC_DELIVERY_MODE_FIXED
-#define FLOW_HANDLER	handle_edge_irq
-#define FLOW_NAME	"edge"
 
 static int hv_pci_irqchip_init(void)
 {
@@ -723,8 +721,6 @@ static void hv_arch_irq_unmask(struct irq_data *data)
 #define HV_PCI_MSI_SPI_START	64
 #define HV_PCI_MSI_SPI_NR	(1020 - HV_PCI_MSI_SPI_START)
 #define DELIVERY_MODE		0
-#define FLOW_HANDLER		NULL
-#define FLOW_NAME		NULL
 #define hv_msi_prepare		NULL
 
 struct hv_pci_chip_data {
@@ -2162,8 +2158,9 @@ static int hv_pcie_domain_alloc(struct irq_domain *d, unsigned int virq, unsigne
 		return ret;
 
 	for (int i = 0; i < nr_irqs; i++) {
-		irq_domain_set_info(d, virq + i, 0, &hv_msi_irq_chip, NULL, FLOW_HANDLER, NULL,
-				    FLOW_NAME);
+		irq_domain_set_hwirq_and_chip(d, virq + i, 0, &hv_msi_irq_chip, NULL);
+		if (IS_ENABLED(CONFIG_X86))
+			__irq_set_handler(virq + i, handle_edge_irq, 0, "edge");
 	}
 
 	return 0;

