Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178E1563A9B
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Jul 2022 22:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiGAUK4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 1 Jul 2022 16:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiGAUKu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 Jul 2022 16:10:50 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE96E1EAE1;
        Fri,  1 Jul 2022 13:10:48 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 50D84580357;
        Fri,  1 Jul 2022 16:01:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 01 Jul 2022 16:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1656705717; x=1656712917; bh=mr
        ZZqztLVKSIkpl2ZtG9SZsAXGvA9Vl+x5zOkvs3Bjg=; b=ifFqAwFeM2wxyJCvKE
        TcogHoKvz8Ikgyvbheen4lB6TK8my3nTFtPtZqZwV2EJoW1d675CVWiRCQYrtpCV
        gjmX3xfutUzOU3hClg0Njj4ieVpzITbRxgXZVuosglRi9Ve/QUV4hEboq9Cl6D5q
        5ZUDm0FkkQme2ysoms3ELh8Ej8sCf/bY7d3513Rv+xbTCp2MmH04t4WPs+p30/R/
        NUoTk/RQLxrRh5NqM1X0miI8sZ9j0rcT8Y1gbcNzWv3fehEjbKWta0Zm2a34hcFz
        IRiPSucdZsSIbDrwFJcccZcbWOSp8i+md8XOrmXWaR/5piNMD50Sh8euiQzn0koH
        sIGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656705717; x=1656712917; bh=mrZZqztLVKSIk
        pl2ZtG9SZsAXGvA9Vl+x5zOkvs3Bjg=; b=P1MvxlIOuM7l0z+qS8yeYED1ddgJs
        ZCs2QYRhK40y97qVVKx50uDXKGc7mEB0wEwGcSiJsX1JtDdjkQWUx99X65YS4sz+
        VfSaSS6Ie4KKuWHsotLfT5em9QY23iuX70+vsHcDY2KRtIP+aVtenEK44OuBMsai
        UBAjIHn3DU+BwynQs3RgoaYjQarWyRcQP7W5Gh2Uup25KvchrpUJqNUtKa3U+bgZ
        BTQhJ+xzfCrqL5QAda74Vyo+egxNHDbWs7GXn2vOV7ssh9klKGGfy1CHr9gnsXME
        J2Ch54d15PxAoSgBunXMCXpz/ijn5crnwUN/1XIG9K1lsPwNHpUnb99dA==
X-ME-Sender: <xms:tVK_Yn0kldOcLkWk3dfIzfXt7vEQSWSDQuQhk6xOyUH6462s2Aafdw>
    <xme:tVK_YmHzembFAoNWd77N3YnMz2ToCVVA3ID83I0u19Nq-hOul4kwoPfowFqG0OJU5
    9Up9yAkJymy0CEPig>
X-ME-Received: <xmr:tVK_Yn4ez4uypnFnFJ_3S-MZZK2rMoSOVkyJcaQENIV3-JxGd7QBPtijtwYnd0ibdz0oyf0Ih3Ol2g8rOwlklU9P9_G8MyY9ieFatffNBjzmGTzr0MCSIh0uclg2SZmSBTnenw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehfedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:tVK_Ys2boEFyZ2b7B1aml8ZopCfvtqe4SBKhfTNbbjUwaL5H_-Vt5w>
    <xmx:tVK_YqFInOCCYvQ6u16XXnQamCJINVqY-HKUCA2295MtRmC9HX0L8w>
    <xmx:tVK_Yt8uHh-EDhML-nWscQ8f9B1_bd-I8tbDH-V2EpmCZ_1zpFsBkg>
    <xmx:tVK_YiGQ7OXgBCgZlUMKnwYghy6mgLV662iTefVRH5xGXr6DzTd3uQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Jul 2022 16:01:54 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Samuel Holland <samuel@sholland.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Chris Zankel <chris@zankel.net>,
        Colin Ian King <colin.king@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dexuan Cui <decui@microsoft.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jan Beulich <jbeulich@suse.com>,
        Joerg Roedel <joro@8bytes.org>,
        Juergen Gross <jgross@suse.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Rich Felker <dalias@libc.org>,
        Richard Henderson <rth@twiddle.net>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sven Schnelle <svens@stackframe.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Wei Liu <wei.liu@kernel.org>, Wei Xu <xuwei5@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hyperv@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH v3 8/8] genirq: Provide an IRQ affinity mask in non-SMP configs
Date:   Fri,  1 Jul 2022 15:00:56 -0500
Message-Id: <20220701200056.46555-9-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220701200056.46555-1-samuel@sholland.org>
References: <20220701200056.46555-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

IRQ affinity masks are not allocated in uniprocessor configurations.
This requires special case non-SMP code in drivers for irqchips which
have per-CPU enable or mask registers.

Since IRQ affinity is always the same in a uniprocessor configuration,
we can provide a correct affinity mask without allocating one per IRQ.

By returning a real cpumask from irq_data_get_affinity_mask even when
SMP is disabled, irqchip drivers which iterate over that mask will
automatically do the right thing.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - Use cpumask_of(0) instead of cpu_possible_mask

 include/linux/irq.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 02073f7a156e..996e22744edd 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -151,7 +151,9 @@ struct irq_common_data {
 #endif
 	void			*handler_data;
 	struct msi_desc		*msi_desc;
+#ifdef CONFIG_SMP
 	cpumask_var_t		affinity;
+#endif
 #ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
 	cpumask_var_t		effective_affinity;
 #endif
@@ -882,13 +884,19 @@ static inline int irq_data_get_node(struct irq_data *d)
 static inline
 const struct cpumask *irq_data_get_affinity_mask(struct irq_data *d)
 {
+#ifdef CONFIG_SMP
 	return d->common->affinity;
+#else
+	return cpumask_of(0);
+#endif
 }
 
 static inline void irq_data_update_affinity(struct irq_data *d,
 					    const struct cpumask *m)
 {
+#ifdef CONFIG_SMP
 	cpumask_copy(d->common->affinity, m);
+#endif
 }
 
 static inline const struct cpumask *irq_get_affinity_mask(int irq)
-- 
2.35.1

