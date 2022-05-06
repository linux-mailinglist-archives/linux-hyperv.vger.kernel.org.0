Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E4751D19E
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 May 2022 08:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386415AbiEFGux (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 6 May 2022 02:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386438AbiEFGuv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 6 May 2022 02:50:51 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2AA66ADC;
        Thu,  5 May 2022 23:47:05 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e5so5402300pgc.5;
        Thu, 05 May 2022 23:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=SVrPke/lqrjA1eruVK5ZqtuF2QDsH4+WE7DbjG6xz4w=;
        b=p5Zkf2hHffFiPP9THSRb07u7RWxN20fY/fGHkeVuflQRrjwRSBK9cd2sUeO7pql7Ih
         eIgkGJhho1A5j8qGewXD9EiULFIRrKPe3jvxZ5DYF+wi3TXzIu1sp4Patebacss0A1MF
         4S+Ipj3D0yzhmsbYG9bCQD9SkCycdGP3kHms8TLXeclu7ZmQulb3Qxh+xKqvpHywI0Kt
         tb4u7jXZ4kRdFzzDGaVF551Yn4qMoWZtA38LkhVh9kLSwHQG54EhPROfqVEzEGg/kBP6
         t+aNIs9dKzP6K315J43S7a7x+9Cm4uZYmQGdO3FXSLViXQlq3uzinNap+q0rS83JX1xK
         CvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:organization
         :in-reply-to:content-transfer-encoding;
        bh=SVrPke/lqrjA1eruVK5ZqtuF2QDsH4+WE7DbjG6xz4w=;
        b=ccGZBGjY5ydvl2cT67jkC1rzWH6y3aWkDsteVmJAH1qbjvHznfc3o/+5p6tSpaiu+c
         oUeDw9u3NEVRvILIAF4gNfmdHUavF8czSJPagHFSgITogQaExjVOOb+z6I1LnViv9rBf
         kGIkXV0ipvvltdLI0Ikf8DNKhshZlVeEMWUjJmgL5Zr6Of1U9PITHS+DT/aPkl755Ukm
         5HpdD/cHhafScwC6RV2oLT3r0BapMWYccxZ8LOK/pHSGniSww5tKsAP45o/M58w+sRV8
         Ue3w6nviC5fDdwc+CYY91UPDVBZAYYdeywMrKNwTK16TXEPI5oGvo2S3MKifCRlFDR73
         0JIA==
X-Gm-Message-State: AOAM532YCMOzwPOrw1lAG5mQrWKGPozPW54m5uUHP+2D4OfjJcKaZZmQ
        S6OJW3Jqljy7v/HPI+taxC4=
X-Google-Smtp-Source: ABdhPJzPCYq+ZUPdXkfsCgdKUyuAi+Z0T9m4yjZSYC7CCbfoNU37JvO5+LqitStjiWBR+F5oahslKQ==
X-Received: by 2002:a63:d07:0:b0:3c2:7317:24c8 with SMTP id c7-20020a630d07000000b003c2731724c8mr1591014pgl.109.1651819624715;
        Thu, 05 May 2022 23:47:04 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:6:8000::e2? ([2404:f801:9000:18:efed::e2])
        by smtp.gmail.com with ESMTPSA id y1-20020aa79e01000000b0050dc7628175sm2560205pfq.79.2022.05.05.23.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 23:47:04 -0700 (PDT)
Message-ID: <6a00a53b-0653-4f82-3f7a-7374ec9b0ab8@gmail.com>
Date:   Fri, 6 May 2022 14:46:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: tiala@microsoft.com
Subject: Re: [PATCH] x86/Hyper-V: Add SEV negotiate protocol support in
 Isolation VM
Content-Language: en-US
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, brijesh.singh@amd.com,
        venu.busireddy@oracle.com, michael.roth@amd.com,
        Tianyu.Lan@microsoft.com, thomas.lendacky@amd.com, jroedel@suse.de,
        michael.h.kelley@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com
References: <20220505131502.402259-1-ltykernel@gmail.com>
 <20220505154717.GA3526@anparri>
From:   Tianyu Lan <ltykernel@gmail.com>
Organization: Microsft
In-Reply-To: <20220505154717.GA3526@anparri>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 5/5/2022 11:47 PM, Andrea Parri wrote:
> On Thu, May 05, 2022 at 09:15:02AM -0400, Tianyu Lan wrote:
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>
>> Hyper-V Isolation VM code uses sev_es_ghcb_hv_call() to read/write MSR
>> via GHCB page. The SEV-ES guest should negotiate GHCB version before
>> reading/writing MSR via GHCB page. Expose sev_es_negotiate_protocol()
>> and sev_es_terminate() from AMD SEV code and negotiate GHCB version in
>> hyperv_init_ghcb() fro Hyper-V Isolation VM.
>>
>> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> Applied to tip's x86/sev and checked that this can fix the regression (to
> be introduced) by commit 2ea29c5abbc2 ("x86/sev: Save the negotiated GHCB
> version"):
> 
> Tested-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> 
> Nits: (in the commit message) fro -> for, Isolation VM -> Isolated VM
> 

Nice catch! Thanks.
