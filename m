Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEA96079EC
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Oct 2022 16:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiJUOvC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Oct 2022 10:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiJUOu4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Oct 2022 10:50:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BE2237FAB
        for <linux-hyperv@vger.kernel.org>; Fri, 21 Oct 2022 07:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666363854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3KqX3cQJyXO8DgUbmcCGSuro7kDodg56LrRmLb6OdXw=;
        b=U9RemClIwLARdPL9RzHZc/nj8BpFxP4L3MElp6L5MRfcLZ/43i1O/Cwc3qM2G0xYmNXxwg
        5ZP3vuaUjSudXGymUDGh2mFnLAnPYr08UOIN6Hq6iiYzdaFMr1o1BVApnYru4N9DPh6C1V
        wP5uwPMTkKfRPOeinwROXN/uZwZiL/k=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-448-ITYABYW8Nk-juwc_fV5toA-1; Fri, 21 Oct 2022 10:50:52 -0400
X-MC-Unique: ITYABYW8Nk-juwc_fV5toA-1
Received: by mail-ed1-f69.google.com with SMTP id y10-20020a056402358a00b0045d5cf18d4cso2760485edc.17
        for <linux-hyperv@vger.kernel.org>; Fri, 21 Oct 2022 07:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3KqX3cQJyXO8DgUbmcCGSuro7kDodg56LrRmLb6OdXw=;
        b=Uj0LEoPtIqR01KT8j7YmdM3twRFK/EjImX+gOqzYq1MnVwPoIH8cnTWd7/7zjlH90o
         B4tCzAFCerDOGKKmTts9gI7UCQfUZcZAgmxx27WK0PrTr98n1lFDo8OH8QoIJaDzg+Bk
         y7ies6Mr3vWEkeTuEBrDzh0ethcKr/u5/ptWtzwW0t04uaJDaXetd/8vcQ2H0UQg2YY4
         5jkqJxBx5H0yyVnI01o4x7hUJANIeKCnreD/MVRZhOn69TomxutkA4oOP5pvprqpiUw1
         8VYCPHgha96uRAMVm4epSwy2lb35QcK9YPBBIwNTmaJYAMxxYKCHTdEnRzTQJ0THFYs5
         nR3g==
X-Gm-Message-State: ACrzQf2vLLm8PbXiqJHsW/qLp3O37faQ0AW38OG/6hgi/LX27YyiWnoq
        Gz3080VtUQ4+vrBtkLWgL2v4fnwq5AyVVRE4OUGSu2lpUgr0JedoEdnAZ50NFupmFUnVT7ZcQ7P
        av1iUwfatfscsmmTXeMh8Y54c
X-Received: by 2002:a05:6402:2b8d:b0:43a:5410:a9fc with SMTP id fj13-20020a0564022b8d00b0043a5410a9fcmr18067370edb.99.1666363851551;
        Fri, 21 Oct 2022 07:50:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5J8Tepa5KCpS+HvcbR1Fjb2ekWhuUACSZhePPlBCOVX120kQfGnZ0JJY3aPy+j1VOKboUWWQ==
X-Received: by 2002:a05:6402:2b8d:b0:43a:5410:a9fc with SMTP id fj13-20020a0564022b8d00b0043a5410a9fcmr18067350edb.99.1666363851353;
        Fri, 21 Oct 2022 07:50:51 -0700 (PDT)
Received: from ovpn-192-65.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id ku16-20020a170907789000b0078ca30ee18bsm11857943ejc.95.2022.10.21.07.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 07:50:50 -0700 (PDT)
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
Subject: Re: [PATCH v11 44/46] KVM: selftests: evmcs_test: Introduce L2 TLB
 flush test
In-Reply-To: <Y1B35gupSqXAvAOZ@google.com>
References: <20221004123956.188909-1-vkuznets@redhat.com>
 <20221004123956.188909-45-vkuznets@redhat.com>
 <Y1B35gupSqXAvAOZ@google.com>
Date:   Fri, 21 Oct 2022 16:50:49 +0200
Message-ID: <87wn8tb586.fsf@ovpn-192-65.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Oct 04, 2022, Vitaly Kuznetsov wrote:

...

>>  
>> +	/* L2 TLB flush setup */
>> +	current_evmcs->partition_assist_page = hv_pages->partition_assist_gpa;
>> +	current_evmcs->hv_enlightenments_control.nested_flush_hypercall = 1;
>> +	current_evmcs->hv_vm_id = 1;
>> +	current_evmcs->hv_vp_id = 1;
>> +	current_vp_assist->nested_control.features.directhypercall = 1;
>> +	*(u32 *)(hv_pages->partition_assist) = 0;
>> +
>>  	GUEST_ASSERT(!vmlaunch());
>
> Pre-existing code, but would it make sense to add an assert here to verify L2
> exited due to an NMI?  Feel free to ignore this for now if it's not straightforward,
> this series is plenty big :-)
>

Well, simple

+       GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_EXCEPTION_NMI);
+       GUEST_ASSERT_EQ((vmreadz(VM_EXIT_INTR_INFO) & 0xff), NMI_VECTOR);

seems to be working (passing) so why not :-)

-- 
Vitaly

