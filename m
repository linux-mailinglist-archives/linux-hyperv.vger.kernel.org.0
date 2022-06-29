Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A01E560C44
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Jun 2022 00:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiF2W1q (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 29 Jun 2022 18:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiF2W1p (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 29 Jun 2022 18:27:45 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CBE39B81
        for <linux-hyperv@vger.kernel.org>; Wed, 29 Jun 2022 15:27:44 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id e131so23536502oif.13
        for <linux-hyperv@vger.kernel.org>; Wed, 29 Jun 2022 15:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ng/t2d/qzqjg5f87HKrQVLd4Y/9sxNRY/C0EI7Ml8dE=;
        b=kSMy4+POZIfLq5+w6YmxCyMWnCS8C3Mt4MMhjMqXwrv6YoCSvS9D9M6EsnnlTHCwXg
         WpsB41G0aP+1mpcUBlsDVrbw0fMWz+Vtv8sCHqkTZ3nUw6/Tb5t4Gi5e1gW78IZ4Srnx
         ij6ANEQxs4JzTjmGk4DxHQT9H0Rvj6s2Mqdko6vWujTIAKTQdPRLzMzZ0e5nzWbUh7WR
         0U6TOmvZn+NjpRywnZJDvXZFho+7h2SMTxdAaOQSr1Z9ks/zHrjiL2Q4Ay9eSWaNP70X
         aUxCx9k7jjB64wr8LruCIUlU+dtv2EzVtu/C6stflSzpyD109LwXnG/PUKFkv0TqFD+R
         hPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ng/t2d/qzqjg5f87HKrQVLd4Y/9sxNRY/C0EI7Ml8dE=;
        b=YI0N7iVncYamtP7MFGeTeMBeVeuJ+L+YeXSJjYT5TUIEw82By/jy4hM9h97Eq7ddV6
         cD+vlHabHmvy6ubQ3USp+8f/I8sU/QuEJ7vn9rTmfyGj8eYQsJsZH4ueMa+dOs9TbGWu
         NouKVYlGITly1PgN6WVwKhHkjPx5vCptyx226jAJuw2eo5KJ1c8AkSqIPNVog5skPcwW
         ONx2/2rJTs/kAfb83YHJxKEDe4tmf2l2rgklVY7iOLlJ9lowJYMTEUAZIQp1uWYoxvTW
         UaHcIQhPdM8Iuxgzx15yyDoMQRU39FYYyfKVltqEx0rq+zmenznW03/nArY2nIXWYQf5
         LPrQ==
X-Gm-Message-State: AJIora+fqAWxmx+v6VEGogTAoCdjR+cQccAZoomdipaQkXgfQXuolAYK
        YoF5V0aZ+wkuvvzDL3/wlFpl5Vy3MsyZsNRb74bYCg==
X-Google-Smtp-Source: AGRyM1sl8Uu5Y6pb7Dl4WPAxpFaszRjgSF59h8aOJ+5i3RM3dFYPgMIvv9fll/+t/oLDS23mv6D/L9U8smAMfkgSZ8Q=
X-Received: by 2002:a05:6808:2124:b0:335:7483:f62d with SMTP id
 r36-20020a056808212400b003357483f62dmr4581673oiw.112.1656541663655; Wed, 29
 Jun 2022 15:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220627160440.31857-1-vkuznets@redhat.com> <CALMp9eQL2a+mStk-cLwVX6NVqwAso2UYxAO7UD=Xi2TSGwUM2A@mail.gmail.com>
 <87y1xgubot.fsf@redhat.com> <CALMp9eSBLcvuNDquvSfUnaF3S3f4ZkzqDRSsz-v93ZeX=xnssg@mail.gmail.com>
 <87letgu68x.fsf@redhat.com> <CALMp9eQ35g8GpwObYBJRxjuxZAC8P_HNMMaC0v0uZeC+pMeW_Q@mail.gmail.com>
 <87czeru9cp.fsf@redhat.com>
In-Reply-To: <87czeru9cp.fsf@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 29 Jun 2022 15:27:32 -0700
Message-ID: <CALMp9eQ5Sqv3RP8kipSbpfnvef_Sc1xr1+g53fwr0a=bhzgAhg@mail.gmail.com>
Subject: Re: [PATCH 00/14] KVM: nVMX: Use vmcs_config for setting up nested
 VMX MSRs
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        kvm@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Jun 29, 2022 at 2:06 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:

> For PERF_GLOBAL_CTRL errata:
> - We can move the filtering to vmx_vmexit_ctrl()/vmx_vmentry_ctrl()
> preserving the status quo: KVM doesn't use the feature but it is exposed
> to L1 hypervisor (and L1 hypervisor presumably has the same check and
> doesn't use the feature. FWIW, the workaround was added in 2011 and the
> erratas it references appeared in 2010, this means that the affected
> CPUs are quite old, modern proprietary hypervisors won't likely boot
> there).
Sadly, Nehalem and Westmere are well-supported by KVM today, and we
will probably still continue to support them for at least another
decade. They both have EPT, unrestricted guest, and other VT-x2
features that KVM still considers optional.
