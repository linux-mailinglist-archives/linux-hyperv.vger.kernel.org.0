Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C6D690125
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Feb 2023 08:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjBIHW4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Feb 2023 02:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjBIHWw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Feb 2023 02:22:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468CD4EF8;
        Wed,  8 Feb 2023 23:22:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3E44220C8B;
        Thu,  9 Feb 2023 07:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675927343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QHDr4/oY9jwjgsuyt0ENY6hb99lvK8llTbmW7FwD1WY=;
        b=hkd/8ZSN2yr1EXH/otlZ2IOhrexNw9ZlHMfSi/2RYl35jCKYc1+CxTPbtthvkyKAMbhsIJ
        g4kzzt5oIWj2s2vNcLDEo0ZCc5isCqLAHsLy88icLk+t71MwZA7susB62v8ObQjk5OzYP+
        PN1MAI+by459aRFgxt6PvL8nvvRR3SU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B266A1339E;
        Thu,  9 Feb 2023 07:22:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id e00xKi6f5GPgeAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 09 Feb 2023 07:22:22 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org, Juergen Gross <jgross@suse.com>,
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
Subject: [PATCH v2 0/8] x86/mtrr: fix handling with PAT but without MTRR
Date:   Thu,  9 Feb 2023 08:22:12 +0100
Message-Id: <20230209072220.6836-1-jgross@suse.com>
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

Changes in V2:
- replaced former patches 1+2 with new patches 1-4, avoiding especially
  the rather hacky approach of V1, while making all the MTRR type
  conflict tests available for the Xen PV case
- updated patch 6 (was patch 4 in V1)

Juergen Gross (8):
  x86/mtrr: split off physical address size calculation
  x86/mtrr: support setting MTRR state for software defined MTRRs
  x86/hyperv: set MTRR state when running as SEV-SNP Hyper-V guest
  x86/xen: set MTRR state when running as Xen PV initial domain
  x86/mtrr: revert commit 90b926e68f50
  x86/mtrr: don't let mtrr_type_lookup() return MTRR_TYPE_INVALID
  x86/mm: only check uniform after calling mtrr_type_lookup()
  x86/mtrr: drop sanity check in mtrr_type_lookup_fixed()

 arch/x86/include/asm/mtrr.h        |  9 +++-
 arch/x86/include/uapi/asm/mtrr.h   |  6 +--
 arch/x86/kernel/cpu/mshyperv.c     |  8 +++
 arch/x86/kernel/cpu/mtrr/generic.c | 56 +++++++++++++++++----
 arch/x86/kernel/cpu/mtrr/mtrr.c    | 79 ++++++++++++++++--------------
 arch/x86/mm/pat/memtype.c          |  3 +-
 arch/x86/mm/pgtable.c              |  6 +--
 arch/x86/xen/enlighten_pv.c        | 49 ++++++++++++++++++
 8 files changed, 159 insertions(+), 57 deletions(-)

-- 
2.35.3

