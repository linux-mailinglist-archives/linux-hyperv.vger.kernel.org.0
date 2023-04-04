Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E266D5DAD
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Apr 2023 12:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbjDDKjX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 4 Apr 2023 06:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbjDDKjV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 4 Apr 2023 06:39:21 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 642DF198A;
        Tue,  4 Apr 2023 03:39:17 -0700 (PDT)
Received: from [10.156.156.87] (unknown [167.220.238.23])
        by linux.microsoft.com (Postfix) with ESMTPSA id C114E210DD83;
        Tue,  4 Apr 2023 03:39:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C114E210DD83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680604756;
        bh=t1RBKOWPXIYWXkmpINOZQASPASeY4H8gbn3HuGOfaXU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C2cXmlNMbgJtDztc5Z5+q05aQErSSQ+TITzEQjzFT85RztAMThbd76GivmwzcMhKT
         xP5j40JNpbGjq5g/hNzGzH2MhACUsvN/4pAwoZd2u+Dq31G52HRiZRSS8+eK1ZzNjD
         H7MZIdoAhofhLEhFUfKfa2hbF9jQZcLc74/eAxi0=
Message-ID: <03f62671-7f01-eeb3-4326-cbf0c2250c30@linux.microsoft.com>
Date:   Tue, 4 Apr 2023 16:09:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] Drivers: hv: Do not free synic pages when they were not
 allocated
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        haiyangz@microsoft.com, decui@microsoft.com
References: <1680564122-30819-1-git-send-email-nunodasneves@linux.microsoft.com>
Content-Language: en-US
From:   Jinank Jain <jinankjain@linux.microsoft.com>
In-Reply-To: <1680564122-30819-1-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Reviewed-by: Jinank Jain <jinankjain@linux.microsoft.com>

On 4/4/2023 4:52 AM, Nuno Das Neves wrote:
> In case of root partition or snp, the synic pages are allocated by the
> hypervisor instead of the kernel, so they should not be freed.
>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>   drivers/hv/hv.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index c7f7652932ca..a10cf642c9ad 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -193,8 +193,10 @@ void hv_synic_free(void)
>   		struct hv_per_cpu_context *hv_cpu
>   			= per_cpu_ptr(hv_context.cpu_context, cpu);
>   
> -		free_page((unsigned long)hv_cpu->synic_event_page);
> -		free_page((unsigned long)hv_cpu->synic_message_page);
> +		if (!hv_isolation_type_snp() && !hv_root_partition) {
> +			free_page((unsigned long)hv_cpu->synic_event_page);
> +			free_page((unsigned long)hv_cpu->synic_message_page);
> +		}
>   		free_page((unsigned long)hv_cpu->post_msg_page);
>   	}
>   
