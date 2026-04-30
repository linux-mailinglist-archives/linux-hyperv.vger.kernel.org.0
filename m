Return-Path: <linux-hyperv+bounces-10514-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AS1FjHU8mmyugEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10514-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 06:01:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF58449D1CA
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 06:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC3293029E60
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 04:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7432362151;
	Thu, 30 Apr 2026 04:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LEV4ELxS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4185E28371;
	Thu, 30 Apr 2026 04:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777521685; cv=none; b=r1e9CFX/xsk7wV/m/zLBIAzbRtd/RYst4hplvBwyttjR//2IlCeS8QJd2Fg421kzGaogAjWGr25eskNRQqtQgHgy9e2hmJuuVZn3lzUDBK/lJtF8GWEzZle3biSATsvH7Gpg2txGXMv4TGHLGh1g9bDOWkbje0IVXEKDLLFaqVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777521685; c=relaxed/simple;
	bh=40tcjBGuaqP4Wg4pEIBM/AhsHcHzBH6ywRh7TgHFlts=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XyzbaLEqbLnSA+oW0yyjDTS45+GXsDVwYnpPAynSuQDVdelN2kT3uZ6pm0KkOoRPs1YGXiw71Mzvs0DOOJnhlxlfLMNSN9qx+ayL8Gyq7KL5HrzGrxiiJJOERGITiw7/j92g3jjfDtPvCgbt9Wr9Gv/0D3tPUBIroASjIh2Y3OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LEV4ELxS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0979E20B716D;
	Wed, 29 Apr 2026 21:01:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0979E20B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777521684;
	bh=PZLSspUx4HwTXhZFE3EOnV/6TAaRyW3B+9uu3JTJu1Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LEV4ELxSwsg0PPhMrrHskPs6M3ZWeN1bI7JOIWvze5xISuxYc5FziflAmpsbafPrl
	 7RXBWJZ/syrLgbPqZAY9sIGq7OlmPnSze6ko0ErYZn8ehP9pVyBeqD7oIcRcXOtyrM
	 QAOMcoEHUkjVvWsyrNGFPP7rkHRq5tBBpn84IOG0=
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	leon@kernel.org,
	longli@microsoft.com,
	kotaranov@microsoft.com,
	horms@kernel.org,
	shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	stephen@networkplumber.org,
	jacob.e.keller@intel.com,
	dipayanroy@microsoft.com,
	leitao@debian.org,
	kees@kernel.org,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	sdf@fomichev.me,
	yury.norov@gmail.com
Subject: [PATCH 1/3] net: mana: check xdp_rxq registration before unreg in mana_destroy_rxq()
Date: Wed, 29 Apr 2026 20:57:52 -0700
Message-ID: <20260430035935.1859220-2-dipayanroy@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260430035935.1859220-1-dipayanroy@linux.microsoft.com>
References: <20260430035935.1859220-1-dipayanroy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EF58449D1CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	TAGGED_FROM(0.00)[bounces-10514-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

When mana_create_rxq() fails at mana_create_wq_obj() or any step before
xdp_rxq_info_reg() is called, the error path jumps to `out:` which calls
mana_destroy_rxq(). mana_destroy_rxq() unconditionally calls
xdp_rxq_info_unreg() on xilinx xdp_rxq that was never registered,
triggering a WARN_ON in net/core/xdp.c:

mana 7870:00:00.0: HWC: Failed hw_channel req: 0xc000009a
mana 7870:00:00.0 eth7: Failed to create RXQ: err = -71
Driver BUG
WARNING: CPU: 442 PID: 491615 at ../net/core/xdp.c:150 xdp_rxq_info_unreg+0x44/0x70
Modules linked in: tcp_bbr xsk_diag udp_diag raw_diag unix_diag af_packet_diag netlink_diag nf_tables nfnetlink tcp_diag inet_diag binfmt_misc rpcsec_gss_krb5 nfsv3 nfs_acl auth_rpcgss nfsv4 dns_resolver nfs lockd ext4 grace crc16 iscsi_tcp mbcache fscache libiscsi_tcp jbd2 netfs rpcrdma af_packet sunrpc rdma_ucm ib_iser rdma_cm iw_cm iscsi_ibft ib_cm iscsi_boot_sysfs libiscsi rfkill scsi_transport_iscsi mana_ib ib_uverbs ib_core mana hyperv_drm(X) drm_shmem_helper intel_rapl_msr drm_kms_helper intel_rapl_common syscopyarea nls_iso8859_1 sysfillrect intel_uncore_frequency_common nls_cp437 vfat fat nfit sysimgblt libnvdimm hv_netvsc(X) hv_utils(X) fb_sys_fops hv_balloon(X) joydev fuse drm dm_mod configfs ip_tables x_tables xfs libcrc32c sd_mod nvme nvme_core nvme_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 hid_generic serio_raw pci_hyperv(X) hv_storvsc(X) scsi_transport_fc hyperv_keyboard(X) hid_hyperv(X) pci_hyperv_intf(X) crc32_pclmul
 crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd cryptd hv_vmbus(X) softdog sg scsi_mod efivarfs
Supported: Yes, External
CPU: 442 PID: 491615 Comm: ethtool Kdump: loaded Tainted: G               X    5.14.21-150500.55.136-default #1 SLE15-SP5 a627be1b53abbfd64ad16b2685e4308c52847f42
Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 07/25/2025
RIP: 0010:xdp_rxq_info_unreg+0x44/0x70
Code: e8 91 fe ff ff c7 43 0c 02 00 00 00 48 c7 03 00 00 00 00 5b c3 cc cc cc cc e9 58 3a 1c 00 48 c7 c7 f6 5f 19 97 e8 5c a4 7e ff <0f> 0b 83 7b 0c 01 74 ca 48 c7 c7 d9 5f 19 97 e8 48 a4 7e ff 0f 0b
RSP: 0018:ff3df6c8f7207818 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ff30d89f94808a80 RCX: 0000000000000027
RDX: 0000000000000000 RSI: 0000000000000002 RDI: ff30d94bdcca2908
RBP: 0000000000080000 R08: ffffffff98ed11a0 R09: ff3df6c8f72077a0
R10: dead000000000100 R11: 000000000000000a R12: 0000000000000000
R13: 0000000000002000 R14: 0000000000040000 R15: ff30d89f94800000
FS:  00007fe6d8432b80(0000) GS:ff30d94bdcc80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe6d81a89b1 CR3: 00000b3b6d578001 CR4: 0000000000371ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mana_destroy_rxq+0x5b/0x2f0 [mana 267acf7006bcb696095bba4d810643d1db3b9e94]
 mana_create_rxq.isra.55+0x3db/0x720 [mana 267acf7006bcb696095bba4d810643d1db3b9e94]
 ? simple_lookup+0x36/0x50
 ? current_time+0x42/0x80
 ? __d_free_external+0x30/0x30
 mana_alloc_queues+0x32a/0x470 [mana 267acf7006bcb696095bba4d810643d1db3b9e94]
 ? _raw_spin_unlock+0xa/0x30
 ? d_instantiate.part.29+0x2e/0x40
 ? _raw_spin_unlock+0xa/0x30
 ? debugfs_create_dir+0xe4/0x140
 mana_attach+0x5c/0xf0 [mana 267acf7006bcb696095bba4d810643d1db3b9e94]
 mana_set_ringparam+0xd5/0x1a0 [mana 267acf7006bcb696095bba4d810643d1db3b9e94]
 ethnl_set_rings+0x292/0x320
 genl_family_rcv_msg_doit.isra.15+0x11b/0x150
 genl_rcv_msg+0xe3/0x1e0
 ? rings_prepare_data+0x80/0x80
 ? genl_family_rcv_msg_doit.isra.15+0x150/0x150
 netlink_rcv_skb+0x50/0x100
 genl_rcv+0x24/0x40
 netlink_unicast+0x1b6/0x280
 netlink_sendmsg+0x365/0x4d0
 sock_sendmsg+0x5f/0x70
 __sys_sendto+0x112/0x140
 __x64_sys_sendto+0x24/0x30
 do_syscall_64+0x5b/0x80
 ? handle_mm_fault+0xd7/0x290
 ? do_user_addr_fault+0x2d8/0x740
 ? exc_page_fault+0x67/0x150
 entry_SYSCALL_64_after_hwframe+0x6b/0xd5
RIP: 0033:0x7fe6d8122f06
Code: 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 72 f3 c3 41 57 41 56 4d 89 c7 41 55 41 54 41
RSP: 002b:00007fff2b66b068 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 000055771123d2a0 RCX: 00007fe6d8122f06
RDX: 0000000000000034 RSI: 000055771123d3b0 RDI: 0000000000000003
RBP: 00007fff2b66b100 R08: 00007fe6d8203360 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000246 R12: 000055771123d350
R13: 000055771123d340 R14: 0000000000000000 R15: 00007fff2b66b2b0
 </TASK>

Guard the xdp_rxq_info_unreg() call with xdp_rxq_info_is_reg() so that
mana_destroy_rxq() is safe to call regardless of how far initialization
progressed.

Fixes: ed5356b53f07 ("net: mana: Add XDP support")
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index a654b3699c4c..dfb4ba9f7664 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2520,7 +2520,9 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 		napi_disable_locked(napi);
 		netif_napi_del_locked(napi);
 	}
-	xdp_rxq_info_unreg(&rxq->xdp_rxq);
+
+	if (xdp_rxq_info_is_reg(&rxq->xdp_rxq))
+		xdp_rxq_info_unreg(&rxq->xdp_rxq);
 
 	mana_destroy_wq_obj(apc, GDMA_RQ, rxq->rxobj);
 
-- 
2.43.0


