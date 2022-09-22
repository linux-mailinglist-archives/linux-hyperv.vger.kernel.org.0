Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD94F5E6C1B
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Sep 2022 21:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiIVTxC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Sep 2022 15:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbiIVTwr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Sep 2022 15:52:47 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA9610C7AA
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Sep 2022 12:52:46 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id y11so10855920pjv.4
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Sep 2022 12:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=wMNXJ8tFxE5zdbCt/8NlY898zBIrwCziYNXTEkeFtOE=;
        b=osmH1rZrpkJ6s76hQuUAEjFLexMUXotkjlIrkAHzJLLxfMjT4VOxIIq7LsqQygOh1U
         MoPViL9Sh3S3Qf6Ig3abH0WuEvy3q7FJqIZkhBpXAk5dtG45kC6WW06TWbRtFiRcwIZA
         +/V/HjoJfQPK57rx8trhI7mrhNdKAf1dRseLhJKopMegcnOL2hYPoKiiOZZR0tGrcgUK
         S/vrE7BpLzym8cvD4FET/cPLMF8VJlHGakNccZ6Putz3DmOWcdPJWkLOuClFVeSCBlZE
         IfLPei+StKU1CMKK9+vrHZfyN+5Qv06CZ3dDS/Y6m7OFbLzYA9ARkbF6avZezHx5q+Gp
         F1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=wMNXJ8tFxE5zdbCt/8NlY898zBIrwCziYNXTEkeFtOE=;
        b=g8hmQ0A2pFQa8TmNakHG1zXs/fS1+wmUQwpHg8ffRT1taB+PpYrclObI4VLNdasfah
         zmXs1ODQYaTq20yuJoVeIN2Mdl3WaSY3Pbmrqn0s5nVFaqJrUermNApwS8KBl7dL0XyN
         H8NRCD/I7CGYUi/t5LarbYt378f4yjNDhyiK4hhz75MOYZisE3cSwRcrJnD8f5f+vYPH
         PZk+CX88cPoaijgZj8dxh4Xy0wSGN4s7b05d3+YSH3hwIW/OKiaGvIV0RNTK4OW0DBiP
         eBBwdjhQ4ixbVz2Tecq8q4HeCvV4TtfWg8ljRbikS+mZEnZumFYAr8a2S1spCff/Rtlo
         I+8A==
X-Gm-Message-State: ACrzQf0WAKUMXiv3pyatybkap2LcuV3UuHm/NZYcoJVu4Uq4oeCDFOUj
        0O0lzn22NZjZVkFko7EShfKomcItJklRIg==
X-Google-Smtp-Source: AMsMyM5BdUqTDuToI93vzvlISEbaqCLJ8dQf04fko/C0BcWQFqgd8LAFO+L9G1jawdpz47TT0G+T8g==
X-Received: by 2002:a17:902:b089:b0:178:54cf:d692 with SMTP id p9-20020a170902b08900b0017854cfd692mr4732453plr.1.1663876365741;
        Thu, 22 Sep 2022 12:52:45 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u16-20020a632350000000b004277f43b736sm4180327pgm.92.2022.09.22.12.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 12:52:44 -0700 (PDT)
Date:   Thu, 22 Sep 2022 19:52:40 +0000
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
Subject: Re: [PATCH v10 14/39] KVM: nSVM: Keep track of Hyper-V
 hv_vm_id/hv_vp_id
Message-ID: <Yyy9CH9CgCsZ3m3V@google.com>
References: <20220921152436.3673454-1-vkuznets@redhat.com>
 <20220921152436.3673454-15-vkuznets@redhat.com>
 <Yyt/Nrh4aoLrNt11@google.com>
 <87y1ubn3e9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1ubn3e9.fsf@redhat.com>
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

On Thu, Sep 22, 2022, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > I'm definitely not dead set against having hyperv.{ch}, but unless there's a high
> > probability of SVM+Hyper-V getting to eVMCS levels of enlightenment, my vote is
> > to put these helpers in svm/nested.c and move then if/when we do end up accumulating
> > more SVM+Hyper-V code.
> 
> Well, there's more on the TODO list :-) There are even nSVM-only
> features like "enlightened TLB" (to split ASID invalidations into two
> stages) so I don't want to pollute 'nested.c'. In fact, I was thinking
> about renaming vmx/evmcs.{ch} into vmx/hyperv.{ch} as we're doing more
> than eVMCS there already. Also, having separate files help with the
> newly introduces 'KVM X86 HYPER-V (KVM/hyper-v)' MAINTAINERS entry.

Ya, there is that.

> Does this sound like a good enough justification for keeping hyperv.{ch}?

Your call, I'm totally ok either way.  If we do add svm/hyperv.{ch}, my vote is
to also rename vmx/evmcs.{ch} as you suggested.  I like symmetry :-)
