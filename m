Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1E859882F
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Aug 2022 18:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344424AbiHRP7g (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Aug 2022 11:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344365AbiHRP7b (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Aug 2022 11:59:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0423A5A3DC
        for <linux-hyperv@vger.kernel.org>; Thu, 18 Aug 2022 08:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660838368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s6slTsTy/Pyr3LUrFg5ZWWvb0V6yCPma3CmmqBIOSdY=;
        b=H0EW+IjtDns3PU9xPMlV0FeRTub7LmtJ8CU76Z6PeES1cJfXfoNjEKR+YmW9We4DROgxSa
        XV+631vF/+/yLWKLz2I9TIIT/TvUrsJ0IoUjUUXJ7Abox/I/4lKPgXv73z1HT0Ol/dasC3
        zQKfMZjfK5wLHtfiSoeLRhBap/Xsma4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-534-AwRx4NbIPVqmw8PdB1lRNw-1; Thu, 18 Aug 2022 11:59:26 -0400
X-MC-Unique: AwRx4NbIPVqmw8PdB1lRNw-1
Received: by mail-ed1-f70.google.com with SMTP id m22-20020a056402431600b0043d6a88130aso1176830edc.18
        for <linux-hyperv@vger.kernel.org>; Thu, 18 Aug 2022 08:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=s6slTsTy/Pyr3LUrFg5ZWWvb0V6yCPma3CmmqBIOSdY=;
        b=PR+4yUCqJv1FW+mlvBacbUkjuzNA3ccw6hecHpBQ/LPhLrAWqKr/rhC/uSLIoXdNLq
         HNIB8hCXOuLLp1CWCO4b5J4Gf3ala2TzXxuGRr+NgZVeyoTtRzQTAa98x194RB/UNH70
         GheUbK9Jep9Saj5q0NRCWabK0Np2BD5UjF6orcnpgNdCyEkcVhoa3l1OCSayr3Cx1FRg
         wntA9aBsPymAvOUPfOk82ktggdD9y0zHXMG/+NjpMqwanmNCrf7+HyPAKymaWrlGwbEy
         dCj0//ZtFJwz5SesXoY6NtUjEzqBUNuWmJ2CMEDDuwUVppXy28vSm4ax6hgzX2nqwvxE
         vfeA==
X-Gm-Message-State: ACgBeo3NXfjaPkOr1pa8d2HL+PAuqbCws9puBkIlM/EX7DdEieyHNLVI
        NSqSnZWtTXlm/BdOwoycV0dQUxFg233Xefa7uk26ojSsvZ5su0bO2/2ykij7Jpj8peErUhQ9UZW
        nYNwoeacZMpFVgo1BLzty660P
X-Received: by 2002:a17:907:16ab:b0:731:55c0:e7a1 with SMTP id hc43-20020a17090716ab00b0073155c0e7a1mr2262769ejc.154.1660838364165;
        Thu, 18 Aug 2022 08:59:24 -0700 (PDT)
X-Google-Smtp-Source: AA6agR43/Fekyuhe13hqCkeDMRAWKoBKaprssqUdg/IBU7sIkeVPGzkM+98pWaDy6eX29y9yAdIC3Q==
X-Received: by 2002:a17:907:16ab:b0:731:55c0:e7a1 with SMTP id hc43-20020a17090716ab00b0073155c0e7a1mr2262742ejc.154.1660838363940;
        Thu, 18 Aug 2022 08:59:23 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id v2-20020a170906292200b0071cef6c53aesm1000562ejd.0.2022.08.18.08.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 08:59:23 -0700 (PDT)
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
In-Reply-To: <Yv5fcKOEVAlAh0px@google.com>
References: <20220802160756.339464-1-vkuznets@redhat.com>
 <20220802160756.339464-2-vkuznets@redhat.com>
 <Yv5XPnSRwKduznWI@google.com> <878rnltw7b.fsf@redhat.com>
 <Yv5fcKOEVAlAh0px@google.com>
Date:   Thu, 18 Aug 2022 17:59:22 +0200
Message-ID: <8735dttued.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Aug 18, 2022, Vitaly Kuznetsov wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> 
>> > On Tue, Aug 02, 2022, Vitaly Kuznetsov wrote:
>> >> For some features, Hyper-V spec defines two separate CPUID bits: one
>> >> listing whether the feature is supported or not and another one showing
>> >> whether guest partition was granted access to the feature ("partition
>> >> privilege mask"). 'Debug MSRs available' is one of such features. Add
>> >> the missing 'access' bit.
>> >> 
>> >> Note: hv_check_msr_access() deliberately keeps checking
>> >> HV_FEATURE_DEBUG_MSRS_AVAILABLE bit instead of the new HV_ACCESS_DEBUG_MSRS
>> >> to not break existing VMMs (QEMU) which only expose one bit. Normally, VMMs
>> >> should set either both these bits or none.
>> >
>> > This is not the right approach long term.  If KVM absolutely cannot unconditionally
>> > switch to checking HV_ACCESS_DEBUG_MSRS because it would break QEMU users, then we
>> > should add a quirk, but sweeping the whole thing under the rug is wrong.
>> >
>> 
>> First, this patch is kind of unrelated to the series so in case it's the
>> only thing which blocks it from being merged -- let's just pull it out
>> and discuss separately.
>
> Regarding the series, are there any true dependencies between the eVMCS patches
> (1 - 11) and the VMCS sanitization rework (12 - 26)?  I.e. can the VMCS rework
> be queued ahead of the eVMCS v1 support?

My memory is a bit blurry already but I think PATCH11 ("KVM: VMX: Get
rid of eVMCS specific VMX controls sanitization") needs to go before
PATCH24 ("KVM: nVMX: Use sanitized allowed-1 bits for VMX control MSRs")
to have "bug compatibility" and resolve Jim's concern: guest visible
VMX feature MSR values are not supposed to change. Currently, we filter
out unsupported features from eVMCS for KVM itself but not for L1 as we
expose raw host MSR values there. This is likely broken if L1 decides to
*use* these features for real but that's another story.

-- 
Vitaly

