Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D5E571909
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Jul 2022 13:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiGLLxV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 Jul 2022 07:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbiGLLxD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Jul 2022 07:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74150B5D3A
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 04:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657626723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X6w0674s9ili7eArWVuDLnAMEL/ug8bcR3ZZcjz90CE=;
        b=ftkTFSd6uoqAKsuawDclIPJwy8GUChX4PVBnPPm7A9sUKEjd9OfdRUO88LrAImUG6NnDe2
        EDEoIKxDwDQjU/OstYTiSMuRPVzBhSJSk5G5gk1IqtAqXa22+x1CG3DJ+BXGMjA1rqfku+
        LrhzZ70UdtEubXUL6XT9rdemfUndB3I=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-19C_CCmYPnykXiigU3bmRQ-1; Tue, 12 Jul 2022 07:52:02 -0400
X-MC-Unique: 19C_CCmYPnykXiigU3bmRQ-1
Received: by mail-qk1-f199.google.com with SMTP id bk12-20020a05620a1a0c00b006b194656099so7582776qkb.5
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 04:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=X6w0674s9ili7eArWVuDLnAMEL/ug8bcR3ZZcjz90CE=;
        b=tgrvZ9I8GCzwTynCB6UYT0wNWhQ9ldQ/dqLRTFXM33RrsF+u+kAGQ8hWWnIPPPmUjF
         hntwYzh6AiUQcJM0+QxSDF+b9yThuDsCo/Vve52bLEdqOXcrJ+M2g7MGfUBKlp7d/sDE
         rPceXyjd/yqC6R+uUqzUB9s7EgWdTWlvG+CTfIzRrgUwUwCvPD22FIfpN0+NOGMhlwKX
         0Bpx3UfeTMe+KvvlwWZVqltqyfeFYhr/pEtFrl6eEuoMXvYtUkYbsl4x1/WvxITtbLCf
         RlPx0IlwqIBC1oEbOqMfsuufaEGfqCZKilKaznkLjxhQUdZng51GNEqUE8NRMBPkB+nN
         ub+g==
X-Gm-Message-State: AJIora/P5V8J1WsJaSPpRtKLyiWe5SbULU9pEBS8f7ZA9qv8/R911pLh
        PCISP3yf0h0JeRrXhoChNTIELSAVmxqkN6kax3cfAmDnEfKhiM5uhVRMfuQZ1GDVnFbPnCGtRLx
        mPZ7wUQm9bAkHHUlu6HH80F0k
X-Received: by 2002:a05:620a:460d:b0:6b5:91f7:62e with SMTP id br13-20020a05620a460d00b006b591f7062emr4923487qkb.487.1657626722509;
        Tue, 12 Jul 2022 04:52:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tOyzMnWtzjI+gxSVBLeO+oFjE5N8UcGZXyfPv0gM8p73Issnk6xlKMnd/qXHM9ma7lLPObww==
X-Received: by 2002:a05:620a:460d:b0:6b5:91f7:62e with SMTP id br13-20020a05620a460d00b006b591f7062emr4923471qkb.487.1657626722298;
        Tue, 12 Jul 2022 04:52:02 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id j9-20020ac85c49000000b0031eac31e630sm7443948qtj.49.2022.07.12.04.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:52:01 -0700 (PDT)
Message-ID: <86803b99df343926b9dd4f4089fccd7efb04eb00.camel@redhat.com>
Subject: Re: [PATCH v3 07/25] KVM: selftests: Add
 ENCLS_EXITING_BITMAP{,HIGH} VMCS fields
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 14:51:58 +0300
In-Reply-To: <20220708144223.610080-8-vkuznets@redhat.com>
References: <20220708144223.610080-1-vkuznets@redhat.com>
         <20220708144223.610080-8-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, 2022-07-08 at 16:42 +0200, Vitaly Kuznetsov wrote:
> The updated Enlightened VMCS definition has 'encls_exiting_bitmap'
> field which needs mapping to VMCS, add the missing encoding.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  tools/testing/selftests/kvm/include/x86_64/vmx.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/vmx.h b/tools/testing/selftests/kvm/include/x86_64/vmx.h
> index cc3604f8f1d3..5292d30fb7f2 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/vmx.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/vmx.h
> @@ -208,6 +208,8 @@ enum vmcs_field {
>  	VMWRITE_BITMAP_HIGH		= 0x00002029,
>  	XSS_EXIT_BITMAP			= 0x0000202C,
>  	XSS_EXIT_BITMAP_HIGH		= 0x0000202D,
> +	ENCLS_EXITING_BITMAP		= 0x0000202E,
> +	ENCLS_EXITING_BITMAP_HIGH	= 0x0000202F,
>  	TSC_MULTIPLIER			= 0x00002032,
>  	TSC_MULTIPLIER_HIGH		= 0x00002033,
>  	GUEST_PHYSICAL_ADDRESS		= 0x00002400,

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

