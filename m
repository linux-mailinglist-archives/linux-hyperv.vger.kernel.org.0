Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D777355C480
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jun 2022 14:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345341AbiF1MDH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 28 Jun 2022 08:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245048AbiF1MDG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 28 Jun 2022 08:03:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49904B6A
        for <linux-hyperv@vger.kernel.org>; Tue, 28 Jun 2022 05:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656417783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zXN9dl3fgirbCGdVmbSz4P1oGzXcIrM4VABDL6FQNWQ=;
        b=PE+Vow8d7KbrqRicSbIHO5jbuqGuxTqifmJonSWG63qKoJPSHGAQqFWV7Gvm62zuSOR5AR
        OtKhZho8HEKkD0y3GS4mQB6YTV5AM8w/1cUj9qR4Oy7p1nQm10LRiyajHa3feYtj2TsLbi
        4NeynLZWpr4MD8PS8LKSxDZHIN1EVdk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-mnXiPVWHNIa05M8MitrdPg-1; Tue, 28 Jun 2022 08:03:02 -0400
X-MC-Unique: mnXiPVWHNIa05M8MitrdPg-1
Received: by mail-wm1-f71.google.com with SMTP id h125-20020a1c2183000000b003a03a8475c6so4520856wmh.8
        for <linux-hyperv@vger.kernel.org>; Tue, 28 Jun 2022 05:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=zXN9dl3fgirbCGdVmbSz4P1oGzXcIrM4VABDL6FQNWQ=;
        b=IzgnV5OBa6W0Ir8Zuswjuuyzvcz7JH4ysN2cD3bv4Y4zOqqW3cZM3JzdkjQNsvgtKV
         NOAi+vTqdac+c45/cNh/H+uQMOZUAjGDvt9Ro7uGFsMACzMtElH0vt193ytmS3M5qn30
         d6LWYs3vGRCwDZ10svd4RgAaJ77ofgH5OPZJzUlefrAS8D6lrYwxK8wVFgVZPoCycKOd
         17JcmWcMTTDodIDMjabqtcahj7ZcB1QHen4sh6unnm+UmDgjkfRj6nClBfHLPIGaGG7X
         uDDgF/rrtYeXJ8jjlAG+RcN2aTNV70+01KOb0FOdFiAq7w7WfPWT0tErj+sPuSgzwBcK
         YWgg==
X-Gm-Message-State: AJIora8Encm///oQuYwpR2+KshtDbR2fqQYfNMvMOOB/BAiqBsMzxyho
        zNo0caP+oeQblgzZMrZm8ln+afL5eSTzve7W6OHuVN+Q8aDlPK2BiW4FON5ChgxFtzUyBbKVOsB
        +qnh3lZMCdh6jQU1RT4fcf3Zy
X-Received: by 2002:a5d:5887:0:b0:21b:ca70:f60d with SMTP id n7-20020a5d5887000000b0021bca70f60dmr12317086wrf.32.1656417780733;
        Tue, 28 Jun 2022 05:03:00 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t9eqJuqY/RFJQsbq4btuDnPgxRTxSsH/0pQc+gWLgk0/ru8KAoT2hMTtcP0KdWktRXSvABGA==
X-Received: by 2002:a5d:5887:0:b0:21b:ca70:f60d with SMTP id n7-20020a5d5887000000b0021bca70f60dmr12317056wrf.32.1656417780509;
        Tue, 28 Jun 2022 05:03:00 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id d11-20020a5d4f8b000000b0020c7ec0fdf4sm15791108wru.117.2022.06.28.05.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 05:02:59 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Dong, Eddie" <eddie.dong@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Christopherson, Sean" <seanjc@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 04/14] KVM: VMX: Extend VMX controls macro shenanigans
In-Reply-To: <BL0PR11MB304264B62299D642FF906C298AB99@BL0PR11MB3042.namprd11.prod.outlook.com>
References: <20220627160440.31857-1-vkuznets@redhat.com>
 <20220627160440.31857-5-vkuznets@redhat.com>
 <BL0PR11MB304264B62299D642FF906C298AB99@BL0PR11MB3042.namprd11.prod.outlook.com>
Date:   Tue, 28 Jun 2022 14:02:59 +0200
Message-ID: <87edz9uhak.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

"Dong, Eddie" <eddie.dong@intel.com> writes:

>> -----Original Message-----
>> From: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Sent: Monday, June 27, 2022 9:05 AM
>> To: kvm@vger.kernel.org; Paolo Bonzini <pbonzini@redhat.com>;
>> Christopherson,, Sean <seanjc@google.com>
>> Cc: Anirudh Rayabharam <anrayabh@linux.microsoft.com>; Wanpeng Li
>> <wanpengli@tencent.com>; Jim Mattson <jmattson@google.com>; Maxim
>> Levitsky <mlevitsk@redhat.com>; linux-hyperv@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: [PATCH 04/14] KVM: VMX: Extend VMX controls macro shenanigans
>> 
>> When VMX controls macros are used to set or clear a control bit, make sure
>> that this bit was checked in setup_vmcs_config() and thus is properly
>> reflected in vmcs_config.
>> 

...

>
> With this, will it be safer if we present L1 CTRL MSRs with the bits
> KVM really uses? Do I miss something?

Sean has already answered but let me present my version. Currently,
vmcs_config has sanitized VMX control MSRs values filtering out three
groups of features:
- Features, which KVM doesn't know about.
- Features, which KVM can't enable (because of eVMCS, bugs,...)
- Features, which KVM doesn't want to enable for some reason.
L1 VMX control MSRs should have the first two groups filtered out but
not the third. E.g. when EPT is in use, KVM doesn't use
CPU_BASED_CR3_LOAD_EXITING/CPU_BASED_CR3_STORE_EXITING but this doesn't
mean that all possible L1 hypervisors are going to be happy if we filter
these out. Same goes to e.g. CPU_BASED_RDTSC_EXITING: KVM never sets
this for itself but nested hypervisor can.

-- 
Vitaly

