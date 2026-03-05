Return-Path: <linux-hyperv+bounces-9150-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNlxJFWnqWlSBwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9150-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 16:55:01 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB0E214ECD
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 16:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B950B3000091
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Mar 2026 15:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFAB3CE481;
	Thu,  5 Mar 2026 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bhfd7vYD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3843CD8D2;
	Thu,  5 Mar 2026 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772725040; cv=none; b=LnWQpXdO7Gm+Qf42ctTZdPGhY6d1ahCdQVH+czWKIFWlahZUseeEc7hVpzcwwmk+ekV18zY4xmJCbdBqbHj6F6H+EXzRAKQGP7JP0hoRz4AzLqW6+7gYZcr/exfodFpThOf1K3onH6AfGD89Gr4p2Q3szM0F/mhw1Pc7FcwfFcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772725040; c=relaxed/simple;
	bh=Yhl0gWZMiDd1Tqs4mW2XcYXwszy4vPsjwXrYC/z2oHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oo0s1fn+OeuNg5wqtFz7ESotbS4gBkyWGyVSEGT5OxbI/U7KGYb/UWNLxLZYW9gdU1pFFhc5brGHXbaFeegge7mIf5TpIS5xk5vWGS5Gfk4/tbXUDW+93x7H8FyLuMpOcjVV9nWpfgsgFOFq44uwJt0EgjWHgrloYJDOXYP19Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bhfd7vYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA5AC2BC9E;
	Thu,  5 Mar 2026 15:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772725040;
	bh=Yhl0gWZMiDd1Tqs4mW2XcYXwszy4vPsjwXrYC/z2oHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bhfd7vYDbZj+VJmQhKmtyFyGcODJGK0wyrht/H5hO7JcFBdZQANLPiyJ2opxoTfZM
	 Ce2eAurzJsHVFQ9mim5tpUtk3yrtXltnsdokK6sgkRptIQKl1zMP0cugsWkJhbDJq6
	 JeNCnZ4UsF9w3Gzkv3jpUH8pjDPtpJ3sPFrglV3IRvFcTGQqKRM61EvS0B1JC9ebrW
	 ua9y0es3BCrly8cBpSIj/IRY74rkCG1eyX0YT2syXQIFvQ1NyJL4XvVoFURgxzCqo2
	 oLpD+zA5EkYLBcLY7a9ddJCXNU/Von5DR8LYCxlsH38u8FkPApIgDQUAfOEEjreCEk
	 3aR5NC6duRyaw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	James.Bottomley@HansenPartnership.com,
	linux-hyperv@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-5.10] scsi: storvsc: Fix scheduling while atomic on PREEMPT_RT
Date: Thu,  5 Mar 2026 10:36:53 -0500
Message-ID: <20260305153704.106918-10-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305153704.106918-1-sashal@kernel.org>
References: <20260305153704.106918-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9FB0E214ECD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[siemens.com,outlook.com,oracle.com,kernel.org,microsoft.com,HansenPartnership.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9150-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,oracle.com:email,siemens.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Action: no action

From: Jan Kiszka <jan.kiszka@siemens.com>

[ Upstream commit 57297736c08233987e5d29ce6584c6ca2a831b12 ]

This resolves the follow splat and lock-up when running with PREEMPT_RT
enabled on Hyper-V:

[  415.140818] BUG: scheduling while atomic: stress-ng-iomix/1048/0x00000002
[  415.140822] INFO: lockdep is turned off.
[  415.140823] Modules linked in: intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_core pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vsec ghash_clmulni_intel aesni_intel rapl binfmt_misc nls_ascii nls_cp437 vfat fat snd_pcm hyperv_drm snd_timer drm_client_lib drm_shmem_helper snd sg soundcore drm_kms_helper pcspkr hv_balloon hv_utils evdev joydev drm configfs efi_pstore nfnetlink vsock_loopback vmw_vsock_virtio_transport_common hv_sock vmw_vsock_vmci_transport vsock vmw_vmci efivarfs autofs4 ext4 crc16 mbcache jbd2 sr_mod sd_mod cdrom hv_storvsc serio_raw hid_generic scsi_transport_fc hid_hyperv scsi_mod hid hv_netvsc hyperv_keyboard scsi_common
[  415.140846] Preemption disabled at:
[  415.140847] [<ffffffffc0656171>] storvsc_queuecommand+0x2e1/0xbe0 [hv_storvsc]
[  415.140854] CPU: 8 UID: 0 PID: 1048 Comm: stress-ng-iomix Not tainted 6.19.0-rc7 #30 PREEMPT_{RT,(full)}
[  415.140856] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 09/04/2024
[  415.140857] Call Trace:
[  415.140861]  <TASK>
[  415.140861]  ? storvsc_queuecommand+0x2e1/0xbe0 [hv_storvsc]
[  415.140863]  dump_stack_lvl+0x91/0xb0
[  415.140870]  __schedule_bug+0x9c/0xc0
[  415.140875]  __schedule+0xdf6/0x1300
[  415.140877]  ? rtlock_slowlock_locked+0x56c/0x1980
[  415.140879]  ? rcu_is_watching+0x12/0x60
[  415.140883]  schedule_rtlock+0x21/0x40
[  415.140885]  rtlock_slowlock_locked+0x502/0x1980
[  415.140891]  rt_spin_lock+0x89/0x1e0
[  415.140893]  hv_ringbuffer_write+0x87/0x2a0
[  415.140899]  vmbus_sendpacket_mpb_desc+0xb6/0xe0
[  415.140900]  ? rcu_is_watching+0x12/0x60
[  415.140902]  storvsc_queuecommand+0x669/0xbe0 [hv_storvsc]
[  415.140904]  ? HARDIRQ_verbose+0x10/0x10
[  415.140908]  ? __rq_qos_issue+0x28/0x40
[  415.140911]  scsi_queue_rq+0x760/0xd80 [scsi_mod]
[  415.140926]  __blk_mq_issue_directly+0x4a/0xc0
[  415.140928]  blk_mq_issue_direct+0x87/0x2b0
[  415.140931]  blk_mq_dispatch_queue_requests+0x120/0x440
[  415.140933]  blk_mq_flush_plug_list+0x7a/0x1a0
[  415.140935]  __blk_flush_plug+0xf4/0x150
[  415.140940]  __submit_bio+0x2b2/0x5c0
[  415.140944]  ? submit_bio_noacct_nocheck+0x272/0x360
[  415.140946]  submit_bio_noacct_nocheck+0x272/0x360
[  415.140951]  ext4_read_bh_lock+0x3e/0x60 [ext4]
[  415.140995]  ext4_block_write_begin+0x396/0x650 [ext4]
[  415.141018]  ? __pfx_ext4_da_get_block_prep+0x10/0x10 [ext4]
[  415.141038]  ext4_da_write_begin+0x1c4/0x350 [ext4]
[  415.141060]  generic_perform_write+0x14e/0x2c0
[  415.141065]  ext4_buffered_write_iter+0x6b/0x120 [ext4]
[  415.141083]  vfs_write+0x2ca/0x570
[  415.141087]  ksys_write+0x76/0xf0
[  415.141089]  do_syscall_64+0x99/0x1490
[  415.141093]  ? rcu_is_watching+0x12/0x60
[  415.141095]  ? finish_task_switch.isra.0+0xdf/0x3d0
[  415.141097]  ? rcu_is_watching+0x12/0x60
[  415.141098]  ? lock_release+0x1f0/0x2a0
[  415.141100]  ? rcu_is_watching+0x12/0x60
[  415.141101]  ? finish_task_switch.isra.0+0xe4/0x3d0
[  415.141103]  ? rcu_is_watching+0x12/0x60
[  415.141104]  ? __schedule+0xb34/0x1300
[  415.141106]  ? hrtimer_try_to_cancel+0x1d/0x170
[  415.141109]  ? do_nanosleep+0x8b/0x160
[  415.141111]  ? hrtimer_nanosleep+0x89/0x100
[  415.141114]  ? __pfx_hrtimer_wakeup+0x10/0x10
[  415.141116]  ? xfd_validate_state+0x26/0x90
[  415.141118]  ? rcu_is_watching+0x12/0x60
[  415.141120]  ? do_syscall_64+0x1e0/0x1490
[  415.141121]  ? do_syscall_64+0x1e0/0x1490
[  415.141123]  ? rcu_is_watching+0x12/0x60
[  415.141124]  ? do_syscall_64+0x1e0/0x1490
[  415.141125]  ? do_syscall_64+0x1e0/0x1490
[  415.141127]  ? irqentry_exit+0x140/0x7e0
[  415.141129]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

get_cpu() disables preemption while the spinlock hv_ringbuffer_write is
using is converted to an rt-mutex under PREEMPT_RT.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Tested-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Link: https://patch.msgid.link/0c7fb5cd-fb21-4760-8593-e04bade84744@siemens.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have enough context to analyze this commit thoroughly.

## Analysis

### 1. Problem Description
The commit fixes a **"BUG: scheduling while atomic"** crash and
**lockup** on Hyper-V VMs running with `PREEMPT_RT` enabled. The stack
trace in the commit message clearly shows the issue:

- `storvsc_queuecommand()` calls `get_cpu()` which disables preemption
- It then calls `storvsc_do_io()` → `vmbus_sendpacket_mpb_desc()` →
  `hv_ringbuffer_write()`
- `hv_ringbuffer_write()` takes a spinlock that, under PREEMPT_RT, is
  converted to an rt-mutex
- rt-mutexes can sleep/schedule, but preemption is disabled →
  **scheduling while atomic BUG**

### 2. The Fix
The fix replaces:
```c
ret = storvsc_do_io(dev, cmd_request, get_cpu());
put_cpu();
```
with:
```c
migrate_disable();
ret = storvsc_do_io(dev, cmd_request, smp_processor_id());
migrate_enable();
```

The purpose of `get_cpu()` here was to get a stable CPU number to use as
a channel index in `storvsc_do_io()`. The actual requirement is just to
prevent migration (so the CPU number stays valid), not to disable
preemption entirely. `migrate_disable()` achieves this while allowing
scheduling under PREEMPT_RT.

### 3. Correctness
- `migrate_disable()` prevents the task from being migrated to another
  CPU, so `smp_processor_id()` remains valid throughout the call
- On non-PREEMPT_RT kernels, this is functionally equivalent
  (migrate_disable maps to preempt_disable)
- On PREEMPT_RT, it allows the rt-mutex in `hv_ringbuffer_write()` to
  sleep as needed

### 4. Scope and Risk
- **3 lines changed** - extremely small and surgical
- Only affects `storvsc_queuecommand()` in the Hyper-V storage driver
- Well-understood transformation pattern
  (`get_cpu()`→`migrate_disable()`+`smp_processor_id()`) used
  extensively across the kernel for PREEMPT_RT fixes
- Has been **Tested-by** two people and **Reviewed-by** the Hyper-V
  subsystem expert (Michael Kelley)

### 5. User Impact
- **Hyper-V VMs with PREEMPT_RT**: This is a hard crash/lockup during
  normal I/O operations (ext4 writes), making the system completely
  unusable
- PREEMPT_RT is increasingly used in enterprise and embedded
  deployments, including on Hyper-V/Azure
- Without this fix, PREEMPT_RT kernels on Hyper-V are effectively broken
  for any storage I/O

### 6. Stable Criteria Assessment
- **Obviously correct**: Yes - standard PREEMPT_RT fix pattern
- **Fixes a real bug**: Yes - kernel BUG + lockup
- **Important issue**: Yes - system lockup during normal I/O
- **Small and contained**: Yes - 3-line change in one file
- **No new features**: Correct - pure bug fix
- **Tested**: Yes - two Tested-by tags

### Verification
- Read `storvsc_drv.c:1858` confirming the old code uses
  `get_cpu()`/`put_cpu()` (matches the diff)
- Read `storvsc_do_io()` at line 1453: confirms `q_num` is used as a CPU
  index into `stor_chns[]` array and passed to
  `cpumask_of_node(cpu_to_node(q_num))` - only needs migration
  stability, not preemption disabled
- Confirmed the call chain: `storvsc_do_io()` →
  `vmbus_sendpacket_mpb_desc()` (line 1547) → `hv_ringbuffer_write()`
  which takes a spinlock (as shown in the stack trace)
- The stack trace shows `rt_spin_lock` → `rtlock_slowlock_locked` →
  `schedule_rtlock` confirming the spinlock-to-rt-mutex conversion is
  the trigger
- `git log` confirmed this is in a well-maintained driver with recent
  activity

**YES**

 drivers/scsi/storvsc_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index b43d876747b76..68c837146b9ea 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1855,8 +1855,9 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	cmd_request->payload_sz = payload_sz;
 
 	/* Invokes the vsc to start an IO */
-	ret = storvsc_do_io(dev, cmd_request, get_cpu());
-	put_cpu();
+	migrate_disable();
+	ret = storvsc_do_io(dev, cmd_request, smp_processor_id());
+	migrate_enable();
 
 	if (ret)
 		scsi_dma_unmap(scmnd);
-- 
2.51.0


