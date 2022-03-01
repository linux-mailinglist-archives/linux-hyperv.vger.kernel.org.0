Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52DD4C8B03
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 12:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbiCALoV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 06:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbiCALoV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 06:44:21 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5843054BF3;
        Tue,  1 Mar 2022 03:43:40 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5C51F68AFE; Tue,  1 Mar 2022 12:43:35 +0100 (CET)
Date:   Tue, 1 Mar 2022 12:43:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "tboot-devel@lists.sourceforge.net" 
        <tboot-devel@lists.sourceforge.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 08/12] x86: centralize setting SWIOTLB_FORCE when guest
 memory encryption is enabled
Message-ID: <20220301114335.GA2881@lst.de>
References: <20220301105311.885699-1-hch@lst.de> <20220301105311.885699-9-hch@lst.de> <8e623a11-d809-4fab-401c-2ce609a9fc14@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e623a11-d809-4fab-401c-2ce609a9fc14@citrix.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 01, 2022 at 11:39:29AM +0000, Andrew Cooper wrote:
> This isn't really "must".  The guest is perfectly capable of sharing
> memory with the hypervisor.
> 
> It's just that for now, bounce buffering is allegedly faster, and the
> simple way of getting it working.

Yeah, I guess you щould just share/unshare on demand.  But given that
this isn't implemented it is a must in the current kernel.  But if
you want a different wording suggest one and I'll put it in.
