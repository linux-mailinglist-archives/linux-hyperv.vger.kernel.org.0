Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7E95C00E6
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Sep 2022 17:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiIUPQZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Sep 2022 11:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiIUPQN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Sep 2022 11:16:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211A78E0CC
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Sep 2022 08:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663773364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e1/3iD7RI36kvj0Sowor/BnZgoD6RNq2G2Sg9asUTkE=;
        b=AqOvxOjFKvDwMq7eXfYzBWy3/w5EkwzOeoTtiIrsQ548mx3ILqEQrgE0RcS8rZCJUDyQr0
        lyE1zaQbETqUmREQ3NmZhtLd1o76jIGquw7gz9SMgB61hRq+Kgjhp7O2rpntMPB2CEA/oW
        zeHld1Sicx0l4+X7wpSFdqkYqyreC/U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-529-RL56mCxwNlSs1CXYn88c4w-1; Wed, 21 Sep 2022 11:16:03 -0400
X-MC-Unique: RL56mCxwNlSs1CXYn88c4w-1
Received: by mail-ej1-f72.google.com with SMTP id ne4-20020a1709077b8400b0078114a1a6d8so3267556ejc.9
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Sep 2022 08:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=e1/3iD7RI36kvj0Sowor/BnZgoD6RNq2G2Sg9asUTkE=;
        b=LGFAxb4FU3ViBiU6r+m8h3hzjL9Jw0c9Y8Sqtm63F0s1yu8gH7qUWI5ibCj2SQDWpr
         iX2jlfcOJfjyrLbL4i89wriaogG4WXQMxJeX+qRFUrqDTKgrxmZJuhWWE+dE9ZFhRTZC
         F5dfDuoklc4ZaQBS6J6njHO/KZSSNQxymHb2XGDpHXgiWlcevcwK/5d7/Nmrsun60+m8
         9Tbfcyk1aHARiWxV3N26DiT08VwhOMAK6AWY2RSjZu6+4YnyKnkCwXgd1H98EmUiB+Ge
         gSrXCMHGZ5wFlJ1L2PGfznpu8s6nLCg+4j484A4r2fhI/i+XTwaJ7bsGVu2TjOSGdjrp
         znfQ==
X-Gm-Message-State: ACrzQf2fDkd6jaIDvMPcasApyhWdB+/RBcRewELty/3AOdSmTrjnTaLe
        d70Y+9ddvaicMJcwtdXsqckpCJ6R/ACndB47wqdPkM+/C97YxDvpHxwuMapPCbDsdnXV76kOlLj
        RK4WtYuaW1C4KYbIUtA0Y/gwl
X-Received: by 2002:a17:907:75dc:b0:730:9c68:9a2e with SMTP id jl28-20020a17090775dc00b007309c689a2emr21875427ejc.22.1663773362040;
        Wed, 21 Sep 2022 08:16:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6C+CtvwXrusPAZI+96omZxJ1ec8xlFJMKiv4OXhnUjyL+XsezuiUSrsR051eKLQRYujgifDA==
X-Received: by 2002:a17:907:75dc:b0:730:9c68:9a2e with SMTP id jl28-20020a17090775dc00b007309c689a2emr21875408ejc.22.1663773361822;
        Wed, 21 Sep 2022 08:16:01 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id ay4-20020a170906d28400b00777249e951bsm1420632ejb.51.2022.09.21.08.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:15:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v9 00/40] KVM: x86: hyper-v: Fine-grained TLB flush + L2
 TLB flush features
In-Reply-To: <Yw46XAP3aafdH/xZ@google.com>
References: <20220803134110.397885-1-vkuznets@redhat.com>
 <8735ddvoc2.fsf@redhat.com> <Yw46XAP3aafdH/xZ@google.com>
Date:   Wed, 21 Sep 2022 17:15:52 +0200
Message-ID: <87o7v8oj13.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Aug 30, 2022, Vitaly Kuznetsov wrote:
>> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
>> 
>> > Changes since v8:
>> > - Rebase to the current kvm/queue (93472b797153)
>> > - selftests: move Hyper-V test pages to a dedicated struct untangling from 
>> >  vendor-specific (VMX/SVM) pages allocation [Sean].
>> 
>> Sean, Paolo,
>> 
>> I've jsut checked and this series applies cleanly on top of the latest
>> kvm/queue [372d07084593]. I also don't seem to have any feedback to
>> address.
>> 
>> Any chance this can be queued?
>
> It's the top "big" series on my todo list.  I fully plan on getting queued for 6.1,
> but I don't expect to get to it this week.

I was going to do a bare 'ping' here but then I decided to check whether
this series still applies cleanly and turns out there's some fuzz and
some minor conflicts with the already queued "KVM: VMX: Support updated
eVMCSv1 revision + use vmcs_config for L1 VMX MSRs" (in
sean/for_paolo/6.1 atm). I've rebased and re-tested and besides the
(unrelated) shadow MMU issue I've reported, things still seem to work
fine. I'm going to go ahead and send out rebased v10 then.

-- 
Vitaly

