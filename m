Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF5F1FAD8C
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jun 2020 12:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgFPKIP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Jun 2020 06:08:15 -0400
Received: from verein.lst.de ([213.95.11.211]:37352 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727773AbgFPKIP (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Jun 2020 06:08:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1D0F968AEF; Tue, 16 Jun 2020 12:08:11 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:08:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Dexuan Cui <decui@microsoft.com>, Christoph Hellwig <hch@lst.de>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Michael Kelley <mikelley@microsoft.com>,
        Ju-Hyoung Lee <juhlee@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: Re: hv_hypercall_pg page permissios
Message-ID: <20200616100810.GA28973@lst.de>
References: <20200407073830.GA29279@lst.de> <C311EB52-A796-4B94-AADD-CCABD19B377E@amacapital.net> <HK0P153MB0322D52F61E540CA7515CC4BBF810@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <87y2ooiv5k.fsf@vitty.brq.redhat.com> <HK0P153MB0322DE798AA39BCCD4A208E4BF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <HK0P153MB0322EB3EE51073CC021D4AEABF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <87blljicjm.fsf@vitty.brq.redhat.com> <20200616093341.GA26400@lst.de> <20200616095549.GA27917@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616095549.GA27917@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 16, 2020 at 11:55:49AM +0200, Christoph Hellwig wrote:
> Actually, what do you think of this one:

Plus this whole series to kill of vmalloc_exec entirely:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/vmalloc_exec-fixes
