Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB9256BBC1
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Jul 2022 16:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237862AbiGHO1t (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Jul 2022 10:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237385AbiGHO1s (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Jul 2022 10:27:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74E5CB7DC
        for <linux-hyperv@vger.kernel.org>; Fri,  8 Jul 2022 07:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657290467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TgSz10/9BsFZpGAIEkp0ySVetokqd5lKigRRrfTtX48=;
        b=VPBDbjy1ATanClTQL2ecrBfrsbHdjo4fpPHcjWN+vDanvZA+r3eJGYS0xpVbfXr2nNJILB
        mkIuqmFKdc6iDjEkBqkQaFMmoM/zI/MgROCN3r+H0gPvAFxNMUguqiLft+V77Z0KpG4S8Q
        4MBFaf+ws6FnCSZO+SpQe2h1Va9hsu4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-3Yr7ycRWOnqfHQ_hwESruw-1; Fri, 08 Jul 2022 10:27:46 -0400
X-MC-Unique: 3Yr7ycRWOnqfHQ_hwESruw-1
Received: by mail-wm1-f72.google.com with SMTP id m17-20020a05600c3b1100b003a04a2f4936so1051884wms.6
        for <linux-hyperv@vger.kernel.org>; Fri, 08 Jul 2022 07:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=TgSz10/9BsFZpGAIEkp0ySVetokqd5lKigRRrfTtX48=;
        b=K/DyFECoBPElS2sZVMUdP5KmFM0FqYtfMLpBU5SaqycnaIqoYnEa5ux0xUYSENmhUn
         Y8D3A6zDotuMiSP1IZcGBGACrNFmez7YPfPws7W0ESeWHa/Zx6w9pMkgcQZQ9iPfVPXL
         MK+M9EsN1vmNMZjtkwW8ZfzvZu2W3dxWzpBgBuashIx3TxPI7XMBKDZte6z7a5pL8AZD
         5y5UVGjMW1sbJR7z13dlhrUANBuvgq4o+rU6mbxtRHaEeOeaxLYpwfcMfLKCAH563dPd
         i7m8G1D3pynbCcI77hnVpS5Wyx1NYFFCPi3CTgwYJEG3YQnZbkZHkv4e7k/7AnoBaw1U
         xWBg==
X-Gm-Message-State: AJIora+wy+d3Sythpqtv9xf7qn/wwHc87tfZsHck98u/0ai9swcW/Q6S
        Y1XFeGro3DvYw0x2tfJhpdbQcmvHN5Ati9pPKetS598OaOK8CdkXZ12m+ChS7Dab7Uf/vGhdcq9
        oMhmFGJvoT8eDncv7RJqY8+ob
X-Received: by 2002:adf:efc7:0:b0:21d:9412:7d54 with SMTP id i7-20020adfefc7000000b0021d94127d54mr556191wrp.230.1657290464829;
        Fri, 08 Jul 2022 07:27:44 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sVca1hCqgfCicFr9JuOmeFXakjNABoNNlhHLLByVKShUtTdzfE9ZgweqHWfo2pmAH7s/5t7w==
X-Received: by 2002:adf:efc7:0:b0:21d:9412:7d54 with SMTP id i7-20020adfefc7000000b0021d94127d54mr556175wrp.230.1657290464654;
        Fri, 08 Jul 2022 07:27:44 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id ay26-20020a5d6f1a000000b0021baf5e590dsm41084417wrb.71.2022.07.08.07.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 07:27:43 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] KVM: x86: Fully initialize 'struct kvm_lapic_irq' in
 kvm_pv_kick_cpu_op()
In-Reply-To: <20220708125147.593975-1-vkuznets@redhat.com>
References: <20220708125147.593975-1-vkuznets@redhat.com>
Date:   Fri, 08 Jul 2022 16:27:42 +0200
Message-ID: <87let3ptlt.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> 'vector' and 'trig_mode' fields of 'struct kvm_lapic_irq' are left
> uninitialized in kvm_pv_kick_cpu_op(). While these fields are normally
> not needed for APIC_DM_REMRD, they're still referenced by
> __apic_accept_irq() for trace_kvm_apic_accept_irq(). Fully initialize
> the structure to avoid consuming random stack memory.
>
> Fixes: a183b638b61c ("KVM: x86: make apic_accept_irq tracepoint more generic")
> Reported-by: syzbot+d6caa905917d353f0d07@syzkaller.appspotmail.com
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

The patch was sent to linux-hyperv@ by mistake, my apologies.

-- 
Vitaly

