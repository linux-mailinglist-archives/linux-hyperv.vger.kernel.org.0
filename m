Return-Path: <linux-hyperv+bounces-10215-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GRiNo8w5ml6tAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10215-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 15:56:31 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABC942C71B
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 15:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BF8F30E3A3F
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 13:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36EC3DF000;
	Mon, 20 Apr 2026 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsinxEoc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE27A3DEFF7;
	Mon, 20 Apr 2026 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691464; cv=none; b=otPg8ekVHyase7Aybgp/Yw2RHziVvoJKfUrjZy9CbnxsxNERL4Tb78xDton2XuOZo3acLDScQvmhoD7DC4XGKvkWi74VHo61RVgkdvnFgkhQzlRJXHnKClDUc08OzyrW2VhHyN+iyUCOVOQSFbBRMrR9De9CHB8J1EdTRpj87tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691464; c=relaxed/simple;
	bh=PFof+sqPrsbw5QjSULIQvTePoLhi3BlC0bcTDi+1jwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EiP9GDyGvwe1T9dhrS4Lb0/bAzUuw10s57QsBW8xJFJxDhLYj30LH2MYaU7VyF90um5iecNtykGw51HWMOe+jWstcxDdIHiJdnRRMGvBO5rpbq/1ndIgXGEFx6T4qoYe1Ic5JigdnKtaxO4q+WCCXy7DdJrv7+x11KdlC5yg9w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsinxEoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14218C19425;
	Mon, 20 Apr 2026 13:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691464;
	bh=PFof+sqPrsbw5QjSULIQvTePoLhi3BlC0bcTDi+1jwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DsinxEoc+6nxdSlYlH4/u1zJDZ7JuiNuixUvDmbsmCPfkGNx06I2Exg+3YsYfiJaH
	 j9V9KPuLYGRQXqn7sjkJPsp7pQ9PlLpEHXChdCpsNcFmOKZ7F2PsqeYZ+NyQKyVj8c
	 cicpErrMG7KUjc3Tmve5MIxL3od+BTW0ih8zuqWhR/59wHVsVuveWCNPW59V5hUIov
	 c1L16yoxv+NuA1yYPujYB70UbfN47rPT8V8K1WsjIjTozRVV5mFAfosmitP0n/VTAv
	 zZPTTVajO+R6RtrCsUpqqc0jUQJDbJsMQHi9EYefc5C971FDHRTpcNY3HQs/W+I9Vi
	 7vb91OS7QZ+nA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.18] net: mana: hardening: Validate adapter_mtu from MANA_QUERY_DEV_CONFIG
Date: Mon, 20 Apr 2026 09:17:18 -0400
Message-ID: <20260420132314.1023554-44-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 7.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-10215-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 8ABC942C71B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

[ Upstream commit d7709812e13d06132ddae3d21540472ea5cb11c5 ]

As a part of MANA hardening for CVM, validate the adapter_mtu value
returned from the MANA_QUERY_DEV_CONFIG HWC command.

The adapter_mtu value is used to compute ndev->max_mtu via:
gc->adapter_mtu - ETH_HLEN. If hardware returns a bogus adapter_mtu
smaller than ETH_HLEN (e.g. 0), the unsigned subtraction wraps to a
huge value, silently allowing oversized MTU settings.

Add a validation check to reject adapter_mtu values below
ETH_MIN_MTU + ETH_HLEN, returning -EPROTO to fail the device
configuration early with a clear error message.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Link: https://patch.msgid.link/20260326173101.2010514-1-ernis@linux.microsoft.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

This confirms the integer underflow. Now let me complete the analysis.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

**Step 1.1: Subject Line**
- Subsystem: `net: mana:` (Microsoft Azure Network Adapter driver)
- Action: "hardening: Validate" - input validation / defensive check
- Summary: Validates `adapter_mtu` from hardware config query to prevent
  integer underflow

**Step 1.2: Tags**
- `Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>` -
  author, Microsoft employee, regular MANA contributor (9+ commits)
- `Link: https://patch.msgid.link/20260326173101.2010514-1-
  ernis@linux.microsoft.com` - single patch (not part of a series,
  1-of-1)
- `Signed-off-by: Jakub Kicinski <kuba@kernel.org>` - netdev maintainer
  accepted the patch
- No Fixes: tag (expected for candidates under review)
- No Reported-by tag
- No Cc: stable tag

**Step 1.3: Body Text**
- Bug: `adapter_mtu` value from hardware can be bogus (< ETH_HLEN = 14).
  The subtraction `gc->adapter_mtu - ETH_HLEN` used to compute
  `ndev->max_mtu` wraps to a huge value (~4GB), silently allowing
  oversized MTU settings.
- Context: Part of CVM (Confidential VM) hardening where the hypervisor
  is less trusted.
- Fix: Reject values below `ETH_MIN_MTU + ETH_HLEN` (82 bytes) with
  `-EPROTO`.

**Step 1.4: Hidden Bug Fix Detection**
- Though labeled "hardening," this IS a real bug fix: it prevents a
  concrete integer underflow that leads to incorrect max_mtu. The bug
  mechanism is clear and the consequences (allowing oversized MTU
  settings) are real.

## PHASE 2: DIFF ANALYSIS

**Step 2.1: Inventory**
- Files: `drivers/net/ethernet/microsoft/mana/mana_en.c` (+8/-2 net, ~6
  lines of logic)
- Function modified: `mana_query_device_cfg()`
- Scope: Single-file, single-function, surgical fix

**Step 2.2: Code Flow Change**
- Before: `resp.adapter_mtu` was accepted unconditionally when
  msg_version >= GDMA_MESSAGE_V2
- After: Validates `resp.adapter_mtu >= ETH_MIN_MTU + ETH_HLEN` (82)
  before accepting; returns `-EPROTO` on failure
- The else branch and brace additions are purely cosmetic (adding braces
  to existing if/else)

**Step 2.3: Bug Mechanism**
- Category: Integer underflow / input validation bug
- Mechanism: `gc->adapter_mtu` (u16, could be 0) used in `ndev->max_mtu
  = gc->adapter_mtu - ETH_HLEN`. If adapter_mtu < 14, the result wraps
  to ~4GB as unsigned int.
- Confirmed via two usage sites:
  - `mana_en.c:3349`: `ndev->max_mtu = gc->adapter_mtu - ETH_HLEN`
  - `mana_bpf.c:242`: `ndev->max_mtu = gc->adapter_mtu - ETH_HLEN`

**Step 2.4: Fix Quality**
- Obviously correct: simple bounds check with a clear threshold
- Minimal: 6 lines of logic change
- No regression risk: only rejects values that would cause incorrect
  behavior anyway
- Clean: well-contained, single function

## PHASE 3: GIT HISTORY INVESTIGATION

**Step 3.1: Blame**
- The `adapter_mtu` field assignment was introduced in commit
  `80f6215b450eb8` ("net: mana: Add support for jumbo frame", Haiyang
  Zhang, 2023-04-12)
- This commit was first included in `v6.4-rc1`
- The vulnerable code has been present since v6.4

**Step 3.2: No Fixes: tag to follow**

**Step 3.3: File History**
- The file has active development with multiple fixes applied. No
  conflicting changes to the `mana_query_device_cfg()` function recently
  aside from commit `290e5d3c49f687` which added GDMA_MESSAGE_V3
  handling.

**Step 3.4: Author**
- Erni Sri Satya Vennela is a regular MANA contributor with 9+ commits
  to the driver, all from `@linux.microsoft.com`. The author is part of
  the Microsoft team maintaining this driver.

**Step 3.5: Dependencies**
- This is a standalone patch (1-of-1, not part of a series)
- Uses only existing constants (`ETH_MIN_MTU`, `ETH_HLEN`) which exist
  in all kernel versions
- The GDMA_MESSAGE_V2 check already exists in stable trees since v6.4

## PHASE 4: MAILING LIST RESEARCH

**Step 4.1-4.5:** b4 dig failed to find the thread. Lore is behind an
anti-scraping wall. However, the patch was accepted by netdev maintainer
Jakub Kicinski (signed-off-by), which indicates it passed netdev review.
The Link tag confirms it was a single-patch submission.

## PHASE 5: CODE SEMANTIC ANALYSIS

**Step 5.1: Functions Modified**
- `mana_query_device_cfg()` - device configuration query during probe

**Step 5.2: Callers**
- Called from `mana_probe_port()` -> `mana_query_device_cfg()` during
  device initialization
- This is the main probe path for all MANA network interfaces in Azure
  VMs

**Step 5.3: Downstream Impact**
- `gc->adapter_mtu` is used in two places to compute `ndev->max_mtu`:
  - `mana_en.c:3349` during probe
  - `mana_bpf.c:242` when XDP is detached
- Both perform `gc->adapter_mtu - ETH_HLEN` without checking for
  underflow

**Step 5.4: Reachability**
- This code is reached during every MANA device probe in Azure VMs -
  very common path for Azure users

## PHASE 6: STABLE TREE ANALYSIS

**Step 6.1: Buggy Code in Stable Trees**
- `adapter_mtu` was added in v6.4-rc1 via commit `80f6215b450eb8`
- Present in stable trees: 6.6.y, 6.12.y, 7.0.y
- NOT present in: 6.1.y, 5.15.y, 5.10.y (pre-dates adapter_mtu feature)

**Step 6.2: Backport Complications**
- Note: the current 7.0 tree has `resp.hdr.response.msg_version` (from
  commit `290e5d3c49f687`) while older stable trees may have
  `resp.hdr.resp.msg_version`. The diff may need minor adjustment for
  6.6.y.
- The validation logic itself is self-contained and trivially adaptable.

**Step 6.3: No related fixes already in stable.**

## PHASE 7: SUBSYSTEM AND MAINTAINER CONTEXT

**Step 7.1: Subsystem**
- `drivers/net/ethernet/microsoft/mana/` - MANA network driver for Azure
  VMs
- Criticality: IMPORTANT - widely used in Azure cloud infrastructure
  (millions of VMs)

**Step 7.2: Activity**
- Actively maintained with regular fixes. The author and team are
  Microsoft employees dedicated to this driver.

## PHASE 8: IMPACT AND RISK ASSESSMENT

**Step 8.1: Who is Affected**
- All Azure VM users running MANA driver (very large population)
- Especially CVM (Confidential VM) users where the hypervisor is less
  trusted

**Step 8.2: Trigger Conditions**
- Triggered when hardware/hypervisor returns `adapter_mtu < 82` in the
  config query response
- In CVM scenarios: malicious hypervisor could deliberately trigger this
- In non-CVM: unlikely but possible with firmware bugs

**Step 8.3: Failure Mode Severity**
- Integer underflow causes `max_mtu` to be set to ~4GB
- This silently allows setting huge MTU values that the hardware cannot
  support
- Could lead to packet corruption, buffer overflows in TX path, or
  device malfunction
- Severity: HIGH (potential for data corruption or security issue,
  especially in CVM)

**Step 8.4: Risk-Benefit Ratio**
- BENEFIT: Prevents integer underflow and incorrect device
  configuration. HIGH for CVM users, MEDIUM for regular Azure users.
- RISK: VERY LOW - only adds a bounds check on the initialization path.
  Cannot cause regression because it only rejects values that would
  cause broken behavior.

## PHASE 9: FINAL SYNTHESIS

**Step 9.1: Evidence Summary**

FOR backporting:
- Fixes a concrete integer underflow bug (adapter_mtu - ETH_HLEN wraps
  to ~4GB)
- Small, surgical fix (6 lines of logic)
- Obviously correct bounds check
- No regression risk
- Accepted by netdev maintainer
- Author is regular driver contributor
- Affects widely-used Azure MANA driver
- Security-relevant in CVM environments

AGAINST backporting:
- Labeled as "hardening" rather than "fix"
- No user reports of this being triggered in practice
- Trigger requires malicious or buggy firmware
- May need minor adjustment for older stable trees (response field name)

**Step 9.2: Stable Rules Checklist**
1. Obviously correct and tested? **YES** - simple bounds check, accepted
   by netdev maintainer
2. Fixes a real bug? **YES** - integer underflow leading to incorrect
   max_mtu
3. Important issue? **YES** - incorrect MTU can cause device
   malfunction; security issue in CVM
4. Small and contained? **YES** - 6 lines, single function, single file
5. No new features or APIs? **CORRECT** - no new features
6. Can apply to stable? **YES** - may need trivial adjustment for
   response field name in 6.6.y

**Step 9.3: Exception Categories**
- Not a standard exception category, but fits the pattern of input
  validation fixes that prevent integer overflow/underflow.

**Step 9.4: Decision**
The fix prevents a concrete integer underflow that causes `max_mtu` to
be set to ~4GB when hardware returns an invalid adapter_mtu. The fix is
minimal, obviously correct, and has zero regression risk. It is relevant
for Azure CVM security and defensive against firmware bugs.

## Verification

- [Phase 1] Parsed tags: Signed-off-by from author (Microsoft) and
  netdev maintainer Jakub Kicinski; Link to single-patch submission
- [Phase 2] Diff analysis: +6 lines of validation in
  `mana_query_device_cfg()`, checks `resp.adapter_mtu >= ETH_MIN_MTU +
  ETH_HLEN` (82)
- [Phase 2] Integer underflow verified: adapter_mtu=0 ->
  max_mtu=4294967282 (~4GB) via Python simulation
- [Phase 3] git blame: adapter_mtu code introduced in commit
  `80f6215b450eb8` (v6.4-rc1, 2023-04-12)
- [Phase 3] git describe --contains: confirmed in v6.4-rc1
- [Phase 3] Author has 9+ commits to MANA driver, regular contributor
- [Phase 4] b4 dig failed to find thread (timeout); lore blocked by
  anti-bot measures
- [Phase 5] Callers: `mana_query_device_cfg()` called from probe path;
  `gc->adapter_mtu - ETH_HLEN` used at mana_en.c:3349 and mana_bpf.c:242
- [Phase 5] Both usage sites perform unsigned subtraction without bounds
  check
- [Phase 6] Buggy code exists in stable trees 6.6.y+ (since v6.4-rc1)
- [Phase 6] Standalone fix, may need minor field name adjustment for
  older trees
- [Phase 7] MANA driver widely used in Azure (IMPORTANT criticality)
- [Phase 8] Failure mode: max_mtu set to ~4GB, allowing oversized MTU;
  severity HIGH
- [Phase 8] Risk: VERY LOW (only rejects clearly invalid values)

**YES**

 drivers/net/ethernet/microsoft/mana/mana_en.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 09a53c9775455..7589ead7efdb6 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1214,10 +1214,16 @@ static int mana_query_device_cfg(struct mana_context *ac, u32 proto_major_ver,
 
 	*max_num_vports = resp.max_num_vports;
 
-	if (resp.hdr.response.msg_version >= GDMA_MESSAGE_V2)
+	if (resp.hdr.response.msg_version >= GDMA_MESSAGE_V2) {
+		if (resp.adapter_mtu < ETH_MIN_MTU + ETH_HLEN) {
+			dev_err(dev, "Adapter MTU too small: %u\n",
+				resp.adapter_mtu);
+			return -EPROTO;
+		}
 		gc->adapter_mtu = resp.adapter_mtu;
-	else
+	} else {
 		gc->adapter_mtu = ETH_FRAME_LEN;
+	}
 
 	if (resp.hdr.response.msg_version >= GDMA_MESSAGE_V3)
 		*bm_hostmode = resp.bm_hostmode;
-- 
2.53.0


