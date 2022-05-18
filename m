Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1008652BE45
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 May 2022 17:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238859AbiEROzY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 May 2022 10:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238862AbiEROzW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 May 2022 10:55:22 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2A844A2E
        for <linux-hyperv@vger.kernel.org>; Wed, 18 May 2022 07:55:20 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id k16so2380445pff.5
        for <linux-hyperv@vger.kernel.org>; Wed, 18 May 2022 07:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o7tY6ZcRmC6gYAakiOEfUJCGVoPD3Xvj9BL1UezKdDA=;
        b=VPhKTi9d8w7lwf065MCuP6kWcomDghzJDkfvBQwDM9ND2AbNAeIZk20nTc63vu6Mos
         wag31H9GOQNSydzbC5RipG22vzckeEC+ITBUZzqhHq7mDWtPnoKq5jo2cTUqWpLKrTe4
         WRkoKwzSZ6uhDh9PaswEQCSHJIPI22M/PAjIqhjrXaGjT3XGB75hvtpifewTVXtoWVmn
         iJ0qdKOWoGkCWpDZrLhex/I5t0AlklSTgtp4IWxeJ0JihjReGg8FJ+USEvlJmqa8Esfi
         i6NlWqbaVKThA/yt171mlYyO0TUSCPiXvO14Ex5U20QOp72xCVt484SU7jhaoMdIof0b
         LBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o7tY6ZcRmC6gYAakiOEfUJCGVoPD3Xvj9BL1UezKdDA=;
        b=GNO+W7eLGigSmyhPWcThhQ7jDgSHccDktzxCGFsNE8vfqEyCLdqH8zeQ77tH8qIxhE
         uDwOobu7TckS7Z+Xi0Nv9eBr+vlPKo20haJIbgt2p3t4NG7C0yfQPrkk8OkIhEDJdWdO
         LWuSl6RNJiK0I+X3CMKXaNmu9Sb7Sx5k8Nv+AUVLq4bnY+Rw3WH2QARq0RpjvOfObsiX
         fGkhbdwEjP7eRQEMkghdo3X3aHO8tKHvGAE+M+zJdF0vF8omWH8Al6ipLZrVYht8li6T
         19EcsQSZnodVyJ2hwYt5rPpXF3KU4/ftIokyhimn6hMxVs4nrgTy6h1pCkTdHC873lIE
         SPDA==
X-Gm-Message-State: AOAM530xOwMsYlHvRoM2AOSUzaG9z4fvz+Z5i6+zzkHOlr762mAdiUPv
        zojQYpmgxuve5W34aEWwScxpbg==
X-Google-Smtp-Source: ABdhPJysEejWXF06hcE4vW/aCi2q+cxS02x/9DLbVEAvnOwBC9SO7Q3PrJUwsB/1bty7W3/d06HCcQ==
X-Received: by 2002:a05:6a00:2908:b0:4fa:9297:f631 with SMTP id cg8-20020a056a00290800b004fa9297f631mr93240pfb.3.1652885720016;
        Wed, 18 May 2022 07:55:20 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id jh1-20020a170903328100b0015e8d4eb269sm1781608plb.179.2022.05.18.07.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 07:55:19 -0700 (PDT)
Date:   Wed, 18 May 2022 14:55:15 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 04/34] KVM: x86: hyper-v: Handle
 HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST{,EX} calls gently
Message-ID: <YoUI03NDdMPYTiSO@google.com>
References: <20220414132013.1588929-1-vkuznets@redhat.com>
 <20220414132013.1588929-5-vkuznets@redhat.com>
 <165aea185dfef1eba9ba0f4fd1c3a95361c41396.camel@redhat.com>
 <877d6juqkw.fsf@redhat.com>
 <YoUAM9UtfQlGOZxl@google.com>
 <87y1yyucis.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1yyucis.fsf@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, May 18, 2022, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Wed, May 18, 2022, Vitaly Kuznetsov wrote:
> >> Maxim Levitsky <mlevitsk@redhat.com> writes:
> >> > Or if using kfifo, then it can contain plain u64 items, which is even more natural.
> >> >
> >> 
> >> In the next version I switch to fifo and get rid of 'flush_all' entries
> >> but instead of a boolean I use a 'magic' value of '-1' in GVA. This way
> >> we don't need to synchronize with the reader and add any special
> >> handling for the flag.
> >
> > Isn't -1 theoretically possible?  Or is wrapping not allowed?  E.g. requesting a
> > flush for address=0xfffffffffffff000, count = 0xfff will yield -1 and doesn't
> > create any illegal addresses in the process.
> >
> 
> Such an error would just lead to KVM flushing the whole guest address
> space instead of flushing 4096 pages starting with 0xfffffffffffff000
> but over-flushing is always architecturally correct, isn't it?

Oh, duh.  Yeah, flushing everything is totally ok.  Maybe just add a comment above
the #define for the magic value calling out that corner case and why it's ok?
