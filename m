Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8BD6D69B2
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Apr 2023 19:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjDDRAU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 4 Apr 2023 13:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbjDDRAR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 4 Apr 2023 13:00:17 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82602D1;
        Tue,  4 Apr 2023 10:00:16 -0700 (PDT)
Received: from [192.168.0.5] (unknown [71.212.161.12])
        by linux.microsoft.com (Postfix) with ESMTPSA id D7FD0210DD99;
        Tue,  4 Apr 2023 10:00:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7FD0210DD99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680627616;
        bh=eekB3bYoQqC3IJ2D872oRGGQeEcgPYH1G+tXq6FWN2A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YiOICRBkseLaRSK7TUNqQ3yPBKOdljXbZ7yV6NAxoxVfjIQCj+2tXmsKJfwu3IdVm
         1t9Wrg4ZUWgjCSBOwaYFCgWNCg/8PIs+KLf6LzqKOEftMR1tXfA6Cmrz15ZiTYO+bQ
         vtH5IFH06p9aMbbPlxhyxxeVNbTTLbPZ0LkBVVmI=
Message-ID: <2543a6aa-adc0-b471-6281-38130b4d6a08@linux.microsoft.com>
Date:   Tue, 4 Apr 2023 10:00:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] PCI: hv: Use nested hypercall for retargeting interrupts
Content-Language: en-US
To:     Jinank Jain <jinankjain@linux.microsoft.com>,
        jinankjain@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com
Cc:     linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230404113546.856813-1-jinankjain@linux.microsoft.com>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20230404113546.856813-1-jinankjain@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

On 4/4/2023 4:35 AM, Jinank Jain wrote:
> In case of nested MSHV, retargeting interrupt hypercall should be sent
> to L0 hypervisor instead of L1 hypervisor.
> 
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
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

