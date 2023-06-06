Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49D6724836
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Jun 2023 17:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbjFFPuL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 6 Jun 2023 11:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238010AbjFFPuK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 6 Jun 2023 11:50:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1EF10D1
        for <linux-hyperv@vger.kernel.org>; Tue,  6 Jun 2023 08:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686066561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sHW62n9UHGko3VJYRUlg4WSO9igiZ1RT0fE8QaKfMYc=;
        b=VN8iDBjW6Xxr98AEHGnj+vD0sj/AlOtD00aUhK7KKdi8RxXS+L+fVAVwMuDAkk6U3wy8d/
        6LUlt7wasvGRMyJ2yENo3g8NIeYTiAWwQ0dzK6CX+S7ntQE56OeVWUude4yVg7hxdZWrJp
        ula0Er0IoK/SX9txMjX6diP6HQeX7pE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-YJTWO2wYM82CBSYGTOtz4w-1; Tue, 06 Jun 2023 11:49:20 -0400
X-MC-Unique: YJTWO2wYM82CBSYGTOtz4w-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6262360e603so68284896d6.2
        for <linux-hyperv@vger.kernel.org>; Tue, 06 Jun 2023 08:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686066560; x=1688658560;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sHW62n9UHGko3VJYRUlg4WSO9igiZ1RT0fE8QaKfMYc=;
        b=CKEv2LZkIb8FWYnzR6dCp5akZu9rxt2vYf5MYydNTBwQiY5a7b5GnOlY/LARFtUPPE
         ScFvgrNQhgfDvWTj/p/Nc5a0fSuLQ5xUrTiwN5urj8koGkBMCTRvk7IMF85bmE4nwoMc
         oEK433y0lOcuGQciCD9nPX3dcuGmqTonNlz6mCkjPTwzi0lJNV9hZJAS/pYJL+QyaLv8
         wrW8xevx6jIjfG4XgKfNeIWEIZPCeCVAW4e38szbtCSAPPcbio8yN2pttRuVJ1aLaMm2
         42y5K8L3npMwnGuUL7JYM3Jz0AYuN/t7iOt/PI71glpuBoLjgUqaD0LVRoQL1VdvkHy7
         5wRQ==
X-Gm-Message-State: AC+VfDzjE265iAAj2ZkbCwSWUpMpcRkNWJy1KI7Xn0W+293fFKhsWeyj
        r6c8q1ZYugTeJUAIO6xsvPwU/AfGF4tCG0Q2SA2DOuHR5v+BgkD4ib8S6sVA620pJy5BbgkoDoG
        kJNE6bzMVmu2jgV/c554sBVV4
X-Received: by 2002:a05:6214:c4a:b0:623:9218:58e5 with SMTP id r10-20020a0562140c4a00b00623921858e5mr3046789qvj.39.1686066559934;
        Tue, 06 Jun 2023 08:49:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ50JQIIoil5JiSTdmsb+6pApFtKxP9ntyQPRWklH9ZkQzBpZua8a7/GwPPddH+uoWxcHSKrVQ==
X-Received: by 2002:a05:6214:c4a:b0:623:9218:58e5 with SMTP id r10-20020a0562140c4a00b00623921858e5mr3046767qvj.39.1686066559718;
        Tue, 06 Jun 2023 08:49:19 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id u5-20020a0cc485000000b006263c531f61sm5428989qvi.24.2023.06.06.08.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 08:49:19 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] x86/hyperv: Mark Hyper-V vp assist page unencrypted
 in SEV-SNP enlightened guest
In-Reply-To: <4103a70f-cc09-a966-3efa-5ab9273f5c55@gmail.com>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-4-ltykernel@gmail.com> <873536ksye.fsf@redhat.com>
 <4103a70f-cc09-a966-3efa-5ab9273f5c55@gmail.com>
Date:   Tue, 06 Jun 2023 17:49:15 +0200
Message-ID: <87o7lsk2v8.fsf@redhat.com>
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

Tianyu Lan <ltykernel@gmail.com> writes:

> On 6/5/2023 8:13 PM, Vitaly Kuznetsov wrote:
>>> @@ -113,6 +114,11 @@ static int hv_cpu_init(unsigned int cpu)
>>>   
>>>   	}
>>>   	if (!WARN_ON(!(*hvp))) {
>>> +		if (hv_isolation_type_en_snp()) {
>>> +			WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1));
>>> +			memset(*hvp, 0, PAGE_SIZE);
>>> +		}
>> Why do we need to set the page as decrypted here and not when we
>> allocate the page (a few lines above)?
>
> If Linux root partition boots in the SEV-SNP guest, the page still needs 
> to be decrypted.
>

I'd suggest we add a flag to indicate that VP assist page was actually
set (on the first invocation of hv_cpu_init() for guest partitions and
all invocations for root partition) and only call
set_memory_decrypted()/memset() then: that would both help with the
potential issue with KVM using enlightened vmcs and avoid the unneeded
hypercall.

-- 
Vitaly

