Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E89076D7B8
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Aug 2023 21:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjHBT3B (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Aug 2023 15:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjHBT3A (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Aug 2023 15:29:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1CA198B;
        Wed,  2 Aug 2023 12:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=acrSt/0dfnAuOYA3kr0V0TFcrwCk8zPYsNK8t3sQlW8=; b=M9iRT6l1WDQ2oHfc8NOUYhjj0k
        EHrmUwz67ebhDUJoYo6yWFtN+TEM7WXojgWr3pPgqhQK7XbG3T7zaFZxsNFm+7a1UughFihwrrZZk
        Tk5WQJiJFRyU/UqXalr+qV/O1PchsHiro4jcRJewG/QAjawsTNB5WHxzjuMRQ+FhuxWERR55AAZmF
        qm7eBIuuyiEfKChuHfPE/u4ePgt1fvy6Mwr0R0EGBhg3hl9rct+u8QBWwm0ElUfTijPbFwxrkSCIk
        Aeh6HojJFfITTAmATtIa4k8mW0hiGVVpstwTU4I262f88uny6Zluv9NMxVOGIjuxeS21Dj171YKZ2
        yXupdwKA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRHWS-00GkwV-BR; Wed, 02 Aug 2023 19:28:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F2294300301;
        Wed,  2 Aug 2023 21:28:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D9226210FEE66; Wed,  2 Aug 2023 21:28:39 +0200 (CEST)
Date:   Wed, 2 Aug 2023 21:28:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "levymitchell0@gmail.com" <levymitchell0@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mikelly@microsoft.com" <mikelly@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] hv_balloon: Update the balloon driver to use the SBRM API
Message-ID: <20230802192839.GB231007@hirez.programming.kicks-ass.net>
References: <20230726-master-v1-1-b2ce6a4538db@gmail.com>
 <BYAPR21MB16889DB462CEA394895BEBDBD70BA@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB16889DB462CEA394895BEBDBD70BA@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 02, 2023 at 05:47:55PM +0000, Michael Kelley (LINUX) wrote:
> From: Mitchell Levy via B4 Relay <devnull+levymitchell0.gmail.com@kernel.org> Sent: Tuesday, July 25, 2023 5:24 PM
> >
> > This patch is intended as a proof-of-concept for the new SBRM
> > machinery[1]. For some brief background, the idea behind SBRM is using
> > the __cleanup__ attribute to automatically unlock locks (or otherwise
> > release resources) when they go out of scope, similar to C++ style RAII.
> > This promises some benefits such as making code simpler (particularly
> > where you have lots of goto fail; type constructs) as well as reducing
> > the surface area for certain kinds of bugs.
> > 
> > The changes in this patch should not result in any difference in how the
> > code actually runs (i.e., it's purely an exercise in this new syntax
> > sugar). In one instance SBRM was not appropriate, so I left that part
> > alone, but all other locking/unlocking is handled automatically in this
> > patch.
> > 
> > Link: https://lore.kernel.org/all/20230626125726.GU4253@hirez.programming.kicks-ass.net/ [1]
> 
> I haven't previously seen the "[1]" footnote-style identifier used with the
> Link: tag.  Usually the "[1]" goes at the beginning of the line with the
> additional information, but that conflicts with the Link: tag.  Maybe I'm
> wrong, but you might either omit the footnote-style identifier, or the Link:
> tag, instead of trying to use them together.
> 
> Separately, have you built a kernel for ARM64 with these changes in
> place?  The Hyper-V balloon driver is used on both x86 and ARM64
> architectures.  There's nothing obviously architecture specific here,
> but given that SBRM is new, it might be wise to verify that all is good
> when building and running on ARM64.

The only issue that has popped up so far is that __cleanup__ and
asm-goto don't interact nicely. GCC will silently mis-compile but clang
will issue a compile error/warning.

Specifically, GCC seems to have implemented asm-goto like the 'labels as
values' extention and loose the source context of the edge or something.
With result that the actual goto does not pass through the __cleanup__.

Other than that, it seems to work as expected across the platforms.

A brief look through the patch didn't show me anything odd, should be
ok. Although my primary purpose was to get rid of 'unlock' labels and
error handling, simple usage like this is perfectly fine too.
