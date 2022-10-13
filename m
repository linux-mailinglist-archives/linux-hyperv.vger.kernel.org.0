Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E174B5FD6D1
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Oct 2022 11:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiJMJQd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 Oct 2022 05:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiJMJQb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 Oct 2022 05:16:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B90125598
        for <linux-hyperv@vger.kernel.org>; Thu, 13 Oct 2022 02:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665652586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c1PougXwFNeOBx9Qjbr5s56x+6pgJ2sjuaM5Urh09Fk=;
        b=hi7Sxs3NUN5tw74/8sYvvgVIUK8SB5X2/LwQmwLLi28U1NhOwQUi8ykWVXfSUFBrXEJ/l8
        xpxmpjd81gFK/6a/KiWWrDNc2mYmjUssfVDk3Lcclll7R6olcLfPAofB6bNHhb/ThLJOyS
        LleJ1zdyp3vTSwPWCjpFeNXr+s6JT08=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-595-CAoK-u55PSOJwux_SIqWhA-1; Thu, 13 Oct 2022 05:16:25 -0400
X-MC-Unique: CAoK-u55PSOJwux_SIqWhA-1
Received: by mail-wr1-f72.google.com with SMTP id u20-20020adfc654000000b0022cc05e9119so307428wrg.16
        for <linux-hyperv@vger.kernel.org>; Thu, 13 Oct 2022 02:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1PougXwFNeOBx9Qjbr5s56x+6pgJ2sjuaM5Urh09Fk=;
        b=oAWRRChcGmD8B1qivxuwrczMk4Pf9WhGIIlhH8w29pToUdzXDgT7JonpKKvGUk3mdA
         xykWcQrFPu6O95c7k1Gx7g+sStzf/SGnhgfo+72u7+nVYCPwkSqhazSz3U003LpgNG1z
         1Dsl3dFtX4cRG+5tWUn7vvnDfcJB3N5Fkvr9gkTpNEzE4PuJDaBp22unAL2FIww9fttx
         Tv9YpJWRrjVUTrvudRwZaYuqHWel0oC1EnYUFpG96VimNtbV6FD1lXUqrjlBggdcgJ4K
         NsYEv+mbVLllpj5i8dG1m5ZngqvdWph4Qcr5KxrdCLnG7ZgKXXsBJNrcNNiMe+gv1tOy
         EHHg==
X-Gm-Message-State: ACrzQf3XC7ci1V2LObQ0TY8/bHk7h/Ae7SqXrQ/qoYszkSKgPFLupR5N
        ozaWiQEMTbtHNCNK1wSI42cPDcm7aPbnBhWok4V5SL7awfW2eXghBpKZvNyY8zggcW7x4uqT7Cc
        pu5tNrk8eg4ZV+XMv3vxS7gSR
X-Received: by 2002:a05:600c:1e88:b0:3c3:ecf:ce3e with SMTP id be8-20020a05600c1e8800b003c30ecfce3emr5656946wmb.15.1665652584176;
        Thu, 13 Oct 2022 02:16:24 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7lz0WlApvKFq530rS3Ksn4hAAN1MoaF0PVyZiyi2JurSmUe0qN78jbTg3xrD4n6KsUR0fbjQ==
X-Received: by 2002:a05:600c:1e88:b0:3c3:ecf:ce3e with SMTP id be8-20020a05600c1e8800b003c30ecfce3emr5656930wmb.15.1665652583965;
        Thu, 13 Oct 2022 02:16:23 -0700 (PDT)
Received: from ovpn-194-196.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c4ed100b003b4ac05a8a4sm5313583wmq.27.2022.10.13.02.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 02:16:23 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/6] KVM: selftests: Test Hyper-V invariant TSC control
In-Reply-To: <Y0bwwfuO/iubQDPH@google.com>
References: <20220922143655.3721218-1-vkuznets@redhat.com>
 <20220922143655.3721218-7-vkuznets@redhat.com>
 <Y0XGuk4vwJBTU9oN@google.com> <87v8op6wq3.fsf@ovpn-194-196.brq.redhat.com>
 <Y0bwwfuO/iubQDPH@google.com>
Date:   Thu, 13 Oct 2022 11:16:22 +0200
Message-ID: <87pmew6q3d.fsf@ovpn-194-196.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Oct 12, 2022, Vitaly Kuznetsov wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> 

...

>> > Aha!  Idea.  Assuming none of the MSRs are write-only, what about adding a prep
>> > patch to rework this code so that it verifies RDMSR returns what was written when
>> > a fault didn't occur.
>> >
>> 
>> There is at least one read-only MSR which comes to mind:
>> HV_X64_MSR_EOI.
>
> I assume s/read-only/write-only since it's EOI?
>

Yes, of course)

>> Also, some of the MSRs don't preserve the written value,
>> e.g. HV_X64_MSR_RESET which always reads as '0'.
>
> Hrm, that's annoying.

'Slightly annoying'. In fact, the test never writes anything besides '0'
to the MSR as the code is not ready to handle real vCPU reset. I'll
leave a TODO note about that.

...

> static bool is_write_only_msr(uint32_t msr)
> {
> 	return msr == HV_X64_MSR_EOI;
> }

This is all we need, basically. I'll go with that.

-- 
Vitaly

