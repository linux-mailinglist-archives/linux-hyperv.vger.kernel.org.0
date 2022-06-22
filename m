Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AE4554CFE
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Jun 2022 16:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbiFVO3X (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Jun 2022 10:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358478AbiFVO2v (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Jun 2022 10:28:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 086972FE45
        for <linux-hyperv@vger.kernel.org>; Wed, 22 Jun 2022 07:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655908128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x34IRi49NgING8whuhdPrWa3tANXSDCipF9OzN2jvL4=;
        b=LC/nLSAgU8lNYX1aYqvIv4mPIggit84hM6rJ6TA6IU/dV22Og2RKHjFBo5q3+ewRukHXMH
        cJzMDjw86JHLO0mzvwhdNUhUD9Okzdb5PjVIN0CNgP9uetGWh+elMsLMp8wFH1zIX/PSSq
        1sMu/20hbEI+GNiMB6Uj+NuwOoVnm4c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-N5nYTWIMOCqTZKCRJJPowg-1; Wed, 22 Jun 2022 10:28:46 -0400
X-MC-Unique: N5nYTWIMOCqTZKCRJJPowg-1
Received: by mail-wm1-f70.google.com with SMTP id k15-20020a7bc40f000000b0039c4b7f7d09so7912403wmi.8
        for <linux-hyperv@vger.kernel.org>; Wed, 22 Jun 2022 07:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=x34IRi49NgING8whuhdPrWa3tANXSDCipF9OzN2jvL4=;
        b=8PyoaBA75VYRf1+xdPSuoQBetQ9SFAi/VbxeXZPXVpjv5fakFTngSaSDqVAGbtvZu7
         G52pt+VK3CispjZsLvv4TMil5BMwidIILvpMP5mkUMKEczpgVaseVEr/wYklGA7FoUxs
         wkCygLfwIqMD54cw8MlTrJfcP+VSnp+NhyR2ERgAKdS+T7buEyWg+cZd49S7peH4vL+X
         Qazfm3c0cg+FgXN3sY7uqz7c8icsefsTKqgNB2LncIx1+p3N6KXVl+RGpeYjm8Wz1Tt+
         PJj/4BGvhYYL+e+JaY41iNXTXauiGhQWjOtyFq+/jBpArFgA+6+BMkTrGhtEvYbUY7Ua
         uajg==
X-Gm-Message-State: AJIora+hLRRKG1BEunItZkhngU9VaFC/GrbMZTJxIFLw3XmhYrhyJ3a7
        v2BVpr5kRWU29XULT/h4lUAJFoCfGV8fEQthohX7NEGTdFlQlWJ6lkcysAGqOfQtTPgp3SBb3ZH
        /ICXibUgsi9/rJsIPTIYiSY4P
X-Received: by 2002:a5d:5984:0:b0:219:e396:d3d1 with SMTP id n4-20020a5d5984000000b00219e396d3d1mr3649483wri.701.1655908124725;
        Wed, 22 Jun 2022 07:28:44 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vuhyEjREFg3dGcH7vFPn3yakH8vgcXSr8DuJhoDWbuzWlidbf8KyA6iZoKwjJuqao0HuIjng==
X-Received: by 2002:a5d:5984:0:b0:219:e396:d3d1 with SMTP id n4-20020a5d5984000000b00219e396d3d1mr3649464wri.701.1655908124542;
        Wed, 22 Jun 2022 07:28:44 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id c130-20020a1c3588000000b0039c798b2dc5sm25959911wma.8.2022.06.22.07.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 07:28:44 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 10/39] KVM: x86: hyper-v: Don't use
 sparse_set_to_vcpu_mask() in kvm_hv_send_ipi()
In-Reply-To: <36f2de4e-43fe-7280-8cac-f44de89b2b98@redhat.com>
References: <20220613133922.2875594-1-vkuznets@redhat.com>
 <20220613133922.2875594-11-vkuznets@redhat.com>
 <17a2e85a-a1f2-99e1-fc69-1baed2275bd5@redhat.com>
 <87zgi640mm.fsf@redhat.com>
 <36f2de4e-43fe-7280-8cac-f44de89b2b98@redhat.com>
Date:   Wed, 22 Jun 2022 16:28:43 +0200
Message-ID: <87tu8cydpg.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 6/21/22 15:17, Vitaly Kuznetsov wrote:
>>>
>>> Just to be clear, PV IPI does*not*  support the VP_ID, right?
>> Hm, with Hyper-V PV IPI hypercall vCPUs are also addressed by their
>> VP_IDs, not by their APIC ids so similar to Hyper-V PV TLB flush we need
>> to convert the supplied set (either flat u64 bitmask of VP_IDs for
>> non-EX hypercall or a sparse set for -EX).
>> 
>
> So this means the series needs a v8, right?
>

No, I was just trying to explaini what the patch is doing in the series,
it looks good to me (but I'm biased, of course).

-- 
Vitaly

