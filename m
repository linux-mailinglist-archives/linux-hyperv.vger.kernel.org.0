Return-Path: <linux-hyperv+bounces-4660-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A3FA6BD1F
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Mar 2025 15:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA1AF7A97BA
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Mar 2025 14:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B681DED49;
	Fri, 21 Mar 2025 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DKE3+r+4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27A71D61BC
	for <linux-hyperv@vger.kernel.org>; Fri, 21 Mar 2025 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567757; cv=none; b=i5c3/6LWRTGSOfVOuPX6gv0e0vHGWSzjyaIBeqxmcfzUUVQMO1l3rtuIyQOH5pj24v5LDylPizsPnDFzNww4Gm+ylRGBL3cUhGQv8xXho3MlV+42P0jAdfigRcw0rUy0u48HSjqY/JaRBIW9GXCiVum5SNgQnIRD5YKoTcjGD/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567757; c=relaxed/simple;
	bh=zewkcsreTAIYS7PHyX+Qg+PK84VPiklh12ShuEBHSeo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OMRGXHvwn6HtyDIeILDMo0sI9aIpxe4eYSBF4zgC0jCWoWmf3PwY9DrFjnCwTefaY3gwyrm0qRAnYEZtRUUJQ2J8woWrEIJ28PraM8blUFxeyZuS81zmx1BnhC1QAsT+LVsfgsIV9KcTSnkf9G2WC0Jfwj1n5+zmL4uVqcSb8y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DKE3+r+4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43690d4605dso14138045e9.0
        for <linux-hyperv@vger.kernel.org>; Fri, 21 Mar 2025 07:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567754; x=1743172554; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jhrcb/mTWviEZZ7YzcelEEpsaZNAgBebPczHwX9f7os=;
        b=DKE3+r+4X2pN1mTf4btc6K08Jo6IBxqc3fpE8DwsT/Yjhj56lj0mnxHHQl6Pql8O2H
         1q0hy80hyInP532X4gjbVhyvUkdfJFyovESh5SvYvpkblbmYJVeH/+txxwsXqFo5k1Xo
         54oEdae/1/htQzyra5WMWQTvYh1qsbXdE/5f/fQ6yhpPUmgT0opOdP93vc8f2uCbAje+
         fbmzhJ+nOr+SdF2tH/jkM4T81ErOGYcDZlK9rhChgsAFXXUQ20hTj+0t1I9CVHa/uxl4
         5AeezBxjoke9jayxqCawXNiKDp5/T3P0Texjic96WmjmmzCG7Rb5aBQHzKe1cp8+iVKw
         5ZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567754; x=1743172554;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jhrcb/mTWviEZZ7YzcelEEpsaZNAgBebPczHwX9f7os=;
        b=SqCGjA6R1EkP1G5YrRa6+LDCiI55poej7BwVfqwKXjPveRplvPOGu65munjiT1Mz94
         HKeXArvZsx9B61ZQd2wAdyKLwuKCXYJInOIVYIeYiro20ifnc3v2rtt+kf6L+WjBhQzr
         YcDgnO+759x0Fhu0aQ/2rvVl4knnjgiLzO7eFB+x4YbJU9tMTU10nTOin523UiZJ8RC1
         YIvaQ31Gr1x6DBXsF2Ut3L1EP4B2fFrfv6yXZ5Ey96SUt7Ihn46AVElGl+G6g2WwiF+9
         e7NWHZXiEpBXBU5Pmdo/VOv7FrQZVOoX7UaNPkWSryYa+z82U0dfEnNgr4ZvYgntSSGz
         HMDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0UfXWvKStEMlLRIxxAj2uG5Z3pf1QMZGE23VkNof/eYghatUVlS7JXEZ8blGCJOgDaqzcG+TNKUUkQ+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3r2ShBDWDkh+7SA9YhoJ3p5D36144E/Z67NQ2xrcMhgHj5rs2
	S4Tm7voF+Ajb23omWruSgIoMUqatwa2QypCJpBRJvK7m23vsq/wp9KvX36d4JrE=
X-Gm-Gg: ASbGnctLV2UA5C0GmcD/Miu2nOun8zOgGnpBjznygnIv4M2WA6n4scqU41pWMn31ux0
	MdkQ0bqiW3glS8nLXtKJ807JET4XwPbrq+rzNizAVGD8QEwYpnepW5TqCi4PYxDvtrvT3UaRhl9
	zx3NzBD0tVhqiVhisphr94YWypTviRoW2GX2ggmz64E9lhG9K+TzGcnNjY2l7xabPQrn7vDrsqw
	nk/32WRqkP44clrwQ6xe008i+A9anxnzKjisNivi1TwyqL65gz1gJf0U2mRYjp520uK885t0wJS
	9MQeDAiXB7x9cZXH90xQLH0fxYj0S4ByyVr13J7Esayq8gWNY8HopWG3JmWF
X-Google-Smtp-Source: AGHT+IFTlIYuugJCayoKps7oOfO+nEY2lgoAtdOqm9RkYPvK6VO/88fiHmYrMJaHHiCsISy8+YmeUg==
X-Received: by 2002:a05:600c:1548:b0:43c:f513:958a with SMTP id 5b1f17b1804b1-43d509f4d23mr32282675e9.13.1742567753912;
        Fri, 21 Mar 2025 07:35:53 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d43f43ed6sm79077865e9.13.2025.03.21.07.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:35:53 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:35:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] Drivers: hv: mshv: Prevent potential NULL dereference
Message-ID: <9fee7658-1981-48b1-b909-fb2b78894077@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Move the NULL check on "partition" before the dereference.

Fixes: f5288d14069b ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/hv/mshv_synic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index a3daedd680ff..88949beb5e37 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -151,13 +151,12 @@ static bool mshv_async_call_completion_isr(struct hv_message *msg)
 	rcu_read_lock();
 
 	partition = mshv_partition_find(partition_id);
-	partition->async_hypercall_status = async_msg->status;
-
 	if (unlikely(!partition)) {
 		pr_debug("failed to find partition %llu\n", partition_id);
 		goto unlock_out;
 	}
 
+	partition->async_hypercall_status = async_msg->status;
 	complete(&partition->async_hypercall);
 
 	handled = true;
-- 
2.47.2


