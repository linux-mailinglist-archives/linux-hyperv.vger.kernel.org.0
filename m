Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5328E518804
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 May 2022 17:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbiECPNc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 3 May 2022 11:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237856AbiECPNb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 3 May 2022 11:13:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B10EF3A706
        for <linux-hyperv@vger.kernel.org>; Tue,  3 May 2022 08:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651590593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q8KRyeOIJowwgq1LjuL92i0OyzQpFO6OlQ5jrqBwiaQ=;
        b=ONI3K06SDHzgIhiEA7pFS9NinIdHrgEPUH3vax1Amzp2RcTLs1rl84I8C2971I9s00EAW6
        BzDPr2gPbIkL1yAh6fVecILNRTSNf2XJaMTeFdBVjytU4iHqoBtcHNHw2LVr/90hzn3x2p
        f4zCC6RhadlUZly0xQp4Gy92AhdX6LA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-fQSgJ7TjPFyp34PKXHJwjg-1; Tue, 03 May 2022 11:09:24 -0400
X-MC-Unique: fQSgJ7TjPFyp34PKXHJwjg-1
Received: by mail-lf1-f72.google.com with SMTP id h15-20020ac24daf000000b00472586ed83dso4163300lfe.22
        for <linux-hyperv@vger.kernel.org>; Tue, 03 May 2022 08:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=q8KRyeOIJowwgq1LjuL92i0OyzQpFO6OlQ5jrqBwiaQ=;
        b=2QO1eF+hBujY+Dh+UasmlpjHWbvWXdQo6WvPOGB2kMEBftGJonZqnQtCbOUX2bnwea
         va4uOkJnQHuPd1uQO1CI7QRRuIeYUWSmbBr1d2VEilVnvi2CqkPJP7RS2yWsKrdx8iHO
         LmrJ71UHKjeYIiT4fqmgYhg8CyzMPFfHd7MJP1Rmh1/sN9Zn+BeDS5gcE+jJOBWeoV2Z
         jq6ZQ7Zkc203jxT5GkoINshHwUudrQ6SQ0luGhf1RtxKLDWFso9NTPMvC+vzoaUedZG+
         MNcnsTF5XhJ50w/D53OG9ESV3b+TMP22BGLkGLnUppJPAMftiysRYnEf+oIwcVDmgw0j
         xtEw==
X-Gm-Message-State: AOAM533NL/6RuE47ZoAw9R8yO9N57Gb2tsQthunFfgqgKGc7QXOauMGQ
        N6yNbE4b6HOsKTikqStpm4ewCzgJ5gLP+CzIlHWvu1O5zVj3VzIJvVzmsrUXEp8rt4Jzg6MCDJC
        fehdA3iXjq8mDpKVV51f3hNbH
X-Received: by 2002:a5d:64c1:0:b0:20c:6ff9:3a61 with SMTP id f1-20020a5d64c1000000b0020c6ff93a61mr4770688wri.709.1651590080961;
        Tue, 03 May 2022 08:01:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFddadb0RhMqbED3cKhIrdL1UAliMUxLFrwK6VNOQYuEXW0q5ELPbxKJShs+8DVKmBmOBFgQ==
X-Received: by 2002:a5d:64c1:0:b0:20c:6ff9:3a61 with SMTP id f1-20020a5d64c1000000b0020c6ff93a61mr4770661wri.709.1651590080743;
        Tue, 03 May 2022 08:01:20 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id t1-20020adfba41000000b0020c6fa5a797sm3344358wrg.91.2022.05.03.08.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 08:01:20 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/34] KVM: x86: hyper-v: Fine-grained TLB flush + L2
 TLB flush feature
In-Reply-To: <20220414132013.1588929-1-vkuznets@redhat.com>
References: <20220414132013.1588929-1-vkuznets@redhat.com>
Date:   Tue, 03 May 2022 17:01:19 +0200
Message-ID: <87bkwe3bk0.fsf@redhat.com>
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

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Changes since v1:

This should've beed 'since v2', obviously.

...

>
> Currently, KVM handles HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST{,EX} requests
> by flushing the whole VPID and this is sub-optimal. This series introduces
> the required mechanism to make handling of these requests more 
> fine-grained by flushing individual GVAs only (when requested). On this
> foundation, "Direct Virtual Flush" Hyper-V feature is implemented. The 
> feature allows L0 to handle Hyper-V TLB flush hypercalls directly at
> L0 without the need to reflect the exit to L1. This has at least two
> benefits: reflecting vmexit and the consequent vmenter are avoided + L0
> has precise information whether the target vCPU is actually running (and
> thus requires a kick).

FWIW, patches still apply cleanly to kvm/queue so probably there's no
need to resend.

-- 
Vitaly

