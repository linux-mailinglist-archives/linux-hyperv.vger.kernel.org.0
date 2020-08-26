Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DB42539A0
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 23:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgHZVUC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 17:20:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33596 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgHZVUA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 17:20:00 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598476797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WYZnB7uf4zw+g6DBBef5reqPEj8a0j4M5RX3zdOOKzc=;
        b=pvKvB1AMMg61vF3fuuFlE/MjubeGYv3ru+dZbTvHajwgBVYvAEQefT04IBXFOezkguPQmN
        /CZWOdtXKlQmE8ObjUoPwGvTbYZfMrTtdvjVYhynH8BTWRfQ0kCVBtP+xO5yNuaFZlTyoB
        YfFVLUqTCqkdxpR7lkPmYqNGoB43zk5UlwhM33f8pFT3UDs0fKUTc+N48y18DXhTyrikLB
        Cn4e2VBH7/Fb0KqpKDKd2gzoGZZSVES7hQWMowj45Xk7MA5bYvJBJMqC5hQufiBX92bva3
        oTxipIX/Q7LReXbW3YfAemOe94IuUH+vGtqhQh0JAvhW7MdTZUObynzmLOAwFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598476797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WYZnB7uf4zw+g6DBBef5reqPEj8a0j4M5RX3zdOOKzc=;
        b=oWrjSaUuvxZFWVKpzIddniXB4pV/MwolflT+zDiuc64L+U6Z6uqVmYilcDAgH4c1Moq+9p
        bsm+zr1NkfquxRCw==
To:     Marc Zyngier <maz@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch V2 04/46] genirq/chip: Use the first chip in irq_chip_compose_msi_msg()
In-Reply-To: <87a6yh2nln.wl-maz@kernel.org>
References: <20200826111628.794979401@linutronix.de> <20200826112331.047917603@linutronix.de> <87a6yh2nln.wl-maz@kernel.org>
Date:   Wed, 26 Aug 2020 23:19:56 +0200
Message-ID: <87o8mxt88z.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 26 2020 at 20:50, Marc Zyngier wrote:
> On Wed, 26 Aug 2020 12:16:32 +0100,
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> ---
>> V2: New patch. Note, that this might break other stuff which relies on the
>>     current behaviour, but the hierarchy composition of DT based chips is
>>     really hard to follow.
>
> Grepping around, I don't think there is any occurrence of two irqchips
> providing irq_compose_msi() that can share a hierarchy on any real
> system, so we should be fine. Famous last words.

Knocking on wood :)

>>  #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
>> -	for (; data; data = data->parent_data)
>> -#endif
>> -		if (data->chip && data->chip->irq_compose_msi_msg)
>> +	for (; data; data = data->parent_data) {
>> +		if (data->chip && data->chip->irq_compose_msi_msg) {
>>  			pos = data;
>> +			break;
>> +		}
>> +	}
>> +#else
>> +	if (data->chip && data->chip->irq_compose_msi_msg)
>> +		pos = data;
>> +#endif
>>  	if (!pos)
>>  		return -ENOSYS;
>
> Is it just me, or is this last change more complex than it ought to
> be?

Kinda.

> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 857f5f4c8098..25e18b73699c 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -1544,7 +1544,7 @@ int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  	struct irq_data *pos = NULL;
>  
>  #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
> -	for (; data; data = data->parent_data)
> +	for (; data && !pos; data = data->parent_data)
>  #endif
>  		if (data->chip && data->chip->irq_compose_msi_msg)
>  			pos = data;
>
> Though the for loop in a #ifdef in admittedly an acquired taste...

Checking !pos is simpler obviously. That doesn't make me hate the loop
in the #ifdef less. :)

What about the below?

Thanks,

        tglx
---
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -473,6 +473,15 @@ static inline void irq_domain_deactivate
 }
 #endif
 
+static inline struct irq_data *irqd_get_parent_data(struct irq_data *irqd)
+{
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+	return irqd->parent_data;
+#else
+	return NULL;
+#endif
+}
+
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
 #include <linux/debugfs.h>
 
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1541,18 +1541,17 @@ EXPORT_SYMBOL_GPL(irq_chip_release_resou
  */
 int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	struct irq_data *pos = NULL;
+	struct irq_data *pos;
 
-#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
-	for (; data; data = data->parent_data)
-#endif
+	for (pos = NULL; !pos && data; data = irqd_get_parent_data(data)) {
 		if (data->chip && data->chip->irq_compose_msi_msg)
 			pos = data;
+	}
+
 	if (!pos)
 		return -ENOSYS;
 
 	pos->chip->irq_compose_msi_msg(pos, msg);
-
 	return 0;
 }
 
