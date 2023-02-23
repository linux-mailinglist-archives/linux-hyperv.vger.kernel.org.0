Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0027B6A04DD
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Feb 2023 10:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjBWJcx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Feb 2023 04:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbjBWJcv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Feb 2023 04:32:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5D27692;
        Thu, 23 Feb 2023 01:32:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CD0005BCDA;
        Thu, 23 Feb 2023 09:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677144766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=C995AjaZ46xbV13+isMfz3LA3fxYywRVUZkm4+TPAWU=;
        b=txNsDPLk4f2qQu+vuFEutx6H4efCH4XDAlf5/mg63gyYRT89Wsgajq4Fzdy9gcCNuqw7gf
        5poPJ9ggFpgCDn4QrEBY7Tlz7telq+D3bpc8JlhdqwacNdF4ThetYCobiVROkv4iNVMJvX
        4p5BQG0GXkRbMTKwTbPii9X5KbZeOtg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 640BD13928;
        Thu, 23 Feb 2023 09:32:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iFEhF74y92NebAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 23 Feb 2023 09:32:46 +0000
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
Subject: [PATCH v3 00/12] x86/mtrr: fix handling with PAT but without MTRR
Date:   Thu, 23 Feb 2023 10:32:31 +0100
Message-Id: <20230223093243.1180-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Juergen Gross (12):
  x86/mtrr: split off physical address size calculation
  x86/mtrr: optimize mtrr_calc_physbits()
  x86/mtrr: support setting MTRR state for software defined MTRRs
  x86/hyperv: set MTRR state when running as SEV-SNP Hyper-V guest
  x86/xen: set MTRR state when running as Xen PV initial domain
  x86/mtrr: replace vendor tests in MTRR code
  x86/mtrr: allocate mtrr_value array dynamically
  x86/mtrr: add get_effective_type() service function
  x86/mtrr: construct a memory map with cache modes
  x86/mtrr: use new cache_map in mtrr_type_lookup()
  x86/mtrr: don't let mtrr_type_lookup() return MTRR_TYPE_INVALID
  x86/mm: only check uniform after calling mtrr_type_lookup()

 arch/x86/include/asm/mtrr.h        |  15 +-
 arch/x86/include/uapi/asm/mtrr.h   |   6 +-
 arch/x86/kernel/cpu/mshyperv.c     |   4 +
 arch/x86/kernel/cpu/mtrr/amd.c     |   2 +-
 arch/x86/kernel/cpu/mtrr/centaur.c |   2 +-
 arch/x86/kernel/cpu/mtrr/cleanup.c |   4 +-
 arch/x86/kernel/cpu/mtrr/cyrix.c   |   2 +-
 arch/x86/kernel/cpu/mtrr/generic.c | 487 ++++++++++++++++++-----------
 arch/x86/kernel/cpu/mtrr/mtrr.c    |  94 +++---
 arch/x86/kernel/cpu/mtrr/mtrr.h    |   7 +-
 arch/x86/kernel/setup.c            |   2 +
 arch/x86/mm/pgtable.c              |  24 +-
 arch/x86/xen/enlighten_pv.c        |  50 +++
 13 files changed, 447 insertions(+), 252 deletions(-)

-- 
2.35.3

