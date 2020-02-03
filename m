Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27A35150896
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Feb 2020 15:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgBCOmM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 Feb 2020 09:42:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59841 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbgBCOmL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 Feb 2020 09:42:11 -0500
Received: from [89.248.140.14] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iycvG-0006rj-Pp; Mon, 03 Feb 2020 15:41:59 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id B8D19100C1B; Mon,  3 Feb 2020 15:41:52 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Boqun Feng <boqun.feng@gmail.com>, linux-pci@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v2 3/3] PCI: hv: Introduce hv_msi_entry
In-Reply-To: <20200203050313.69247-4-boqun.feng@gmail.com>
References: <20200203050313.69247-1-boqun.feng@gmail.com> <20200203050313.69247-4-boqun.feng@gmail.com>
Date:   Mon, 03 Feb 2020 15:41:52 +0100
Message-ID: <87d0av20nj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Boqun Feng <boqun.feng@gmail.com> writes:
>  /*
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 6b79515abb82..3bdaa3b6e68f 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -240,6 +240,11 @@ bool hv_vcpu_is_preempted(int vcpu);
>  static inline void hv_apic_init(void) {}
>  #endif
>  
> +#define hv_set_msi_address_from_desc(msi_entry, msi_desc)	\
> +do {								\
> +	(msi_entry)->address = (msi_desc)->msg.address_lo;	\
> +} while (0)

Any reason why this needs to be a macro? inlines are preferrred. They
are typesafe and readable.

Thanks,

        tglx
