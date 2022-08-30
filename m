Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57595A6560
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Aug 2022 15:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiH3Nqr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Aug 2022 09:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiH3Nqb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Aug 2022 09:46:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A209B4E
        for <linux-hyperv@vger.kernel.org>; Tue, 30 Aug 2022 06:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661867027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xSYsGT+JuRUnE0x8Uu6rvpfH2JA8fm0UMDh7oy78WJU=;
        b=MCdnOLAW3MVOXTiLVGGPVJsWO2E6VuQqwD/gk/ms7uzFeyJlWE3mkKFWyP2J+4LeUbdj09
        iz02xe8gZyEljj14+hAraHMnLUVCo37W7uNY1GpSaAqJnKrGluXsW3A9tHlhnO+j05jTut
        JKHvVNw30CpA3UWMUAFR/hFttYRQNmI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-46-vMlaDYgQP86aZDwPvroMag-1; Tue, 30 Aug 2022 09:43:46 -0400
X-MC-Unique: vMlaDYgQP86aZDwPvroMag-1
Received: by mail-wr1-f71.google.com with SMTP id i27-20020adfa51b000000b00226d0b29adfso1551123wrb.0
        for <linux-hyperv@vger.kernel.org>; Tue, 30 Aug 2022 06:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=xSYsGT+JuRUnE0x8Uu6rvpfH2JA8fm0UMDh7oy78WJU=;
        b=t/GluqK4NNMp3pVyQfNwO6p0nqc6hHjxFzviRTo2VglXG7VvYdS84uOOARW46qVchn
         hKnzYH8Catb/P01y/rWbe1sPvOy4vOvQpTi+W9e1YlTbHrNz2wc7G/vc/FR1lJMtzNgf
         lPEKY96k9T8IZAbhBkMk6i9qQFI+qGpaR5z82g851aXXEVn8+kCVP/BrfhdiGDKeAcmO
         2gz/YKBjOVU6Ytut2SH/AMOQGV4Xb2WoieQYMIIRW/eZnFMKgFUsXNPL0dpmk3VZa5oj
         f3nIBU4sGbgMqzxCHxP8g6XVMYnWZXZ7Bq5lR0SFB4gO+N02AxL2tDlBr25G9w+BiNMR
         HN4A==
X-Gm-Message-State: ACgBeo1BTqDpRcBWQ3wjtkN2xdf+pT0WhkLLMAsfLnPPfU2CIjp+l5hm
        0C6EUuuGQIrVT/r9H41MO4UBwyPhOXk0or62VcdBk7s6goDhWfYstdylTzJr6rqRdgHIqN7xCct
        fj++Tg72jHfxZCH/VSsdr5Xhc
X-Received: by 2002:a05:600c:418a:b0:3a5:168e:a918 with SMTP id p10-20020a05600c418a00b003a5168ea918mr9782004wmh.31.1661867023752;
        Tue, 30 Aug 2022 06:43:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7J7amscRJ3WfZNYVzhrBCLo4tjoSRLTzgx5nbx4QzFf31AtfhlXNT2cljEHY97bXhWh+p3lQ==
X-Received: by 2002:a05:600c:418a:b0:3a5:168e:a918 with SMTP id p10-20020a05600c418a00b003a5168ea918mr9781989wmh.31.1661867023521;
        Tue, 30 Aug 2022 06:43:43 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id i20-20020a05600c2d9400b003a604a29a34sm11680851wmg.35.2022.08.30.06.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 06:43:42 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v9 00/40] KVM: x86: hyper-v: Fine-grained TLB flush + L2
 TLB flush features
In-Reply-To: <20220803134110.397885-1-vkuznets@redhat.com>
References: <20220803134110.397885-1-vkuznets@redhat.com>
Date:   Tue, 30 Aug 2022 15:43:41 +0200
Message-ID: <8735ddvoc2.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Changes since v8:
> - Rebase to the current kvm/queue (93472b797153)
> - selftests: move Hyper-V test pages to a dedicated struct untangling from 
>  vendor-specific (VMX/SVM) pages allocation [Sean].

Sean, Paolo,

I've jsut checked and this series applies cleanly on top of the latest
kvm/queue [372d07084593]. I also don't seem to have any feedback to
address.

Any chance this can be queued?

-- 
Vitaly

