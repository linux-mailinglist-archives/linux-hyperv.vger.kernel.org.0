Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C26360EB92
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Oct 2022 00:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbiJZW2O (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Oct 2022 18:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJZW2O (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Oct 2022 18:28:14 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65E710CF99
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Oct 2022 15:28:13 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id g129so14777043pgc.7
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Oct 2022 15:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KsWF78Gscc45zIQ47ZS6ZoiLQcSQAlGBZpSARx9aWwY=;
        b=TjoRXwn3EYI1ezNi3qGsg1eeufk6bTxFNdjZXJnIQa08tKTAhaoDJR8RMxSAftli/2
         1X5ywx4Buv+5PxPdVIeKXblPblTlc4azKUZoB7hD47vVoR8M2aI1iVIG2PTrH81ktSQ+
         Hy0ZRDZkYWn5p2GH2y/D+GsN+t3KodNUGfcBGBo8QipSrf6wBek5YATobOiFDGjh79z0
         AVOs0cz0JCHOM/mcH72zcfXh87ob3e6fW76dB304DPtegwxM3FxgtzSp9sF0vdqrowjY
         DOWwoGR9bPbC8EyVZRGYsMiu3dfVVsBTMJw9kd4249t+yhoZaeHhRW7BEui6i/N8kYL4
         kb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsWF78Gscc45zIQ47ZS6ZoiLQcSQAlGBZpSARx9aWwY=;
        b=oicEFHzcEjV8twffeWszk5N8j/FKlKaH7BmsdZWcUDHfPpi6AtitY/ds8//d06cgJf
         X2PPnWL+MOAwQqx5BBc+RObAmh7wfDHrgitrqhDGKq2bfu9lAoq74606a03u9gZ/zw7Z
         Q7vdP+B5aYRjDiPrrpkOw4z5Xr3fAe4Z8PKG22argJ1qqVV4izjdutXMQMrqKAn0PX99
         JBkVXq6IDojQK3DtaEGiH0k1+UdGHQ0+diPhDkbD6cy9X8Oy3Mmp0K+7n3Rld2wqm1gc
         Tz8ZHOunG+Ez/OwUVidazxxBaFkbJedZ2VGbcRSjwtwlE356e13cypzCbk3t4XsaBpYu
         6HfA==
X-Gm-Message-State: ACrzQf2HNO/wOq/tDoih8u8sabApLdYcWdPv158S5bzOyUeMJDZ7ubdS
        C47WyJ5MqtduGJ/R+hSwuTByXw==
X-Google-Smtp-Source: AMsMyM5JA6nepD5A108Co2GC+LtcBJCI9HUpneh2uAuYYgnnqBCQdGkWSFYsA/qzjGRxZFEOVTBMVQ==
X-Received: by 2002:a63:e14c:0:b0:439:2e24:e014 with SMTP id h12-20020a63e14c000000b004392e24e014mr38639934pgk.173.1666823293254;
        Wed, 26 Oct 2022 15:28:13 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id c29-20020a056a00009d00b0056b9c2699cesm3466337pfj.46.2022.10.26.15.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 15:28:12 -0700 (PDT)
Date:   Wed, 26 Oct 2022 22:28:09 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 00/46] KVM: x86: hyper-v: Fine-grained TLB flush + L2
 TLB flush features
Message-ID: <Y1m0ef+LdcAW0Bzh@google.com>
References: <20221021153521.1216911-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021153521.1216911-1-vkuznets@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Oct 21, 2022, Vitaly Kuznetsov wrote:
>   KVM: selftests: evmcs_test: Introduce L2 TLB flush test
>   KVM: selftests: hyperv_svm_test: Introduce L2 TLB flush test

Except for these two (patches 44 and 45),

Reviewed-by: Sean Christopherson <seanjc@google.com>
