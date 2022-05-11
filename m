Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0315231E3
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 May 2022 13:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240207AbiEKLeW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 May 2022 07:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239193AbiEKLeN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 May 2022 07:34:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6F2363BC9
        for <linux-hyperv@vger.kernel.org>; Wed, 11 May 2022 04:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652268851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mdeNvQnnRKq3lrGA3PKNhx7zg1/AlenjiqX4C5ajWH8=;
        b=cL2xDAc+xowVyeofo3+TSX0YQYg1i0QlLyt3MOi/Mm4K5SsP9BtXwgxm2nXlgpU/WBWp2H
        FRwS18FT3h376RYgt2zhyTrDsnb2za0+XuS8E0QgmYX6uLUFqfdvAYAJAhZm3qyIxKQ3Qg
        tpTnzkodZSxWknAGBs7dYLJhw/t7xs4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-YH3jB-eAMvW9f57drIZoQg-1; Wed, 11 May 2022 07:34:07 -0400
X-MC-Unique: YH3jB-eAMvW9f57drIZoQg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F37C1C01B28;
        Wed, 11 May 2022 11:34:07 +0000 (UTC)
Received: from starship (unknown [10.40.192.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D126D1121314;
        Wed, 11 May 2022 11:34:03 +0000 (UTC)
Message-ID: <5f10e72e7be843c629c5de4be93fad6ac091c285.camel@redhat.com>
Subject: Re: [PATCH v3 22/34] KVM: x86: Expose Hyper-V L2 TLB flush feature
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 11 May 2022 14:34:02 +0300
In-Reply-To: <20220414132013.1588929-23-vkuznets@redhat.com>
References: <20220414132013.1588929-1-vkuznets@redhat.com>
         <20220414132013.1588929-23-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 2022-04-14 at 15:20 +0200, Vitaly Kuznetsov wrote:
> With both nSVM and nVMX implementations in place, KVM can now expose
> Hyper-V L2 TLB flush feature to userspace.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/hyperv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 68a0df4e3f66..1d6927538bc7 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -2826,6 +2826,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>  
>  		case HYPERV_CPUID_NESTED_FEATURES:
>  			ent->eax = evmcs_ver;
> +			ent->eax |= HV_X64_NESTED_DIRECT_FLUSH;
>  			ent->eax |= HV_X64_NESTED_MSR_BITMAP;
>  
>  			break;

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

