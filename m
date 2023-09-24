Return-Path: <linux-hyperv+bounces-264-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A7C7AC6AF
	for <lists+linux-hyperv@lfdr.de>; Sun, 24 Sep 2023 07:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 17D081C2029D
	for <lists+linux-hyperv@lfdr.de>; Sun, 24 Sep 2023 05:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925267FE;
	Sun, 24 Sep 2023 05:51:59 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6501C653
	for <linux-hyperv@vger.kernel.org>; Sun, 24 Sep 2023 05:51:58 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E24EE;
	Sat, 23 Sep 2023 22:51:56 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68cc1b70e05so1124857b3a.1;
        Sat, 23 Sep 2023 22:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695534716; x=1696139516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dcQLWA0BLZ69vvjFwwdHdjp5Y4U2eIKLK0g6iLOyzUg=;
        b=LmSboI+mUoRsji3R7nYbEVVtz1EzZe4k5BcPC5pbKQD7dX/3gXnpbxH+WQFpQutUxH
         lMLALthUyTSegpQSykClv4jKa3XW05V1SPmJ0wKx78aPt0Y0QvdXUbNhui7eyBeHMytv
         C/SVtrgdc4VF/+7A3aN9rCTNLrulDIDOOc5TLziGxw1UIea9Hr9SMyVvmc3iuEQUptmP
         Jov7kwtUtS2l1Zzc9nLnwutg+IVCvIIoFUzeG2Btdm3AFqvbjw9TaWLz5Iptndtx1fqS
         FQsCJb4FoyzwLKeU/eLdTfLUmNRfdGbrYGqsilvQWjMER5h4+SJoNWddWcRR+s5JRKgv
         aBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695534716; x=1696139516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcQLWA0BLZ69vvjFwwdHdjp5Y4U2eIKLK0g6iLOyzUg=;
        b=pE0Klr5Rp+dC3cA94dx/CNmDow0vDV26cpf9g1HqbQOPQjQkJVV+s4+3R7xNxPIegC
         WJuoy7A0YGzVt1gHeSKTsIZcDpBurgmX1/FyDadJJdDGersku6zbZM+sCRx78v/gdOIq
         v90pXHY91W1t8bULivlzGtj5RmiJdBvqm1DlSZnh1ghMqiYC0b2ERekGEbibB6XYY6Rp
         6i3qu8Kp1X+idwQIxLaJUb3wC6PWa69JuU3EwYMpHisWqwycSQrCHHFcyKMf8mSOhkI4
         1PeWhtubgdWlSxK8TWz/K5EZnBHUkzFWb+eteaV6cGslurYePYaWM1KhTwru7NZEC2Ff
         XUlA==
X-Gm-Message-State: AOJu0YwEt0uetRge2uQMGXJxkmhV6NOH3Rt0O7GfqDnEBMnQFHlIPaoy
	KATx9AGyg+/nnzgeng1rFFvGysmluhchaoRn
X-Google-Smtp-Source: AGHT+IE6vrHER9qQ209eSz94gIe9HRHPjnd6dFrGsH9Qi992yiW8q62Sd6KKalioKSyhUx4nP9EMTA==
X-Received: by 2002:a05:6a21:33a7:b0:13d:7aa3:aa6c with SMTP id yy39-20020a056a2133a700b0013d7aa3aa6cmr6059301pzb.0.1695534715472;
        Sat, 23 Sep 2023 22:51:55 -0700 (PDT)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id q9-20020a639809000000b00573f82bb00esm5649060pgd.2.2023.09.23.22.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 22:51:54 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: kys@microsoft.com
Cc: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] tools: hv: kvp: fix memory leak in realloc failure handling
Date: Sun, 24 Sep 2023 13:51:48 +0800
Message-Id: <20230924055148.1074754-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In the previous code, there was a memory leak issue where the
previously allocated memory was not freed upon a failed realloc
operation. This patch addresses the problem by releasing the old memory
before setting the pointer to NULL in case of a realloc failure. This
ensures that memory is properly managed and avoids potential memory
leaks.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 tools/hv/hv_kvp_daemon.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 27f5e7dfc2f7..af180278d56d 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -209,11 +209,13 @@ static void kvp_update_mem_state(int pool)
 			 * We have more data to read.
 			 */
 			num_blocks++;
-			record = realloc(record, alloc_unit * num_blocks);
+			struct kvp_record *record_tmp =
+				realloc(record, alloc_unit * num_blocks);
 
-			if (record == NULL) {
+			if (record_tmp == NULL) {
 				syslog(LOG_ERR, "malloc failed");
 				kvp_release_lock(pool);
+				free(record);
 				exit(EXIT_FAILURE);
 			}
 			continue;
@@ -345,11 +347,15 @@ static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
 	 */
 	if (num_records == (ENTRIES_PER_BLOCK * num_blocks)) {
 		/* Need to allocate a larger array for reg entries. */
-		record = realloc(record, sizeof(struct kvp_record) *
-			 ENTRIES_PER_BLOCK * (num_blocks + 1));
+		struct kvp_record *record_tmp = realloc(
+			record, sizeof(struct kvp_record) * ENTRIES_PER_BLOCK *
+					(num_blocks + 1));
 
-		if (record == NULL)
+		if (record_tmp == NULL) {
+			free(record);
 			return 1;
+		}
+		record = record_tmp;
 		kvp_file_info[pool].num_blocks++;
 
 	}
-- 
2.25.1


