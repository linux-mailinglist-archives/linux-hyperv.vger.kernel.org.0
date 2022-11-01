Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158EA614EE6
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Nov 2022 17:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiKAQNp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Nov 2022 12:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiKAQNo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Nov 2022 12:13:44 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2881C435
        for <linux-hyperv@vger.kernel.org>; Tue,  1 Nov 2022 09:13:42 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso19333070pjc.0
        for <linux-hyperv@vger.kernel.org>; Tue, 01 Nov 2022 09:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nk9Zj5yWhkiJNSaUjwt3uwdSYsNnenBADlut1qfzb/c=;
        b=Qf7LaT+jXyZwyffGV6Uu8kqE/SPSE05I5EbEGO9LMigJW9/fR0LAB99WBDeXmcmL/5
         nPfRl//7Ed3WD18z9qPaUbZlLHQaTSFzoo/c6+D6xsTajkEsC34NizVHSNc8xaNBN9QI
         UlqtsRTNt0Sxumz1pyaM6UXCDohIPRcdqmgQAdqkSUNb2dxxNSrYI9GOReyYthxC+Li/
         nFuO7fEvjWOBlxNSXpI6/YBTnPZfLavMFbChtL2Iua+OyUmNLgKK4RbPidnJNgVrfZU4
         mbIkwkLtM8WiiHorTY+MGYZxiiqv3Dy8eiyaSpG0gB+NBfCHopz9IITjPHpNvMvcWROL
         kwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nk9Zj5yWhkiJNSaUjwt3uwdSYsNnenBADlut1qfzb/c=;
        b=phJ14DGhrTvyTJ03hPX12rMMrj143lLz4VvrwFcwpuxGmsfKIlMwRRIazdKvOcBNaF
         f3aCH3ZpvBHD49J6g/GD1mymoZtatEADbJSYWqfO5EkTqQDoo3HXfBBk4cYNDsgp2ii0
         Cjw8VeZ4glMMH/rgUe9ip8oNGHU4W8gQQ/gfexI7G2vHd58/pBG95aScO9tPPE58nzhf
         tBiNpfZJVTztQf9aB5dzwLrSjT5+qbvuoDb1WKj8gJF8R0feed4DwIoZJzzmydx8AXAi
         BaHT7S6owiIrMZuhLx3SQ0efWLwB523qKnk4n/jaN9t0MptHfZbseuDRPUjv3ZILyXy3
         zw8g==
X-Gm-Message-State: ACrzQf19vlPfNfRlnR4+1fE7N2AObUnvh8yAf5bfULg2f4hxhpxujztH
        df0CHjVYVfvCEhjh+BtIystjyg==
X-Google-Smtp-Source: AMsMyM5sMc6G6Axs5CplqsNMfpyQ4uSMH9AtzNaScglfsBB2PnXGH0+Ty0kIPYt4vCV1C8OSn3UKzQ==
X-Received: by 2002:a17:902:d48d:b0:186:cf83:4be3 with SMTP id c13-20020a170902d48d00b00186cf834be3mr20033880plg.22.1667319222319;
        Tue, 01 Nov 2022 09:13:42 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id s16-20020aa78bd0000000b0056b88187374sm6694607pfd.85.2022.11.01.09.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 09:13:42 -0700 (PDT)
Date:   Tue, 1 Nov 2022 16:13:38 +0000
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
Subject: Re: [PATCH v13 41/48] KVM: selftests: Split off load_evmcs() from
 load_vmcs()
Message-ID: <Y2FFstEvVhUTrtxD@google.com>
References: <20221101145426.251680-1-vkuznets@redhat.com>
 <20221101145426.251680-42-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101145426.251680-42-vkuznets@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Nov 01, 2022, Vitaly Kuznetsov wrote:
> +	/* Setup shadow VMCS, do not load it yet. */
> +	*(uint32_t *)(vmx->shadow_vmcs) =
> +		vmcs_revision() | 0x80000000ul;

In case another version is sent, or if Paolo feels like doing fixup when applying,
this wrap is no longer necessary.
