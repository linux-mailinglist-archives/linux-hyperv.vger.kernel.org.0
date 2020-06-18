Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B881FEE9E
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2020 11:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgFRJ2Z (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Jun 2020 05:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728819AbgFRJ2Y (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Jun 2020 05:28:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6063C06174E;
        Thu, 18 Jun 2020 02:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pPaJGkFgBfRy4kaAhXnVgmi64gvv/YLPA3TXaJg16Q8=; b=PAI+gY1xuHZWivpl4xx1ZghwO6
        z9Bz22F1p9LF1ZKU1ty6/y+9lb4oldbxrXSHZe4JCOBG1c3sYaFwzzaw+HmpH/Z1TM6pE7AXtJyCg
        267Q2QzF/zHB7/1E5MEEF1kZjEMEQttL2ZgY/rFHu45oh70kFej1uF6R7uhr6QFExRJ4ZVoEO+sn0
        oJJou5XY6rNZixZZ1XMnzr2b96PbqpfcL2zm8exRkD6UAwNoZuPkmlZEe2b8oVZfkp660c9zR38sH
        fqFoDbH+TLWWvAttW+6xqmufOhYytqWG92mwMI69Q3dD1pJHVdyMgS4jl747ZXfkyGKlD3Q3OyWte
        +Yocc0ZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlqqG-0004my-82; Thu, 18 Jun 2020 09:28:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A822D307A66;
        Thu, 18 Jun 2020 11:28:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 96F692059AC5C; Thu, 18 Jun 2020 11:28:14 +0200 (CEST)
Date:   Thu, 18 Jun 2020 11:28:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dexuan Cui <decui@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: fix a hyperv W^X violation and remove vmalloc_exec
Message-ID: <20200618092814.GG576905@hirez.programming.kicks-ass.net>
References: <20200618064307.32739-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618064307.32739-1-hch@lst.de>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jun 18, 2020 at 08:43:04AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> Dexuan reported a W^X violation due to the fact that the hyper hypercall
> page due switching it to be allocated using vmalloc_exec.  The problem
> is that PAGE_KERNEL_EXEC as used by vmalloc_exec actually sets writable
> permissions in the pte.  This series fixes the issue by switching to the
> low-level __vmalloc_node_range interface that allows specifing more
> detailed permissions instead.  It then also open codes the other two
> callers and removes the somewhat confusing vmalloc_exec interface.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> Peter noted that the hyper hypercall page allocation also has another
> long standing issue in that it shouldn't use the full vmalloc but just
> the module space.  This issue is so far theoretical as the allocation is
> done early in the boot process.  I plan to fix it with another bigger
> series for 5.9.

Thanks!
