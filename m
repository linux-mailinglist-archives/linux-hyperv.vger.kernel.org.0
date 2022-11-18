Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F055362EC48
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Nov 2022 04:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbiKRDCG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Nov 2022 22:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbiKRDCF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Nov 2022 22:02:05 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D9673B90;
        Thu, 17 Nov 2022 19:02:01 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so1922861pjh.2;
        Thu, 17 Nov 2022 19:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y0BPaM8FRNxyjrgi80/IHtEdi//TfYvYEdnlSUnsg7I=;
        b=Kg1Di143IsqlNKp4LopyknneEJmTpurUoKLRaod0LBE3Nqge5CgiwIqYqnhSX2TWnC
         lrqRnsWCqfD5LpphZSF41SrKd8JZ9htzgj1cPhNgwe8fpClXmyAin61AWj4v2geUjtY+
         KZTpBwWKM0CzIxRZKnNHMcWnIjvY3a5FBF2EbN8MkMacnUSk/OhgvmeaH4eERM5PQDGK
         5CZHRFBi+VdG4+djI2Zlht3oCsIy9f0RF8EYivur7S7uKEtsDIlEsbZVN7qrrXsN6EDi
         ZcadoXBSvwEhHiTyfV/25MRe+KZFtfPmdHAhoOUMMOuWti/Bcc7rEyhaPc9MRtjmN4zq
         uf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y0BPaM8FRNxyjrgi80/IHtEdi//TfYvYEdnlSUnsg7I=;
        b=PfOyHI3M76Ick44dfn6j6L78ZmwL39rPqNNpwbI0IWckh2R4tR4O5J18m989X4JXKK
         g6QRb/ZchMK2PtKa6BfQY0CsOKAgM4ZjRAc74QM9XgbCw4kjaOn+6xNIprFghFnYjgPk
         1ZvNLP71ECLW+bbRXaXtrCd1GZHnc/jGBLH/B6xTyFnR9qY+Zz9SobiVP40BmD5tlAsx
         oj8mlwgtzhPqUnqqm7JZBEaIcZsbCs9eSD8m3CTvAu7Wgm1j5LATd5RvAkyIYcyN+w5Y
         mLfdqPaJJAMdK1bkBvPPl542vt6GzZhJjuZgF0PHi/Jsk0tSl/V9kWjlN2veI8KXeiDd
         bTeQ==
X-Gm-Message-State: ANoB5plEaF5XLU6J8K6aHzFxkWMLG+QOlx5pM+/FxzvfggESYFBc1uwt
        B7JMQh100sdBHIS0iV020A8=
X-Google-Smtp-Source: AA0mqf7ZpKWT+rnFQJRXqI6RoyJMsad3ljcqmFaADVSvAnONx+SpibI0gZuU9nRpmOX3SzFlqznhgw==
X-Received: by 2002:a17:90a:2c0a:b0:212:cd9c:b44f with SMTP id m10-20020a17090a2c0a00b00212cd9cb44fmr11472177pjd.14.1668740521521;
        Thu, 17 Nov 2022 19:02:01 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id y12-20020aa79aec000000b0056ee49d6e95sm1913002pfp.86.2022.11.17.19.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 19:02:00 -0800 (PST)
Message-ID: <354a1247-056c-076f-850c-cda78f00c628@gmail.com>
Date:   Fri, 18 Nov 2022 11:01:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2] iommu/hyper-v: Allow hyperv irq remapping without
 x2apic
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Cc:     mikelley@microsoft.com, sunilmut@microsoft.com, wei.liu@kernel.org,
        kys@microsoft.com, Tianyu.Lan@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, dwmw2@infradead.org,
        joro@8bytes.org, will@kernel.org
References: <1668715899-8971-1-git-send-email-nunodasneves@linux.microsoft.com>
Content-Language: en-US
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <1668715899-8971-1-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 11/18/2022 4:11 AM, Nuno Das Neves wrote:
> If x2apic is not available, hyperv-iommu skips remapping
> irqs. This breaks root partition which always needs irqs
> remapped.
> 
> Fix this by allowing irq remapping regardless of x2apic,
> and change hyperv_enable_irq_remapping() to return
> IRQ_REMAP_XAPIC_MODE in case x2apic is missing.
> 
> Tested with root and non-root hyperv partitions.
> 
> Signed-off-by: Nuno Das Neves<nunodasneves@linux.microsoft.com>
> ---
>   arch/x86/kernel/cpu/mshyperv.c |  6 ++++++
>   drivers/iommu/Kconfig          |  6 +++---
>   drivers/iommu/hyperv-iommu.c   | 11 ++++++++---
>   3 files changed, 17 insertions(+), 6 deletions(-)


Reviewed-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
