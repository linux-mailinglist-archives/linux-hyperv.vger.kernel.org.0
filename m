Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D754815039A
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Feb 2020 10:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgBCJvp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 Feb 2020 04:51:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36453 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgBCJvp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 Feb 2020 04:51:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so17120282wru.3
        for <linux-hyperv@vger.kernel.org>; Mon, 03 Feb 2020 01:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rnDPBSUuVuYgxfTH/LE+fCmpX3/NqS6sW9R93j88kKg=;
        b=CPpgzeMv6frDZeN7Ohf8Ni6aGL9A7BPf33E1PJD2dRObj80331n8Tq2PNB26N3uflb
         v9XTi3vrj3ujEYXIplN6/HZBrorzao1cmnSQi44JxS3QX/7z9dFujRdPvBiGo1NcQXTO
         AHWfYj4HJylTEAucXZWvYAKMaKJfFZWOq14wL5mPKmOZlY86fUtKOyMu8uws9LgHG8Qj
         2EAlBBbFhM1XtHjw0KrqvrlqeQB5+4Iusl/A7bEqPeIvYsmjcYW3Cj3LH6i3v5EJpKMY
         k+JfJnBM/NxsO0ke0m6V+TCXaADzCwbqK4KVb4EU08drZwMQsMJZ/dYnmsfdmAX2rTZu
         VYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rnDPBSUuVuYgxfTH/LE+fCmpX3/NqS6sW9R93j88kKg=;
        b=RwWFCevA87IA8fEGNegq+0Rj/PX6exBJE+1XBz2/d1ZFDJeHjIYqfjoiN5WDmUqVjO
         1A7uGGsxGCuZ2KcvjzAeyaBr2t8C90oniqMU6neg/rYWemglJX0xOqghspe49ciG2DUb
         zpdUI6GPHKZoeNLtAWa0Vn3DkzT6t/WvXZD+y9pxfXDrRrvhSFklWe29ezJXdmGzP3TY
         DXJ7ULTi/EjHFpN/AVgK07qG2qKzDbrybrv+mjzBUHw4EXb3sAlxm5zgjWMfJwFHLih9
         RlsaABincwREUKNmovjkYnzQ1wEHpcd/pNp/7YmI+TBjtjRPS8qTDm2g9Ww3bgHOLqr2
         vbNw==
X-Gm-Message-State: APjAAAVP/PrTtQUZFPCDBDrs6zpTXFrgcfXXnOZ7D6480CVezAQ57PDx
        DDJi0Wq4PjlYJt13BEUXtW0C1w==
X-Google-Smtp-Source: APXvYqw7V7B7iGDd6nFgnka0ziI8dHLkn3HmGFeQJiw3wbFDH3xDp2B94hEuTX3mpEjB0xaTbYrdsA==
X-Received: by 2002:adf:ca07:: with SMTP id o7mr14000110wrh.49.1580723502887;
        Mon, 03 Feb 2020 01:51:42 -0800 (PST)
Received: from big-machine ([2a00:23c5:dd80:8400:459c:4174:f0ee:1b26])
        by smtp.gmail.com with ESMTPSA id t1sm23821080wma.43.2020.02.03.01.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 01:51:41 -0800 (PST)
Date:   Mon, 3 Feb 2020 09:51:40 +0000
From:   Andrew Murray <amurray@thegoodpenguin.co.uk>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 3/3] PCI: hv: Introduce hv_msi_entry
Message-ID: <20200203095140.GE20189@big-machine>
References: <20200203050313.69247-1-boqun.feng@gmail.com>
 <20200203050313.69247-4-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203050313.69247-4-boqun.feng@gmail.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Feb 03, 2020 at 01:03:13PM +0800, Boqun Feng wrote:
> Add a new structure (hv_msi_entry), which is also defined int tlfs, to

s/int/in the/ ?

> describe the msi entry for HVCALL_RETARGET_INTERRUPT. The structure is
> needed because its layout may be different from architecture to
> architecture.
> 
> Also add a new generic interface hv_set_msi_address_from_desc() to allow
> different archs to set the msi address from msi_desc.
> 
> No functional change, only preparation for the future support of virtual
> PCI on non-x86 architectures.
> 
> Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h  | 11 +++++++++--
>  arch/x86/include/asm/mshyperv.h     |  5 +++++
>  drivers/pci/controller/pci-hyperv.c |  4 ++--
>  3 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index 4a76e442481a..953b3ad38746 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -912,11 +912,18 @@ struct hv_partition_assist_pg {
>  	u32 tlb_lock_count;
>  };
>  
> +union hv_msi_entry {
> +	u64 as_uint64;
> +	struct {
> +		u32 address;
> +		u32 data;
> +	} __packed;
> +};
> +
>  struct hv_interrupt_entry {
>  	u32 source;			/* 1 for MSI(-X) */
>  	u32 reserved1;
> -	u32 address;
> -	u32 data;
> +	union hv_msi_entry msi_entry;
>  } __packed;
>  
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

Given that this is a single statement, is there really a need for the do ; while(0) ?


> +
>  #else /* CONFIG_HYPERV */
>  static inline void hyperv_init(void) {}
>  static inline void hyperv_setup_mmu_ops(void) {}
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 0d9b74503577..2240f2b3643e 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1170,8 +1170,8 @@ static void hv_irq_unmask(struct irq_data *data)
>  	memset(params, 0, sizeof(*params));
>  	params->partition_id = HV_PARTITION_ID_SELF;
>  	params->int_entry.source = 1; /* MSI(-X) */
> -	params->int_entry.address = msi_desc->msg.address_lo;
> -	params->int_entry.data = msi_desc->msg.data;
> +	hv_set_msi_address_from_desc(&params->int_entry.msi_entry, msi_desc);
> +	params->int_entry.msi_entry.data = msi_desc->msg.data;

If the layout may differ, then don't we also need a wrapper for data?

Thanks,

Andrew Murray

>  	params->device_id = (hbus->hdev->dev_instance.b[5] << 24) |
>  			   (hbus->hdev->dev_instance.b[4] << 16) |
>  			   (hbus->hdev->dev_instance.b[7] << 8) |
> -- 
> 2.24.1
> 
