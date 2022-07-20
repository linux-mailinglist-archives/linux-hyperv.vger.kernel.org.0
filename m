Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA1F57B0FB
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Jul 2022 08:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239721AbiGTGWL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Jul 2022 02:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239706AbiGTGWK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Jul 2022 02:22:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DF0459AD;
        Tue, 19 Jul 2022 23:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N8oOzok8H1+6umo4BD4brmMX42cs5KyS+2E/YgEjqfQ=; b=d6x7y4kRuoyMXFwbjDU7gAhtxQ
        aS8JvEku+J+AOWzR5jWwR6Jm7WGEL6R1fASbvaEaA4hOWQAkviROz2EBDifNvU6HPUxvLiNdBHBNK
        q1TDluHBP9CIR1Epz4zcBrJPQlhWJJRgiIDVKKBSXLvCmZTaoo8ObSNbSR02KIgOrCLarsvfIhYKW
        FTVQvjLCJDamzRbTavHMykRMQOwVvMJzmARcmzt+EOmnFUhBqsWgO18+nQOfL/VSpr4xEaE1Vv2Wm
        Qeu2uHI39qVQPLssNagqDqEqAOPBj1g3XPKM5d+IjhpYph5b2T9XT0naheZ8yZ6c2KKI4ACyyqlJH
        Gjc0MgPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oE35n-001CHV-VK; Wed, 20 Jul 2022 06:21:55 +0000
Date:   Tue, 19 Jul 2022 23:21:55 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Tianyu Lan <ltykernel@gmail.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "hch@infradead.org" <hch@infradead.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        KY Srinivasan <kys@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "kirill.shutemov@intel.com" <kirill.shutemov@intel.com>,
        "andi.kleen@intel.com" <andi.kleen@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH V4] swiotlb: Split up single swiotlb lock
Message-ID: <YtefA9mZJo5+YzBG@infradead.org>
References: <20220708161544.522312-1-ltykernel@gmail.com>
 <PH0PR21MB3025C32C80BFBE8651CF196AD78C9@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB3025C32C80BFBE8651CF196AD78C9@PH0PR21MB3025.namprd21.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Tianyu or Michael, can someone please send me a fixup patch for this?

