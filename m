Return-Path: <linux-hyperv+bounces-4659-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075BBA6BD17
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Mar 2025 15:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25BEC3B1E01
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Mar 2025 14:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406E41CBEB9;
	Fri, 21 Mar 2025 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IHAc0U9f"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EE21CDFD4
	for <linux-hyperv@vger.kernel.org>; Fri, 21 Mar 2025 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567737; cv=none; b=gcNmLR9vHC6KcpMrGlJV6UayChkS+IhxsCW5S+zO7Q32uZsqHSoo2uGrsxURkmbv5Dfrpim1Hhcf4kQSlQh/ltjtuj4EUatjMfOubA8G++CrTStGNmLW9HIgHjd1Ykz3z8zdprJxaKwvfpHlV1rH0HplOtkk5kwGFMxtn1ghvQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567737; c=relaxed/simple;
	bh=jOvj8sUhQOnWWb9RP/PYMDVrKj4dgjPG61k1ISynHeY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p8Vy1BoCWxL9h/PVYWlluREZlZHnJlqLoajyFs88RKFstz0q/pbhnUOBeXeL0XxrtgbEJkarPw687ufZe8dKCTFiybEFKTe+gQMIpbMXNIFbbneBw07SNH/IbNN18b2uUFvK1pHV8aimWCXFbnY5gycFZamwnWhJAH2rMWFOYes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IHAc0U9f; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-391342fc0b5so1777647f8f.3
        for <linux-hyperv@vger.kernel.org>; Fri, 21 Mar 2025 07:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567734; x=1743172534; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ePP2nkQSnuEG/AnhVnMeNi8KNMe79AtuZeTxXxzHFJo=;
        b=IHAc0U9f3RG6Wwpu6N7vtMeH50i8WZeu58gJXcBTFuzGgAs4nWodu4GIxCbxrgDrEP
         juIpsWWU2hi+7KrGOSNBBIQKLP8Zf0RuwkK90NngLHL8xZBLL4+lnYQ9oZSpJu6prA8w
         prdaO63mRm03h/Psi34Dyxe+M7oyth3aoSDuHFI/HcqyM2klwC+1Nx+X6l4JVjavHTOH
         mSx9S3QA0oSNpRF/VgyDQIssDDEis8DW2ENXhqNQIORqfvv7O7xn2+S5rB5vJHtgg9A1
         skyY/tCiX3pF9qBw55rk/2hqwdXBby261+F5XiUZOTL+4mii0IUU/WXazhDHWh0WVPo7
         3egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567734; x=1743172534;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ePP2nkQSnuEG/AnhVnMeNi8KNMe79AtuZeTxXxzHFJo=;
        b=mBMKvFYy9pncQ5QI6B4DW4hvxrnrzHmGR83EbBLT4UuyQgDq2IRjdAZS70PDK5Gef5
         n/stcoASPYCDDO3hA5xys9mci/8TMojpJFQByw7/8GA0svwpBNmnGXpNIQHS5KvImsdj
         t1Iburp+qDC9EUwTpcwqlJGQHRFABTFkW6V39U78RWV+BIT7oFI027GBRvMdEDdcZ63D
         VQY0SxDxeuYpIUt5VSyH26MSbCG4z9WgUISEqJE5BRonazEDTSuhaE0qq7HR0menkwL+
         DQ0CWmtCXOG6U/N9W3zqJLPy5apOue1GCgXfeQqxfaxY88Nq90dpx7azGGQu9m/T6YxR
         0YbA==
X-Forwarded-Encrypted: i=1; AJvYcCWPDmyNeSk1s1jOxNQ4/cq3QFPgVeQ0n65XyD4zj9buANssMI+X3s0RSyQ0Za/ukpjQOF9YyVAH1kO9T7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvSwoK0ltdCS0jR+yNcB0XKvMPfBDpo+CipMDe8W1jx3rBWZl+
	o9Vf5IJ/unkQYGoXZRp88soE0rpCADuDeAFstOdXJMg9NBNmG1CGmdigiEN78n8=
X-Gm-Gg: ASbGnctKyaw6lxT1atFUUgZ+Nf2UQhihuCqqheLY6hTnYlBv3Zf12ISV0Bf38YEVXJl
	MaCIv2Jp5I27//yWV4hs3qim7Mo7SA0sa/RodtY9OFo9Ar6MbxdBzmRDzznCUbjGHt6CLbBp99w
	EnGLgK73KfasqgHVwDABah6adfILp0B+gnuU3hPGelsqA9GO6jsVOL6g3L5/cLZlq8npOV9eZY5
	5z8+tS2JYbdg2yw7imwL5SQsQwWjb10O1+Lh5iPOXYc0Nh9TI876dbGB6O8dNGkRvJd1OLP615Q
	AarvYGOlgXZ1Nm7WUORP93Z0Qrw18n73+D9cjLFujKRufjEUYQ==
X-Google-Smtp-Source: AGHT+IHo3Yc3MCPOadC9UN49uSmHsJsixyIQa4snXxSgTEg4SRqx8S+qcU3YVR3JJisZ0M7ofeV/DQ==
X-Received: by 2002:a05:6000:1842:b0:392:bf8:fc96 with SMTP id ffacd0b85a97d-3997f8f8be6mr3252239f8f.4.1742567733638;
        Fri, 21 Mar 2025 07:35:33 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f9eff6esm2504188f8f.100.2025.03.21.07.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:35:33 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:35:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Jinank Jain <jinankjain@microsoft.com>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] Drivers: hv: mshv: Fix uninitialize variable in
 mshv_ioctl_passthru_hvcall()
Message-ID: <97036225-597d-4a2d-8f51-7310757b9929@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "ret" variable could be uninitialized on the success path depending
on if "is_async" is true of false.  Initialized it to zero.

Fixes: f5288d14069b ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/hv/mshv_root_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 29fa6d5a3994..b94d8fe0f691 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -151,13 +151,14 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
 				      void __user *user_args)
 {
 	u64 status;
-	int ret, i;
 	bool is_async;
 	struct mshv_root_hvcall args;
 	struct page *page;
 	unsigned int pages_order;
 	void *input_pg = NULL;
 	void *output_pg = NULL;
+	int ret = 0;
+	int i;
 
 	if (copy_from_user(&args, user_args, sizeof(args)))
 		return -EFAULT;
-- 
2.47.2


