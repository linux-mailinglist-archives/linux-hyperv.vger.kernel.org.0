Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BDF66DAA5
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jan 2023 11:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbjAQKL0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Jan 2023 05:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbjAQKLZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Jan 2023 05:11:25 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2339410CA;
        Tue, 17 Jan 2023 02:11:25 -0800 (PST)
Received: from [10.156.157.53] (unknown [167.220.238.149])
        by linux.microsoft.com (Postfix) with ESMTPSA id 216B120DFE8B;
        Tue, 17 Jan 2023 02:11:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 216B120DFE8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1673950284;
        bh=fMPznZUmuXYY6rJhrntqSizTdW6HflkVGu4AZPQ7j98=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U1nZXks4iXywV3lIsjGmb9kyX5bzuv7RmUTpSInTcgoNXdMaATCQEeWgS1V3d27z+
         jvqWqnW9EnUU07UF4cksv6PMl0vQJe9CfyMnFCKwedaysbCMpf4EQ7W6hMkkwobmqT
         5yuzMPGhnTCyWXU+XZbrH8O7sEU7nek2wcptkyjk=
Message-ID: <401ef436-5f78-6dd7-0157-5b580c6b7f87@linux.microsoft.com>
Date:   Tue, 17 Jan 2023 15:41:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] x86/hyperv: conditionally build hv_get_nested_reg()
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mikelley@microsoft.com,
        nunodasneves@linux.microsoft.com
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230114015643.3950640-1-trix@redhat.com>
From:   Jinank Jain <jinankjain@linux.microsoft.com>
In-Reply-To: <20230114015643.3950640-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Reviewed-by: Jinank Jain <jinankjain@linux.microsoft.com>

On 1/14/2023 7:26 AM, Tom Rix wrote:
> cppcheck reports
> [arch/x86/kernel/cpu/mshyperv.c:44]: (style) The function 'hv_get_nested_reg' is never used.
>
> hv_get_nested_reg() is built unconditially but is only used conditionally in
> hv_get_register() and hv_set_register() by CONFIG_HYPERV.
>
> Move the conditional #if to also include hv_get_nested_reg()
>
> Fixes: 89acd9b2ff8e ("Drivers: hv: Setup synic registers in case of nested root partition")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>   arch/x86/kernel/cpu/mshyperv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index b8bb13daacf7..9ca202970569 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -41,6 +41,7 @@ bool hv_root_partition;
>   bool hv_nested;
>   struct ms_hyperv_info ms_hyperv;
>   
> +#if IS_ENABLED(CONFIG_HYPERV)
>   static inline unsigned int hv_get_nested_reg(unsigned int reg)
>   {
>   	switch (reg) {
> @@ -61,7 +62,6 @@ static inline unsigned int hv_get_nested_reg(unsigned int reg)
>   	}
>   }
>   
> -#if IS_ENABLED(CONFIG_HYPERV)
>   u64 hv_get_non_nested_register(unsigned int reg)
>   {
>   	u64 value;
