Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450B456BD7F
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Jul 2022 18:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbiGHP6o (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Jul 2022 11:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238231AbiGHP6m (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Jul 2022 11:58:42 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629E56B249
        for <linux-hyperv@vger.kernel.org>; Fri,  8 Jul 2022 08:58:41 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id i190so10097092pge.7
        for <linux-hyperv@vger.kernel.org>; Fri, 08 Jul 2022 08:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B8w4bwYuqV6DXk3ShmGJ/aTll0ynf+VvQDcahL2hqj4=;
        b=bfCBNAPgf5AtCFBnWe/2nrt7kg29z/w5Q01kuQ6lA+gveTZTp/emDFQxX4//qULTB1
         /cK4O+t1Z+i0p4mGAfgY8TN8v0tQ0RSvxquGKJmX4QGik5uArQ6ecp3U65ZSDt8cnezy
         vGAyYDn3mUw1c2vTleiOPAnO9QfnpJOoCWVDhAsvcFJI8Rk2RlC4oZQdtEHG3DzFVxZP
         R7aHe9QHxnyRN9lRq7Va+0rjvw5ejyajU+vbEeLjLx7KjBkbz3wGUd+8NPfsVNnERiK3
         WjZgiDfSHkSo40HlMmmR7c5mwZVjIi/thPN0pGgF4588q13cCYCzUgZ6bUJtMN5IYvkD
         57Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B8w4bwYuqV6DXk3ShmGJ/aTll0ynf+VvQDcahL2hqj4=;
        b=xI5DIQ0E+mo6z6UGZHxAW633IgDFPZNSMlePoCCHQI3Yz2JZmVqnH+d2RYQsL6s5kR
         /0USH7YEJT6cSOIGg1j5/9JUAeK1gvYpVgixcnQ5/UzxRIfk97eoK/RxZtk1dfRZ5znC
         BPyKXSKT0u6v7wxqdTHmNDtKAU8CSqYS2kLKAWzIR1Pfv/mW+OAy8l0sE5Aa5s8LSXP6
         WVtnWQThSMIX2SY47ZjiOKiBE7tRqot4YKU5an9z+DyBLi3Z/fmu3kF5uUa4N+JAX78f
         +MgBA8z2ZwMSKzm3vxMrDHy0CxZxrxIEXG39TJrLSv7kQB+HJv6ZTuNFasyOR+C62SD2
         GScg==
X-Gm-Message-State: AJIora801UK/953QNJXHqFtjfH7awnnA8r6WPbI01/fFQ2gr2mDjxQ88
        iqizWmi1ZE8iWi7jQxiP+xKTew==
X-Google-Smtp-Source: AGRyM1vTv4xL2/UTTju5PFq9Kvb5or53YEm+WZJ52+HPaHJtWg1ukrZVjJdpIkPwNcaRQPI2DCWFkQ==
X-Received: by 2002:a05:6a00:188e:b0:52a:b545:559f with SMTP id x14-20020a056a00188e00b0052ab545559fmr1935105pfh.18.1657295920505;
        Fri, 08 Jul 2022 08:58:40 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709026f1700b00161ccdc172dsm30065208plk.300.2022.07.08.08.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 08:58:40 -0700 (PDT)
Date:   Fri, 8 Jul 2022 15:58:36 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: x86: Fully initialize 'struct kvm_lapic_irq' in
 kvm_pv_kick_cpu_op()
Message-ID: <YshULK9IG9mw7ms3@google.com>
References: <20220708125147.593975-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708125147.593975-1-vkuznets@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 08, 2022, Vitaly Kuznetsov wrote:
> 'vector' and 'trig_mode' fields of 'struct kvm_lapic_irq' are left
> uninitialized in kvm_pv_kick_cpu_op(). While these fields are normally
> not needed for APIC_DM_REMRD, they're still referenced by
> __apic_accept_irq() for trace_kvm_apic_accept_irq(). Fully initialize
> the structure to avoid consuming random stack memory.
> 
> Fixes: a183b638b61c ("KVM: x86: make apic_accept_irq tracepoint more generic")
> Reported-by: syzbot+d6caa905917d353f0d07@syzkaller.appspotmail.com
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
