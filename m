Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFA957B103
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Jul 2022 08:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbiGTGYJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Jul 2022 02:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGTGYI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Jul 2022 02:24:08 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30680459B2;
        Tue, 19 Jul 2022 23:24:08 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 23so15517423pgc.8;
        Tue, 19 Jul 2022 23:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qW4cVmX1h5qZcLNtal52XJ6b8VLXyII7R4K8/LUylOY=;
        b=b9nJbugDE8v6UEtq08WfqdV8g/Ro42CRXvk8R9JRfDaW1nqNrnKYkJznV4y3fyh3jD
         xU3ZVvaeKxIIMu6B2Xn6kodlPD4H6uT2gPc6XcLTOur+9ur5qFUwKg7pnQID3yyY8aah
         BUtRjQaC7c16DIm9PUQs349wmd6X7v8+ymhZXLZ9TEPWYXkvTKKzMvQy37gZojABPK2y
         MzOmy3swv+oTq+t+KzSJXn3YAUd9Kiw0lxQB2CtALKx6MA82zf+J2ozdmB6yh+O9xuwF
         N3u30wkxj1mucmMQDugX8M41NqLUbGYVaFmHYzkjZaNd3ACPALWTMls57nKDU9Wd+wjV
         EyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qW4cVmX1h5qZcLNtal52XJ6b8VLXyII7R4K8/LUylOY=;
        b=HxQuexyeOpZQWK0ZP3BOyBl5/0khkWbUMWKk9jlvC6oo/3J5FTh7gujvY4IzSsOgnR
         Nhn1Wa0ccoCPEp2To1xTanc+uPJ4Fb+2ePokk6tuqXf71DsHtEM8qEL89zuG8azzSUcD
         CgPx0MCGDnp7Mf3TDGHeVe9Gn7rgMwTVgVtghc6gstPgQc/t8hWXBu4W4BOp9hz+G4th
         uUYnbw+EvoC7t7I0dSLcOkcOE0+XaYpi0UtkOgfktFggVLLa5uqhj5O4D9pZJmtT7Heh
         80xqjU/1JA4MO5jT5f6180zeSa+1UjXah7G/wHsVpFHYQYYUWowwDDX+MLAzPQNR2Nv/
         I4Hg==
X-Gm-Message-State: AJIora9IFFSdW55uOWZeOH+7CLGgy7Z6c/XO+qH7oen+8Lr0WicoFata
        TQU4YnyHzrGRB9qyqmYyzd0=
X-Google-Smtp-Source: AGRyM1t20nKvY5mV9uyAaORDu5M6aIvYGVS5ZptGu3bcOMOYwTEMY3j9cRRop4fUq6UWUwH9CnM8jA==
X-Received: by 2002:a63:8549:0:b0:415:ed3a:a0c with SMTP id u70-20020a638549000000b00415ed3a0a0cmr31889521pgd.448.1658298247575;
        Tue, 19 Jul 2022 23:24:07 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902eccb00b0016a034ae481sm12961967plh.176.2022.07.19.23.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 23:24:07 -0700 (PDT)
Message-ID: <020db88c-981f-01fb-9689-3e54824f260a@gmail.com>
Date:   Wed, 20 Jul 2022 14:23:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4] swiotlb: Split up single swiotlb lock
Content-Language: en-US
To:     "hch@infradead.org" <hch@infradead.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        KY Srinivasan <kys@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "kirill.shutemov@intel.com" <kirill.shutemov@intel.com>,
        "andi.kleen@intel.com" <andi.kleen@intel.com>,
        Andi Kleen <ak@linux.intel.com>
References: <20220708161544.522312-1-ltykernel@gmail.com>
 <PH0PR21MB3025C32C80BFBE8651CF196AD78C9@PH0PR21MB3025.namprd21.prod.outlook.com>
 <YtefA9mZJo5+YzBG@infradead.org>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <YtefA9mZJo5+YzBG@infradead.org>
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

On 7/20/2022 2:21 PM, hch@infradead.org wrote:
> Tianyu or Michael, can someone please send me a fixup patch for this?
> 

Sure. I will do this soon.
