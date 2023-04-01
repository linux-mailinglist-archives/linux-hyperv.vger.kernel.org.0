Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B166D2E99
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Apr 2023 08:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjDAGhA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 1 Apr 2023 02:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjDAGg7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 1 Apr 2023 02:36:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC0A1D85C;
        Fri, 31 Mar 2023 23:36:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 85D9F1F8B9;
        Sat,  1 Apr 2023 06:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680331015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fwlqVEU+eay08IeeOOBfH65TQZ/XQ2nl5oYOkjj7LF0=;
        b=MLhGuHY3CSmYqr2j6E4yBaM89chPjWoCvhK+8ZTpJAQ4LqUfQfGaDbjFkxkQbSoUvT19LR
        UnX7QI+Uvo4rZ2gsQVxltDevlaQX+pUb0sZdTlyT42PQAUrR4sbpAQ0h0YQABpzteF3uPT
        KiNeYdvQLVNqIhlg1bIFWY1mzObA3oI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10300134FB;
        Sat,  1 Apr 2023 06:36:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AzBZAgfRJ2QGdwAAMHmgww
        (envelope-from <jgross@suse.com>); Sat, 01 Apr 2023 06:36:55 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v5 00/15] x86/mtrr: fix handling with PAT but without MTRR
Date:   Sat,  1 Apr 2023 08:36:37 +0200
Message-Id: <20230401063652.23522-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This series tries to fix the rather special case of PAT being available
without having MTRRs (either due to CONFIG_MTRR being not set, or
because the feature has been disabled e.g. by a hypervisor).

The main use cases are Xen PV guests and SEV-SNP guests running under
Hyper-V.

Instead of trying to work around all the issues by adding if statements
here and there, just try to use the complete available infrastructure
by setting up a read-only MTRR state when needed.

In the Xen PV case the current MTRR MSR values can be read from the
hypervisor, while for the SEV-SNP case all needed is to set the
default caching mode to "WB".

I have added more cleanup which has been discussed when looking into
the most recent failures.

Note that I couldn't test the Hyper-V related change (patch 3).

Running on bare metal and with Xen didn't show any problems with the
series applied.

It should be noted that patches 9+10 are replacing today's way to
lookup the MTRR cache type for a memory region from looking at the
MTRR register values to building a memory map with the cache types.
This should make the lookup much faster and much easier to understand.

Changes in V2:
- replaced former patches 1+2 with new patches 1-4, avoiding especially
  the rather hacky approach of V1, while making all the MTRR type
  conflict tests available for the Xen PV case
- updated patch 6 (was patch 4 in V1)

Changes in V3:
- dropped patch 5 of V2, as already applied
- split patch 1 of V2 into 2 patches
- new patches 6-10
- addressed comments

Changes in V4:
- addressed comments

Changes in V5
- addressed comments
- some other small fixes
- new patches 3, 8 and 15

clone of "mtrr"

Juergen Gross (15):
  x86/mtrr: split off physical address size calculation
  x86/mtrr: optimize mtrr_calc_physbits()
  x86/mtrr: replace some constants with defines
  x86/mtrr: support setting MTRR state for software defined MTRRs
  x86/hyperv: set MTRR state when running as SEV-SNP Hyper-V guest
  x86/xen: set MTRR state when running as Xen PV initial domain
  x86/mtrr: replace vendor tests in MTRR code
  x86/mtrr: have only one set_mtrr() variant
  x86/mtrr: allocate mtrr_value array dynamically
  x86/mtrr: add get_effective_type() service function
  x86/mtrr: construct a memory map with cache modes
  x86/mtrr: use new cache_map in mtrr_type_lookup()
  x86/mtrr: don't let mtrr_type_lookup() return MTRR_TYPE_INVALID
  x86/mm: only check uniform after calling mtrr_type_lookup()
  x86/mtrr: remove unused code

 arch/x86/include/asm/mtrr.h        |  44 ++-
 arch/x86/include/uapi/asm/mtrr.h   |   6 +-
 arch/x86/kernel/cpu/mshyperv.c     |   4 +
 arch/x86/kernel/cpu/mtrr/amd.c     |   2 +-
 arch/x86/kernel/cpu/mtrr/centaur.c |  11 +-
 arch/x86/kernel/cpu/mtrr/cleanup.c |   6 +-
 arch/x86/kernel/cpu/mtrr/cyrix.c   |   2 +-
 arch/x86/kernel/cpu/mtrr/generic.c | 578 +++++++++++++++++++----------
 arch/x86/kernel/cpu/mtrr/mtrr.c    | 146 ++++----
 arch/x86/kernel/cpu/mtrr/mtrr.h    |   7 +-
 arch/x86/kernel/setup.c            |   2 +
 arch/x86/mm/pgtable.c              |  24 +-
 arch/x86/xen/enlighten_pv.c        |  52 +++
 13 files changed, 573 insertions(+), 311 deletions(-)

-- 
2.35.3

