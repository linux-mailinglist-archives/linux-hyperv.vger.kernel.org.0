Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30146078C2
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Oct 2022 15:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiJUNnc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Oct 2022 09:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiJUNnJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Oct 2022 09:43:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D62277092
        for <linux-hyperv@vger.kernel.org>; Fri, 21 Oct 2022 06:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666359781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Fp/t0MHVjo92qogg0AYC5TyzhcxyvXKs2Riw174VTM=;
        b=bQUR61Hh8b8OQPqpKukfCKfGdKTd9X4+t0rh4qIWiRxKoArLtwEBu7nYyNn9I6rEgbl6KS
        PMN4bYQQmO1uVmPvj05uTQ7GxT4Xomh1q7QieDIBaCOjQ7ZyhFmjza7GpXLCeKNzGpHLdc
        HIXIsZ+5M9wO0Pcefk0UXT1yxLkAJzQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-657-EABp_yCMOUKXQvfc71yFNQ-1; Fri, 21 Oct 2022 09:43:00 -0400
X-MC-Unique: EABp_yCMOUKXQvfc71yFNQ-1
Received: by mail-ed1-f72.google.com with SMTP id y14-20020a056402440e00b0044301c7ccd9so2491504eda.19
        for <linux-hyperv@vger.kernel.org>; Fri, 21 Oct 2022 06:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Fp/t0MHVjo92qogg0AYC5TyzhcxyvXKs2Riw174VTM=;
        b=Dx7irX5dWMXRD6QaV1rPvQjzKarJAY2Pyy58E+qryTlSrWe3CotqjTVK+psnZ4wNTn
         FqyWwTqMP1eWImtYcjDvR2Dft18OX2VwagWPvk2AIPP4vjFtZ75jbwyXkAjs+xz8sfcR
         4a0XlQOJEwFSJBTrU9Fr+MfB0Qn/ycC33jOp2KSjoQnrzM4FKpk8amoVd2U2vhL0uoP5
         3k2QEPy7OZ+02oW7XYKYStKnnyKIJJhKaFyV0/uJHsJLc5/WTwpGNdJ7fCz5CrC4YWOg
         RVLnwk9x4Re4G96GpNygcvsdyD1lISjo9hvd/zsQrfWs8+5Kkc9gGAJHNniTEmydMyw/
         bBPQ==
X-Gm-Message-State: ACrzQf35wdhL/FMibfdJHMksKES7vXVhIGYzm17F3ba2I89sYAzSmNVq
        zIIWy2jxF2tYsqk86JvrIK0GSQxL7HILsvTtIKkk9jcdAj3O8Th6lDSbrdKQ3rivxEfdNFQoA5u
        cVjtf7d9NokBmgKUqi+JYMjCj
X-Received: by 2002:a05:6402:50d4:b0:45d:fe2:45 with SMTP id h20-20020a05640250d400b0045d0fe20045mr17837338edb.221.1666359777045;
        Fri, 21 Oct 2022 06:42:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM50/NSD4ymcGHu4c1l7asjJM1pvpRY2nyQysqVvK1pwNVFmAnQO/1RBD/6H+/pj7se2K/xv4A==
X-Received: by 2002:a05:6402:50d4:b0:45d:fe2:45 with SMTP id h20-20020a05640250d400b0045d0fe20045mr17837321edb.221.1666359776876;
        Fri, 21 Oct 2022 06:42:56 -0700 (PDT)
Received: from ovpn-192-65.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id s11-20020a50d48b000000b00458947539desm13649818edi.78.2022.10.21.06.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 06:42:56 -0700 (PDT)
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
Subject: Re: [PATCH v11 33/46] KVM: selftests: Hyper-V PV IPI selftest
In-Reply-To: <874jvxcnyp.fsf@ovpn-192-65.brq.redhat.com>
References: <20221004123956.188909-1-vkuznets@redhat.com>
 <20221004123956.188909-34-vkuznets@redhat.com>
 <Y1B1eBIL9WhB4dwc@google.com> <874jvxcnyp.fsf@ovpn-192-65.brq.redhat.com>
Date:   Fri, 21 Oct 2022 15:42:55 +0200
Message-ID: <87zgdpb8dc.fsf@ovpn-192-65.brq.redhat.com>
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

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Sean Christopherson <seanjc@google.com> writes:
>
>> On Tue, Oct 04, 2022, Vitaly Kuznetsov wrote:
>
> ...
>
>>> +
>>> +	r = pthread_cancel(thread);
>>> +	TEST_ASSERT(r == 0,
>>
>> !r is generally preferred over "r == 0"
>>
>>> +		    "pthread_cancel on vcpu_id=%d failed with errno=%d",
>>> +		    vcpu->id, r);
>>
>> Do you happen to know if errno is preserved?  I.e. if TEST_ASSERT()'s print of
>> errno will capture the right errno?  If so, this and the pthread_join() assert
>> can be:
>>
>> 	TEST_ASSERT(!r, pthread_cancel() failed on vcpu_id=%d, vcpu->id);
>>
>
> The example from 'man 3 pthread_cancel' makes me think errno is not
> set. 'man 3 errno' confirms that:
>
> "
>        Note  that the POSIX threads APIs do not set errno on error.
> Instead, on failure they return an error number as the function result.
> These error numbers have the same meanings as the error numbers returned
> in errno by other APIs.
> "
>
> but nothing stops us from doing something like
>
> #include <errno.h>
> ...
>
> errno = pthread_cancel(thread);
> TEST_ASSERT(!errno, pthread_cancel() failed on vcpu_id=%d, vcpu->id);
>
> I believe.

... only the fact that this won't be thread safe :-( i.e. if we also try
setting 'errno' from vcpu_thread() (where the pattern for
pthread_setcanceltype() is exactly the same), we will likely be
reporting the wrong errno. I think it's better to keep reporting 'r' for
now (and maybe think about pthread* wrappers later).

-- 
Vitaly

