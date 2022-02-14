Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3884B4ED0
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Feb 2022 12:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352014AbiBNLjJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Feb 2022 06:39:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352025AbiBNLjB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Feb 2022 06:39:01 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03C26163;
        Mon, 14 Feb 2022 03:28:48 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id r64-20020a17090a43c600b001b8854e682eso15540188pjg.0;
        Mon, 14 Feb 2022 03:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UTXgoU8n+KrzppBWMa0hmTFNwCf9odk0keuvKtaxU/k=;
        b=cnBuoZw/RKHhZsGhbrd4qubVrdgqaBcgF2vbB3TLWl8veImaTHi6FiowKDVE2OsPaQ
         3+hEBVsaBZoUrga9sKj4zUSo7mwvsBepRCyWZAOkpyC7qZ/1ezKf3T64rZSWOA4XrXXs
         5K5UEu+nNpRJzOuKQyecbIjxZdyKqqVqMdQmmH/y99QQZ2kLWX23TkzeaP7dwJYBhTGx
         KWdHVfBFhbFbPJNr7CIbLXk7xUbGCPvkEZRtzuQdqKA4zrI/dlxwPXgbsbEVTWQ3y65D
         c4EGfc4mJuFpDkcNpdzxW1BLPwFzNXaHGJKkG/2srCpvk64MoTle8XsxOayWytNs2HVr
         dFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UTXgoU8n+KrzppBWMa0hmTFNwCf9odk0keuvKtaxU/k=;
        b=KWV9spucEcgIUB9jcaIxSJbxuavOZteARYK2i8htwqDQTNpYEo6rWmJrTXu8kbvIdG
         KmB+BehsD1BN5UwoVEFZnEkXWby6MHi5lDCcxsdlzrY1h+aUdD+yxLJWC+T6VaBWGh3Y
         E9NU+wv7sQl2cl+VEK7ByIfkxE0DHW0XDZgb24t7ctwjoEkTWU7nPgmW4LJhvhyTHYsd
         KMUrCeZU9WhwcskNhNwIqmg6LvLlP00AhSKskSjnX9Pgy8XecnteeHvKlpHgzEM5EBkx
         njLdVSa0+v9yEDCbBgNMPgzaYANB5umqYbTlz0YaVd/YN/otqh/ZO5g6TQ2xrh7I/lqI
         +s4g==
X-Gm-Message-State: AOAM530y4clQv7G0Py++hV5D5HUScPnkvjWFFX1wM2xbT9V6Jph2Luvl
        q6w+TtVN48hiBKk0UdpfmpY=
X-Google-Smtp-Source: ABdhPJzFsd/ZU8jacmR8tjLDWME3wdGPlEDldYIhUxu28Eo9nQBVjMthkkAZOx//XOQb15xsKiE/EA==
X-Received: by 2002:a17:90b:4c06:: with SMTP id na6mr14002951pjb.62.1644838128522;
        Mon, 14 Feb 2022 03:28:48 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::52c? ([2404:f801:9000:1a:efea::52c])
        by smtp.gmail.com with ESMTPSA id 16sm14490561pgz.76.2022.02.14.03.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 03:28:48 -0800 (PST)
Message-ID: <4f433f07-05be-f81f-43e8-55c3f1af23b3@gmail.com>
Date:   Mon, 14 Feb 2022 19:28:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V2 1/2] Swiotlb: Add swiotlb_alloc_from_low_pages switch
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, hch@infradead.org,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        michael.h.kelley@microsoft.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        brijesh.singh@amd.com, konrad.wilk@oracle.com,
        parri.andrea@gmail.com, thomas.lendacky@amd.com
References: <20220209122302.213882-1-ltykernel@gmail.com>
 <20220209122302.213882-2-ltykernel@gmail.com> <20220214081919.GA18337@lst.de>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20220214081919.GA18337@lst.de>
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

On 2/14/2022 4:19 PM, Christoph Hellwig wrote:
> Adding a function to set the flag doesn't really change much.  As Robin
> pointed out last time you should fine a way to just call
> swiotlb_init_with_tbl directly with the memory allocated the way you
> like it.  Or given that we have quite a few of these trusted hypervisor
> schemes maybe add an argument to swiotlb_init that specifies how to
> allocate the memory.

Thanks for your suggestion. I will try the first approach first approach.

