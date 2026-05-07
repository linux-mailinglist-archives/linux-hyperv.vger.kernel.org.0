Return-Path: <linux-hyperv+bounces-10691-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COgyMjK1/Gm0SwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10691-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 17:52:18 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2CA4EB70D
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 17:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0259A3068EDE
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2026 15:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE0944D014;
	Thu,  7 May 2026 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="s5iYtOor"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C588144CAD4;
	Thu,  7 May 2026 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168673; cv=none; b=qLd/NHT/GQpK+U/KRfGn4PEDZVwhez7GBaN9kcWug73ap/8c9Y5W/X1PYybzXQtZyQSuif2ctAP1V4QFDN+cqeNoQSxZSwQGFIh1aztLNZ1uBZswgWhMGjDLVXNYRfkYu18iJNDBiNixPEg6BngS4KCbmyVz/uc81biXPBykpnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168673; c=relaxed/simple;
	bh=VAVzbZIz6Y7AOmDzfVHXFJ8OXZuw2H2QTFGffhA5alg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUI8q273rFBz0t7oITvXnZTcYegKrmmgc2PN54X5/YWDzOD6wQoWv5Ui8QQDVHWw17DeoUkGQH5yFVGylZEM68PkmTuURySgLN1fbRWf1ts9MLQwIAmQKrMwc5RjsAyHJpHl3hrgvOqCR4ltRpfGjRoMHByk47tYPBk236kU41g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=s5iYtOor; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5A93520B7167;
	Thu,  7 May 2026 08:44:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5A93520B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778168669;
	bh=88cu6iwdTkggh0rypSOpeLqSwCzJ4gXO5/LWuaUpOD8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=s5iYtOorutVI7Ob3xFy1s9psf7n6NSuEq+iIDiuuFnB50EB6V5Lvd1SXGSRXYyOkd
	 lCz/DLP0uMDbFumgjfy9sFM1vlsgq4Eqd9bJUWFybIzGgfEZL+yCbvcR72i3eRjeJz
	 dS54hQDdBTqln5qw6I6OvB00cpjs4cEIRWkl4pac=
Subject: [PATCH v4 17/18] mshv: Publish VP to pt_vp_array before installing
 the file descriptor
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 07 May 2026 15:44:32 +0000
Message-ID: 
 <177816867231.21765.15171005242069873878.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2B2CA4EB70D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-10691-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii-cloud-desktop.internal.cloudapp.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Action: no action

mshv_partition_ioctl_create_vp() called anon_inode_getfd() before
publishing the new VP into partition->pt_vp_array.  anon_inode_getfd()
includes fd_install(), so the fd was live in current->files before the
publish ran.

A concurrent MSHV_RUN_VP ioctl on that fd does not serialise against the
in-progress MSHV_CREATE_VP — it takes vp->vp_mutex, not the partition
mutex.  Once the VP starts running and traps, mshv_intercept_isr() can look
up partition->pt_vp_array[vp_index] and observe NULL, silently dropping the
intercept message.

Split the fd creation: reserve an fd with get_unused_fd_flags(), create the
file with anon_inode_getfile(), publish the VP via smp_store_release(), and
finally call fd_install() as the userspace-visibility commit point.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c |   29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index e32f6e0f9f637..1c18d1c1f7947 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1142,6 +1142,8 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	struct mshv_vp *vp;
 	struct page *intercept_msg_page, *register_page, *ghcb_page;
 	struct hv_stats_page *stats_pages[2];
+	struct file *file;
+	int fd;
 	long ret;
 
 	if (copy_from_user(&args, arg, sizeof(args)))
@@ -1214,14 +1216,18 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	if (ret)
 		goto put_partition;
 
-	/*
-	 * Keep anon_inode_getfd last: it installs fd in the file struct and
-	 * thus makes the state accessible in user space.
-	 */
-	ret = anon_inode_getfd("mshv_vp", &mshv_vp_fops, vp,
-			       O_RDWR | O_CLOEXEC);
-	if (ret < 0)
+	fd = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
+	if (fd < 0) {
+		ret = fd;
 		goto remove_debugfs_vp;
+	}
+
+	file = anon_inode_getfile("mshv_vp", &mshv_vp_fops, vp,
+				  O_RDWR | O_CLOEXEC);
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		goto put_unused_vp_fd;
+	}
 
 	/* already exclusive with the partition mutex for all ioctls */
 	partition->pt_vp_count++;
@@ -1233,8 +1239,17 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	 */
 	smp_store_release(&partition->pt_vp_array[args.vp_index], vp);
 
+	/*
+	 * fd_install() is the userspace-visibility commit point.  Must be the
+	 * last operation that can fail or be observed.
+	 */
+	fd_install(fd, file);
+	ret = fd;
+
 	goto out;
 
+put_unused_vp_fd:
+	put_unused_fd(fd);
 remove_debugfs_vp:
 	mshv_debugfs_vp_remove(vp);
 put_partition:



