Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 139116FBD3
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jul 2019 11:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfGVJIi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Jul 2019 05:08:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36004 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfGVJIi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Jul 2019 05:08:38 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hpUJ7-0002P8-LI; Mon, 22 Jul 2019 11:08:33 +0200
Date:   Mon, 22 Jul 2019 11:08:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sasha Levin <sashal@kernel.org>
cc:     Maya Nakamura <m.maya.nakamura@gmail.com>, mikelley@microsoft.com,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] hv: vmbus: Replace page definition with Hyper-V
 specific one
In-Reply-To: <20190718022228.GF3079@sasha-vm>
Message-ID: <alpine.DEB.2.21.1907221107010.1782@nanos.tec.linutronix.de>
References: <cover.1562916939.git.m.maya.nakamura@gmail.com> <0d9e80ecabcc950dc279fdd2e39bea4060123ba4.1562916939.git.m.maya.nakamura@gmail.com> <20190718022228.GF3079@sasha-vm>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, 17 Jul 2019, Sasha Levin wrote:

> On Fri, Jul 12, 2019 at 08:25:18AM +0000, Maya Nakamura wrote:
> > Replace PAGE_SIZE with HV_HYP_PAGE_SIZE because the guest page size may
> > not be 4096 on all architectures and Hyper-V always runs with a page
> > size of 4096.
> > 
> > Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
> > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> > Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> Thomas, if you're taking this series, could you grab this patch as well
> please (dependencies)?
> 
> 	Acked-by: Sasha Levin <sashal@kernel.org>

Picked it up. The three commits are in

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/hyperv

If you have patches dependend on those either send them my way or pull the
branch into your hyper-v tree.

Thanks,

	tglx
