Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECC0B1A07D2
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Apr 2020 08:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgDGGzD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Apr 2020 02:55:03 -0400
Received: from verein.lst.de ([213.95.11.211]:36674 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgDGGzD (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Apr 2020 02:55:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8435768BEB; Tue,  7 Apr 2020 08:55:00 +0200 (CEST)
Date:   Tue, 7 Apr 2020 08:55:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: hv_hypercall_pg page permissios
Message-ID: <20200407065500.GA28490@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi all,

The x86 Hyper-V hypercall page (hv_hypercall_pg) is the only allocation
in the kernel using __vmalloc with exectutable persmissions, and the
only user of PAGE_KERNEL_RX.  Is there any good reason it needs to
be readable?  Otherwise we could use vmalloc_exec and kill off
PAGE_KERNEL_RX.  Note that before 372b1e91343e6 ("drivers: hv: Turn off
write permission on the hypercall page") it was even mapped writable..
