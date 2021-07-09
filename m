Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9F53C27A9
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 18:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhGIQl3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jul 2021 12:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhGIQl3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jul 2021 12:41:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BEAC0613DD;
        Fri,  9 Jul 2021 09:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PX3PqwK6mixbUhOlosWUIb/7eL4O6l7Xj2gwXvxxNgA=; b=OFNJq5TzEv/ro5xcnMclS41aX+
        0zyePYOhtx0YoA9d2PzMw5E5TQpwJYttbMg0a6qsdv6WgQdJOwBaBMKppVSNFxdqsCZSBj2aApqDi
        Bsd50WT9Q7Tg8IYZzoQ6p7x1yzeocwR3lissZIoP1TDLLR9/2dYWnQEUM2Bwvye4vM8CC5v4fxmaj
        801dFamq6l+iT6JWruP1kQvVuOnn3IraLtsOatgM3EVbp24Oe7ZimzmsRY/LKb+2p/e17Le2ZmMhP
        0n/2uqF7H5rGdjZf4W7Yjx+5zB/pYbCT5wxvlXGf3idG9GSIIIrTu+XUp2/bmy0viHRuNj1aOmm68
        rAkRnzuA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m1tWC-00EgUK-Uu; Fri, 09 Jul 2021 16:38:29 +0000
Date:   Fri, 9 Jul 2021 17:38:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        kumarpraveen@linux.microsoft.com, pasha.tatashin@soleen.com,
        Jonathan Corbet <corbet@lwn.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        Muminul Islam <muislam@microsoft.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [RFC v1 7/8] mshv: implement in-kernel device framework
Message-ID: <YOh7gO3MIDv5Eo8q@casper.infradead.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-8-wei.liu@kernel.org>
 <YOhIzJVPN9SwoRK0@casper.infradead.org>
 <20210709135013.t5axinjmufotpylf@liuwe-devbox-debian-v2>
 <YOhsIDccgbUCzwqt@casper.infradead.org>
 <20210709162732.hnyzpf3uofzc7xqs@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709162732.hnyzpf3uofzc7xqs@liuwe-devbox-debian-v2>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 09, 2021 at 04:27:32PM +0000, Wei Liu wrote:
> > Then don't define your own structure.  Use theirs.
> 
> I specifically mentioned in the cover letter I didn't do it because I
> was not sure if that would be acceptable. I guess I will find out.

I only got patch 7/8.  You can't blame me for not reading 0/8 if you
didn't send me 0/8.
