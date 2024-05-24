Return-Path: <linux-hyperv+bounces-2215-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D3F8CF85F
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 May 2024 06:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB27EB20E1B
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 May 2024 04:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89F07464;
	Mon, 27 May 2024 04:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eQUr3EA2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A446DDA5;
	Mon, 27 May 2024 04:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716784003; cv=none; b=FxNO35VatXRUhFz3vzbnYGuL5+nP51cm55X3/uvg7qOkndjMtgNmhBoGLEfB05ya0ar/7FzVQtRRPme6tEmNIah5Re+D3EiX4GTazs8K9LQ9YxeL5XSYXtEv7F+HSUX8utJuXBvV0faaHXdi/mV2tGpPzpmMaCeyvT+PZ2IGwVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716784003; c=relaxed/simple;
	bh=OCKRCTuGheokwgx9RerQLxxvrlg3RVUbngNYuSYgnw8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=MNhkVmJQO7OnMdUM5vTlXN4XeFBTEuOjfyFsPjs0u1AVpZTb5aY4LRNpCePAlhkf+nGkWDWSoFHtDt/18y2Wk8nwQb8s2n1cHA1jpB57kzKAzFT5EVw1EE5gMyB9CelmEKcXy18c0xdnnVa/FMAaJwv6RrJQ0HvJ/7ON/eQiX8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eQUr3EA2; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240527042638epoutp0435f4af8368192d95df8b921085f941de~TPfNMkCoH1096710967epoutp04r;
	Mon, 27 May 2024 04:26:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240527042638epoutp0435f4af8368192d95df8b921085f941de~TPfNMkCoH1096710967epoutp04r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716783998;
	bh=IXPOW0hbt9QdEYLHLn0tJTlqyKZ43Ofrzjw6xoAX5fo=;
	h=From:To:Cc:Subject:Date:References:From;
	b=eQUr3EA2JOzNam/TM6BpEaUa7Ul9+x2xPnfFzVyxcjA0HAQGJyunc/0vE9GTPLyBb
	 Uo9QrfEjET5daOzxo+KnMoH2Iu4YzdJDcoMwmSBUIAgeldQgko9eKhXPxaaES+1/oJ
	 f45eH6B52sjP9YQvYr7BrdW/dsngLLYliXAIm20s=
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.42.80]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240527042637epcas5p35715effe3387b65ac1c3dea75555e1b4~TPfMsJfG22824428244epcas5p3n;
	Mon, 27 May 2024 04:26:37 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	99.39.19174.D7B04566; Mon, 27 May 2024 13:26:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240524135817epcas5p47d24bc69e88b3c44bee0153daa16f148~ScWdu2p6E0195001950epcas5p4L;
	Fri, 24 May 2024 13:58:17 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240524135817epsmtrp2c629f6a28db1b574821e5df8acdf3e67~ScWdtWhi52934929349epsmtrp2V;
	Fri, 24 May 2024 13:58:17 +0000 (GMT)
X-AuditID: b6c32a50-87fff70000004ae6-ad-66540b7da378
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	F5.22.19234.8FC90566; Fri, 24 May 2024 22:58:16 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240524135809epsmtip1ee62e6c4210d0d521323e2fd292632b1~ScWWnCpDK3100831008epsmtip15;
	Fri, 24 May 2024 13:58:09 +0000 (GMT)
From: Onkarnarth <onkarnath.1@samsung.com>
To: mark.rutland@arm.com, maz@kernel.org, daniel.lezcano@linaro.org,
	tglx@linutronix.de, patrice.chotard@foss.st.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, tsbogend@alpha.franken.de,
	fancer.lancer@gmail.com, liviu.dudau@arm.com, sudeep.holla@arm.com,
	lpieralisi@kernel.org, baruch@tkos.co.il, verdun@hpe.com,
	nick.hawkins@hpe.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, vz@mleia.com, afaerber@suse.de,
	manivannan.sadhasivam@linaro.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, thierry.reding@gmail.com,
	jonathanh@nvidia.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, linux-hyperv@vger.kernel.org,
	linux-mips@vger.kernel.org, imx@lists.linux.dev,
	linux-actions@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-tegra@vger.kernel.org, r.thapliyal@samsung.com, Onkarnath
	<onkarnath.1@samsung.com>, Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 1/1] clocksource: use symbolic error names (%pe) to print
 logs
Date: Fri, 24 May 2024 19:27:59 +0530
Message-Id: <20240524135759.375328-1-onkarnath.1@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxjP6X0VSN214DwpOheEP8DwMIg5mbKxZNGbGAdmzhg3xxq4gOG5
	VgQXVJDioJQBG2WjQFmZzA4fgwvl0eHUNnOB+YglRUGKk9WsOB5upbIChVEuRv/7Pb7v+33f
	SY4QE0+REuGxrOOsLEuaEUT64l3m0NDwU34HU6K+Kd2Eijk5ck/UAmRY0FBIPzSJI61zM/pF
	wQHUVtpAoMfWeDTUzaC6sRISKTTNOGpV9+LIftFAoVr7WRxxfw4RSF39jESDxgYSlXEGgLqc
	ChIph+wEKpvVkOh6yxc4UiwqcGRuOocjm6KMQC337wlQb0M/gbSeywTqmr5FIL3qGYEmBlUY
	cvfPUOic5jXUPpaOPN0cjhydG9GFgR4cdXDqFd+oXRl29gaGbqv0GFqeL8aQmRsRxG1jSiwX
	cOaS9hJgJicmcMZcOksxTyoNFNOrsVGM0VhEMVxrGcmMDvWRzPSdOxTTcf4M4+ioA0xJj4di
	lnQ1OFNRPE0ylZ6ohNeP+O5OZjOOnWBlkW9/6ptm4RqxnM5rIN800koUAlsDUAKhENI7YNXM
	OiXwFYrpPgC1Lh3Gk38BVDap8JfkOUcqgc9qx9OHi2tGL4C28e8JnswCOOZawr1VJB0Gvx29
	LvAaAfQgAWse3CS9BKO/wmDHIzfhTfenE2BRaZAX4nQI/L060dsromPh8yk9xadtgXWWOYrX
	18P+OvvqfGxFLzbUr+4K6S994ahyam2996DOOgl47A+f/ta5NkgCndNX12qyoaJeg/EPUACt
	T0J4+R1ov6db3QyjQ+FPxkhe3gzVA1cEfOw6WLFgF/C6CPZoX+AQOF+jxnkcCB8tNK4lMbBw
	yUJ4sZg+Codd81QV2KJ55RrNK9doXiZ/B7BWIGFz5JmpbFJMzvbwLDYvQi7NlOdmpUYkZWdy
	YPVHhCX0gIttnggTEAiBCUAhFhQgCtAeSBGLkqUnP2dl2Ymy3AxWbgKBQjxoo+jvksZkMZ0q
	Pc6ms2wOK3vhCoQ+kkLBZ/a0qE8s63948wOHuOVUfUisjksg+vKDVeNFPmEJg7sc4ea+97si
	9pyWnK9atv7XXPEwLfNX05nl3OED+0+qbhh9ytPdbZEV17amzf01Z2X3Hl4Y2Zujc1GhpVvj
	PfKS6p15ba6klG01+8yxTbtOS9669ePs5UPWnTOOnsYCW//h+D1udVyS04cWEcFUbc1Hsfvn
	SSQ7eNPl2CCL1/vpdtuufHy/+fEGR0r3gHPxQyIp7PbCu4cCN/mP/Lxj+EiisSgjLvpE+1HM
	FDwVI9tXqcirb3C80SwhSNndgqrRu8350RFYV3l79Hh0izXGEmvoKOf8rlJ/PBhwqgqy/vF8
	nRmEy9Ok28MwmVz6P7/QCWqABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTdxTG8+99K12KXQV7heCyKsvCwptxyfmwF6MGbpbMKtEswSXa0Gsx
	tBRv1YnTqNAySiBQsM6WWp2xaym6jYsttBpf6JKJTjJKrLybZV0mDhijpMKkMCpb4rfnPL/n
	nOfLEWJSM5EmPFR+hOXKlRo5KcJ9QfmG7Hn7roN5X1/Nh2peDwsT5xF4X9oocIcncXBEM+C2
	gUfwQ62dgF8fKyDcxYB13EiCwXYFB4/Fj0Ok3UvB+UgVDvxvYQIs5hkSBgJ2Eky8F4EvaiCh
	LhwhwDRnI+Gu8yscDIsGHIKXanAYM5gIcD7pF4Df3kuAI36dAN/0zwS462cImBiox2Ch9y8K
	amxroGO8DOJdPA7PbsjA9aAbh07essIDjpVjVfcweFTvxmD5n2oMgvywYOt7jDHkwplrjmuI
	mZyYwJlg7RzF/N7opRi/bYxiAoGzFMN7TCQzGr5FMtN9fRTTefU086zTihhjd5xilr45hzMN
	1dMk0xjP27WuWPSBitUcOsZyuR8dEJWG+ItYxY076HjPsIc4g8bsqA4lCWnJFvr5yCJeh0RC
	qaQL0UvzPsEqSKdnB+zUql5Lty39Qa2GZhEd9S+/2iYlWfSF0buCBEiRvCTolqYolhgwiQOj
	ff2tWCK1VrKTPrsUJOqQUIhLMumH5v0JWyz5kI5Nuf9reIu2hl5Qq/6bdK81gic0tuJXe1ux
	JpRsew3ZXkOXkcCDUtkKvVatLanIz9Ertfqj5eqcEp2WR6++JquoG337fTynBwmEqAfRQkye
	It7X9ulBqVilrDzBcrr93FENq+9B6UJcLhNv1JhUUolaeYQtY9kKlvufCoRJaWcELtxZPNO0
	M/fkdt+eUKF90xuBHQXcNrJgyrVHtsN5XVP0eaxsqGEuLdL1/oNTblHS4L7ObRkFheso3WbD
	ucyw7PknatGgv/1KLEOtyL405d7Uqpi6pVr2uYaOJ11c+LtxOS/2cW2HILR7aHC45cXmn2b7
	7st8lt3tZexp5/q26Lhua430nlEeKyh+8mfKhsM/5k5WanXJaQ8/S8VPhor6ApOpyUP9LfPG
	NcO/NL9bmxm9wNoDsbfTuW71F1A6sn6v4Z2bjhOWjZXap6jeU1jbXOVoaDcrjpmb79w8QItG
	Ytk1ihLi1N6nHc3bv3tsfSRWHb4fVsx4PLe/5MKLW0Y5Oa4vVeZnYZxe+S9xx7UNpAMAAA==
X-CMS-MailID: 20240524135817epcas5p47d24bc69e88b3c44bee0153daa16f148
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20240524135817epcas5p47d24bc69e88b3c44bee0153daa16f148
References: <CGME20240524135817epcas5p47d24bc69e88b3c44bee0153daa16f148@epcas5p4.samsung.com>

From: Onkarnath <onkarnath.1@samsung.com>

It is better to use %pe instead of %d or such to print logs
for enhanced error logs readbility.

Error print logs format is more style consistent now.

Co-developed-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
---
 drivers/clocksource/arm_arch_timer.c   |  2 +-
 drivers/clocksource/arm_global_timer.c |  4 ++--
 drivers/clocksource/armv7m_systick.c   |  4 ++--
 drivers/clocksource/hyperv_timer.c     |  6 +++---
 drivers/clocksource/jcore-pit.c        |  4 ++--
 drivers/clocksource/mips-gic-timer.c   |  2 +-
 drivers/clocksource/mps2-timer.c       | 18 +++++++++---------
 drivers/clocksource/timer-clint.c      |  6 +++---
 drivers/clocksource/timer-digicolor.c  |  2 +-
 drivers/clocksource/timer-fsl-ftm.c    | 16 ++++++++--------
 drivers/clocksource/timer-gxp.c        |  8 ++++----
 drivers/clocksource/timer-imx-tpm.c    |  2 +-
 drivers/clocksource/timer-lpc32xx.c    | 10 +++++-----
 drivers/clocksource/timer-owl.c        |  4 ++--
 drivers/clocksource/timer-pistachio.c  |  8 ++++----
 drivers/clocksource/timer-probe.c      |  4 ++--
 drivers/clocksource/timer-riscv.c      |  8 ++++----
 drivers/clocksource/timer-sp804.c      |  4 ++--
 drivers/clocksource/timer-tegra.c      |  8 ++++----
 drivers/clocksource/timer-tegra186.c   | 14 +++++++-------
 drivers/clocksource/timer-zevio.c      |  2 +-
 21 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 5bb43cc1a8df..e36cc8e544cf 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1273,7 +1273,7 @@ static int __init arch_timer_register(void)
 	}
 
 	if (err) {
-		pr_err("can't register interrupt %d (%d)\n", ppi, err);
+		pr_err("can't register interrupt %d: %pe\n", ppi, ERR_PTR(err));
 		goto out_free;
 	}
 
diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index ab1c8c2b66b8..9ed1e9564227 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -399,8 +399,8 @@ static int __init global_timer_of_register(struct device_node *np)
 	err = request_percpu_irq(gt_ppi, gt_clockevent_interrupt,
 				 "gt", gt_evt);
 	if (err) {
-		pr_warn("global-timer: can't register interrupt %d (%d)\n",
-			gt_ppi, err);
+		pr_warn("global-timer: can't register interrupt %d: %pe\n",
+			gt_ppi, ERR_PTR(err));
 		goto out_free;
 	}
 
diff --git a/drivers/clocksource/armv7m_systick.c b/drivers/clocksource/armv7m_systick.c
index 7e78074480e4..15f5dd2ffdae 100644
--- a/drivers/clocksource/armv7m_systick.c
+++ b/drivers/clocksource/armv7m_systick.c
@@ -60,7 +60,7 @@ static int __init system_timer_of_register(struct device_node *np)
 	ret = clocksource_mmio_init(base + SYST_CVR, "arm_system_timer", rate,
 			200, 24, clocksource_mmio_readl_down);
 	if (ret) {
-		pr_err("failed to init clocksource (%d)\n", ret);
+		pr_err("failed to init clocksource: %pe\n", ERR_PTR(ret));
 		if (clk)
 			goto out_clk_disable;
 		else
@@ -77,7 +77,7 @@ static int __init system_timer_of_register(struct device_node *np)
 	clk_put(clk);
 out_unmap:
 	iounmap(base);
-	pr_warn("ARM System timer register failed (%d)\n", ret);
+	pr_warn("ARM System timer register failed: %pe\n", ERR_PTR(ret));
 
 	return ret;
 }
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index b2a080647e41..7d6bb26b2b3c 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -205,7 +205,7 @@ static int hv_setup_stimer0_irq(void)
 	ret = acpi_register_gsi(NULL, HYPERV_STIMER0_VECTOR,
 			ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_HIGH);
 	if (ret < 0) {
-		pr_err("Can't register Hyper-V stimer0 GSI. Error %d", ret);
+		pr_err("Can't register Hyper-V stimer0 GSI. Error: %pe", ERR_PTR(ret));
 		return ret;
 	}
 	stimer0_irq = ret;
@@ -213,8 +213,8 @@ static int hv_setup_stimer0_irq(void)
 	ret = request_percpu_irq(stimer0_irq, hv_stimer0_percpu_isr,
 		"Hyper-V stimer0", &stimer0_evt);
 	if (ret) {
-		pr_err("Can't request Hyper-V stimer0 IRQ %d. Error %d",
-			stimer0_irq, ret);
+		pr_err("Can't request Hyper-V stimer0 IRQ %d. Error: %pe",
+			stimer0_irq, ERR_PTR(ret));
 		acpi_unregister_gsi(stimer0_irq);
 		stimer0_irq = -1;
 	}
diff --git a/drivers/clocksource/jcore-pit.c b/drivers/clocksource/jcore-pit.c
index a4a991101fa3..dfd1e77377ee 100644
--- a/drivers/clocksource/jcore-pit.c
+++ b/drivers/clocksource/jcore-pit.c
@@ -156,7 +156,7 @@ static int __init jcore_pit_init(struct device_node *node)
 				    NSEC_PER_SEC, 400, 32,
 				    jcore_clocksource_read);
 	if (err) {
-		pr_err("Error registering clocksource device: %d\n", err);
+		pr_err("Error registering clocksource device: %pe\n", ERR_PTR(err));
 		return err;
 	}
 
@@ -172,7 +172,7 @@ static int __init jcore_pit_init(struct device_node *node)
 			  IRQF_TIMER | IRQF_PERCPU,
 			  "jcore_pit", jcore_pit_percpu);
 	if (err) {
-		pr_err("pit irq request failed: %d\n", err);
+		pr_err("pit irq request failed: %pe\n", ERR_PTR(err));
 		free_percpu(jcore_pit_percpu);
 		return err;
 	}
diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index b3ae38f36720..628b3aec2b45 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -150,7 +150,7 @@ static int gic_clockevent_init(void)
 
 	ret = setup_percpu_irq(gic_timer_irq, &gic_compare_irqaction);
 	if (ret < 0) {
-		pr_err("IRQ %d setup failed (%d)\n", gic_timer_irq, ret);
+		pr_err("IRQ %d setup failed: %pe\n", gic_timer_irq, ERR_PTR(ret));
 		return ret;
 	}
 
diff --git a/drivers/clocksource/mps2-timer.c b/drivers/clocksource/mps2-timer.c
index efe8cad8f2a5..5e2dcb792741 100644
--- a/drivers/clocksource/mps2-timer.c
+++ b/drivers/clocksource/mps2-timer.c
@@ -109,13 +109,13 @@ static int __init mps2_clockevent_init(struct device_node *np)
 		clk = of_clk_get(np, 0);
 		if (IS_ERR(clk)) {
 			ret = PTR_ERR(clk);
-			pr_err("failed to get clock for clockevent: %d\n", ret);
+			pr_err("failed to get clock for clockevent: %pe\n", clk);
 			goto out;
 		}
 
 		ret = clk_prepare_enable(clk);
 		if (ret) {
-			pr_err("failed to enable clock for clockevent: %d\n", ret);
+			pr_err("failed to enable clock for clockevent: %pe\n", ERR_PTR(ret));
 			goto out_clk_put;
 		}
 
@@ -125,14 +125,14 @@ static int __init mps2_clockevent_init(struct device_node *np)
 	base = of_iomap(np, 0);
 	if (!base) {
 		ret = -EADDRNOTAVAIL;
-		pr_err("failed to map register for clockevent: %d\n", ret);
+		pr_err("failed to map register for clockevent: %pe\n", ERR_PTR(ret));
 		goto out_clk_disable;
 	}
 
 	irq = irq_of_parse_and_map(np, 0);
 	if (!irq) {
 		ret = -ENOENT;
-		pr_err("failed to get irq for clockevent: %d\n", ret);
+		pr_err("failed to get irq for clockevent: %pe\n", ERR_PTR(ret));
 		goto out_iounmap;
 	}
 
@@ -159,7 +159,7 @@ static int __init mps2_clockevent_init(struct device_node *np)
 
 	ret = request_irq(irq, mps2_timer_interrupt, IRQF_TIMER, name, ce);
 	if (ret) {
-		pr_err("failed to request irq for clockevent: %d\n", ret);
+		pr_err("failed to request irq for clockevent: %pe\n", ERR_PTR(ret));
 		goto out_kfree;
 	}
 
@@ -193,13 +193,13 @@ static int __init mps2_clocksource_init(struct device_node *np)
 		clk = of_clk_get(np, 0);
 		if (IS_ERR(clk)) {
 			ret = PTR_ERR(clk);
-			pr_err("failed to get clock for clocksource: %d\n", ret);
+			pr_err("failed to get clock for clocksource: %pe\n", clk);
 			goto out;
 		}
 
 		ret = clk_prepare_enable(clk);
 		if (ret) {
-			pr_err("failed to enable clock for clocksource: %d\n", ret);
+			pr_err("failed to enable clock for clocksource: %pe\n", ERR_PTR(ret));
 			goto out_clk_put;
 		}
 
@@ -209,7 +209,7 @@ static int __init mps2_clocksource_init(struct device_node *np)
 	base = of_iomap(np, 0);
 	if (!base) {
 		ret = -EADDRNOTAVAIL;
-		pr_err("failed to map register for clocksource: %d\n", ret);
+		pr_err("failed to map register for clocksource: %pe\n", ERR_PTR(ret));
 		goto out_clk_disable;
 	}
 
@@ -226,7 +226,7 @@ static int __init mps2_clocksource_init(struct device_node *np)
 				    rate, 200, 32,
 				    clocksource_mmio_readl_down);
 	if (ret) {
-		pr_err("failed to init clocksource: %d\n", ret);
+		pr_err("failed to init clocksource: %pe\n", ERR_PTR(ret));
 		goto out_iounmap;
 	}
 
diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index 0bdd9d7ec545..03ce468bf15e 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -229,7 +229,7 @@ static int __init clint_timer_init_dt(struct device_node *np)
 
 	rc = clocksource_register_hz(&clint_clocksource, clint_timer_freq);
 	if (rc) {
-		pr_err("%pOFP: clocksource register failed [%d]\n", np, rc);
+		pr_err("%pOFP: clocksource register failed: %pe\n", np, ERR_PTR(rc));
 		goto fail_iounmap;
 	}
 
@@ -238,7 +238,7 @@ static int __init clint_timer_init_dt(struct device_node *np)
 	rc = request_percpu_irq(clint_timer_irq, clint_timer_interrupt,
 				 "clint-timer", &clint_clock_event);
 	if (rc) {
-		pr_err("registering percpu irq failed [%d]\n", rc);
+		pr_err("registering percpu irq failed: %pe\n", ERR_PTR(rc));
 		goto fail_iounmap;
 	}
 
@@ -260,7 +260,7 @@ static int __init clint_timer_init_dt(struct device_node *np)
 				clint_timer_starting_cpu,
 				clint_timer_dying_cpu);
 	if (rc) {
-		pr_err("%pOFP: cpuhp setup state failed [%d]\n", np, rc);
+		pr_err("%pOFP: cpuhp setup state failed: %pe\n", np, ERR_PTR(rc));
 		goto fail_free_irq;
 	}
 
diff --git a/drivers/clocksource/timer-digicolor.c b/drivers/clocksource/timer-digicolor.c
index 559aa96089c3..7b4991081bb7 100644
--- a/drivers/clocksource/timer-digicolor.c
+++ b/drivers/clocksource/timer-digicolor.c
@@ -189,7 +189,7 @@ static int __init digicolor_timer_init(struct device_node *node)
 			  IRQF_TIMER | IRQF_IRQPOLL, "digicolor_timerC",
 			  &dc_timer_dev.ce);
 	if (ret) {
-		pr_warn("request of timer irq %d failed (%d)\n", irq, ret);
+		pr_warn("request of timer irq %d failed: %pe\n", irq, ERR_PTR(ret));
 		return ret;
 	}
 
diff --git a/drivers/clocksource/timer-fsl-ftm.c b/drivers/clocksource/timer-fsl-ftm.c
index 93f336ec875a..dd709827a823 100644
--- a/drivers/clocksource/timer-fsl-ftm.c
+++ b/drivers/clocksource/timer-fsl-ftm.c
@@ -188,7 +188,7 @@ static int __init ftm_clockevent_init(unsigned long freq, int irq)
 	err = request_irq(irq, ftm_evt_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
 			  "Freescale ftm timer", &ftm_clockevent);
 	if (err) {
-		pr_err("ftm: setup irq failed: %d\n", err);
+		pr_err("ftm: setup irq failed: %pe\n", ERR_PTR(err));
 		return err;
 	}
 
@@ -218,7 +218,7 @@ static int __init ftm_clocksource_init(unsigned long freq)
 				    freq / (1 << priv->ps), 300, 16,
 				    clocksource_mmio_readl_up);
 	if (err) {
-		pr_err("ftm: init clock source mmio failed: %d\n", err);
+		pr_err("ftm: init clock source mmio failed: %pe\n", ERR_PTR(err));
 		return err;
 	}
 
@@ -235,25 +235,25 @@ static int __init __ftm_clk_init(struct device_node *np, char *cnt_name,
 
 	clk = of_clk_get_by_name(np, cnt_name);
 	if (IS_ERR(clk)) {
-		pr_err("ftm: Cannot get \"%s\": %ld\n", cnt_name, PTR_ERR(clk));
+		pr_err("ftm: Cannot get \"%s\": %pe\n", cnt_name, clk);
 		return PTR_ERR(clk);
 	}
 	err = clk_prepare_enable(clk);
 	if (err) {
-		pr_err("ftm: clock failed to prepare+enable \"%s\": %d\n",
-			cnt_name, err);
+		pr_err("ftm: clock failed to prepare+enable \"%s\": %pe\n",
+			cnt_name, ERR_PTR(err));
 		return err;
 	}
 
 	clk = of_clk_get_by_name(np, ftm_name);
 	if (IS_ERR(clk)) {
-		pr_err("ftm: Cannot get \"%s\": %ld\n", ftm_name, PTR_ERR(clk));
+		pr_err("ftm: Cannot get \"%s\": %pe\n", ftm_name, clk);
 		return PTR_ERR(clk);
 	}
 	err = clk_prepare_enable(clk);
 	if (err)
-		pr_err("ftm: clock failed to prepare+enable \"%s\": %d\n",
-			ftm_name, err);
+		pr_err("ftm: clock failed to prepare+enable \"%s\": %pe\n",
+			ftm_name, ERR_PTR(err));
 
 	return clk_get_rate(clk);
 }
diff --git a/drivers/clocksource/timer-gxp.c b/drivers/clocksource/timer-gxp.c
index 57aa2e2cce53..d016fb324d54 100644
--- a/drivers/clocksource/timer-gxp.c
+++ b/drivers/clocksource/timer-gxp.c
@@ -86,13 +86,13 @@ static int __init gxp_timer_init(struct device_node *node)
 	clk = of_clk_get(node, 0);
 	if (IS_ERR(clk)) {
 		ret = (int)PTR_ERR(clk);
-		pr_err("%pOFn clock not found: %d\n", node, ret);
+		pr_err("%pOFn clock not found: %pe\n", node, clk);
 		goto err_free;
 	}
 
 	ret = clk_prepare_enable(clk);
 	if (ret) {
-		pr_err("%pOFn clock enable failed: %d\n", node, ret);
+		pr_err("%pOFn clock enable failed: %pe\n", node, ERR_PTR(ret));
 		goto err_clk_enable;
 	}
 
@@ -126,7 +126,7 @@ static int __init gxp_timer_init(struct device_node *node)
 	ret = clocksource_mmio_init(system_clock, node->name, freq,
 				    300, 32, clocksource_mmio_readl_up);
 	if (ret) {
-		pr_err("%pOFn init clocksource failed: %d", node, ret);
+		pr_err("%pOFn init clocksource failed: %pe", node, ERR_PTR(ret));
 		goto err_exit;
 	}
 
@@ -145,7 +145,7 @@ static int __init gxp_timer_init(struct device_node *node)
 	ret = request_irq(irq, gxp_timer_interrupt, IRQF_TIMER | IRQF_SHARED,
 			  node->name, gxp_timer);
 	if (ret) {
-		pr_err("%pOFn request_irq() failed: %d", node, ret);
+		pr_err("%pOFn request_irq() failed: %pe", node, ERR_PTR(ret));
 		goto err_exit;
 	}
 
diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index bd64a8a8427f..308bcc4e8960 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -185,7 +185,7 @@ static int __init tpm_timer_init(struct device_node *np)
 	/* enable clk before accessing registers */
 	ret = clk_prepare_enable(ipg);
 	if (ret) {
-		pr_err("tpm: ipg clock enable failed (%d)\n", ret);
+		pr_err("tpm: ipg clock enable failed: %pe\n", ERR_PTR(ret));
 		clk_put(ipg);
 		return ret;
 	}
diff --git a/drivers/clocksource/timer-lpc32xx.c b/drivers/clocksource/timer-lpc32xx.c
index 68eae6378bf3..1e08e2090fee 100644
--- a/drivers/clocksource/timer-lpc32xx.c
+++ b/drivers/clocksource/timer-lpc32xx.c
@@ -161,13 +161,13 @@ static int __init lpc32xx_clocksource_init(struct device_node *np)
 
 	clk = of_clk_get_by_name(np, "timerclk");
 	if (IS_ERR(clk)) {
-		pr_err("clock get failed (%ld)\n", PTR_ERR(clk));
+		pr_err("clock get failed: %pe\n", clk);
 		return PTR_ERR(clk);
 	}
 
 	ret = clk_prepare_enable(clk);
 	if (ret) {
-		pr_err("clock enable failed (%d)\n", ret);
+		pr_err("clock enable failed: %pe\n", ERR_PTR(ret));
 		goto err_clk_enable;
 	}
 
@@ -193,7 +193,7 @@ static int __init lpc32xx_clocksource_init(struct device_node *np)
 	ret = clocksource_mmio_init(base + LPC32XX_TIMER_TC, "lpc3220 timer",
 				    rate, 300, 32, clocksource_mmio_readl_up);
 	if (ret) {
-		pr_err("failed to init clocksource (%d)\n", ret);
+		pr_err("failed to init clocksource: %pe\n", ERR_PTR(ret));
 		goto err_clocksource_init;
 	}
 
@@ -222,13 +222,13 @@ static int __init lpc32xx_clockevent_init(struct device_node *np)
 
 	clk = of_clk_get_by_name(np, "timerclk");
 	if (IS_ERR(clk)) {
-		pr_err("clock get failed (%ld)\n", PTR_ERR(clk));
+		pr_err("clock get failed: %pe\n", clk);
 		return PTR_ERR(clk);
 	}
 
 	ret = clk_prepare_enable(clk);
 	if (ret) {
-		pr_err("clock enable failed (%d)\n", ret);
+		pr_err("clock enable failed: %pe\n", ERR_PTR(ret));
 		goto err_clk_enable;
 	}
 
diff --git a/drivers/clocksource/timer-owl.c b/drivers/clocksource/timer-owl.c
index ac97420bfa7c..3319d3acb635 100644
--- a/drivers/clocksource/timer-owl.c
+++ b/drivers/clocksource/timer-owl.c
@@ -137,7 +137,7 @@ static int __init owl_timer_init(struct device_node *node)
 	clk = of_clk_get(node, 0);
 	if (IS_ERR(clk)) {
 		ret = PTR_ERR(clk);
-		pr_err("Failed to get clock for clocksource (%d)\n", ret);
+		pr_err("Failed to get clock for clocksource: %pe\n", clk);
 		return ret;
 	}
 
@@ -150,7 +150,7 @@ static int __init owl_timer_init(struct device_node *node)
 	ret = clocksource_mmio_init(owl_clksrc_base + OWL_Tx_VAL, node->name,
 				    rate, 200, 32, clocksource_mmio_readl_up);
 	if (ret) {
-		pr_err("Failed to register clocksource (%d)\n", ret);
+		pr_err("Failed to register clocksource: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
diff --git a/drivers/clocksource/timer-pistachio.c b/drivers/clocksource/timer-pistachio.c
index 57b2197a0b67..6b956c3b2f20 100644
--- a/drivers/clocksource/timer-pistachio.c
+++ b/drivers/clocksource/timer-pistachio.c
@@ -174,25 +174,25 @@ static int __init pistachio_clksrc_of_init(struct device_node *node)
 
 	sys_clk = of_clk_get_by_name(node, "sys");
 	if (IS_ERR(sys_clk)) {
-		pr_err("clock get failed (%ld)\n", PTR_ERR(sys_clk));
+		pr_err("clock get failed: %pe\n", sys_clk);
 		return PTR_ERR(sys_clk);
 	}
 
 	fast_clk = of_clk_get_by_name(node, "fast");
 	if (IS_ERR(fast_clk)) {
-		pr_err("clock get failed (%lu)\n", PTR_ERR(fast_clk));
+		pr_err("clock get failed: %pe\n", fast_clk);
 		return PTR_ERR(fast_clk);
 	}
 
 	ret = clk_prepare_enable(sys_clk);
 	if (ret < 0) {
-		pr_err("failed to enable clock (%d)\n", ret);
+		pr_err("failed to enable clock: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
 	ret = clk_prepare_enable(fast_clk);
 	if (ret < 0) {
-		pr_err("failed to enable clock (%d)\n", ret);
+		pr_err("failed to enable clock: %pe\n", ERR_PTR(ret));
 		clk_disable_unprepare(sys_clk);
 		return ret;
 	}
diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
index b7860bc0db4b..913473950191 100644
--- a/drivers/clocksource/timer-probe.c
+++ b/drivers/clocksource/timer-probe.c
@@ -30,8 +30,8 @@ void __init timer_probe(void)
 		ret = init_func_ret(np);
 		if (ret) {
 			if (ret != -EPROBE_DEFER)
-				pr_err("Failed to initialize '%pOF': %d\n", np,
-				       ret);
+				pr_err("Failed to initialize '%pOF': %pe\n", np,
+				       ERR_PTR(ret));
 			continue;
 		}
 
diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 48ce50c5f5e6..05d2294d5444 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -169,7 +169,7 @@ static int __init riscv_timer_init_common(void)
 
 	error = clocksource_register_hz(&riscv_clocksource, riscv_timebase);
 	if (error) {
-		pr_err("RISCV timer registration failed [%d]\n", error);
+		pr_err("RISCV timer registration failed: %pe\n", ERR_PTR(error));
 		return error;
 	}
 
@@ -179,7 +179,7 @@ static int __init riscv_timer_init_common(void)
 				    riscv_timer_interrupt,
 				    "riscv-timer", &riscv_clock_event);
 	if (error) {
-		pr_err("registering percpu irq failed [%d]\n", error);
+		pr_err("registering percpu irq failed: %pe\n", ERR_PTR(error));
 		return error;
 	}
 
@@ -192,8 +192,8 @@ static int __init riscv_timer_init_common(void)
 			 "clockevents/riscv/timer:starting",
 			 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
 	if (error)
-		pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
-		       error);
+		pr_err("cpu hp setup state failed for RISCV timer: %pe\n",
+		       ERR_PTR(error));
 
 	return error;
 }
diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index cd1916c05325..cbb3bc1eac0d 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -66,13 +66,13 @@ static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
 	if (!clk)
 		clk = clk_get_sys("sp804", name);
 	if (IS_ERR(clk)) {
-		pr_err("%s clock not found: %ld\n", name, PTR_ERR(clk));
+		pr_err("%s clock not found: %pe\n", name, clk);
 		return PTR_ERR(clk);
 	}
 
 	err = clk_prepare_enable(clk);
 	if (err) {
-		pr_err("clock failed to enable: %d\n", err);
+		pr_err("clock failed to enable: %pe\n", ERR_PTR(err));
 		clk_put(clk);
 		return err;
 	}
diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
index e9635c25eef4..2fe79042fbf9 100644
--- a/drivers/clocksource/timer-tegra.c
+++ b/drivers/clocksource/timer-tegra.c
@@ -324,8 +324,8 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20,
 		ret = request_irq(cpu_to->clkevt.irq, tegra_timer_isr, flags,
 				  cpu_to->clkevt.name, &cpu_to->clkevt);
 		if (ret) {
-			pr_err("failed to set up irq for cpu%d: %d\n",
-			       cpu, ret);
+			pr_err("failed to set up irq for cpu%d: %pe\n",
+			       cpu, ERR_PTR(ret));
 			irq_dispose_mapping(cpu_to->clkevt.irq);
 			cpu_to->clkevt.irq = 0;
 			goto out_irq;
@@ -338,7 +338,7 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20,
 				    "timer_us", TIMER_1MHz, 300, 32,
 				    clocksource_mmio_readl_up);
 	if (ret)
-		pr_err("failed to register clocksource: %d\n", ret);
+		pr_err("failed to register clocksource: %pe\n", ERR_PTR(ret));
 
 #ifdef CONFIG_ARM
 	register_current_timer_delay(&tegra_delay_timer);
@@ -348,7 +348,7 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20,
 				"AP_TEGRA_TIMER_STARTING", tegra_timer_setup,
 				tegra_timer_stop);
 	if (ret)
-		pr_err("failed to set up cpu hp state: %d\n", ret);
+		pr_err("failed to set up cpu hp state: %pe\n", ERR_PTR(ret));
 
 	return ret;
 
diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer-tegra186.c
index 304537dadf2c..927533d98ef7 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -279,13 +279,13 @@ static struct tegra186_wdt *tegra186_wdt_create(struct tegra186_timer *tegra,
 
 	err = watchdog_init_timeout(&wdt->base, 5, tegra->dev);
 	if (err < 0) {
-		dev_err(tegra->dev, "failed to initialize timeout: %d\n", err);
+		dev_err(tegra->dev, "failed to initialize timeout: %pe\n", ERR_PTR(err));
 		return ERR_PTR(err);
 	}
 
 	err = devm_watchdog_register_device(tegra->dev, &wdt->base);
 	if (err < 0) {
-		dev_err(tegra->dev, "failed to register WDT: %d\n", err);
+		dev_err(tegra->dev, "failed to register WDT: %pe\n", ERR_PTR(err));
 		return ERR_PTR(err);
 	}
 
@@ -406,32 +406,32 @@ static int tegra186_timer_probe(struct platform_device *pdev)
 	tegra->wdt = tegra186_wdt_create(tegra, 0);
 	if (IS_ERR(tegra->wdt)) {
 		err = PTR_ERR(tegra->wdt);
-		dev_err(dev, "failed to create WDT: %d\n", err);
+		dev_err(dev, "failed to create WDT: %pe\n", tegra->wdt);
 		return err;
 	}
 
 	err = tegra186_timer_tsc_init(tegra);
 	if (err < 0) {
-		dev_err(dev, "failed to register TSC counter: %d\n", err);
+		dev_err(dev, "failed to register TSC counter: %pe\n", ERR_PTR(err));
 		return err;
 	}
 
 	err = tegra186_timer_osc_init(tegra);
 	if (err < 0) {
-		dev_err(dev, "failed to register OSC counter: %d\n", err);
+		dev_err(dev, "failed to register OSC counter: %pe\n", ERR_PTR(err));
 		goto unregister_tsc;
 	}
 
 	err = tegra186_timer_usec_init(tegra);
 	if (err < 0) {
-		dev_err(dev, "failed to register USEC counter: %d\n", err);
+		dev_err(dev, "failed to register USEC counter: %pe\n", ERR_PTR(err));
 		goto unregister_osc;
 	}
 
 	err = devm_request_irq(dev, irq, tegra186_timer_irq, 0,
 			       "tegra186-timer", tegra);
 	if (err < 0) {
-		dev_err(dev, "failed to request IRQ#%u: %d\n", irq, err);
+		dev_err(dev, "failed to request IRQ#%u: %pe\n", irq, ERR_PTR(err));
 		goto unregister_usec;
 	}
 
diff --git a/drivers/clocksource/timer-zevio.c b/drivers/clocksource/timer-zevio.c
index ecaa3568841c..b61973a66dc6 100644
--- a/drivers/clocksource/timer-zevio.c
+++ b/drivers/clocksource/timer-zevio.c
@@ -134,7 +134,7 @@ static int __init zevio_timer_add(struct device_node *node)
 	timer->clk = of_clk_get(node, 0);
 	if (IS_ERR(timer->clk)) {
 		ret = PTR_ERR(timer->clk);
-		pr_err("Timer clock not found! (error %d)\n", ret);
+		pr_err("Timer clock not found! error: %pe\n", timer->clk);
 		goto error_unmap;
 	}
 
-- 
2.25.1


