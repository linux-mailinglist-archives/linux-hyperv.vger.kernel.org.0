Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49120571262
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Jul 2022 08:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiGLGoY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 Jul 2022 02:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiGLGoX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Jul 2022 02:44:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2CA37190;
        Mon, 11 Jul 2022 23:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=swJefpXncEluK9yw4UzvA4sA1DCzOw/wXgNu2apBFQg=; b=yiO5Hr/u2nR7lagixpbqvT8rVc
        Ay0EFIElSbZHWvZ3O/VQgB4/UoLDsPySlkZyYWz8nLXmlojBnhGbldHwYjcA/fPgzreE5eG9MuFHa
        kpgMlolQWm5p+ybiN6wppJl+PHFSSmH5NPLpLkL+lvWDru3M8e3dY6JdDe47WZWcjZt2FNZqAgdoF
        yiQh02YgZ9aSuc/HkY05SSx2rCXViPOYSCpSOT2NcUeNc5MvBgLNx0NJVx7shsjcNqjhv0UZd7h02
        fBsz11CSDnZo+4dUDLnfY5CyPcWTzZ+LqIiLHKAGGdTuOhdQQyHwCSMp6YzoOaNORqfXOE7KCBrr4
        e+s4noXQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oB9cr-0086KR-CV; Tue, 12 Jul 2022 06:44:05 +0000
Date:   Mon, 11 Jul 2022 23:44:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     corbet@lwn.net, hch@infradead.org, m.szyprowski@samsung.com,
        robin.murphy@arm.com, paulmck@kernel.org, bp@suse.de,
        keescook@chromium.org, akpm@linux-foundation.org, pmladek@suse.com,
        rdunlap@infradead.org, damien.lemoal@opensource.wdc.com,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        wei.liu@kernel.org, parri.andrea@gmail.com,
        thomas.lendacky@amd.com, linux-hyperv@vger.kernel.org,
        kirill.shutemov@intel.com, andi.kleen@intel.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH V4] swiotlb: Split up single swiotlb lock
Message-ID: <Ys0YNdvNip5kB27V@infradead.org>
References: <20220708161544.522312-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708161544.522312-1-ltykernel@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Thanks,

applied to the dma-mapping tree.
