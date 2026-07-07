Return-Path: <linux-hyperv+bounces-11854-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b1M2J2lYTWqwygEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11854-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Jul 2026 21:50:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A008D71F63F
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Jul 2026 21:50:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=P2lstC0n;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11854-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11854-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7267F301A37E
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jul 2026 19:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB174387346;
	Tue,  7 Jul 2026 19:47:47 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771FC3B9618
	for <linux-hyperv@vger.kernel.org>; Tue,  7 Jul 2026 19:47:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453667; cv=none; b=A++SqELg6CYexDLfBAOvNzbr5wIHkz26pf3xqy55FfVFbm31+e2/ck2nfpe6oXrjD+HZOE9Mr9LfNeogo6uyjWQ+ucwRX6GkC08LIuHGag/cbg3NEAWZKIdytp82spsjKiWzuexgQ+aIMETtk1VpSWtYH8z4i1P/kTyyo2iJQ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453667; c=relaxed/simple;
	bh=Jv1y8m8D6x2KYmcmzXGqhn/fhSnu37R26ZRIePclFU0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZbXjdwUr+XvsYasWGEqMpI8HvYTxAIiI5+qSBYGqqDz5qxRh6r9FggPwrWUWYiJhFrSF9S8YuTY0HHMKuBk/Q+0hOAxvDwraVeN3u7/di3TrMz+4+dPYSSe4LaOyKXzMoCwGk85HpK+bh3FGOgYEZmM0kx1/8wLBz31R76FEnrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2lstC0n; arc=none smtp.client-ip=209.85.210.171
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-847d1e9db22so5061430b3a.2
        for <linux-hyperv@vger.kernel.org>; Tue, 07 Jul 2026 12:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783453666; x=1784058466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CyXJGY0usHae+LXmamNtPRV/qmWOdkzAleKaxE3NMCI=;
        b=P2lstC0npA4x5UUpkz5rt0EviBkV+UCDuKsg/eu0vqeo6e5gCXc3tYpHWNP3MC8u0Z
         CG0AebqOS5Tw0VXyXK7D8QxkU/69nBjX1+nyiMqwYk8E//niBEvV+zdefSr7dpYa4Lr/
         vOXtsAXWxisSJWizsfpTIf9JQTpVJ27ghFB7+4M5w9sxbyGcdOQ9XxPES0ghgKyic04+
         gz/E50TxBJs2VbdaijLWnw+cBQi9xclObLVAUAhbTef0opcR48Y8Afe5ILfX0X8JS85L
         MBKtsEk3ayzwcgZMzp8fwGpGkcrqPtoCb2GoXWx5jWVrFVCOClzpQP9eGVJ+vJ6I5R21
         RyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783453666; x=1784058466;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CyXJGY0usHae+LXmamNtPRV/qmWOdkzAleKaxE3NMCI=;
        b=Sr9gAtVzSx9QpWdJMMICRuLPaXpoEJgRPYwFELvDBCafapICGJu4nABdvUd6hs2kwq
         q9HoHpcqb3xxG7o5/rF+DO2a6CEqrKFomRuEtEWx1AYz1730QZhx0EEfPyr2Plc7FujW
         Kr4d6TP8HuCgC4UJoggvyyQgjbOPOpKqDdf4OKPL94fhA3cZgw38SvcuqNazA3PKEAfB
         D6kECsYikNQtGU0JV2VwEYc3T5maTG0wql35zAr8Q8bfFztBo9Jj2NjZRKNT7BdwN4w9
         d4XKmqq+tXzrVHcQUvwH0IAPDQzeoFsiu0R1IDrGMfkMMbqiaS2Dh5WXwXl7gRIs8h0a
         IZrA==
X-Forwarded-Encrypted: i=1; AHgh+RpVeOHoU0x3ghPP8MzV5yzVMhKoMG0bbZjXk6qJ4D8XWSUrU17Yx8u4VuzkkkhvumJNvIC1NthRvC6/1t8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxok8q6RXHddexCwJzx5Gvd2ZMx6cRPmGF6U76eEmqMHAD1laOn
	47X3hW7swj06Zz+nmR7LlY2YhhD9FeXbahpgrsY7QnrBdYjX5kT8vhrP
X-Gm-Gg: AfdE7cndCGFQKeNH0etgDfCzBAUcYwhwG+sDj7gNqSMfEBWjN+urlgZid/OJnhD8UDe
	YwpFurkj9/cM4jtCa1wjVjwQWZCIZukSH+jeeLWBac6+ORLxNflPPdlxy8q0sP1AySF/fLBoNVZ
	HTd38Y/7F4C9YnewAmfDU0U0KICAldcSrsdmNiLiOXq6Iw1GNhr563sMDwdBsdU7FLcRsCJsCHA
	7jDhftI1NyFYFibMRCRzpWqeHa3WLY9mz6sdo2OUqEOImqQEPlmS8j37F7rDfzjaeVABuZvwBJs
	M84bExXCuInf8WD1NK1TlLUNLIzsy+Tnhpv8ZUvwhyW7mB3gdlyxQZCKAC5LFHjObUBFERQNao1
	xJ8XTOpS4grYTj5DUSmZMof8XzRj19EhKvJxBlgMGmPorhWgdvcEYsOmCiOXMsdJyNtzVdb0RzV
	3lDJwKl7jQBu4SZoE/J4LEIWEDRmO1fnr0ORH5LBI9uTeNtk3JaXrHm3TgJs8=
X-Received: by 2002:a05:6a00:b89:b0:845:cf73:c1d8 with SMTP id d2e1a72fcca58-84826c09c93mr6251882b3a.14.1783453665761;
        Tue, 07 Jul 2026 12:47:45 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8483dc66f2asm280202b3a.24.2026.07.07.12.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 12:47:45 -0700 (PDT)
Subject: [PATCH v7 8/8] drm/gpusvm: Use hmm_range_fault_unlocked_timeout() for
 range faults
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
 corbet@lwn.net, dakr@kernel.org, david@kernel.org, decui@microsoft.com,
 haiyangz@microsoft.com, jgg@ziepe.ca, kees@kernel.org, kys@microsoft.com,
 leon@kernel.org, liam@infradead.org, lizhi.hou@amd.com, ljs@kernel.org,
 longli@microsoft.com, lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, skinsburskii@gmail.com, surenb@google.com,
 tzimmermann@suse.de, vbabka@kernel.org, wei.liu@kernel.org,
 skinsburskii@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Date: Tue, 07 Jul 2026 12:47:43 -0700
Message-ID: <178345366389.660027.12986386801605494596.stgit@skinsburskii>
In-Reply-To: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11854-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ee.iitb.ac.in,linux-foundation.org,lwn.net,kernel.org,microsoft.com,ziepe.ca,infradead.org,amd.com,redhat.com,linux.intel.com,suse.com,lists.freedesktop.org,ffwll.ch,linuxfoundation.org,google.com,suse.de];
	FORGED_SENDER(0.00)[skinsburskii@gmail.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[41];
	FORGED_RECIPIENTS(0.00)[m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:akpm@linux-foundation.org,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:jgg@ziepe.ca,m:kees@kernel.org,m:kys@microsoft.com,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:longli@microsoft.com,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:skinsburskii@gmail.com,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:wei.liu@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@gmail.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A008D71F63F

Several GPU SVM paths take mmap_read_lock() only to call hmm_range_fault(),
then retry -EBUSY until HMM_RANGE_DEFAULT_TIMEOUT expires. Those paths use
MMU interval notifiers whose mm matches the mm that was locked for the HMM
fault.

Use hmm_range_fault_unlocked_timeout() for those faults and pass the
remaining retry budget to HMM. The helper owns mmap_lock acquisition and
refreshes range->notifier_seq internally for each retry, while GPU SVM
keeps its existing driver-lock validation with mmu_interval_read_retry()
after a successful fault.

Leave drm_gpusvm_check_pages() on hmm_range_fault() because that path is
called with the mmap lock already held by its caller.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 drivers/gpu/drm/drm_gpusvm.c |   52 ++++++------------------------------------
 1 file changed, 7 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 958cb605aedd..2601b793428c 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -788,22 +788,8 @@ enum drm_gpusvm_scan_result drm_gpusvm_scan_mm(struct drm_gpusvm_range *range,
 	hmm_range.hmm_pfns = pfns;
 
 retry:
-	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
-	mmap_read_lock(range->gpusvm->mm);
-
-	while (true) {
-		err = hmm_range_fault(&hmm_range);
-		if (err == -EBUSY) {
-			if (time_after(jiffies, timeout))
-				break;
-
-			hmm_range.notifier_seq =
-				mmu_interval_read_begin(notifier);
-			continue;
-		}
-		break;
-	}
-	mmap_read_unlock(range->gpusvm->mm);
+	err = hmm_range_fault_unlocked_timeout(&hmm_range,
+				max_t(long, timeout - jiffies, 1));
 	if (err)
 		goto err_free;
 
@@ -1439,21 +1425,8 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	}
 
 	hmm_range.hmm_pfns = pfns;
-	while (true) {
-		mmap_read_lock(mm);
-		err = hmm_range_fault(&hmm_range);
-		mmap_read_unlock(mm);
-
-		if (err == -EBUSY) {
-			if (time_after(jiffies, timeout))
-				break;
-
-			hmm_range.notifier_seq =
-				mmu_interval_read_begin(notifier);
-			continue;
-		}
-		break;
-	}
+	err = hmm_range_fault_unlocked_timeout(&hmm_range,
+				max_t(long, timeout - jiffies, 1));
 	mmput(mm);
 	if (err)
 		goto err_free;
@@ -1736,24 +1709,13 @@ int drm_gpusvm_range_evict(struct drm_gpusvm *gpusvm,
 		return -ENOMEM;
 
 	hmm_range.hmm_pfns = pfns;
-	while (!time_after(jiffies, timeout)) {
-		hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
-		if (time_after(jiffies, timeout)) {
-			err = -ETIME;
-			break;
-		}
-
-		mmap_read_lock(mm);
-		err = hmm_range_fault(&hmm_range);
-		mmap_read_unlock(mm);
-		if (err != -EBUSY)
-			break;
-	}
+	err = hmm_range_fault_unlocked_timeout(&hmm_range,
+				max_t(long, timeout - jiffies, 1));
 
 	kvfree(pfns);
 	mmput(mm);
 
-	return err;
+	return err == -EBUSY ? -ETIME : err;
 }
 EXPORT_SYMBOL_GPL(drm_gpusvm_range_evict);
 



