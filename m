Return-Path: <linux-hyperv+bounces-8973-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGDhJObWnWk0SQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8973-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 17:50:46 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B5C18A109
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 17:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B34030783D9
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 16:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5D23A963A;
	Tue, 24 Feb 2026 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NfdNWTgd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0593A9608;
	Tue, 24 Feb 2026 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771951689; cv=none; b=ZFNlQTMGIo3NP5neFFkqR6+fyoSzLyKPzjJsUHWeKTcsruVR3GR8bFsXMDYG64g/B63YaxFydI+nlhAorxnRY/Yv4p2gAVVzQgbnRLjHa9Qfcyq3LU3wwDGpY9rOlypjUNHFDum4dS3YJQXVCniYUV/hF1uDEn5T2Uwc0LSCaYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771951689; c=relaxed/simple;
	bh=Km7QkPtERY4epjZbg1vsK01k19uyb1rrFrZwY6IhXtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CoAM05BOs0t8TIcqSF5jEvBbydkBOdLFDkJr22m11aBPF0QBfYa9jYkjmh1DwhjOg/WNzjXdiW/wz5Kua/1TMe3wv64jRqEzCICHGfCcEEI5jXKRsZOLf9Wp0GnvCU7T1DDf9ICktIR5VVtJMzXfRWATsfEmKp/0uwuyj5rsxdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NfdNWTgd; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OEMsNB4097467;
	Tue, 24 Feb 2026 16:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=M0JFcjHxAD5akGRsgzhTJgIJz9EnGFa8rf/jMw3K4Rk=; b=
	NfdNWTgd/yWrB1MlWLv2wc2TEIyf2SGTHb8vRXJQpjVz3vgNbQ6KzMVwosfTaeWT
	a4oNCY/3ee0/ieWrHLMLO91MOBJCVV12lU+qHujRyubbaR9LECJvJOxO/J8FCk3v
	56WLRj31KS/PFoDwvQrk6LBFzSG+lAejnYaS19bNBrivWL6sXtbW838dPEPOX3Q/
	2afU7xWWOwU+g2tpdNie3qgKR2E1xHEaaee2WkHIMqSXKA2dtQaxFVHCwNiXdcZ5
	wR0pvnUMv09iiexjfDrzVyjg0FYOIStYTH5BCfde/Ej+hOkxnbco5kAZEU8E9MZ9
	2ai69meCcuHzA50t+4+LMg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4k5vhh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 16:47:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61OFeBU3015577;
	Tue, 24 Feb 2026 16:47:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35a6kn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 16:47:58 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61OGlt4h012936;
	Tue, 24 Feb 2026 16:47:58 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cf35a6kjb-3;
	Tue, 24 Feb 2026 16:47:58 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-hyperv@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Bezdeka <florian.bezdeka@siemens.com>,
        RT <linux-rt-users@vger.kernel.org>,
        Mitchell Levy <levymitchell0@gmail.com>
Subject: Re: [PATCH] scsi: storvsc: Fix scheduling while atomic on PREEMPT_RT
Date: Tue, 24 Feb 2026 11:47:42 -0500
Message-ID: <177195161164.1154639.10246495163151300179.b4-ty@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <0c7fb5cd-fb21-4760-8593-e04bade84744@siemens.com>
References: <0c7fb5cd-fb21-4760-8593-e04bade84744@siemens.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602240139
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDEzOSBTYWx0ZWRfX7f0z1vOaXp0o
 W3bxmk36ZKTRpJeyMLWUru2PJ6StauwHHIeVWyUO1wydzrqLyWKHxbPe6tq/dVBrZsOWeZSWw0w
 6z9NIeEr2dBYI0ooxmwdH57o7WgihjV6FI7v7oE7CJycBqUyAXPod7w/39ea14II6LGvkk23tC+
 GCYQvK4c3MMIGA7kpO9i8ga96HICmbUIC2tUsjLG20shKfQ1E4dhfQ5ICIIzXPQS9y9cuq7ym4Y
 Wz7xt7Y0dgQ94kPF8bNI5tGEbRic2QVz/od7frXUy/zzlNTjDXRof/QMaXrxXFAlquAx+5wV3/z
 gJYVyv8Jl6K5xbP0WZ/r0yemJyoiwXeEDIJEL+79L0TNo+af4RigKi1Apzo+WuoKrzlZInsP6XH
 j/6y8PGn6PMyAHGERRbnArsbZVrslH7ioM6LrAbZPqbrI/r3ALICdHnZFmsUfvGJmylWY9Hnwcr
 TC8tsgybLl9WvhtbTKQ==
X-Proofpoint-GUID: cB_m9Oi4IYJcIV1-XuyNVHya0Dso12ru
X-Authority-Analysis: v=2.4 cv=b9C/I9Gx c=1 sm=1 tr=0 ts=699dd63f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=H9g4kcow5iyJM_3d0YAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: cB_m9Oi4IYJcIV1-XuyNVHya0Dso12ru
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,siemens.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-8973-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 44B5C18A109
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 15:30:39 +0100, Jan Kiszka wrote:

> This resolves the follow splat and lock-up when running with PREEMPT_RT
> enabled on Hyper-V:
> 
> [  415.140818] BUG: scheduling while atomic: stress-ng-iomix/1048/0x00000002
> [  415.140822] INFO: lockdep is turned off.
> [  415.140823] Modules linked in: intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_core pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vsec ghash_clmulni_intel aesni_intel rapl binfmt_misc nls_ascii nls_cp437 vfat fat snd_pcm hyperv_drm snd_timer drm_client_lib drm_shmem_helper snd sg soundcore drm_kms_helper pcspkr hv_balloon hv_utils evdev joydev drm configfs efi_pstore nfnetlink vsock_loopback vmw_vsock_virtio_transport_common hv_sock vmw_vsock_vmci_transport vsock vmw_vmci efivarfs autofs4 ext4 crc16 mbcache jbd2 sr_mod sd_mod cdrom hv_storvsc serio_raw hid_generic scsi_transport_fc hid_hyperv scsi_mod hid hv_netvsc hyperv_keyboard scsi_common
> [  415.140846] Preemption disabled at:
> [  415.140847] [<ffffffffc0656171>] storvsc_queuecommand+0x2e1/0xbe0 [hv_storvsc]
> [  415.140854] CPU: 8 UID: 0 PID: 1048 Comm: stress-ng-iomix Not tainted 6.19.0-rc7 #30 PREEMPT_{RT,(full)}
> [  415.140856] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 09/04/2024
> [  415.140857] Call Trace:
> [  415.140861]  <TASK>
> [  415.140861]  ? storvsc_queuecommand+0x2e1/0xbe0 [hv_storvsc]
> [  415.140863]  dump_stack_lvl+0x91/0xb0
> [  415.140870]  __schedule_bug+0x9c/0xc0
> [  415.140875]  __schedule+0xdf6/0x1300
> [  415.140877]  ? rtlock_slowlock_locked+0x56c/0x1980
> [  415.140879]  ? rcu_is_watching+0x12/0x60
> [  415.140883]  schedule_rtlock+0x21/0x40
> [  415.140885]  rtlock_slowlock_locked+0x502/0x1980
> [  415.140891]  rt_spin_lock+0x89/0x1e0
> [  415.140893]  hv_ringbuffer_write+0x87/0x2a0
> [  415.140899]  vmbus_sendpacket_mpb_desc+0xb6/0xe0
> [  415.140900]  ? rcu_is_watching+0x12/0x60
> [  415.140902]  storvsc_queuecommand+0x669/0xbe0 [hv_storvsc]
> [  415.140904]  ? HARDIRQ_verbose+0x10/0x10
> [  415.140908]  ? __rq_qos_issue+0x28/0x40
> [  415.140911]  scsi_queue_rq+0x760/0xd80 [scsi_mod]
> [  415.140926]  __blk_mq_issue_directly+0x4a/0xc0
> [  415.140928]  blk_mq_issue_direct+0x87/0x2b0
> [  415.140931]  blk_mq_dispatch_queue_requests+0x120/0x440
> [  415.140933]  blk_mq_flush_plug_list+0x7a/0x1a0
> [  415.140935]  __blk_flush_plug+0xf4/0x150
> [  415.140940]  __submit_bio+0x2b2/0x5c0
> [  415.140944]  ? submit_bio_noacct_nocheck+0x272/0x360
> [  415.140946]  submit_bio_noacct_nocheck+0x272/0x360
> [  415.140951]  ext4_read_bh_lock+0x3e/0x60 [ext4]
> [  415.140995]  ext4_block_write_begin+0x396/0x650 [ext4]
> [  415.141018]  ? __pfx_ext4_da_get_block_prep+0x10/0x10 [ext4]
> [  415.141038]  ext4_da_write_begin+0x1c4/0x350 [ext4]
> [  415.141060]  generic_perform_write+0x14e/0x2c0
> [  415.141065]  ext4_buffered_write_iter+0x6b/0x120 [ext4]
> [  415.141083]  vfs_write+0x2ca/0x570
> [  415.141087]  ksys_write+0x76/0xf0
> [  415.141089]  do_syscall_64+0x99/0x1490
> [  415.141093]  ? rcu_is_watching+0x12/0x60
> [  415.141095]  ? finish_task_switch.isra.0+0xdf/0x3d0
> [  415.141097]  ? rcu_is_watching+0x12/0x60
> [  415.141098]  ? lock_release+0x1f0/0x2a0
> [  415.141100]  ? rcu_is_watching+0x12/0x60
> [  415.141101]  ? finish_task_switch.isra.0+0xe4/0x3d0
> [  415.141103]  ? rcu_is_watching+0x12/0x60
> [  415.141104]  ? __schedule+0xb34/0x1300
> [  415.141106]  ? hrtimer_try_to_cancel+0x1d/0x170
> [  415.141109]  ? do_nanosleep+0x8b/0x160
> [  415.141111]  ? hrtimer_nanosleep+0x89/0x100
> [  415.141114]  ? __pfx_hrtimer_wakeup+0x10/0x10
> [  415.141116]  ? xfd_validate_state+0x26/0x90
> [  415.141118]  ? rcu_is_watching+0x12/0x60
> [  415.141120]  ? do_syscall_64+0x1e0/0x1490
> [  415.141121]  ? do_syscall_64+0x1e0/0x1490
> [  415.141123]  ? rcu_is_watching+0x12/0x60
> [  415.141124]  ? do_syscall_64+0x1e0/0x1490
> [  415.141125]  ? do_syscall_64+0x1e0/0x1490
> [  415.141127]  ? irqentry_exit+0x140/0x7e0
> [  415.141129]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> [...]

Applied to 7.0/scsi-fixes, thanks!

[1/1] scsi: storvsc: Fix scheduling while atomic on PREEMPT_RT
      https://git.kernel.org/mkp/scsi/c/57297736c082

-- 
Martin K. Petersen

