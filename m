Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45E12A54D9
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Sep 2019 13:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbfIBLbC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Sep 2019 07:31:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730159AbfIBLbC (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Sep 2019 07:31:02 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E320217F4;
        Mon,  2 Sep 2019 11:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567423861;
        bh=WT2SFVNIiAvZ2F/oZQL05NK/4+3rrTsFDgCfk2LQIN4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=jyRi/QK+So2inP/2FA7BJSSqTWURiVBKhhFLKzUhSVvn+kZkFR7XAfuzUK8SLboH5
         kNdqQyQlQ7NZBn2swWYTsptjj56kjUTk/yb8KQtiK3PegVBIcSTmBohD6H7dbIbWtB
         YBBNtqJQ/40YBCknQyuJp0JvPL495P30+rm7e0Ug=
Date:   Mon, 2 Sep 2019 13:30:44 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
cc:     "m.maya.nakamura" <m.maya.nakamura@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 4/5] HID: hv: Remove dependencies on PAGE_SIZE for
 ring buffer
In-Reply-To: <DM5PR21MB013708BF1876B7282C049B76D7BC0@DM5PR21MB0137.namprd21.prod.outlook.com>
Message-ID: <nycvar.YFH.7.76.1909021330230.27147@cbobk.fhfr.pm>
References: <cover.1562916939.git.m.maya.nakamura@gmail.com> <5cfa6f8ded52ee709ede57a97fc71e8671b1ceb1.1562916939.git.m.maya.nakamura@gmail.com> <DM5PR21MB013708BF1876B7282C049B76D7BC0@DM5PR21MB0137.namprd21.prod.outlook.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, 31 Aug 2019, Michael Kelley wrote:

> From: Maya Nakamura <m.maya.nakamura@gmail.com>  Sent: Friday, July 12, 2019 1:28 AM
> > 
> > Define the ring buffer size as a constant expression because it should
> > not depend on the guest page size.
> > 
> > Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
> > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 
> Jiri and Benjamin -- OK if this small patch for the Hyper-V HID driver
> goes through the Hyper-V tree maintained by Sasha Levin?   It's a purely
> Hyper-V change so the ring buffer size isn't bigger when running
> on ARM64 where the page size might be 16K or 64K.

Yeah; FWIW feel free to add

	Acked-by: Jiri Kosina <jkosina@suse.cz>

Thanks,

-- 
Jiri Kosina
SUSE Labs

