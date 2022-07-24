Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4114857F537
	for <lists+linux-hyperv@lfdr.de>; Sun, 24 Jul 2022 15:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiGXNah (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 24 Jul 2022 09:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGXNag (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 24 Jul 2022 09:30:36 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC6EDF7E;
        Sun, 24 Jul 2022 06:30:33 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so7977189pjf.2;
        Sun, 24 Jul 2022 06:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hJTWsmGHbh86Ca8Ccu63Ml/CUjCqMMCMq8qVbi37eTA=;
        b=oaQ+hEfjnwIKZKpERyXea3T4r8DEyS/NZDvcKN5Mn8Mx4DBA7jLrar9pxxzJYkLj71
         p0flG63Suq5DKaWEcXj87eX5LKBNkRFQUCCCe/IiFWMCKDJD7BxgemV5KrLj7OKRkkwl
         ieuBfA3JG3LmA3rMMsVp4oagiHhKb97VxG0ctJ39hhlAEpENIpSwsdTlqkUx8iXAvOGW
         J32Tl4VMvydRxA8RvIfe19pBzw/8FLhtF1dGw7Bu5MeEtGeela3fkTyS7m2rWfSw0+bq
         WBgtOvwDbXhydlzrUi/EFqs9SymLfWcTlUxHqFvjlVfynRQs93lAcc3M6C3TaEKSWAmu
         53Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hJTWsmGHbh86Ca8Ccu63Ml/CUjCqMMCMq8qVbi37eTA=;
        b=vG1s6sLi9u6cFxaPwQW0O6dLF63Ak/0Z8UscdFP+WL3GylCSrp3whfoFInul5UPmtt
         BRYyNexUOVXuFB0665zMbsgxT2/+O/bJjnaxz4oz4uYd9ssSZJXKwKoJQS4LSc4v240N
         ZEt7uinU6CuY78hQ3vss0/CJ8B/JgjCO7+ficAyivuUyWnxKwXkxwgegvXnR+Y75Z5ot
         yEI7vftyIBiUTNzvKlJAIYzBRT3K0QaGAhiIrd5RL9I0bxxKJ3aTw4pSQLlSJfAaKAse
         m6ucUNnPz0ZqDsYgWKbBgYxvddNvH70myV8NksI8AprkR6gwN0q1kJeWj4rWTxAPQuOU
         /qfQ==
X-Gm-Message-State: AJIora9ONIoBoo0urV4SI3KreJc1ZqyxFS+azo1F+SpDCfGhLa3a+0uG
        MmeJ3IWT9N/Qg8igELGz8EAxIfYO9gIEtw==
X-Google-Smtp-Source: AGRyM1s4sjal3zMdndzOlqX2N100d0xr+fvpyFBFsxfTMYlSzPYIIxgaYuogmZ7unvQS1lswI4RXJQ==
X-Received: by 2002:a17:90a:2b89:b0:1f2:5860:f9aa with SMTP id u9-20020a17090a2b8900b001f25860f9aamr9958615pjd.40.1658669433248;
        Sun, 24 Jul 2022 06:30:33 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:6:8000::a31c? ([2404:f801:9000:18:efed::a31c])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902bb8500b0016d3d907146sm5386677pls.191.2022.07.24.06.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jul 2022 06:30:32 -0700 (PDT)
Message-ID: <6f9b2b0f-f893-8135-f49b-9b6b44ef408f@gmail.com>
Date:   Sun, 24 Jul 2022 21:30:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] swiotlb: Clean up some coding style and minor issues
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     m.szyprowski@samsung.com, robin.murphy@arm.com,
        michael.h.kelley@microsoft.com, Tianyu Lan <tiala@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
References: <20220722033846.950237-1-ltykernel@gmail.com>
 <YtrAsjp0Fs0ThBa7@infradead.org>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <YtrAsjp0Fs0ThBa7@infradead.org>
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

On 7/22/2022 11:22 PM, Christoph Hellwig wrote:
> I've applied this, but then dropped the debugfs changes.  I can't find
> any good reason why we'd use the _unsafe variant here.  Can you resend
> that bit and write a commit log clearly documenting the considerations
> for it?

Sure. I will do that.
