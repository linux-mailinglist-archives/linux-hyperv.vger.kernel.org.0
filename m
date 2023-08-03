Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C671476F573
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Aug 2023 00:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjHCWHh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Aug 2023 18:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjHCWHg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Aug 2023 18:07:36 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6904E110;
        Thu,  3 Aug 2023 15:07:34 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-268b3ddc894so824435a91.1;
        Thu, 03 Aug 2023 15:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691100454; x=1691705254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GorMN/ZwPfrkzaNazep8IyRB8qxYOzRyNpyV+jJtZgI=;
        b=YKA1ouyfHln/vuyfiZNzVmaNd5J32AtsCq90P0nIm02hBF/RzASKE4S0zH97uGcVO8
         xaB2jHO7Mwc/hgbrwXVbsNtxURCNu5UssJHvMHWg5LiaOxss6o0mfbKED1JhWMsAsXjh
         yBQfQrCvXmbyUBRR1WsIwOZF2m8/Qo57s2EnOiu6T8L6/RLDYovMMPzZBIEH2rDVhCxO
         Op7nz/jkgfNFhQDprFPf8YnLgW+MXHfq9iXBeIODDrbust/tl8AUq0PCurouaF4JbLnV
         dYHyahYKzWVAdY5eMPZVgolduXqjPAw52MRiSn9o9oas2pgOEuF20SALdr1HgGFbpOm0
         Kbrg==
X-Gm-Message-State: AOJu0Ywbp1uqzsyvsKz3dOQrfu1tUyC7dFrGHstiHdY9utBjPZMl/5q7
        bf3aMVrXm2wDZFYu5b8tN44=
X-Google-Smtp-Source: AGHT+IEvCJKTcf4lBGho+GNe2a/F6WWi73Fhu0wdZA+VyrPmPQ+QFwXngeDaA5ObS4vWxb5p1drEBQ==
X-Received: by 2002:a17:90a:6305:b0:268:2d92:55d3 with SMTP id e5-20020a17090a630500b002682d9255d3mr20725pjj.39.1691100453820;
        Thu, 03 Aug 2023 15:07:33 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id 100-20020a17090a09ed00b002609cadc56esm364503pjo.11.2023.08.03.15.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 15:07:32 -0700 (PDT)
Date:   Thu, 3 Aug 2023 22:07:25 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     levymitchell0@gmail.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelly@microsoft.com, peterz@infradead.org
Subject: Re: [PATCH] hv_balloon: Update the balloon driver to use the SBRM API
Message-ID: <ZMwlHdGiXM3fv6f3@liuwe-devbox-debian-v2>
References: <20230726-master-v1-1-b2ce6a4538db@gmail.com>
 <ZMgmuWmJu9Ppqm2t@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMgmuWmJu9Ppqm2t@boqun-archlinux>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jul 31, 2023 at 02:25:13PM -0700, Boqun Feng wrote:
> Hi Mitchell,
> 
> On Wed, Jul 26, 2023 at 12:23:31AM +0000, Mitchell Levy via B4 Relay wrote:
> > From: Mitchell Levy <levymitchell0@gmail.com>
> > 
> > 
> > 
> > ---
> 
> I don't know whether it's a tool issue or something else, but all words
> after the "---" line in the email will be discarded from a commit log.
> You can try to apply this patch yourself and see the result:
> 
> 	b4 shazam 20230726-master-v1-1-b2ce6a4538db@gmail.com 
> 
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
> > 
> > Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: "Mitchell Levy (Microsoft)" <levymitchell0@gmail.com>
> 
> Beside the above format issue, the code looks good to me, nice job!
> 
> Feel free to add:
> 
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> 

FAOD I'm expecting a v2 of this patch.

Thanks,
Wei.

> Regards,
> Boqun
