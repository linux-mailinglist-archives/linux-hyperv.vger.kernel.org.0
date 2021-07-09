Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0423C29D4
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 21:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhGITvc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jul 2021 15:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGITvc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jul 2021 15:51:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBB7C0613DD;
        Fri,  9 Jul 2021 12:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7xOTruRzGa5B9hLk0/wSxAjaR6x7/fszhbg7rE8/TUQ=; b=vrBt/SYKQVqRA3cOE56PBVcIFu
        OImJOqgEYmHxVSPmBn+JWORi8cHqluYxcder3N4sVofDXHhj3HNcq6kkU+ep0/hWgFGVY5hq0Ogzc
        5I7sNJprJCOm6wDj/cFzFYaWNviS+XdqBfOPZ/dNXzbATrgGuHqvov7+sHMMfVzKiGl+Hzq7vVUUP
        4563HHA9K9qG5TGXXx8yTMlW8AW3JZJwSPNDL9B2oZ9WVlnoBtOybp3WKqAcMP47dhJ76/eIqjW12
        pstd60WvK5lXx8Dym5WgYOkBiZ0+bitew6m45ckOVIP1e8696UpHN42QONX3mLsW4QiDv7CFDobM7
        Bp3xcY8A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m1wUG-00EpFB-Ss; Fri, 09 Jul 2021 19:48:38 +0000
Date:   Fri, 9 Jul 2021 20:48:36 +0100
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
Message-ID: <YOioFOT5WgkUB+dY@casper.infradead.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-8-wei.liu@kernel.org>
 <YOhIzJVPN9SwoRK0@casper.infradead.org>
 <20210709135013.t5axinjmufotpylf@liuwe-devbox-debian-v2>
 <YOhsIDccgbUCzwqt@casper.infradead.org>
 <20210709162732.hnyzpf3uofzc7xqs@liuwe-devbox-debian-v2>
 <YOh7gO3MIDv5Eo8q@casper.infradead.org>
 <20210709191405.t3vno3zw7kdlo4ps@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709191405.t3vno3zw7kdlo4ps@liuwe-devbox-debian-v2>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 09, 2021 at 07:14:05PM +0000, Wei Liu wrote:
> You were not CC'ed on this patch, so presumably you got it via one of
> the mailing lists. I'm not sure why you only got this one patch. Perhaps
> if you wait a bit you will get the rest.

No, I won't.  You only cc'd linux-doc on this one patch and not on any
of the others.
