Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F47A520BB5
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 May 2022 05:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbiEJDLU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 9 May 2022 23:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbiEJDLT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 9 May 2022 23:11:19 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4566200F54;
        Mon,  9 May 2022 20:07:22 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id s14so15609581plk.8;
        Mon, 09 May 2022 20:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=eyb6HE0aStupgdY5e1T3X6/fpQLUuJk/A7MCfbx8it0=;
        b=WAuXlFov5rxE53WVcRZLApGiCFyRF7LhHaC7fZmHhqVWfxb/xkpI33YIvGUh594l33
         KWn5cKehBBbnw/LBOU59yNJ6Z0KoT1kBWPr8qTvZau/wI/XckGhSzeHXCvrHyL5fLBzD
         zd4qYishGbUGqebip/6dDGzzL1ImMQqL0WGTJKOPSVboiL1WjUPACAHy9KpbCocWWoeK
         3pmwvIlYGG4vO8WAnHGg9QsxwICIf7XhJyKwNI9EISOUvxTfole9rclv0Tas0qSrFKgz
         9jQFWbBd+rxAWOn5YEAZRBwsFNNNWNQn8W4MkpdwlisIpSaT+H+YkOVAJ6JH7qFwQadT
         2yWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:organization
         :in-reply-to:content-transfer-encoding;
        bh=eyb6HE0aStupgdY5e1T3X6/fpQLUuJk/A7MCfbx8it0=;
        b=LXWD49Jve4W/1ZvMHWPNR1Vnmu4YE6N4L3pyo85CxxSRkv90m14N/uAOqw70OidN8z
         fRyrK03NDZC/p0h1Wh1ZsTQszdyiehGHp0FNq8J+agq/PbnR/2kypeZnZHmt53BBvdML
         2QnOdAu7+STu/MrQ/q2FCp6jH02RHiaHflytIkVgdhhl/iuxOEUCmVfA5bIVnadMvO3s
         b5A7mwALshOL5QMmk7ZVVEM5CdWqOxGSuKOTfOVIO/XmjDnKqM/NAczfI9iwSjXElIK1
         qvAM98Fg12bKMbf1V5JZ2/6YEWVZYeJkCDPDOPGmNNAmqi79ZJ1GlqARs/0v4tDd3Urv
         YfQA==
X-Gm-Message-State: AOAM533QOUOtvP5sKI1TEQQoAGmNM+wh96dUd2TqPu1/1Kb8jecRGt+2
        cNm+1OKdts4iT4U+oZe3Dt4=
X-Google-Smtp-Source: ABdhPJyvTuAE2lqBQDTIpJPUYkLP0W1nBRHHGgimK7qiGCE3o7KbKoH9b6m9bDMfK9bNd1ene+5LZg==
X-Received: by 2002:a17:90a:db51:b0:1dc:9da2:793b with SMTP id u17-20020a17090adb5100b001dc9da2793bmr28972739pjx.77.1652152042333;
        Mon, 09 May 2022 20:07:22 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:6:8000::78? ([2404:f801:9000:18:efed::78])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d2c100b0015eafc485c8sm606664plc.289.2022.05.09.20.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 20:07:21 -0700 (PDT)
Message-ID: <24726c1c-42a8-e2f2-2222-0676c8a3869f@gmail.com>
Date:   Tue, 10 May 2022 11:07:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: tiala@microsoft.com
Subject: Re: [PATCH] x86/Hyper-V: Add SEV negotiate protocol support in
 Isolation VM
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, brijesh.singh@amd.com, venu.busireddy@oracle.com,
        michael.roth@amd.com, Tianyu.Lan@microsoft.com,
        thomas.lendacky@amd.com, jroedel@suse.de,
        michael.h.kelley@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        parri.andrea@gmail.com
References: <20220505131502.402259-1-ltykernel@gmail.com>
 <YnmaSB2WCJwqaZae@zn.tnic>
From:   Tianyu Lan <ltykernel@gmail.com>
Organization: Microsft
In-Reply-To: <YnmaSB2WCJwqaZae@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 5/10/2022 6:48 AM, Borislav Petkov wrote:
> On Thu, May 05, 2022 at 09:15:02AM -0400, Tianyu Lan wrote:
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>
>> Hyper-V Isolation VM code uses sev_es_ghcb_hv_call() to read/write MSR
>> via GHCB page. The SEV-ES guest should negotiate GHCB version before
>> reading/writing MSR via GHCB page.
> 
> Why is that?
> 
>> Expose sev_es_negotiate_protocol() and sev_es_terminate() from AMD SEV
>> code
> 
> Yeah, you keep wanting to expose random SEV-specific code and when we
> go and change it in the future, you'll come complaining that we broke
> hyperv.
> 
> I think it might be a lot better if you implement your own functions:
> for example, looking at sev_es_negotiate_protocol() - it uses only
> primitives which you can use because, well, VMGEXIT() is simply a
> wrapper around the asm insn and sev_es_wr_ghcb_msr() is simply writing
> into the MSR.
> 
> Ditto for sev_es_terminate().
> 
> And sev_es_ghcb_hv_call() too, for that matter. You can define your own.
> 
> IOW, you're much better off using those primitives and creating your own
> functions than picking out random SEV-functions and then us breaking
> your isolation VM stuff.
> 

OK. I got it. Thanks for your suggestion.

