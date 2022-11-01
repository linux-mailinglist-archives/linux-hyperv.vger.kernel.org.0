Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C833614F37
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Nov 2022 17:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiKAQaN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Nov 2022 12:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiKAQaG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Nov 2022 12:30:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3A11C43D
        for <linux-hyperv@vger.kernel.org>; Tue,  1 Nov 2022 09:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667320146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mDuALVSjY6duqc6mfdrdlk2vsq8fjIIz8Dsm5YsRvU8=;
        b=NK3ZvMmokqDaSprakg/26XDVS7YTXTcgYyibm5yuOVwRbpxmqyfK4PPSAmFfYTywiwAnN8
        cjAebcxAMC0gcrDgYondwffTSNlk7ciGEt2QodLl1oyhCMKQN5Bz8q2DIUYCln2eGuDwNs
        gIlm73RPi+pgdlgRcKgZ8C0/M4fqelk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-624-yfoNTadCPoisrK5RxaGCwg-1; Tue, 01 Nov 2022 12:29:03 -0400
X-MC-Unique: yfoNTadCPoisrK5RxaGCwg-1
Received: by mail-ed1-f72.google.com with SMTP id h9-20020a05640250c900b00461d8ee12e2so10401806edb.23
        for <linux-hyperv@vger.kernel.org>; Tue, 01 Nov 2022 09:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mDuALVSjY6duqc6mfdrdlk2vsq8fjIIz8Dsm5YsRvU8=;
        b=cOByIWQRrdnnvPM6ZEPXCowMbQUM4nBYoplkvFOoTuTc/qdzXdzo39dyE1mn6zNhqf
         Cq7NJ23cXgYRyD/jvbq2t77V0HDq3JNc6VQ0ZsPiNhdkZx9Jhxhyo4msPyg5pgVZ1hrH
         GSZZ2rW5UFjJzCFGCKX1BmD6IowkYQTCyuoJgvHKMK7Sbwk0qnISKq5puRvkw4ELp4KM
         9sSA1B21jzsZFQy80GBn3PJgRtqePIUt/hDVKUCj5DxuSMjxKQElpBRMM8AKeKr+Qp6F
         B2GxdQ6rnVXBUULbpG9dXHss7+l1NOjSw+x3RBDy+/b3fCSLi2ubGM7BhVa8iLNEvarZ
         GHEA==
X-Gm-Message-State: ACrzQf1gWC3KUE1Te57ukQ7SuVRvGWTQDSubclNBohV010wuK3ALRkEE
        wNd/nJps3ZjjH1Q3Uxxb4Gkke6uWNL0AzGMhcjS0YU5cixxP3gW4bj82kOmGI9s8woIvgq7t1Y8
        j8S6j6sVPzq8nOs3LssWMjrCP
X-Received: by 2002:a17:906:4c4b:b0:7ad:a197:b58e with SMTP id d11-20020a1709064c4b00b007ada197b58emr19492147ejw.203.1667320142651;
        Tue, 01 Nov 2022 09:29:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6PPPjC11w84o98TwbRsI4d2SLwALdtwCixPHCa/pNLG7jKQOh3T/GXFYuBn3UT4EEHKKU4rA==
X-Received: by 2002:a17:906:4c4b:b0:7ad:a197:b58e with SMTP id d11-20020a1709064c4b00b007ada197b58emr19492120ejw.203.1667320142403;
        Tue, 01 Nov 2022 09:29:02 -0700 (PDT)
Received: from ovpn-194-149.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id d17-20020a170906305100b0073dbaeb50f6sm4326403ejd.169.2022.11.01.09.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 09:29:01 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 00/48] KVM: x86: hyper-v: Fine-grained TLB flush +
 L2 TLB flush features
In-Reply-To: <Y2E5chB/9pZcRWi6@google.com>
References: <20221101145426.251680-1-vkuznets@redhat.com>
 <Y2E5chB/9pZcRWi6@google.com>
Date:   Tue, 01 Nov 2022 17:29:00 +0100
Message-ID: <878rkuskoj.fsf@ovpn-194-149.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Nov 01, 2022, Vitaly Kuznetsov wrote:
>> Changes since v12 (Sean):
>> - Reviewed-by: tags added.
>> - PATCH13: added a comment explaining why 'hc->ingpa' doesn't need to be
>>   translated when the hypercall is 'fast'.
>> - PATCH34: s,wraping,wrapping, in the blurb.
>> - PATCH36: added missing Signed-off-by: tag.
>> - "KVM: selftests: Stuff RAX/RCX with 'safe' values in vmmcall()/vmcall()"
>>   patch added (and used later in the series).
>> - "KVM: selftests: Introduce rdmsr_from_l2() and use it for MSR-Bitmap
>>   tests" patch added (and used later in the series).
>
> Note, this doesn't apply cleanly to kvm/queue for me, looks like there are superficial
> conflicts that make git unhappy with the vmx/evmcs.{ch} => vmx/hyperv.{ch}, though I
> might be missing a git am flag to help it deal with renames.

Sorry, forgot to rebase.

>
> Applies cleanly to e18d6152ff0f ("Merge tag 'kvm-riscv-6.1-1' of
> https://github.com/kvm-riscv/linux into HEAD") and then rebases to kvm/queue without
> needing human assistance.

The miracle of git :-)

-- 
Vitaly

