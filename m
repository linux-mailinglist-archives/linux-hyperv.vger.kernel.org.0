Return-Path: <linux-hyperv+bounces-8626-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGjwLT1ifWkkRwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8626-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 31 Jan 2026 03:00:29 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3665AC02B0
	for <lists+linux-hyperv@lfdr.de>; Sat, 31 Jan 2026 03:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F03F4300D15B
	for <lists+linux-hyperv@lfdr.de>; Sat, 31 Jan 2026 02:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F29280A5B;
	Sat, 31 Jan 2026 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5/kyFy7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A71279DAD
	for <linux-hyperv@vger.kernel.org>; Sat, 31 Jan 2026 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769824827; cv=none; b=jWnpV4rPM79s8Kn2zUhNDWHlouOeUAhYY+Upf5Lw7z7vphczuDO9LD4HIQK/dTSA4iOQ2WeH0tz3UDkVTspvSffrwqLVK5x8fhyFVhcoq6f0wl5tmM1h0wWRM0xnfvKxPXKibw2UuVs11EtEOXwegz0sxUh0NW4s25jcyunVBjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769824827; c=relaxed/simple;
	bh=9ZqB83FAbd1Adsme0MGZf1r4FtbsU6hXRh/jnbCOxcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YqGQ+TJt2nWHo5QqMuuJxzAuu7kjYseGMJEWH/tpsM+x4ADNLfG+TKlC58aF9VRZPhEk2wQUy6rFk7iV1BMi3P3nJdfzmRslOSV/DzzkWOxKJi5Ncm28lOybFFCYodGbVhgxbBKxSkDX4OCXVIMrjGjLKODTscDSRChz42Heowc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5/kyFy7; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b714f30461so2500236eec.0
        for <linux-hyperv@vger.kernel.org>; Fri, 30 Jan 2026 18:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769824825; x=1770429625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mp49pu/98jCz79VjR9BIlt5YZaMqC2vyb84mYb0vpSA=;
        b=U5/kyFy7JUw5CR+NOezwdsi1TmRWXt2cA8pS4yH7U/dVnFPV/1inZbkBpOsu2Oxik+
         Z0ent84Q9cPp0hgH/6kBoFH2xawgsS4ksle+Xqt5ZILmyU6QVpRZ63VklBnb6t070s2/
         0yrU/8U/tmK5k3hEciloDMiZjIAlqdMLE+wPQ0QrBsYiO6ruRcvRJC2BRPofSIvNRxzW
         N/yuB1P788521haQNLGv6XZIVFO4X9MZyDila2WP2iC6Pv8lL9NIietVYfEwTzWhpr9n
         Qpkusngb40BnrUcUMdePkWzSz6vpCNIk9GfUeyp73EeM0k1g+daUDFNf12kflPx2afOr
         enQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769824825; x=1770429625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mp49pu/98jCz79VjR9BIlt5YZaMqC2vyb84mYb0vpSA=;
        b=jMIWT5wJ2tHgdj92EtGFUhcv3EMMvBGGt90zjKfoVDEOZy8QnZmkTfxIRhxsrXZRhm
         slV5rw2ByLhH3/pN/mqxiBLeU4C2VVRNe8TOnUD50PESnjiEmzZqT/Py1Y+MK2CuTAAM
         jJJMyxVkl+RABbfDsX/zG3/SxwrnlgiLxM0X8t1t3hntfIzDAOVQmQ0Mx4i5GRS3iMho
         /c9oh56fQ0fkWh+RFmzkexw86sZLYyPqby49tmzr577rBkSOi8TD3GG+UVdkQof9TNfR
         O6WzOvzuNuGe6e5wOL1y7vcqfZRJg+bzLfuZRqGJmZ5JQVIcLFEeOsWVmxVryXZl+ozx
         zX8Q==
X-Gm-Message-State: AOJu0Yz8jMK0dalAUwpIlEsPQBC2J64BWk7UCD6IEDjRzS5Q7K2tRF5V
	SopTDQkRuecNX/OF54Gkbwr7pSTIgouwW2Ns9tmlSFp9OXAhNGEoF/1dnc/qYmZt
X-Gm-Gg: AZuq6aIBVSTJLaYObMY+hMQeN981MiUVZ4YUsb/KsFi+A7h7He9qvrVQUMkFGAPRPbG
	/4HwZCE16pcwxDvK7hmpJVBexaJ1iwafAf3FL+CGQbmWLKObvUsXTGwsKdWGXRiUhUmYzrrtys5
	PVpNt27ty4YH+c1xuqyG56zKq7JXVONDz10nOwUysLbASarm7R06HWWZPaxTaU/qdiFgQLaBAYz
	Nl7hXEl7FIAN+MefTHbvHHoZGZ4Nu1eF14DA9G6PU8QYgPDITzm4UKQlXfAFLFoAZIKcZT/lyCQ
	UPmpBjbRlFTOzJgt9kSVUnQaML9YHm4WxClU0CbJvbG+JzCXOllxvDqyLQZDLkGNxTPn/C4wLhu
	Dc3vf7M2H93AYO3+iZ3G7DcP2MWZrHXjhsUuP+Qqak5LFHO8QAWAEPvLvigMdROmGLfZPQ9D4n+
	qUBWhhTQD0rTlzPSx/1O3Lf9phf0VPoUhMV6Tk2+zsJbu9IAX7xEEWkE01slHIKBVcSv0tIWxNj
	+rPAhomlxSW4W5HNODQ6jdOM6mRZTDNjBgnp0lyuYgJnvkva+0hxuVZuurcVYhPbc5xnVvm9QI/
	S2aH
X-Received: by 2002:a05:693c:3944:b0:2b7:a4b8:6a00 with SMTP id 5a478bee46e88-2b7c88d8a1fmr2538493eec.21.1769824824911;
        Fri, 30 Jan 2026 18:00:24 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a17083dasm16754140eec.14.2026.01.30.18.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 18:00:24 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] pci: pci-hyperv-intf: remove unnecessary module_init/exit functions
Date: Fri, 30 Jan 2026 18:00:17 -0800
Message-ID: <20260131020017.45712-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,microsoft.com,kernel.org,google.com];
	TAGGED_FROM(0.00)[bounces-8626-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3665AC02B0
X-Rspamd-Action: no action

The pci-hyperv-intf driver has unnecessary empty module_init and
module_exit functions. Remove them. Note that if a module_init function
exists, a module_exit function must also exist; otherwise, the module
cannot be unloaded.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/pci/controller/pci-hyperv-intf.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv-intf.c b/drivers/pci/controller/pci-hyperv-intf.c
index 28b3e93d31c0..18acbda867f0 100644
--- a/drivers/pci/controller/pci-hyperv-intf.c
+++ b/drivers/pci/controller/pci-hyperv-intf.c
@@ -52,17 +52,5 @@ int hyperv_reg_block_invalidate(struct pci_dev *dev, void *context,
 }
 EXPORT_SYMBOL_GPL(hyperv_reg_block_invalidate);
 
-static void __exit exit_hv_pci_intf(void)
-{
-}
-
-static int __init init_hv_pci_intf(void)
-{
-	return 0;
-}
-
-module_init(init_hv_pci_intf);
-module_exit(exit_hv_pci_intf);
-
 MODULE_DESCRIPTION("Hyper-V PCI Interface");
 MODULE_LICENSE("GPL v2");
-- 
2.43.0


