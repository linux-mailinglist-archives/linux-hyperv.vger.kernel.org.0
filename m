Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BE554294B
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jun 2022 10:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiFHIVZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 Jun 2022 04:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiFHIUP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Jun 2022 04:20:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF55C39F24D
        for <linux-hyperv@vger.kernel.org>; Wed,  8 Jun 2022 00:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654674444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NllZgEM9+Xgx+C0OKxvAQxMq/QfRXHmPWsigKuRrfkU=;
        b=V6PISo5IVv+dMS5DYzCfqL+Aa34G9NMsRb6Zhr7fv0wTG73rE6WeQNw9vMPMgtI8fDe3mN
        lgjWhXVnNKBOucS/xKajyK4N8FA4X8UcMsxcpfm4p3oCqPH9/5K1hSRxt7ezq0Sg0Vkgey
        VA316U1an/OQ225RR9oYJx60/gIJLmM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-dO4GlHAINnizyohqwbkQ0g-1; Wed, 08 Jun 2022 03:47:22 -0400
X-MC-Unique: dO4GlHAINnizyohqwbkQ0g-1
Received: by mail-ej1-f70.google.com with SMTP id p7-20020a170906614700b006f87f866117so8983761ejl.21
        for <linux-hyperv@vger.kernel.org>; Wed, 08 Jun 2022 00:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=NllZgEM9+Xgx+C0OKxvAQxMq/QfRXHmPWsigKuRrfkU=;
        b=n/SdtE3ngAHMt4idoDJ4gbD9pfou0gJVos+sOZf71snoeBadIFIN/0RWohA8556d2D
         MdMfFzGuG+daPEwyKnnTXTYqcITUWtCAB+RPMu5FB/OpIeqM3OOzPcgWbHq5WpmvQHbj
         6hp2mV2hBenesBGCJPA11J98XbztVFwgW4UpFc8LOAQMSXqAigURW7xqOgeOPhHJnZyK
         M8/oNtl831Cs9F/mTl/7HrVf9bGoKGHZahREXmznpHKcsoWYPbzwCvr5eeNT6Nn14cFh
         jjHFkVHiivIENvg4lvUoEokIbuPP54tuP+OGSftnuRh8DejBkirfD5xX617uNr0jTg5N
         UtOw==
X-Gm-Message-State: AOAM530AT6Pk5fOhWD0gI5egq5iBYsvJyfWXEjDMuhEWUPGFFmOnuO5q
        18l1dtYF7GeIRF9QnqrZqBBIHdYIcfwepbcUrt/H8hK2I5jJEO5TFs7omUCAJd45T7vasNw78uJ
        ugKXhM4KMtdptGo/AgZxXp3PX
X-Received: by 2002:a05:6402:1c91:b0:42d:c9b6:506b with SMTP id cy17-20020a0564021c9100b0042dc9b6506bmr37157647edb.166.1654674441646;
        Wed, 08 Jun 2022 00:47:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJ6zCbgAByK4tcMjAhyVE5Ffevs0gRLanA9Oj8rlcZDVQlPs1lvb3eSpEaGo0jBy/TWir7Tw==
X-Received: by 2002:a05:6402:1c91:b0:42d:c9b6:506b with SMTP id cy17-20020a0564021c9100b0042dc9b6506bmr37157626edb.166.1654674441430;
        Wed, 08 Jun 2022 00:47:21 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id h4-20020a1709067cc400b006f3ef214ddbsm8815010ejp.65.2022.06.08.00.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 00:47:20 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 03/38] KVM: x86: hyper-v: Introduce TLB flush fifo
In-Reply-To: <4be614689a902303cef1e5e1889564f965e63baa.camel@redhat.com>
References: <20220606083655.2014609-1-vkuznets@redhat.com>
 <20220606083655.2014609-4-vkuznets@redhat.com>
 <4be614689a902303cef1e5e1889564f965e63baa.camel@redhat.com>
Date:   Wed, 08 Jun 2022 09:47:19 +0200
Message-ID: <87bkv3mwag.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Maxim Levitsky <mlevitsk@redhat.com> writes:

> On Mon, 2022-06-06 at 10:36 +0200, Vitaly Kuznetsov wrote:
>> To allow flushing individual GVAs instead of always flushing the
>> whole
>> VPID a per-vCPU structure to pass the requests is needed. Use
>> standard
>> 'kfifo' to queue two types of entries: individual GVA (GFN + up to
>> 4095
>> following GFNs in the lower 12 bits) and 'flush all'.
>
> Honestly I still don't think I understand why we can't just
> raise KVM_REQ_TLB_FLUSH_GUEST when the guest uses this interface
> to flush everthing, and then we won't need to touch the ring
> at all.

The main reason is that we need to know what to flush: L1 or
L2. E.g. for VMX, KVM_REQ_TLB_FLUSH_GUEST is basically

vpid_sync_context(vmx_get_current_vpid(vcpu));

which means that if the target vCPU transitions from L1 to L2 or vice
versa before KVM_REQ_TLB_FLUSH_GUEST gets processed we will flush the
wrong VPID. And actually the writer (the vCPU which processes the TLB
flush hypercall) is not anyhow synchronized with the reader (the vCPU
whose TLB needs to be flushed) here so we can't even know if the target
vCPU is in guest more or not.

With the newly added KVM_REQ_HV_TLB_FLUSH, we always look at the
corresponding FIFO and process 'flush all' accordingly. In case the vCPU
switches between modes, we always raise KVM_REQ_HV_TLB_FLUSH request to
make sure we check. Note: we can't be raising KVM_REQ_TLB_FLUSH_GUEST
instead as it always means 'full tlb flush' and we certainly don't want
that.

-- 
Vitaly

