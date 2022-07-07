Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC4156A667
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Jul 2022 16:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbiGGO6v (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Jul 2022 10:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236742AbiGGO6T (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Jul 2022 10:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BC63338
        for <linux-hyperv@vger.kernel.org>; Thu,  7 Jul 2022 07:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657205868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BPPyfbm7cP61/jDVpNfbjlUmaFCLU4YcNzeyYG8WmXc=;
        b=dBXBk+Df5Pj5p9vcoHut1p1ZjxXRc/8OnZzY1jwPeKahGX59HI/vT+unF7GRzTWeHVVh/E
        oxm+PFujqoznfgYyF4rONJhpXMUj582AAosA1ugTk6Dv3Ln8RyT30z0gi25Sn4Uq1xgnPl
        fMs4xlXlTvNad9fFSNCdi9v7HN8ID9w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-YpzdQTdNM6-1vumSglSzfw-1; Thu, 07 Jul 2022 10:57:47 -0400
X-MC-Unique: YpzdQTdNM6-1vumSglSzfw-1
Received: by mail-wm1-f72.google.com with SMTP id t4-20020a1c7704000000b003a2cfaeca37so675698wmi.5
        for <linux-hyperv@vger.kernel.org>; Thu, 07 Jul 2022 07:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=BPPyfbm7cP61/jDVpNfbjlUmaFCLU4YcNzeyYG8WmXc=;
        b=6olkgyR6muifUQZSgD5ctu3ntEMRYs7c7X1otMIvFPuNAloBfhsz8yic4f1/FwxPnh
         CMTmeW1vopN/s/ENbP/qRWbsE/mDGZ4Fg2ZrFxsNGVzkI1vjke5egJWRCfHA8ifFVtqQ
         owhB/YaG9WfUOWdYlA+OxEWlTVnEa9sZNiZ0EFG5fVHoheHBXJKcixqmwTfW7hCJ8+K7
         6C40kgt/U++43/dGPxxsYc5Z/4qJskaz34U4BjLKm9blBFlkka+VdUjC1swH4FgQ8SEb
         zPtQtRHkMtsChCSQNkTOnudn0JcgZL6CWddG5aM70LY1tjIXGV4RRMzvNbKdSnxSES3l
         9T+A==
X-Gm-Message-State: AJIora8K+V/LSxvDtLNQCe03DctavznITQEOwG3GganjOkD59AH7pGTB
        lgIrRQ/aBWJSP6iO/1wTEGdrpcymrTxsvW6VHAI/B1A5L1mP7qvCl9jsxZLKAseIxrj2npwh3G/
        JblHysxa78mWOw+HrnXWWiWZW
X-Received: by 2002:a05:600c:3511:b0:3a1:9992:f72f with SMTP id h17-20020a05600c351100b003a19992f72fmr5166863wmq.164.1657205866241;
        Thu, 07 Jul 2022 07:57:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u0/E4oQnfuVVwr2Quhckj80YkdpdC1DUvgHP9mLEG3FQiLuZoO9arVkl3lDbI9tW7XUnCGwg==
X-Received: by 2002:a05:600c:3511:b0:3a1:9992:f72f with SMTP id h17-20020a05600c351100b003a19992f72fmr5166839wmq.164.1657205866008;
        Thu, 07 Jul 2022 07:57:46 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id y8-20020adfee08000000b0021d6e49e4ebsm9673078wrn.10.2022.07.07.07.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 07:57:45 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 22/28] KVM: VMX: Clear controls obsoleted by EPT at
 runtime, not setup
In-Reply-To: <CALMp9eRA0v6BK6KG81ZE_iLKF6VNXxemN=E4gAE4AM-V4gkdHQ@mail.gmail.com>
References: <20220629150625.238286-1-vkuznets@redhat.com>
 <20220629150625.238286-23-vkuznets@redhat.com>
 <CALMp9eRA0v6BK6KG81ZE_iLKF6VNXxemN=E4gAE4AM-V4gkdHQ@mail.gmail.com>
Date:   Thu, 07 Jul 2022 16:57:44 +0200
Message-ID: <87wncpotqv.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Jim Mattson <jmattson@google.com> writes:

> On Wed, Jun 29, 2022 at 8:07 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> From: Sean Christopherson <seanjc@google.com>
>>
>> Clear the CR3 and INVLPG interception controls at runtime based on
>> whether or not EPT is being _used_, as opposed to clearing the bits at
>> setup if EPT is _supported_ in hardware, and then restoring them when EPT
>> is not used.  Not mucking with the base config will allow using the base
>> config as the starting point for emulating the VMX capability MSRs.
>>
>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Nit: These controls aren't "obsoleted" by EPT; they're just no longer
> required.

Sean,

I'm going to update the subject line to "KVM: VMX: Clear controls
unneded with EPT at runtime, not setup" retaining your authorship in v3
(if there are no objections, of course).

>
> Reviewed-by: Jim Mattson <jmattson@google.com>
>

Thanks!

-- 
Vitaly

