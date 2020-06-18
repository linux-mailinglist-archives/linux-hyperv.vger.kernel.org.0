Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3731FEBA5
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2020 08:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgFRGnZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Jun 2020 02:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgFRGnY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Jun 2020 02:43:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DBDC0613ED;
        Wed, 17 Jun 2020 23:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=MnNXAxpQLHOaMqStk9KRD+g+da8mFc/xMCqgIsVzzoQ=; b=ooI5Spr2GNPFCJmAN9ct2PlKo3
        PUVMAre3WdizzapatnskE0YvKMD/jl2E7D+48mPdj+8fgkE4nGsxHaDaxqwan6OrJNH9ZPbxZTrnK
        QbIBO13f86P3cdfNeTDkIczaP3MqoUkk12Q1bPokFEFzHbqF3/7sH/Y74RUNKylgasA5feZSUl9hG
        BMXBEfBepXcl78GRzj+VXBmRLuP7UwADD7LUoESb74CXc9aWqylL2hnstmfu0ncNUOoW87x1SurcH
        C5ap3uehlHPOuXkcx8JOWZv/btorO2yH8icOIe1Go+6NtcWbF4cjHBqej24X2KT6iU4VQEy+kgODF
        QGzC3ncQ==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jloGU-0007vK-Cb; Thu, 18 Jun 2020 06:43:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dexuan Cui <decui@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-mm@kvack.org
Subject: fix a hyperv W^X violation and remove vmalloc_exec
Date:   Thu, 18 Jun 2020 08:43:04 +0200
Message-Id: <20200618064307.32739-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi all,

Dexuan reported a W^X violation due to the fact that the hyper hypercall
page due switching it to be allocated using vmalloc_exec.  The problem
is that PAGE_KERNEL_EXEC as used by vmalloc_exec actually sets writable
permissions in the pte.  This series fixes the issue by switching to the
low-level __vmalloc_node_range interface that allows specifing more
detailed permissions instead.  It then also open codes the other two
callers and removes the somewhat confusing vmalloc_exec interface.

Peter noted that the hyper hypercall page allocation also has another
long standing issue in that it shouldn't use the full vmalloc but just
the module space.  This issue is so far theoretical as the allocation is
done early in the boot process.  I plan to fix it with another bigger
series for 5.9.
