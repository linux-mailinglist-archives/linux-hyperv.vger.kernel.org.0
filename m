Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB15461123
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Nov 2021 10:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbhK2JfQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 29 Nov 2021 04:35:16 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:40930 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232358AbhK2JdP (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 29 Nov 2021 04:33:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638178198; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=6eYnZqn/a+66YlvOdqd+LVZ4HfzlOTayDC9zFdg1eh8=; b=msIb9nD4T9xoTH1L/oZSAM+6AmshQs5IBLD42xZjlu1Q/WgzRJYk0ZhNlAS6j7sXPdXt5FVq
 jkc3Vm6qElYEMo1EJj7e6+3ugu0IkDTBHUY/VqerJ4ANXEYrgKtt0stHRYawK4jcLNTxDw75
 zhusivEUpsd8VgPdPNMwnpE6BIw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI4M2VhYiIsICJsaW51eC1oeXBlcnZAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 61a49d953553c354be8af88f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Nov 2021 09:29:57
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D166AC4361B; Mon, 29 Nov 2021 09:29:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C23B0C4338F;
        Mon, 29 Nov 2021 09:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C23B0C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparclinux@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org, ath11k@lists.infradead.org,
        linux-pci@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        linux-hyperv@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [patch 10/22] genirq/msi, treewide: Use a named struct for PCI/MSI attributes
References: <20211126222700.862407977@linutronix.de>
        <20211126223824.679247706@linutronix.de>
Date:   Mon, 29 Nov 2021 11:29:46 +0200
In-Reply-To: <20211126223824.679247706@linutronix.de> (Thomas Gleixner's
        message of "Sat, 27 Nov 2021 02:18:50 +0100 (CET)")
Message-ID: <874k7vcnsl.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> The unnamed struct sucks and is in the way of further cleanups. Stick the
> PCI related MSI data into a real data structure and cleanup all users.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: sparclinux@vger.kernel.org
> Cc: x86@kernel.org
> Cc: xen-devel@lists.xenproject.org
> Cc: ath11k@lists.infradead.org
> ---
>  arch/powerpc/platforms/cell/axon_msi.c    |    2 
>  arch/powerpc/platforms/powernv/pci-ioda.c |    4 -
>  arch/powerpc/platforms/pseries/msi.c      |    6 -
>  arch/sparc/kernel/pci_msi.c               |    4 -
>  arch/x86/kernel/apic/msi.c                |    2 
>  arch/x86/pci/xen.c                        |    6 -
>  drivers/net/wireless/ath/ath11k/pci.c     |    2 

For ath11k:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
