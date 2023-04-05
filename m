Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E7D6D8B06
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Apr 2023 01:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbjDEXRs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Apr 2023 19:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjDEXRr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Apr 2023 19:17:47 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5524F6EB7;
        Wed,  5 Apr 2023 16:17:46 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id d17so37724985wrb.11;
        Wed, 05 Apr 2023 16:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680736664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9HAWFNIUkLfI+TykU7qXeNifdIEUrsEUjcWyjUlZwc=;
        b=xw00ZtoI20CGzLTROO5vxbY3rvxZuhqdCt00ZydzXZlC3LSuu39FrMwFqrLsy0CdpQ
         RKTSRHFSCQRqLPRInMFJ8FueWWBHr/kUJ4GnYsYl22tyIiBuhl6/ath/ESxX7kpkJxhv
         gd0J9GPu23LOQRuTZ2Z80pEtX/bE4T3LtnJ51d3JXIhWSS+2v4UDtLeYX/c9e9j5Uzfz
         WekkHTkMeS9AH5iVVChzntoi0QVmutN9MS192BntyHfXTAXa6XrlLqLu7/d79w9Fdovu
         SyRlR/vIdMetWo/YbLl869GsZmcMbiV+FLZ21zAbgQosgpV1ap7rTpC/cGr5mBdsYz0q
         BTxA==
X-Gm-Message-State: AAQBX9c9FrZNRWaC0oQ1H3hixp/uN9sM1gF9Yqe4TSgpu2Ew++KrZRvs
        MJrH/F0LOddbW4cuVfjyiVY=
X-Google-Smtp-Source: AKy350bVIvzj2w2ex7Yv/ifhviZgw1E23pomxV0Tq72c6IruhzIaqthjEEZ7rWySwdm21cy0A8Kqxw==
X-Received: by 2002:a5d:6b0a:0:b0:2ce:aa62:ff79 with SMTP id v10-20020a5d6b0a000000b002ceaa62ff79mr5343393wrw.40.1680736664654;
        Wed, 05 Apr 2023 16:17:44 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id e10-20020adfdbca000000b002ceac2ccc4asm25182wrj.23.2023.04.05.16.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 16:17:44 -0700 (PDT)
Date:   Wed, 5 Apr 2023 23:17:41 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Jinank Jain <jinankjain@linux.microsoft.com>
Cc:     jinankjain@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        nunodasneves@linux.microsoft.com
Subject: Re: [PATCH] PCI: hv: Use nested hypercall for retargeting interrupts
Message-ID: <ZC4BlSo0D1uNliFk@liuwe-devbox-debian-v2>
References: <20230404113546.856813-1-jinankjain@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404113546.856813-1-jinankjain@linux.microsoft.com>
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 04, 2023 at 11:35:46AM +0000, Jinank Jain wrote:
> In case of nested MSHV, retargeting interrupt hypercall should be sent
> to L0 hypervisor instead of L1 hypervisor.
> 
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>

While I think this is a sensible change -- how did you discover this?
Can you provide a bit more information?

> ---
>  drivers/pci/controller/pci-hyperv.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index f33370b75628..2123f632ecf7 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -704,8 +704,14 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>  		}
>  	}
>  
> -	res = hv_do_hypercall(HVCALL_RETARGET_INTERRUPT | (var_size << 17),
> -			      params, NULL);
> +	if (hv_nested)
> +		res = hv_do_nested_hypercall(HVCALL_RETARGET_INTERRUPT |
> +					     (var_size << 17),
> +					     params, NULL);
> +	else
> +		res = hv_do_hypercall(HVCALL_RETARGET_INTERRUPT |
> +				      (var_size << 17),
> +				      params, NULL);
>  
>  exit_unlock:
>  	spin_unlock_irqrestore(&hbus->retarget_msi_interrupt_lock, flags);
> -- 
> 2.34.1
> 
