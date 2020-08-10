Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CD7240529
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Aug 2020 13:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgHJLTI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 10 Aug 2020 07:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgHJLTH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 10 Aug 2020 07:19:07 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F7CC061756;
        Mon, 10 Aug 2020 04:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u1PEAVefDsXqQCJLTD8YIYvWrfBI1gannHXSs3XUnzc=; b=ZIijHCIvcCLbXmhfoR8cr87sdG
        T+LKBcVhAhAH5bFO4ta3SSzpjDUDh2EbnQYRPui88eKjK1dwv2yaIOxdZAGkP0VZF/FuCKm/+0DMq
        c2JC7Yl5XF1mpTbjq8LPgXl81/1B/gBii3Cx/sSmvNrtA3eCQV796WgnKTRzsiPF29GTI5CwdOQ7Z
        JLNtbeoVAvaaKPqjbtUZUPl0qnlm/eewzGwzfskxksF3Y31JePo2MaqkblYMl/JLYPdu+lViiz4ek
        jDDzlA6lrM3FWAU9BOJXb53cstRb28R54ThM41NrEMduAIpsbw7vXZGNoiwIcSQURuJZTNUQg3lIy
        sOr89qNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k55pT-0003yi-Dj; Mon, 10 Aug 2020 11:18:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E22EE3060C5;
        Mon, 10 Aug 2020 13:18:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C5FC92B491BED; Mon, 10 Aug 2020 13:18:57 +0200 (CEST)
Date:   Mon, 10 Aug 2020 13:18:57 +0200
From:   peterz@infradead.org
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        kys@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/hyperv: Make hv_setup_sched_clock inline
Message-ID: <20200810111857.GQ2674@hirez.programming.kicks-ass.net>
References: <1597022991-24088-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597022991-24088-1-git-send-email-mikelley@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Aug 09, 2020 at 06:29:51PM -0700, Michael Kelley wrote:
> Make hv_setup_sched_clock inline so the reference to pv_ops works
> correctly with objtool updates to detect noinstr violations.
> See https://lore.kernel.org/patchwork/patch/1283635/
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Thanks!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
