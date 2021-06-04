Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3A739B9DE
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Jun 2021 15:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhFDNds (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Jun 2021 09:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhFDNds (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Jun 2021 09:33:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE65C0613DA;
        Fri,  4 Jun 2021 06:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MavlaHcrXTsmTGjPtJGrWFVh4N2RPwLd0U0sgZUv9NQ=; b=KUeV773P7iwXExqW/c26s06Ek8
        26hm/T8cUdtDD3W1aKekCy61rT98aZ3LRe9dDcFV5bHZUPydNUGwwA8MXWCMwdBurq/vt06n+FJME
        feuZL6fz5haQmLawDIeCflpcuMwbEx8ZkeJoEp5ltBGr3FGCTtvqXgU/J0PHjkP15TYnj2z+qddeU
        2MK/9NLqGh6bcbrB+YJRZBB4I1Iy7ay5Nmkj8+tntWoOr16GTwnzOg5pqlKETVeVBAZzvAu57EmEF
        Kl80ntw4SySpF/RhPLCkydEV+fxj5batZqw3urPePQV/kSymibGmEUgV7akUSXYrnLctdfkgW42oF
        tHALoQCg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lp9vP-00DCTA-FW; Fri, 04 Jun 2021 13:31:52 +0000
Date:   Fri, 4 Jun 2021 14:31:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>, wei.liu@kernel.org,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [bug report] Commit ccf953d8f3d6 ("fb_defio: Remove custom
 address_space_operations") breaks Hyper-V FB driver
Message-ID: <YLorQ3r4EH7aEvIV@casper.infradead.org>
References: <87v96tzujm.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v96tzujm.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jun 04, 2021 at 02:25:01PM +0200, Vitaly Kuznetsov wrote:
> Commit ccf953d8f3d6 ("fb_defio: Remove custom address_space_operations")
> seems to be breaking Hyper-V framebuffer

https://lore.kernel.org/linux-mm/YLZUrEjVJWBGGMxf@phenom.ffwll.local/
