Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B99569F11
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Jul 2022 12:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbiGGKDU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Jul 2022 06:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiGGKDT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Jul 2022 06:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FD664F1AE
        for <linux-hyperv@vger.kernel.org>; Thu,  7 Jul 2022 03:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657188198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mNWEDxqg1cccxdZ0v7jY1fOIP46IJFXlMCuR5euWthM=;
        b=f1IFVK7nDBX2AENHCVcb/SoyI+diJawPWoxWKRnxAW5MV4GfJU3nNCENBNgICgZIH66Suf
        iZJXzlD11qq/f+VL6BhqOinXqyU6QbF+xnymgCx2o2qHCvcEBDpmSiDisgC4XHLAQ8GbYm
        bseb1tPqxlAfR4Vf0OOcmKHjc7xa9gE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-1yfd3PW_OAuiqCrGwIBPXw-1; Thu, 07 Jul 2022 06:03:17 -0400
X-MC-Unique: 1yfd3PW_OAuiqCrGwIBPXw-1
Received: by mail-ed1-f71.google.com with SMTP id v16-20020a056402349000b00435a1c942a9so13690786edc.15
        for <linux-hyperv@vger.kernel.org>; Thu, 07 Jul 2022 03:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=mNWEDxqg1cccxdZ0v7jY1fOIP46IJFXlMCuR5euWthM=;
        b=G3w01jdXDSKpWdfmfvMDOENBL4N12VLL2Mq2Dwt1P9blEz7Tx5H/rw/fQnsrj0faSV
         yO8AZMerTIp2VdyDZZPGj6ZinYkmWiBlvwSP4ADnoFo28hrnvmfJNIwaKf8h9wY4Of+x
         X3DFJ9uEmKMfi4ZsTKNFs4Sb+nyZxws9+WX5RcxMgOy3LE4N+hsExrnWpj5OWAKV5OOB
         9hFO3P2VxL5UkLm6Vvd+txEr2QvI8pRrWorVJyCqsCu5Sv+LTG7FTxhY3qYeqL8lUgBr
         QXN9EHOMUwEUQFJYT81P6E+ZYpvQX3sMpY13vqXZi2hzYZCRGSoGPw4GAqvl4qBkc9ax
         42BA==
X-Gm-Message-State: AJIora9dpYtNcrKZmLG/xel2hqBhqeVZk/GsuMaWyTSMjVlVtNHWPM+P
        k8rrZwvXJH6VWD6ggrjFKBGYayQ1b0y0WgZGR3HblIO5UkHyPwDEGWXLx0xoAQJUL/FYFRXN7+Y
        Nbs+MLkr1M3dAZ1Sq4ZOfALba
X-Received: by 2002:a17:907:7f22:b0:726:8962:d5a6 with SMTP id qf34-20020a1709077f2200b007268962d5a6mr44679629ejc.717.1657188196178;
        Thu, 07 Jul 2022 03:03:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u4TDOGXhUWTv81WhVbKpEdofsrU7RbUvvcAymyzuKgcvYHSqvCL2Hj13lnlsPJasUfZ5xXrA==
X-Received: by 2002:a17:907:7f22:b0:726:8962:d5a6 with SMTP id qf34-20020a1709077f2200b007268962d5a6mr44679605ejc.717.1657188195954;
        Thu, 07 Jul 2022 03:03:15 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id ky6-20020a170907778600b0072b0d3ca423sm793207ejc.187.2022.07.07.03.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 03:03:15 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/28] KVM: VMX: Get rid of eVMCS specific VMX
 controls sanitization
In-Reply-To: <YsYMPCr3/ig0xPFj@google.com>
References: <20220629150625.238286-1-vkuznets@redhat.com>
 <20220629150625.238286-14-vkuznets@redhat.com>
 <YsYMPCr3/ig0xPFj@google.com>
Date:   Thu, 07 Jul 2022 12:03:14 +0200
Message-ID: <87ilo9qly5.fsf@redhat.com>
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

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Jun 29, 2022, Vitaly Kuznetsov wrote:
>> With the updated eVMCSv1 definition, there's no known 'problematic'
>> controls which are exposed in VMX control MSRs but are not present in
>> eVMCSv1. Get rid of the filtering.
>
> Ah, this patch is confusing until one realizes that this is dropping the "filtering"
> for what controls/features _KVM_ uses, whereas nested_evmcs_filter_control_msr()
> filters controls that are presented to L1.
>
> Can you add something to clarify that in the changelog?

Yea, this is for KVM-on-Hyper-V only, I'll fix the changelog.

-- 
Vitaly

