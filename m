Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD3F5866A1
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Aug 2022 10:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiHAIzD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 1 Aug 2022 04:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiHAIzC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Aug 2022 04:55:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F158B3AE77
        for <linux-hyperv@vger.kernel.org>; Mon,  1 Aug 2022 01:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659344101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BxiaabKGDEEtXA0mz5czXoc0qeEtxLpaIEZjWv8Aze0=;
        b=bnBhZhCbLoJouxZ569lxIEjwBBli2N4iTerV3vedrW1JiGqUhxAleloy3GkcIqA+5WzlSU
        wZ9hZsv4/1AKkL4QimuNBRylpWFIWg6FBQgxadpMbyJUfAbK60tS1HrjQHux28pX3jkS+K
        aWp1TX0M1tIHHehN66e+Qmc3j+8y+u4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-jAagfy-rOEuV5lgPy3-U5A-1; Mon, 01 Aug 2022 04:54:57 -0400
X-MC-Unique: jAagfy-rOEuV5lgPy3-U5A-1
Received: by mail-wr1-f69.google.com with SMTP id w22-20020adf8bd6000000b002206311fb96so439056wra.12
        for <linux-hyperv@vger.kernel.org>; Mon, 01 Aug 2022 01:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=BxiaabKGDEEtXA0mz5czXoc0qeEtxLpaIEZjWv8Aze0=;
        b=33DQC4tQ/j7n9aHylkEiKn/UaANZz2qNVXMnugbmRMxSUr/BjcrfnN2d/k57n46G8W
         HskmlgJFI3a640+/J+JSJq5TUHqsII/uqrAZEAPOAFQOujTICZ9FPqV0f5XH3kkoBcUC
         0j1ehmb95Cjm49vNAFrUpg8x6QPWhyRng4SkIJ97I/v7WMM5n/QVI3AQFdc17ptEJJRU
         Ka5XJL3u82wRnI6/Dhc9XZSzmSozeEHlBryBKPdZipy4TlkAgYuDwRF3HNmQEdWdgjPE
         irQMQKB5knFI+MU31wSwmt1jc/00M04DDMl9a5SEk/LLNoTPos5Qy3kg6v9e9PLbNV2+
         V0+g==
X-Gm-Message-State: AJIora9xs3qzuMT+CeC0xhBv2ae/ze04hkoVxIAo53Q7DVQaZYuEP8RU
        /p31HoAzz7mWRACDsbpVgbzuD6mNM5cUMFnFVYhY/+mahx+v/XONF/P5H6rs6knQc5pVANONz38
        WNrAXTo+M69ADiE1Bok0UCxGL
X-Received: by 2002:a1c:2584:0:b0:3a1:9de1:f2cd with SMTP id l126-20020a1c2584000000b003a19de1f2cdmr9827299wml.182.1659344096630;
        Mon, 01 Aug 2022 01:54:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vPXHZnEm7WMbonZJJdCYbmjiBsmz6Iyba+hidulBSCOoByBRhmsHlJYAmd1cCIvqAHDv/xhA==
X-Received: by 2002:a1c:2584:0:b0:3a1:9de1:f2cd with SMTP id l126-20020a1c2584000000b003a19de1f2cdmr9827284wml.182.1659344096428;
        Mon, 01 Aug 2022 01:54:56 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p3-20020a5d68c3000000b0021ee65426a2sm11153544wrw.65.2022.08.01.01.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 01:54:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/25] KVM: VMX: nVMX: Support TSC scaling and
 PERF_GLOBAL_CTRL with enlightened VMCS
In-Reply-To: <62ac29cb-3270-a810-bad1-3692da448016@redhat.com>
References: <20220714091327.1085353-1-vkuznets@redhat.com>
 <20220714091327.1085353-10-vkuznets@redhat.com>
 <YtnMIkFI469Ub9vB@google.com>
 <48de7ea7-fc1a-6a83-3d6f-e04d26ea2f05@redhat.com>
 <Yt7ehL0HfR3b97FQ@google.com>
 <870d507d-a516-5601-4d21-2bfd571cf008@redhat.com>
 <YuMKBzeB2cE/NZ2K@google.com>
 <62ac29cb-3270-a810-bad1-3692da448016@redhat.com>
Date:   Mon, 01 Aug 2022 10:54:54 +0200
Message-ID: <875yjc2vj5.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 7/29/22 00:13, Sean Christopherson wrote:
>> The only flaw in this is if KVM gets handed a CPUID model that enumerates support
>> for 2025 (or whenever the next update comes) but not 2022.  Hmm, though if Microsoft
>> defines each new "version" as a full superset, then even that theoretical bug goes
>> away.  I'm happy to be optimistic for once and give this a shot.  I definitely like
>> that it makes it easier to see the deltas between versions.
>
> Okay, I have queued the series but I still haven't gone through all the 
> comments.  So this will _not_ be in the 5.21 pull request.
>
> The first patch also needs a bit more thought to figure out the impact 
> on userspace and whether we can consider syndbg niche enough to not care.

(Sorry for delayed replies here, I'm back from vacation now)

The first patch is not a requirement for the rest of the series, we can
discuss it separately. I, however, think that we can just keep checking
HV_FEATURE_DEBUG_MSRS_AVAILABLE in hv_check_msr_access() to be
compatible with existing QEMUs and make QEMU expose both
HV_FEATURE_DEBUG_MSRS_AVAILABLE and HV_ACCESS_DEBUG_MSRS unconditionally
when syndbg feature is enabled as we know that missing
HV_ACCESS_DEBUG_MSRS is just a bug. I don't think we actually need to
be so picky and support VMMs which want to set 'syndbg without access to
it' and 'access to syndbg without syndbg' use-cases. All-or-nothing is
likely good enough.

-- 
Vitaly

