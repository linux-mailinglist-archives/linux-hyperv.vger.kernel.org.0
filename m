Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B6366DBA5
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jan 2023 11:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbjAQK4a (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Jan 2023 05:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236466AbjAQK4Y (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Jan 2023 05:56:24 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36646301AB
        for <linux-hyperv@vger.kernel.org>; Tue, 17 Jan 2023 02:56:17 -0800 (PST)
Received: from [10.156.157.53] (unknown [167.220.238.149])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1BF4D20DFE93;
        Tue, 17 Jan 2023 02:56:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1BF4D20DFE93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1673952977;
        bh=zXst434NIIVP3ZezL4HM/AIXimSp49v/pllhSJV8o7c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fOsaBkE0TzIsvlu6BkPrcLcodUmHGPaLIDVFubpviM0EEq7ixKtgspBZf0kz6J/VP
         MHq+xEkuV5301Q9ZPvpHLNqHEzmOfRgr7W7BiUNh+TRrvOamZzdsKHIQf1QUqTjoXg
         PNbukBRAF1Zwj3Mg0N7BKT45Xxz2IE1BUtFz+pOo=
Message-ID: <ac8ee542-1f60-fa66-99f5-d716cd2dff33@linux.microsoft.com>
Date:   Tue, 17 Jan 2023 16:26:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [bug report] x86/hyperv: Add Write/Read MSR registers via ghcb
 page
Content-Language: en-US
To:     Dan Carpenter <error27@gmail.com>, Tianyu.Lan@microsoft.com
Cc:     linux-hyperv@vger.kernel.org
References: <Y8UM59rdoCD0D6V2@kili>
From:   Jinank Jain <jinankjain@linux.microsoft.com>
In-Reply-To: <Y8UM59rdoCD0D6V2@kili>
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

Does making 0 as the default value makes sense?

Regards,

Jinank

On 1/16/2023 2:07 PM, Dan Carpenter wrote:
> Hello Tianyu Lan,
>
> The patch faff44069ff5: "x86/hyperv: Add Write/Read MSR registers via
> ghcb page" from Oct 25, 2021, leads to the following Smatch static
> checker warning:
>
> 	arch/x86/kernel/cpu/mshyperv.c:73 hv_get_non_nested_register()
> 	error: uninitialized symbol 'value'.
>
> arch/x86/kernel/cpu/mshyperv.c
>      63
>      64 #if IS_ENABLED(CONFIG_HYPERV)
>      65 u64 hv_get_non_nested_register(unsigned int reg)
>      66 {
>      67         u64 value;
>      68
>      69         if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
>      70                 hv_ghcb_msr_read(reg, &value);
>                                               ^^^^^^
> There are three places in hv_ghcb_msr_read() which don't initialize
> value.
>
>      71         else
>      72                 rdmsrl(reg, value);
> --> 73         return value;
>      74 }
>
> regards,
> dan carpenter
