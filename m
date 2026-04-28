Return-Path: <linux-hyperv+bounces-10413-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFxhJwiW8GnnVAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10413-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 13:12:08 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB87483668
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 13:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D8D9F30593C0
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 10:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603203FB7E4;
	Tue, 28 Apr 2026 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnZDS58u"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8993FB7DE;
	Tue, 28 Apr 2026 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372925; cv=none; b=tvOZpJGeZ03VJ5cjaGavRgaDv8PZTNwRh3FDffQMYjFwKhbsLXKeDaZtChIPofaHernx3WZ+Nl2AKPWfbNaf4sdlkqLQaDGksYwaWyqGBYAWgvW8gqmU63GFqDqyuFmeQOg3q/CxYEmjPJ5Vkmoo8lRC20DDzBSTpyXEFz+I7co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372925; c=relaxed/simple;
	bh=vA373YL3h68bLTYYCHuZBVlqlW2rLVoK7vXWdxBy1xU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXfkxw2H30G455Rnh+gzXHtI7NMyTzDCrYd5iXuYi+lukbTVl/ESA5/Hn8FpDCDNJ5PQ5zumn9stlzvLUNL0U/yCc0413rXIHjACL47872leaxB48U2Pav8Ly8GBlKhSAvLU04xcC/Q4jUPeiTHE1F5UTnhHp5KXjt7DdOpc7Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnZDS58u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB72C2BCC7;
	Tue, 28 Apr 2026 10:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777372924;
	bh=vA373YL3h68bLTYYCHuZBVlqlW2rLVoK7vXWdxBy1xU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gnZDS58u/LHARZgs2R66E1ZNmZHjlFj2/OsJGzjKv3ga+ttcAP55C415QbTAatMxm
	 eDKquV0mnBjiQGG2yZjX3mqReFlLZiqqyRxZf1xyBRKJKuFl5hV0fxiqPkW6MVQyMr
	 XHC3MQz7AYSrQaUqPkXFFJswPzaPML+sGYztQWz8YCwVcWC+CdrfAYpb1U02Xw+Eyj
	 +OqRE/pru4prS0uv3CF5ts+o738uJ5AzGNqzUiXDcQmSc6HGhwqQFGoSHgryNiLE73
	 FIRMz2KMiUkkFS9S13HUZljwwiLZbosWYtwXvnB4pfHPdC+02Xj+PTXQCBLP8wDwOx
	 /OMpfR9LNR9Rw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Li Tian <litian@redhat.com>,
	Long Li <longli@microsoft.com>,
	Laurence Oberman <loberman@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	jejb@linux.ibm.com,
	linux-hyperv@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-5.10] scsi: storvsc: Handle PERSISTENT_RESERVE_IN truncation for Hyper-V vFC
Date: Tue, 28 Apr 2026 06:40:33 -0400
Message-ID: <20260428104133.2858589-22-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428104133.2858589-1-sashal@kernel.org>
References: <20260428104133.2858589-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 7.0.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9BB87483668
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10413-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,oracle.com:email]

From: Li Tian <litian@redhat.com>

[ Upstream commit 9cf351b289fb2be22491fa3964f99126db67aa08 ]

The storvsc driver has become stricter in handling SRB status codes
returned by the Hyper-V host. When using Virtual Fibre Channel (vFC)
passthrough, the host may return SRB_STATUS_DATA_OVERRUN for
PERSISTENT_RESERVE_IN commands if the allocation length in the CDB does
not match the host's expected response size.

Currently, this status is treated as a fatal error, propagating
Host_status=0x07 [DID_ERROR] to the SCSI mid-layer. This causes
userspace storage utilities (such as sg_persist) to fail with transport
errors, even when the host has actually returned the requested
reservation data in the buffer.

Refactor the existing command-specific workarounds into a new helper
function, storvsc_host_mishandles_cmd(), and add PERSISTENT_RESERVE_IN
to the list of commands where SRB status errors should be suppressed for
vFC devices. This ensures that the SCSI mid-layer processes the returned
data buffer instead of terminating the command.

Signed-off-by: Li Tian <litian@redhat.com>
Reviewed-by: Long Li <longli@microsoft.com>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Link: https://patch.msgid.link/20260406015344.12566-1-litian@redhat.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have enough information. Let me synthesize the full analysis.

---

## Phase 1: Commit Message Forensics

**Step 1.1 — Subject line parse**
Record: Subsystem `scsi: storvsc`, verb "Handle" (bug-fix indicator),
summary: treat SRB_STATUS_DATA_OVERRUN for PERSISTENT_RESERVE_IN on
Hyper-V vFC as success instead of DID_ERROR.

**Step 1.2 — Tags**
Record:
- Signed-off-by: Li Tian (Red Hat, author)
- Reviewed-by: Long Li (Microsoft, storvsc maintainer/co-maintainer)
- Reviewed-by: Laurence Oberman (Red Hat, storage expert)
- Link: patch.msgid.link (lore)
- Signed-off-by: Martin K. Petersen (SCSI maintainer)
- No Fixes:, no Cc: stable (expected for manual review candidates)

**Step 1.3 — Body analysis**
Record: Bug is concrete and user-visible. When the storvsc driver became
stricter (SRB_STATUS_DATA_OVERRUN treated as error), Hyper-V vFC started
failing PERSISTENT_RESERVE_IN with `Host_status=0x07 [DID_ERROR]`, which
causes `sg_persist` and other SCSI-3 PR utilities to fail with transport
errors even though the reservation data was correctly returned in the
buffer. Root cause: the host echoes SRB_STATUS_DATA_OVERRUN when the
CDB's allocation length does not match the host's expected response
size.

**Step 1.4 — Hidden bug-fix detection**
Record: "Handle ... truncation" = explicit bug fix; the refactor is
incidental.

---

## Phase 2: Diff Analysis

**Step 2.1 — Inventory**
Record: Single file `drivers/scsi/storvsc_drv.c`, +21/-11, scope: one
new static helper (`storvsc_host_mishandles_cmd`) and a rewrite of one
`if` expression in `storvsc_on_io_completion`.

**Step 2.2 — Code flow change**
Record:
- BEFORE: `if ((cdb[0]==INQUIRY) || (cdb[0]==MODE_SENSE) ||
  (cdb[0]==MODE_SENSE_10) || (cdb[0]==MAINTENANCE_IN &&
  hv_dev_is_fc(device)))` → mask status to success
- AFTER: `if (storvsc_host_mishandles_cmd(cdb[0], device))` → same mask;
  helper adds `PERSISTENT_RESERVE_IN` under the FC-gated arm

**Step 2.3 — Bug mechanism**
Record: Hardware-workaround / status-filtering bug. Adds
PERSISTENT_RESERVE_IN to the same whitelist used for MAINTENANCE_IN —
i.e., commands for which Hyper-V vFC returns SRB_STATUS_DATA_OVERRUN
despite the data being correct.

**Step 2.4 — Fix quality**
Record: Obviously correct: the new `switch` is semantically identical to
the old `if` for existing opcodes; it only adds PERSISTENT_RESERVE_IN
under `hv_dev_is_fc(device)`. Minimal, surgical. Refactor into a helper
is cosmetic but slightly expands diff; no functional change for non-vFC
devices or for other opcodes.

---

## Phase 3: Git History Investigation

**Step 3.1 — Blame**
Record: The stricter handling of SRB_STATUS_DATA_OVERRUN was introduced
by commit `812fe6420a6e7` ("scsi: storvsc: Handle additional SRB status
values"), which went into **v6.6-rc1**. Before that, unknown SRB
statuses were simply ignored, so the bug did not manifest.

**Step 3.2 — Fixes: follow-up**
Record: There is no Fixes: tag, but the root-cause commit is clearly
`812fe6420a6e7` (v6.6). That commit IS present in all stable trees from
6.6.y onward, so the bug it introduced is present in all those trees.

**Step 3.3 — File history / related commits**
Record:
- `b1aee7f034615` ("scsi: storvsc: Do not flag MAINTENANCE_IN return of
  SRB_STATUS_DATA_OVERRUN as an error", v6.13-rc2, Cathy Avery) —
  parallel fix for MAINTENANCE_IN/RTPG. **Confirmed via web search this
  was AUTOSEL'd to 6.6.y stable (`[PATCH AUTOSEL 6.6 17/23]` on lkml).**
- `9eacec5d18f98` ("scsi: storvsc: Process unsupported MODE_SENSE_10",
  2026) — also had `Cc: stable@kernel.org` and `Fixes:`.
- The current commit is effectively "MAINTENANCE_IN fix, part 2" for a
  different opcode.

**Step 3.4 — Author context**
Record: Li Tian (Red Hat) — regular contributor of Hyper-V /
virtualization fixes. Reviewed by Long Li (Microsoft), who is the
storvsc maintainer. Strong review signal.

**Step 3.5 — Dependencies**
Record: Uses `hv_dev_is_fc(device)`, `INQUIRY`, `MODE_SENSE`,
`MODE_SENSE_10`, `MAINTENANCE_IN`, `PERSISTENT_RESERVE_IN`, all of which
exist in every stable tree 6.6+. Patch is self-contained.

---

## Phase 4: Mailing List and External Research

**Step 4.1 — b4 dig**
Record: `b4 dig -c 9cf351b289fb2` matched by patch-id, single series,
only v1, URL
`https://lore.kernel.org/all/20260406015344.12566-1-litian@redhat.com`.
No v2 or further revisions — applied as submitted.

**Step 4.2 — b4 dig -w**
Record: Recipients included linux-scsi, linux-hyperv, Microsoft
maintainers (K. Y. Srinivasan, Haiyang Zhang, Wei Liu, Dexuan Cui, Long
Li), James Bottomley, and Martin K. Petersen. The right audience
reviewed it.

**Step 4.3 — Thread contents (saved mbox)**
Record: Thread contains:
- Reviewed-by: Long Li: "Reviewed-by: Long Li <longli@microsoft.com>"
- Reviewed-by: Laurence Oberman: "Looks good, rewrite of how it was done
  before but will achieve the same behavior we wanted for the new
  addition for PR. Reviewed-by: Laurence Oberman."
- Martin K. Petersen applied to 7.1/scsi-staging and later 7.1/scsi-
  queue.
No NAKs, no stable-suitability concerns raised. No explicit `Cc: stable`
nomination, but also no objections.

**Step 4.4 — Series**
Record: Standalone single-patch series, no dependencies.

**Step 4.5 — Stable list history**
Record: Could not access lore.kernel.org/stable (bot protection). Web
search confirms the sibling MAINTENANCE_IN fix `b1aee7f034615` was
selected by AUTOSEL for 6.6.y, validating the pattern for stable
backport.

---

## Phase 5: Code Semantic Analysis

**Step 5.1–5.2 — Callers**
Record: `storvsc_on_io_completion` is called from `storvsc_on_receive`
for `VSTOR_OPERATION_COMPLETE_IO`, which is the primary completion path
for every SCSI command issued through storvsc. Every `sg_persist` or
other userspace PR issuer for a vFC LUN reaches this code.

**Step 5.3 — Callees**
Record: `hv_dev_is_fc()` is a trivial GUID comparison
(`HV_SYNTHFC_GUID`); no side effects.

**Step 5.4 — Reachability**
Record: Yes, trivially reachable from userspace: `/dev/sgN` ioctl →
PERSISTENT_RESERVE_IN CDB → storvsc → this completion path. Used by
`sg_persist`, `multipath`, cluster software.

**Step 5.5 — Similar patterns**
Record: Same pattern already applied for INQUIRY (pre-2014),
MODE_SENSE/MODE_SENSE_10 (`9eacec5d18f98`, Cc: stable), and
MAINTENANCE_IN (`b1aee7f034615`, AUTOSEL to 6.6.y).

---

## Phase 6: Stable Tree Analysis

**Step 6.1 — Bug presence in stable**
Record: Stricter SRB_STATUS_DATA_OVERRUN handling (812fe6420a6e7) is in
v6.6+. Therefore the PERSISTENT_RESERVE_IN regression exists in 6.6.y,
6.12.y, 6.15.y, 6.18.y and current trees.

**Step 6.2 — Backport complications**
Record: On stable trees that already have the MAINTENANCE_IN fix
(`b1aee7f034615`), the diff context matches exactly and should apply
cleanly with minor refactor. On any tree missing the MAINTENANCE_IN fix,
the refactor-into-helper form may need trivial adjustment. Given that
`b1aee7f034615` was AUTOSEL'd to 6.6.y, most 6.6+ stable trees should
have it.

**Step 6.3 — Related fixes already in stable**
Record: `b1aee7f034615` (MAINTENANCE_IN) and `9eacec5d18f98`
(MODE_SENSE_10) are already in stable. This completes the triad for vFC
command-mishandle workarounds.

---

## Phase 7: Subsystem Context

**Step 7.1 — Criticality**
Record: `drivers/scsi/storvsc_drv.c` — Hyper-V synthetic SCSI/FC driver.
IMPORTANT (used by every Linux VM running on Hyper-V/Azure that uses vFC
for storage — enterprise and cloud).

**Step 7.2 — Activity**
Record: Actively maintained; recent commits (MODE_SENSE_10,
MAINTENANCE_IN, queue/channel work). Not a stale subsystem.

---

## Phase 8: Impact and Risk

**Step 8.1 — Affected population**
Record: Linux VMs on Hyper-V/Azure using vFC passthrough with SCSI-3
persistent reservations (HA clusters, shared-storage coordination,
`sg_persist` consumers). Significant enterprise user base; not a niche
driver.

**Step 8.2 — Trigger**
Record: Any userspace call issuing PERSISTENT_RESERVE_IN (service action
READ_KEYS, READ_RESERVATION, REPORT_CAPABILITIES, READ_FULL_STATUS) to a
vFC LUN. Reproduces via `sg_persist -k /dev/sdX`. Unprivileged trigger:
limited by device permissions, but not a kernel-level security issue.

**Step 8.3 — Failure mode severity**
Record: User-visible I/O failure (sg_persist returns transport error,
multipath/cluster software fails to query/modify reservations). Severity
MEDIUM — no crash, no corruption, but broken functionality that blocks
clustering on Hyper-V vFC.

**Step 8.4 — Risk/benefit**
Record:
- Benefit: restores working SCSI-3 PR on Hyper-V vFC for all stable
  users on 6.6+.
- Risk: very low — change is gated on opcode == PERSISTENT_RESERVE_IN
  AND device is vFC. Non-vFC storvsc devices and non-PR opcodes are
  unaffected. The refactor is semantically equivalent for existing
  cases.
Ratio: favorable.

---

## Phase 9: Final Synthesis

**Step 9.1 — Evidence**
FOR: real user-visible bug (sg_persist failure), subsystem-maintainer +
independent reviewer sign-off, small single-file diff, follows
established pattern (MAINTENANCE_IN fix was AUTOSEL'd to 6.6.y), bug
present in all 6.6+ stable trees, no dependencies, low regression
surface.
AGAINST: includes a refactor-into-helper along with the fix (minor
cosmetic); missing explicit `Cc: stable` tag (but that's expected for
manually-reviewed candidates and also absent from the already-backported
MAINTENANCE_IN fix).

**Step 9.2 — Stable rules checklist**
1. Obviously correct & tested? YES (reviewed by MS + RH; switch is
   semantically equivalent for existing opcodes).
2. Fixes a real bug affecting users? YES (sg_persist on vFC).
3. Important issue? YES — breaks clustering/PR on a widely-used
   virtualization platform (MEDIUM-HIGH severity).
4. Small & contained? YES (+21/-11, one file).
5. No new features/APIs? YES (workaround only).
6. Applies to stable? YES (clean on 6.13+; likely clean on 6.6.y–6.12.y
   which already have the sibling MAINTENANCE_IN fix).

**Step 9.3 — Exception category**
Record: Falls under "hardware workaround / quirk" exception — the host-
side mishandling is effectively a device bug the driver compensates for.

**Step 9.4 — Decision**
YES.

---

### Verification
- [Phase 1] Parsed tags via Read of commit message: found 2 Reviewed-by,
  Link:, Signed-off-by chain. No Fixes/Cc:stable.
- [Phase 2] `git show 9cf351b289fb2`: confirmed +21/-11, single file,
  refactor + PERSISTENT_RESERVE_IN addition gated on
  `hv_dev_is_fc(device)`.
- [Phase 3] `git log --oneline --grep="MAINTENANCE_IN" --
  drivers/scsi/storvsc_drv.c`: found sibling fix `b1aee7f034615`.
- [Phase 3] `git show 812fe6420a6e`: confirmed this is the commit that
  introduced the stricter handling. `git describe --contains
  812fe6420a6e` → `v6.6-rc1~11^2~9^2` (v6.6).
- [Phase 3] `git describe --contains b1aee7f034615` → v6.13-rc2~7^2~1
  (MAINTENANCE_IN fix landed in v6.13).
- [Phase 3] `git show 9eacec5d18f98`: confirmed MODE_SENSE_10 handling
  fix explicitly had `Cc: stable@kernel.org` and `Fixes:` tag (similar
  hardware-mishandling pattern).
- [Phase 4] `b4 dig -c 9cf351b289fb2`: matched by patch-id, single
  version v1, lore URL obtained.
- [Phase 4] `b4 dig -c 9cf351b289fb2 -a`: only v1 exists (no v2/v3;
  applied as submitted).
- [Phase 4] `b4 dig -c 9cf351b289fb2 -w`: correct recipients (Microsoft
  storvsc maintainers + linux-scsi + linux-hyperv + MKP).
- [Phase 4] Saved thread to /tmp/thread.mbox and read it: found Long
  Li's Reviewed-by, Laurence Oberman's Reviewed-by ("Looks good, rewrite
  of how it was done before..."), and Martin K. Petersen's "Applied to
  7.1/scsi-queue". No NAKs, no concerns.
- [Phase 4] WebSearch confirmed `b1aee7f034615` was listed as "[PATCH
  AUTOSEL 6.6 17/23]" on lkml, validating that the AUTOSEL process
  already backported the sibling fix.
- [Phase 5] Grep for `storvsc_on_io_completion`: confirmed it is called
  from `storvsc_on_receive` on `VSTOR_OPERATION_COMPLETE_IO`, i.e.,
  every SCSI completion path.
- [Phase 5] Read `hv_dev_is_fc` (line 1928): trivial GUID match against
  `HV_SYNTHFC_GUID` — zero side effects.
- [Phase 6] v6.6 contains 812fe6420a6e (bug root cause is present in
  6.6.y, 6.12.y, 6.15.y, 6.18.y).
- [Phase 8] Failure mode: sg_persist returns DID_ERROR even when host
  returned data; breaks SCSI-3 PR on vFC — MEDIUM severity, broad impact
  on enterprise Hyper-V users.
- UNVERIFIED: Could not fetch lore.kernel.org/stable directly (Anubis
  bot protection), so I could not confirm whether this specific commit
  is already under stable discussion. This does not change the YES
  decision; it is based on technical merit.
- UNVERIFIED: Did not run an actual `git am` against linux-stable
  branches to confirm clean apply, but the code context (lines 1131–1180
  in storvsc_drv.c) matches the upstream base `ae1abab97835` (index in
  diff) and all referenced symbols (`INQUIRY`, `MODE_SENSE_10`,
  `MAINTENANCE_IN`, `PERSISTENT_RESERVE_IN`, `hv_dev_is_fc`) exist in
  6.13+ trees with the MAINTENANCE_IN fix already present.

This is a small, well-reviewed hardware-workaround fix for a real user-
visible regression (sg_persist/SCSI-3 PR broken on Hyper-V vFC since
v6.6), following an established pattern whose sibling was already
AUTOSEL'd to stable. Benefit clearly outweighs risk.

**YES**

 drivers/scsi/storvsc_drv.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index ae1abab97835b..6977ca8a06582 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1131,6 +1131,26 @@ static void storvsc_command_completion(struct storvsc_cmd_request *cmd_request,
 		kfree(payload);
 }
 
+/*
+ * The current SCSI handling on the host side does not correctly handle:
+ * INQUIRY with page code 0x80, MODE_SENSE / MODE_SENSE_10 with cmd[2] == 0x1c,
+ * and (for FC) MAINTENANCE_IN / PERSISTENT_RESERVE_IN passthrough.
+ */
+static bool storvsc_host_mishandles_cmd(u8 opcode, struct hv_device *device)
+{
+	switch (opcode) {
+	case INQUIRY:
+	case MODE_SENSE:
+	case MODE_SENSE_10:
+		return true;
+	case MAINTENANCE_IN:
+	case PERSISTENT_RESERVE_IN:
+		return hv_dev_is_fc(device);
+	default:
+		return false;
+	}
+}
+
 static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 				  struct vstor_packet *vstor_packet,
 				  struct storvsc_cmd_request *request)
@@ -1141,22 +1161,12 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 	stor_pkt = &request->vstor_packet;
 
 	/*
-	 * The current SCSI handling on the host side does
-	 * not correctly handle:
-	 * INQUIRY command with page code parameter set to 0x80
-	 * MODE_SENSE and MODE_SENSE_10 command with cmd[2] == 0x1c
-	 * MAINTENANCE_IN is not supported by HyperV FC passthrough
-	 *
 	 * Setup srb and scsi status so this won't be fatal.
 	 * We do this so we can distinguish truly fatal failues
 	 * (srb status == 0x4) and off-line the device in that case.
 	 */
 
-	if ((stor_pkt->vm_srb.cdb[0] == INQUIRY) ||
-	   (stor_pkt->vm_srb.cdb[0] == MODE_SENSE) ||
-	   (stor_pkt->vm_srb.cdb[0] == MODE_SENSE_10) ||
-	   (stor_pkt->vm_srb.cdb[0] == MAINTENANCE_IN &&
-	   hv_dev_is_fc(device))) {
+	if (storvsc_host_mishandles_cmd(stor_pkt->vm_srb.cdb[0], device)) {
 		vstor_packet->vm_srb.scsi_status = 0;
 		vstor_packet->vm_srb.srb_status = SRB_STATUS_SUCCESS;
 	}
-- 
2.53.0


