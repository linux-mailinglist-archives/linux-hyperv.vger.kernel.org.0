Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5F759873B
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Aug 2022 17:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242310AbiHRPU6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Aug 2022 11:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343601AbiHRPUb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Aug 2022 11:20:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC575A3CB
        for <linux-hyperv@vger.kernel.org>; Thu, 18 Aug 2022 08:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660836029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3GQGhpbZE8ROB+knhR1egNzmPjUJp4WnI2UO3qznnGI=;
        b=TiCxWfNfaoo7OG2GAolITqe0T+j8XORHAX2lDhUnB7ffAkPIWKU/hbtg/A6AOV2WhSfUYP
        i8RQUYcio62tVNM9xNUG4nGNupjA0Wn+76IMN1alMX8IAETf5Pmlry+oQ7u7ZuSa4vnEQb
        tJj8SajWeLA2nZw/NJGSQ4LxCpVDi5k=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-327-yL2cimwrNJasxKB1MNl4JQ-1; Thu, 18 Aug 2022 11:20:28 -0400
X-MC-Unique: yL2cimwrNJasxKB1MNl4JQ-1
Received: by mail-ed1-f71.google.com with SMTP id w17-20020a056402269100b0043da2189b71so1118210edd.6
        for <linux-hyperv@vger.kernel.org>; Thu, 18 Aug 2022 08:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=3GQGhpbZE8ROB+knhR1egNzmPjUJp4WnI2UO3qznnGI=;
        b=BUqLKYZmppIDjKMwIhKUwIgO1qzF5R14n61milc2ziMJ5nXSolOfMmJWju6xRc6FpC
         Yk/ENc4xYqA1Fy2VHZ7TyF5d5U9+jiWCgRnUNaoajo9/lrKhUuntuiktVD9bT0KBsHGL
         WzA7L5OE733kZzFHwwdLZ6+ZTU/r95FGtOgjFFoCmLowUE0aXCrI6Gs/wA87PpNEzrmd
         Lz9FNoBCgdP+YEwHWPuF6Hys6tB7lnbPBSJFlH8lu62QN/YU7fzmZe+tzJo+8QR677Yo
         2mh1iYJEwF2duX2CCtB+xUT/NUDprkFR7KhAVfM0oDXN/aGBfMc3wSEMY1oL4D+SI579
         uXOw==
X-Gm-Message-State: ACgBeo1ozqMk9w6DBpNUUwk1YdqJ1alGTH5luOO+Pmg1RyVjUc8UuHPH
        foVKICplzTLSa5Q7tjLrV3iINqVErvny/rhZwGVtrha2uuatCU+JYJPPQ1Y2Ol0VMHvCjiLul+H
        XKRo5GoJHw1L+TdB4WK/+6GS+
X-Received: by 2002:a17:906:9b09:b0:730:9480:9729 with SMTP id eo9-20020a1709069b0900b0073094809729mr2228159ejc.588.1660836025926;
        Thu, 18 Aug 2022 08:20:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7bh4JrZAPWDBf+wZbX/JS8gz/ZAVA15O/nNLBF7TBz5gRTyDxEDV3jKJnQao0yfUYyQPmZUg==
X-Received: by 2002:a17:906:9b09:b0:730:9480:9729 with SMTP id eo9-20020a1709069b0900b0073094809729mr2228146ejc.588.1660836025686;
        Thu, 18 Aug 2022 08:20:25 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p6-20020a05640210c600b0043df40e4cfdsm1308866edu.35.2022.08.18.08.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 08:20:25 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/26] KVM: x86: hyper-v: Expose access to debug MSRs
 in the partition privilege flags
In-Reply-To: <Yv5XPnSRwKduznWI@google.com>
References: <20220802160756.339464-1-vkuznets@redhat.com>
 <20220802160756.339464-2-vkuznets@redhat.com>
 <Yv5XPnSRwKduznWI@google.com>
Date:   Thu, 18 Aug 2022 17:20:24 +0200
Message-ID: <878rnltw7b.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Aug 02, 2022, Vitaly Kuznetsov wrote:
>> For some features, Hyper-V spec defines two separate CPUID bits: one
>> listing whether the feature is supported or not and another one showing
>> whether guest partition was granted access to the feature ("partition
>> privilege mask"). 'Debug MSRs available' is one of such features. Add
>> the missing 'access' bit.
>> 
>> Note: hv_check_msr_access() deliberately keeps checking
>> HV_FEATURE_DEBUG_MSRS_AVAILABLE bit instead of the new HV_ACCESS_DEBUG_MSRS
>> to not break existing VMMs (QEMU) which only expose one bit. Normally, VMMs
>> should set either both these bits or none.
>
> This is not the right approach long term.  If KVM absolutely cannot unconditionally
> switch to checking HV_ACCESS_DEBUG_MSRS because it would break QEMU users, then we
> should add a quirk, but sweeping the whole thing under the rug is wrong.
>

First, this patch is kind of unrelated to the series so in case it's the
only thing which blocks it from being merged -- let's just pull it out
and discuss separately.

My personal opinion is that in this particular case we actually can
switch to checking HV_ACCESS_DEBUG_MSRS and possibly backport this patch
to stable@ and be done with it as SynDBG is a debug feature which is not
supposed to be used much in the wild. This, however, will not give us
much besides 'purity' in KVM as no sane VMM is supposed to set just one
of the HV_FEATURE_DEBUG_MSRS_AVAILABLE/HV_ACCESS_DEBUG_MSRS bits. TL;DR:
I'm not against the change.

-- 
Vitaly

