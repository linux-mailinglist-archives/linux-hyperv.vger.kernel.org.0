Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF085620BF
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Jun 2022 19:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbiF3RCd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 30 Jun 2022 13:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbiF3RCd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 30 Jun 2022 13:02:33 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A505338B1;
        Thu, 30 Jun 2022 10:02:32 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id t21so50653pfq.1;
        Thu, 30 Jun 2022 10:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XWkDP+ftLDbtk7OocZFgBK5F1p4Vc5nVr5Aln5Bk0dQ=;
        b=n8LZs4epo5UQ4J+3zuY7BUPjc4xUXA5d75K4z0momEv9N2Xnjov8J9gGiRdXoZSw+a
         6NtaahIysIS6pe67AF+pd02MuWdfRsIPS87b9idHjXHB4s9qXq1N9s/K9a928WA13DLy
         hSLunucs/qAhoLDf8VwPCY/1b8VXIamidzzdwOHAZQkHwy3CzGsKWcDVOTJGKjtCqGmY
         Z3SxNKybvr9SGYe7fEOMXpjxv1O8TU5KELQOyVx7afeHuSSaVXRLUieqswFuXLZNFca5
         4p9+C8qUzny199h/ejCsCs2gFTFlYnZkbFPRfnWY93w/c8AUKw6qZkz/B4bH3jdfO0gY
         VkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XWkDP+ftLDbtk7OocZFgBK5F1p4Vc5nVr5Aln5Bk0dQ=;
        b=71r9QfUmHBEZ8sOeGk/HASNmbuQG+OPA47kWgRHwZkIBPTGU2A+J4HzV03lxXZ0cp4
         qboO+qZ2+xNYhL+X+X7FdaQTT76S7Bv0Zkiazov9H1VMRR0tGLknPz6dOSSJAaDdiABU
         i+l22tkixEWTfr7dcMSC4yFfHdUcGdpEQoE37jeU5VWnfUkpAdELTYO+THH6RSHVwRqo
         O3HyIrbJ4e4EvMIIQIKAzOxARx9740+Tp1ehTe4Ysf36fyHXhxnoa+qJ6eq+DLuSwyIi
         QlcOzQor+BOICM91x8iV4PRtUTlUQfC6qMFbBr424jKBe2P/y4leE1RV5+r+yuFaRQ9t
         Te4A==
X-Gm-Message-State: AJIora9UNUS4ljUVjOuxiH1zE5VT95X9SGjEqUR5hNMFxooTKBAoPcM8
        q1TsRJakaxNjVxWGGc3yYTM=
X-Google-Smtp-Source: AGRyM1unLh5+2f3N8WdaNvFePkaneEkCPbeaBgJSIjnjZNxgOeXkifHqiBLyurLiV39500WbhCEqGA==
X-Received: by 2002:a63:5304:0:b0:3db:2e57:6f34 with SMTP id h4-20020a635304000000b003db2e576f34mr8330163pgb.88.1656608551924;
        Thu, 30 Jun 2022 10:02:31 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902a9c100b0016a1e2c2efcsm13681071plr.223.2022.06.30.10.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 10:02:31 -0700 (PDT)
Message-ID: <a876f862-c005-108d-e6f9-68336a8d89f0@gmail.com>
Date:   Fri, 1 Jul 2022 01:02:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] x86/ACPI: Set swiotlb area according to the number of
 lapic entry in MADT
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     corbet@lwn.net, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        m.szyprowski@samsung.com, robin.murphy@arm.com, paulmck@kernel.org,
        akpm@linux-foundation.org, keescook@chromium.org,
        songmuchun@bytedance.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, michael.h.kelley@microsoft.com,
        kys@microsoft.com, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        vkuznets@redhat.com, wei.liu@kernel.org, parri.andrea@gmail.com,
        thomas.lendacky@amd.com, linux-hyperv@vger.kernel.org,
        kirill.shutemov@intel.com, andi.kleen@intel.com,
        Andi Kleen <ak@linux.intel.com>
References: <20220627153150.106995-1-ltykernel@gmail.com>
 <20220627153150.106995-3-ltykernel@gmail.com>
 <YrxcCZKvFYjxLf9n@infradead.org>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <YrxcCZKvFYjxLf9n@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 6/29/2022 10:04 PM, Christoph Hellwig wrote:
> On Mon, Jun 27, 2022 at 11:31:50AM -0400, Tianyu Lan wrote:
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>
>> When initialize swiotlb bounce buffer, smp_init() has not been
>> called and cpu number can not be got from num_online_cpus().
>> Use the number of lapic entry to set swiotlb area number and
>> keep swiotlb area number equal to cpu number on the x86 platform.
> 
> Can we reorder that initialization?  Because I really hate having
> to have an arch hook in every architecture.

How about using "flags" parameter of swiotlb_init() to pass area number
or add new parameter for area number?

I just reposted patch 1 since there is just some coding style issue and 
area number may also set via swiotlb kernel parameter. We still need 
figure out a good solution to pass area number from architecture code.



