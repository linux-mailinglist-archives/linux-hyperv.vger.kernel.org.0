Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E607F584831
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Jul 2022 00:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiG1WZH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Jul 2022 18:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiG1WZF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Jul 2022 18:25:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C8CD796AB
        for <linux-hyperv@vger.kernel.org>; Thu, 28 Jul 2022 15:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659047104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ndVyxggE9NRkNXPrTefS8i3sDBY7mXSC7xSnt5hqVcI=;
        b=Vxc03qeZPzdA8LRwslpSUWJ2yhzMW4nsE9fl1aGVk07p9Vr+sStgqWanQpuY+59Rl9Zvyf
        lwOzV6J1HxYrP0llI8J2zFqPwzDRnk/HjurEWf3ooKtluc4msHY2CCu4WpYMsYDVgWKAG1
        l5u7uECZS3GJppY59ggEQN+BkzHUKRM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-546-H1rzvCUXM5e9mralAXS5VQ-1; Thu, 28 Jul 2022 18:25:02 -0400
X-MC-Unique: H1rzvCUXM5e9mralAXS5VQ-1
Received: by mail-wm1-f69.google.com with SMTP id az39-20020a05600c602700b003a321d33238so1505350wmb.1
        for <linux-hyperv@vger.kernel.org>; Thu, 28 Jul 2022 15:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ndVyxggE9NRkNXPrTefS8i3sDBY7mXSC7xSnt5hqVcI=;
        b=0vr8QD8Br9fvHSdmY5GMp8cCm08t3VjJn28aeKP+6ZtOAoOgevID2jykYuvtcNQMg4
         sQm4E/b7rOeDFnIjz73Ao/QE2KHI0u1t5iMz0QN0Yj9wHStuJNN4WNbydJvtnneB5PXx
         ezcrepBcff2aHjTRu5fV2te8PEOIgtKuR3tlVuMHL8kSNVEPqNz2YbCvssZYDSTuFWOa
         sLy0tsm38+//EfdgAhPrqkGp9v+aj5ttwY5iVFYYCt0EK34VUCOp6t9mTuyX3HZxoYo0
         DPNEh2XY2Gs33omtgcjc1LHDXbJ0+++mdvArTyjEFJBIxM19gutNAvGX0gkKwLlNFexH
         Sn6w==
X-Gm-Message-State: ACgBeo15AM8g6QIQ+ngexpDnzARrfTtUCqxTk+Kg/ExEMCuheBm8DZb5
        sDbV+AYP8doQsYWbD5d5omXUrYLd2+lNVTMBSZ529PQz9sXqUyuAALIrv/360xJP5jtBE5ocZN2
        WoUuRXXdz89RTtj5Bbt4msZg/
X-Received: by 2002:adf:fb43:0:b0:21a:22eb:da43 with SMTP id c3-20020adffb43000000b0021a22ebda43mr536574wrs.347.1659047101750;
        Thu, 28 Jul 2022 15:25:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6Q9rKQXjFh0ctRsdAdZhnqZ3N2P/1jov3HzMQFk5kNK/RNIbPCnkKzM1LTMgw0NuP7UzQJXA==
X-Received: by 2002:adf:fb43:0:b0:21a:22eb:da43 with SMTP id c3-20020adffb43000000b0021a22ebda43mr536558wrs.347.1659047101267;
        Thu, 28 Jul 2022 15:25:01 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id a6-20020a5d53c6000000b0021ea5b1c781sm2112257wrw.49.2022.07.28.15.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 15:25:00 -0700 (PDT)
Message-ID: <62ac29cb-3270-a810-bad1-3692da448016@redhat.com>
Date:   Fri, 29 Jul 2022 00:24:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 09/25] KVM: VMX: nVMX: Support TSC scaling and
 PERF_GLOBAL_CTRL with enlightened VMCS
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220714091327.1085353-1-vkuznets@redhat.com>
 <20220714091327.1085353-10-vkuznets@redhat.com> <YtnMIkFI469Ub9vB@google.com>
 <48de7ea7-fc1a-6a83-3d6f-e04d26ea2f05@redhat.com>
 <Yt7ehL0HfR3b97FQ@google.com>
 <870d507d-a516-5601-4d21-2bfd571cf008@redhat.com>
 <YuMKBzeB2cE/NZ2K@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YuMKBzeB2cE/NZ2K@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 7/29/22 00:13, Sean Christopherson wrote:
> The only flaw in this is if KVM gets handed a CPUID model that enumerates support
> for 2025 (or whenever the next update comes) but not 2022.  Hmm, though if Microsoft
> defines each new "version" as a full superset, then even that theoretical bug goes
> away.  I'm happy to be optimistic for once and give this a shot.  I definitely like
> that it makes it easier to see the deltas between versions.

Okay, I have queued the series but I still haven't gone through all the 
comments.  So this will _not_ be in the 5.21 pull request.

The first patch also needs a bit more thought to figure out the impact 
on userspace and whether we can consider syndbg niche enough to not care.

Paolo

