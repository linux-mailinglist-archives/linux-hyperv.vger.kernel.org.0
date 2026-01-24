Return-Path: <linux-hyperv+bounces-8517-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFxmCKASdWkAAgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8517-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 19:42:40 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 909697E819
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 19:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47B223022561
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 18:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B4422127E;
	Sat, 24 Jan 2026 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qZmQmWqI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C3F3EBF12;
	Sat, 24 Jan 2026 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769280142; cv=none; b=mQa7npc8DGjghjSw8qSC5ktm475FMhJjNWLF7XTGOTBJesh2zXRwXDE8y9vugi+YhJwIwfgy0OfRrhdEvbCUi0gdHXpzOdXCLL+rBcuBWNr39/IFN+9rO8KDEZOvZgVez5tcddCGr0e2jHKduLEWeVwDsjbHUWEQ9gmw25VAzgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769280142; c=relaxed/simple;
	bh=HHYWyV7af3mBJHu5CmA3BGO7cMbnLuB3f6BZQk6Wybc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mn4wi3fHvorlRsrtcs3UNvKQbglqVyTRhmKVsCHYHZoJnciuDsTNVaJjj+8GrKsUSO5lrhxz+uf513tJXST9qn7ZskWyjAU8/qruq9MgnDaBwedDnQ/zKfqpTICKxATUEWVUkZmQNdGyNzCf1kN1tZZ6HD/HqIzsMmT61c6hgHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qZmQmWqI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 82EF620B7167;
	Sat, 24 Jan 2026 10:42:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 82EF620B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769280135;
	bh=34ZaAspxRobJApkIuqW9+l564JDWtw8PAuABg5DZrms=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=qZmQmWqI1yUelAm+uD01ffD6ZgkHdcFCl/gn+kVWPWizvIhyzS9Z1lne82xCVF9au
	 X9arZM8peufiNrvlm+oi0TMEBT5pY6Cr9lOp0nvWSXIc9lPAMoY5vWnjwvXfhU2obJ
	 KhYt7opxKi+56ESXMkNcQGgugASjO6v00slBs7R0=
Subject: [RFC PATCH 1/3] luo: Extract file object logic
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 24 Jan 2026 18:42:15 +0000
Message-ID: 
 <176928013535.26405.5652761027502265757.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <176927917602.26405.4149319776242398706.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <176927917602.26405.4149319776242398706.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-8517-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: 909697E819
X-Rspamd-Action: no action

Split file object related logic out of the liveupdate implementation so it
can be reused by other kernel subsystems.

This is a preparatory change for enabling use of the luo infrastructure
outside of liveupdate. No functional change intended.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 include/linux/liveupdate.h       |    3 ++
 kernel/liveupdate/luo_file.c     |   55 ++++++++++++++++++++++++++++++++------
 kernel/liveupdate/luo_internal.h |    2 +
 kernel/liveupdate/luo_session.c  |    2 +
 4 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index a7f6ee5b6771..0e6e0a1b1489 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -112,6 +112,9 @@ int liveupdate_reboot(void);
 int liveupdate_register_file_handler(struct liveupdate_file_handler *fh);
 int liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh);
 
+int liveupdate_session_create(char *name, struct file **filep);
+void liveupdate_session_destroy(char *name, struct file *file);
+
 #else /* CONFIG_LIVEUPDATE */
 
 static inline bool liveupdate_enabled(void)
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index a32a777f6df8..e46aeb29ab4d 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -250,12 +250,11 @@ static bool luo_token_is_used(struct luo_file_set *file_set, u64 token)
  *         -ENOMEM on memory allocation failure.
  *         Other erros might be returned by .preserve().
  */
-int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
+static int luo_preserve_file(struct luo_file_set *file_set, u64 token, struct file *file)
 {
 	struct liveupdate_file_op_args args = {0};
 	struct liveupdate_file_handler *fh;
 	struct luo_file *luo_file;
-	struct file *file;
 	int err;
 
 	if (luo_token_is_used(file_set, token))
@@ -264,13 +263,9 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 	if (file_set->count == LUO_FILE_MAX)
 		return -ENOSPC;
 
-	file = fget(fd);
-	if (!file)
-		return -EBADF;
-
 	err = luo_alloc_files_mem(file_set);
 	if (err)
-		goto  err_fput;
+		return err;
 
 	err = -ENOENT;
 	luo_list_for_each_private(fh, &luo_file_handler_list, list) {
@@ -313,8 +308,22 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 	kfree(luo_file);
 err_free_files_mem:
 	luo_free_files_mem(file_set);
-err_fput:
-	fput(file);
+
+	return err;
+}
+
+int luo_preserve_fd(struct luo_file_set *file_set, u64 token, int fd)
+{
+	struct file *file;
+	int err;
+
+	file = fget(fd);
+	if (!file)
+		return -EBADF;
+
+	err = luo_preserve_file(file_set, token, file);
+	if (err)
+		fput(file);
 
 	return err;
 }
@@ -861,6 +870,34 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
 	return err;
 }
 
+int liveupdate_session_create(char *name, struct file **filep)
+{
+	struct luo_session *session;
+	int err;
+
+	err = luo_session_create(name, filep);
+	if (err)
+		return err;
+
+	session = (*filep)->private_data;
+
+	/* Not need to guard here, session is not yet visible to others */
+	err = luo_preserve_file(&session->file_set, 0, *filep);
+	if (err)
+		goto err_preserve;
+
+	return 0;
+
+err_preserve:
+	fput(*filep);
+	return err;
+}
+
+void liveupdate_session_destroy(char *name, struct file *file)
+{
+	fput(file);
+}
+
 /**
  * liveupdate_unregister_file_handler - Unregister a liveupdate file handler
  * @fh: The file handler to unregister
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index c8973b543d1d..b14391f1514f 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -93,7 +93,7 @@ int luo_session_deserialize(void);
 bool luo_session_quiesce(void);
 void luo_session_resume(void);
 
-int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd);
+int luo_preserve_fd(struct luo_file_set *file_set, u64 token, int fd);
 void luo_file_unpreserve_files(struct luo_file_set *file_set);
 int luo_file_freeze(struct luo_file_set *file_set,
 		    struct luo_file_set_ser *file_set_ser);
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index dbdbc3bd7929..641186d41a22 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -234,7 +234,7 @@ static int luo_session_preserve_fd(struct luo_session *session,
 	int err;
 
 	guard(mutex)(&session->mutex);
-	err = luo_preserve_file(&session->file_set, argp->token, argp->fd);
+	err = luo_preserve_fd(&session->file_set, argp->token, argp->fd);
 	if (err)
 		return err;
 



