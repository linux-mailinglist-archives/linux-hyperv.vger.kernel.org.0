Return-Path: <linux-hyperv+bounces-10343-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YF4EH1VI6mkhxgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10343-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 18:27:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE1E454DE6
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 18:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 030173081855
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 16:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844B9386567;
	Thu, 23 Apr 2026 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="meGuQuMn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9BA3128B2;
	Thu, 23 Apr 2026 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960990; cv=none; b=SvE9KNLLLr02059Rftx5Po7HY8BHQcY1PqWpOlyic8dgEyujfuyjZpvwaMDgS2aSBOVK8VKkR6XZz0c4DtDMdkCOXl5kvYwWTLzUjVhR6vyTNQIbL5uOVoQeSXw0jGSp5TgaJutSwtcXEhg1CFYfwJkRbylr/PlHXKLbPQ/leSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960990; c=relaxed/simple;
	bh=3QLlUUA45jvg2Bo/2NlwgsNjoebfzweDDS8HuHR8aFs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KqAIUi6l4fg5ZzhQd1i1/70u45HwdqKDN6+vB44cJ3WwE41fEfSjMas+XZgXrrcBP8XE/XFwzyEUld1BHejiCNPy8c3AUZeh4KzVkdB/l8tabQFXm0qvejvU4reFJAKiHfj5Y+YCfhoFyKnskc2CAQHThvHO99ui5u9wcDR38zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=meGuQuMn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 031FE20B7165; Thu, 23 Apr 2026 09:16:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 031FE20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776960989;
	bh=nS3ZXhBI9YIGEoe/pnr3KjJMA28TZVBjHOa6JEa/7po=;
	h=Date:From:To:Subject:From;
	b=meGuQuMnAY7ojg9GpAPQzjAe6kRgB2d95O4fUTQqfo8yNM8OcwE+kYyycypMacuhe
	 kGSCNe309udZ9Li78zyD/Syg2XYBIk4hVbeHx1uw56BbRHcqSqYc6JUaTZHmQS3jux
	 GAptQp/khgZIu7bnnCQH+NHYkz3xwW1Lc0IhWPuA=
Date: Thu, 23 Apr 2026 09:16:28 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	leon@kernel.org, longli@microsoft.com, kotaranov@microsoft.com,
	horms@kernel.org, shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, stephen@networkplumber.org,
	jacob.e.keller@intel.com, dipayanroy@microsoft.com,
	leitao@debian.org, kees@kernel.org, john.fastabend@gmail.com,
	hawk@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	ast@kernel.org, sdf@fomichev.me, yury.norov@gmail.com
Subject: [PATCH net] net: mana: hardening: Validate SHM offset from BAR0
 register to prevent crash due to alignment fault
Message-ID: <aepF3NwyANeklkfD@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10343-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	RCPT_COUNT_TWELVE(0.00)[33];
	DBL_BLOCKED_OPENRESOLVER(0.00)[b.ne:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: DCE1E454DE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During Function Level Reset recovery, the MANA driver reads
hardware BAR0 registers that may temporarily contain garbage values.
The SHM (Shared Memory) offset read from GDMA_REG_SHM_OFFSET is used
to compute gc->shm_base, which is later dereferenced via readl() in
mana_smc_poll_register(). If the hardware returns an unaligned or
out-of-range value, the driver must not blindly use it, as this would
propagate the hardware error into a kernel crash.

The following crash was observed on an arm64 Hyper-V guest running
kernel 6.17.0-3013-azure during VF reset recovery triggered by HWC
timeout.

[13291.785274] Unable to handle kernel paging request at virtual address ffff8000a200001b
[13291.785311] Mem abort info:
[13291.785332]   ESR = 0x0000000096000021
[13291.785343]   EC = 0x25: DABT (current EL), IL = 32 bits
[13291.785355]   SET = 0, FnV = 0
[13291.785363]   EA = 0, S1PTW = 0
[13291.785372]   FSC = 0x21: alignment fault
[13291.785382] Data abort info:
[13291.785391]   ISV = 0, ISS = 0x00000021, ISS2 = 0x00000000
[13291.785404]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[13291.785412]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[13291.785421] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000014df3a1000
[13291.785432] [ffff8000a200001b] pgd=1000000100438403, p4d=1000000100438403, pud=1000000100439403, pmd=0068000fc2000711
[13291.785703] Internal error: Oops: 0000000096000021 [#1]  SMP
[13291.830975] Modules linked in: tls qrtr mana_ib ib_uverbs ib_core xt_owner xt_tcpudp xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables cfg80211 8021q garp mrp stp llc binfmt_misc joydev serio_raw nls_iso8859_1 hid_generic aes_ce_blk aes_ce_cipher polyval_ce ghash_ce sm4_ce_gcm sm4_ce_ccm sm4_ce sm4_ce_cipher hid_hyperv sm4 sm3_ce sha3_ce hv_netvsc hid vmgenid hyperv_keyboard hyperv_drm sch_fq_codel nvme_fabrics efi_pstore dm_multipath nfnetlink vsock_loopback vmw_vsock_virtio_transport_common hv_sock vmw_vsock_vmci_transport vmw_vmci vsock dmi_sysfs ip_tables x_tables autofs4
[13291.862630] CPU: 122 UID: 0 PID: 61796 Comm: kworker/122:2 Tainted: G        W           6.17.0-3013-azure #13-Ubuntu VOLUNTARY
[13291.869902] Tainted: [W]=WARN
[13291.871901] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 01/08/2026
[13291.878086] Workqueue: events mana_serv_func
[13291.880718] pstate: 62400005 (nZCv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
[13291.884835] pc : mana_smc_poll_register+0x48/0xb0
[13291.887902] lr : mana_smc_setup_hwc+0x70/0x1c0
[13291.890493] sp : ffff8000ab79bbb0
[13291.892364] x29: ffff8000ab79bbb0 x28: ffff00410c8b5900 x27: ffff00410d630680
[13291.896252] x26: ffff004171f9fd80 x25: 000000016ed55000 x24: 000000017f37e000
[13291.899990] x23: 0000000000000000 x22: 000000016ed55000 x21: 0000000000000000
[13291.904497] x20: ffff8000a200001b x19: 0000000000004e20 x18: ffff8000a6183050
[13291.908308] x17: 0000000000000000 x16: 0000000000000000 x15: 000000000000000a
[13291.912542] x14: 0000000000000004 x13: 0000000000000000 x12: 0000000000000000
[13291.916298] x11: 0000000000000000 x10: 0000000000000001 x9 : ffffc45006af1bd8
[13291.920945] x8 : ffff000151129000 x7 : 0000000000000000 x6 : 0000000000000000
[13291.925293] x5 : 000000015f214000 x4 : 000000017217a000 x3 : 000000016ed50000
[13291.930436] x2 : 000000016ed55000 x1 : 0000000000000000 x0 : ffff8000a1ffffff
[13291.934342] Call trace:
[13291.935736]  mana_smc_poll_register+0x48/0xb0 (P)
[13291.938611]  mana_smc_setup_hwc+0x70/0x1c0
[13291.941113]  mana_hwc_create_channel+0x1a0/0x3a0
[13291.944283]  mana_gd_setup+0x16c/0x398
[13291.946584]  mana_gd_resume+0x24/0x70
[13291.948917]  mana_do_service+0x13c/0x1d0
[13291.951583]  mana_serv_func+0x34/0x68
[13291.953732]  process_one_work+0x168/0x3d0
[13291.956745]  worker_thread+0x2ac/0x480
[13291.959104]  kthread+0xf8/0x110
[13291.961026]  ret_from_fork+0x10/0x20
[13291.963560] Code: d2807d00 9417c551 71000673 54000220 (b9400281)
[13291.967299] ---[ end trace 0000000000000000 ]---

Disassembly of mana_smc_poll_register() around the crash site:

Disassembly of section .text:

00000000000047c8 <mana_smc_poll_register>:
    47c8: d503201f        nop
    47cc: d503201f        nop
    47d0: d503233f        paciasp
    47d4: f800865e        str     x30, [x18], #8
    47d8: a9bd7bfd        stp     x29, x30, [sp, #-48]!
    47dc: 910003fd        mov     x29, sp
    47e0: a90153f3        stp     x19, x20, [sp, #16]
    47e4: 91007014        add     x20, x0, #0x1c
    47e8: 5289c413        mov     w19, #0x4e20
    47ec: f90013f5        str     x21, [sp, #32]
    47f0: 12001c35        and     w21, w1, #0xff
    47f4: 14000008        b       4814 <mana_smc_poll_register+0x4c>
    47f8: 36f801e1  tbz  w1, #31, 4834 <mana_smc_poll_register+0x6c>
    47fc: 52800042        mov     w2, #0x2
    4800: d280fa01        mov     x1, #0x7d0
    4804: d2807d00        mov     x0, #0x3e8
    4808: 94000000        bl      0 <usleep_range_state>
    480c: 71000673        subs    w19, w19, #0x1
    4810: 54000200        b.eq    4850 <mana_smc_poll_register+0x88>
    4814: b9400281      ldr   w1, [x20] <-- **** CRASHED HERE *****
    4818: d50331bf        dmb     oshld
    481c: 2a0103e2        mov     w2, w1
    4820: ca020042        eor     x2, x2, x2
    4824: b5000002        cbnz    x2, 4824 <mana_smc_poll_register+0x5c>
    4828: 710002bf        cmp     w21, #0x0
    482c: 3a411820        ccmn    w1, #0x1, #0x0, ne
    4830: 54fffe41        b.ne    47f8 <mana_smc_poll_register+0x30>
    4834: f85f8e5e        ldr     x30, [x18, #-8]!
    4838: 52800000        mov     w0, #0x0
    483c: a94153f3        ldp     x19, x20, [sp, #16]
    4840: f94013f5        ldr     x21, [sp, #32]
    4844: f84307fd        ldr     x29, [sp], #48
    4848: d50323bf        autiasp
    484c: d65f03c0        ret
    4850: f85f8e5e        ldr     x30, [x18, #-8]!
    4854: 12800da0        mov     w0, #0xffffff92
    4858: a94153f3        ldp     x19, x20, [sp, #16]
    485c: f94013f5        ldr     x21, [sp, #32]
    4860: f84307fd        ldr     x29, [sp], #48
    4864: d50323bf        autiasp
    4868: d65f03c0        ret

From the crash signature x20 = ffff8000a200001b, this address
ends in 0x1b which is not 4-byte aligned, so the 'ldr w1, [x20]'
instruction (readl) triggers the arm64 alignment fault (FSC = 0x21).

The root cause is in mana_gd_init_vf_regs(), which computes:

  gc->shm_base = gc->bar0_va + mana_gd_r64(gc, GDMA_REG_SHM_OFFSET);

without validating the offset read from hardware. If the register
returns a garbage value that is neither within bar 0 bounds nor aligned
to the 4-byte granularity, thus causing the alignment fault.

Harden the register validation in both mana_gd_init_vf_regs() and
mana_gd_init_pf_regs() by checking the SHM offset for bounds and
4-byte alignment before use. Return -EPROTO on invalid values, which
the existing recovery path in mana_serv_reset() already handles by
falling through to PCI device rescan, giving the hardware another
chance to present valid register values.

Fixes: 9bf66036d686 ("net: mana: Handle hardware recovery events when probing the device")
Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 32 +++++++++++++++++--
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 098fbda0d128..75efbeebae0e 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -45,6 +45,7 @@ static int mana_gd_init_pf_regs(struct pci_dev *pdev)
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 	void __iomem *sriov_base_va;
 	u64 sriov_base_off;
+	u64 sriov_shm_off;
 
 	gc->db_page_size = mana_gd_r32(gc, GDMA_PF_REG_DB_PAGE_SIZE) & 0xFFFF;
 
@@ -73,10 +74,25 @@ static int mana_gd_init_pf_regs(struct pci_dev *pdev)
 	gc->phys_db_page_base = gc->bar0_pa + gc->db_page_off;
 
 	sriov_base_off = mana_gd_r64(gc, GDMA_SRIOV_REG_CFG_BASE_OFF);
+	if (sriov_base_off >= gc->bar0_size ||
+	    !IS_ALIGNED(sriov_base_off, sizeof(u32))) {
+		dev_err(gc->dev,
+			"SRIOV base offset 0x%llx out of range or unaligned (BAR0 size 0x%llx)\n",
+			sriov_base_off, (u64)gc->bar0_size);
+		return -EPROTO;
+	}
 
 	sriov_base_va = gc->bar0_va + sriov_base_off;
-	gc->shm_base = sriov_base_va +
-			mana_gd_r64(gc, sriov_base_off + GDMA_PF_REG_SHM_OFF);
+
+	sriov_shm_off = mana_gd_r64(gc, sriov_base_off + GDMA_PF_REG_SHM_OFF);
+	if (sriov_base_off + sriov_shm_off >= gc->bar0_size ||
+	    !IS_ALIGNED(sriov_shm_off, sizeof(u32))) {
+		dev_err(gc->dev,
+			"SRIOV SHM offset 0x%llx out of range or unaligned (BAR0 size 0x%llx)\n",
+			sriov_shm_off, (u64)gc->bar0_size);
+		return -EPROTO;
+	}
+	gc->shm_base = sriov_base_va + sriov_shm_off;
 
 	return 0;
 }
@@ -84,6 +100,7 @@ static int mana_gd_init_pf_regs(struct pci_dev *pdev)
 static int mana_gd_init_vf_regs(struct pci_dev *pdev)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
+	u64 shm_off;
 
 	gc->db_page_size = mana_gd_r32(gc, GDMA_REG_DB_PAGE_SIZE) & 0xFFFF;
 
@@ -111,7 +128,16 @@ static int mana_gd_init_vf_regs(struct pci_dev *pdev)
 	gc->db_page_base = gc->bar0_va + gc->db_page_off;
 	gc->phys_db_page_base = gc->bar0_pa + gc->db_page_off;
 
-	gc->shm_base = gc->bar0_va + mana_gd_r64(gc, GDMA_REG_SHM_OFFSET);
+	shm_off = mana_gd_r64(gc, GDMA_REG_SHM_OFFSET);
+	if (shm_off >= gc->bar0_size ||
+	    !IS_ALIGNED(shm_off, sizeof(u32))) {
+		dev_err(gc->dev,
+			"SHM offset 0x%llx out of range or unaligned (BAR0 size 0x%llx)\n",
+			shm_off, (u64)gc->bar0_size);
+		return -EPROTO;
+	}
+
+	gc->shm_base = gc->bar0_va + shm_off;
 
 	return 0;
 }
-- 
2.43.0


