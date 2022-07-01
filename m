Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC4D562A37
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Jul 2022 06:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbiGAEOy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 1 Jul 2022 00:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGAEOx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 Jul 2022 00:14:53 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D7D21E15
        for <linux-hyperv@vger.kernel.org>; Thu, 30 Jun 2022 21:14:52 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so1024725otk.0
        for <linux-hyperv@vger.kernel.org>; Thu, 30 Jun 2022 21:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ohGS/GHjNx6gKBxjpOLnl3kUH/TQygNHmQFNpt5O95s=;
        b=GuELxlwIpzpiKD2YPx5S9btLkqNl6v08gJXYXRJGHFF1f66CnWPQ+VhHnxgOwvZpUD
         SsiI7teOiWo6y3ihKRF/hSaI4nzEoB3dMDXnSONCa13yka7pK3SHf/LXJjiqUAJu6u97
         rjgo19RxR3a9kcnUjrqU/2/UvQYLgknm+nguYSvdiUnxcPEavtdVFkRoFiWzLziZigo2
         T8SdyW+XfKzqDJ5gLSWP0fGxGGfclbgvp0u0OeEUDrgqmoDthyzaO1bvFTw/484qfnBO
         J6FXiBr2WlOTUf3B6wVOwwao311dr866KSo6u+OemWstFMgdGU5Tf+coPHgJ0sOQfIiB
         Hdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ohGS/GHjNx6gKBxjpOLnl3kUH/TQygNHmQFNpt5O95s=;
        b=5UOjG7FgQjdtYfvCZEpTHX3Hz1w4R0IxB3gZePrq9TgnS4/RDFbBlbYM97jSpoww4r
         yIYrpGA53J/UVesSiKu1CZqXea7thciynpPle89bWOR2qYt+QNqRF8C3TgJgiLZAMVLT
         JVU9RI5x5OMVwwOzAcg8SECd59PKhiQtGV1QS6WM9J1FqAL7Yl8dtYWpL/hl4oJH0Z1O
         Aq38GJixsUbwP2WMv2+v2bb/mqCfA5jRXdmOQN0W57zpNBCrfrEHT2b8onNCbsUo61D5
         +VpRug5Iy4KTPPYervlYO24Mz9M95KEc6Bt18Sg3CqXTceiA5Ga12vg+bQomqhDkummM
         r3ug==
X-Gm-Message-State: AJIora+T3Hxl/8gVjvIPwyp8ZxoXancJK+F2v4kugTRHfRFbmuKEYcYY
        5fFwepRfwXqyfio9IZ5xjHVv5w/L3jZcvMZQ1aLvjw==
X-Google-Smtp-Source: AGRyM1uVQkyvpZqWDwzmoKsksd5X4YjrjaWxlBJlYHpBkAj0z5nN/XbtMv/wWV3AOCs3/mFOVaWht/cbshz/KM0rpXI=
X-Received: by 2002:a05:6830:14:b0:616:dcbd:e53e with SMTP id
 c20-20020a056830001400b00616dcbde53emr5370409otp.267.1656648891911; Thu, 30
 Jun 2022 21:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220629150625.238286-1-vkuznets@redhat.com> <20220629150625.238286-19-vkuznets@redhat.com>
In-Reply-To: <20220629150625.238286-19-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 30 Jun 2022 21:14:40 -0700
Message-ID: <CALMp9eRhxvquDMn3ROUqdNL4bG769eG+ZJ4o3t8rwne8pkKbiw@mail.gmail.com>
Subject: Re: [PATCH v2 18/28] KVM: VMX: Move CPU_BASED_CR8_{LOAD,STORE}_EXITING
 filtering out of setup_vmcs_config()
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
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

On Wed, Jun 29, 2022 at 8:07 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> As a preparation to reusing the result of setup_vmcs_config() in
> nested VMX MSR setup, move CPU_BASED_CR8_{LOAD,STORE}_EXITING filtering
> to vmx_exec_control().
>
> No functional change intended.
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
