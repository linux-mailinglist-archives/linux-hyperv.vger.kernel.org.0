Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648C16F4352
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 May 2023 14:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbjEBMJw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 2 May 2023 08:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjEBMJv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 May 2023 08:09:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EBA4EC8;
        Tue,  2 May 2023 05:09:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 23DE021A10;
        Tue,  2 May 2023 12:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683029382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5isj2N5NCBHlgNEX7kDR8L5F10upbDgKEvNgnzD7pjU=;
        b=lCdfsFMOgUvQOOjznQ29dhIfCPfBATrhqs0ygxXq+WuLpchDR8rfeWRUqFg4gsVq1hAZso
        M6yRbkcUUeSN+OZpt0kdpNk+01NuOD3H4axIM8mN+INEgVDTKNBob6uRoIMwSVTHqsAyiH
        tXY30Kqoaqh0gDh5kUwQuvMJsIBgFwg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9635D139C3;
        Tue,  2 May 2023 12:09:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bPRFI4X9UGRmLwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 02 May 2023 12:09:41 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     mikelley@microsoft.com, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v6 00/16] x86/mtrr: fix handling with PAT but without MTRR
Date:   Tue,  2 May 2023 14:09:15 +0200
Message-Id: <20230502120931.20719-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Changes in V6:
- patch 1 replaces patches 1+2 of V5
- new patches 8+12
- addressed comments

Juergen Gross (16):
  x86/mtrr: remove physical address size calculation
  x86/mtrr: replace some constants with defines
  x86/mtrr: support setting MTRR state for software defined MTRRs
  x86/hyperv: set MTRR state when running as SEV-SNP Hyper-V guest
  x86/xen: set MTRR state when running as Xen PV initial domain
  x86/mtrr: replace vendor tests in MTRR code
  x86/mtrr: have only one set_mtrr() variant
  x86/mtrr: move 32-bit code from mtrr.c to legacy.c
  x86/mtrr: allocate mtrr_value array dynamically
  x86/mtrr: add get_effective_type() service function
  x86/mtrr: construct a memory map with cache modes
  x86/mtrr: add mtrr=debug command line option
  x86/mtrr: use new cache_map in mtrr_type_lookup()
  x86/mtrr: don't let mtrr_type_lookup() return MTRR_TYPE_INVALID
  x86/mm: only check uniform after calling mtrr_type_lookup()
  x86/mtrr: remove unused code

 .../admin-guide/kernel-parameters.txt         |   4 +
 arch/x86/hyperv/ivm.c                         |   4 +
 arch/x86/include/asm/mtrr.h                   |  43 +-
 arch/x86/include/uapi/asm/mtrr.h              |   6 +-
 arch/x86/kernel/cpu/mtrr/Makefile             |   2 +-
 arch/x86/kernel/cpu/mtrr/amd.c                |   2 +-
 arch/x86/kernel/cpu/mtrr/centaur.c            |  11 +-
 arch/x86/kernel/cpu/mtrr/cleanup.c            |  22 +-
 arch/x86/kernel/cpu/mtrr/cyrix.c              |   2 +-
 arch/x86/kernel/cpu/mtrr/generic.c            | 677 ++++++++++++------
 arch/x86/kernel/cpu/mtrr/legacy.c             |  90 +++
 arch/x86/kernel/cpu/mtrr/mtrr.c               | 195 ++---
 arch/x86/kernel/cpu/mtrr/mtrr.h               |  18 +-
 arch/x86/kernel/setup.c                       |   2 +
 arch/x86/mm/pgtable.c                         |  24 +-
 arch/x86/xen/enlighten_pv.c                   |  52 ++
 16 files changed, 721 insertions(+), 433 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/mtrr/legacy.c

-- 
2.35.3

