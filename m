Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2453156DF0
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Feb 2020 04:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgBJDkI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 9 Feb 2020 22:40:08 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40632 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgBJDkI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 9 Feb 2020 22:40:08 -0500
Received: by mail-qk1-f196.google.com with SMTP id b7so5222430qkl.7;
        Sun, 09 Feb 2020 19:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=frfitOFXox86XEifRvZU8CHfdOpsMURa7f2gjVq2U28=;
        b=iWycGiy96SWpQJ31sL6iYLl3KcJ0dFgExK3vPC1U1Fedgb3NlUkSaKIEFQfH9YvVLC
         ln8/R5P8WT6z9PWn02Fop2/cllNGbdbj5ep2xctdG6NThRWxxA9MKl4zIQ5A7cxfBSKr
         CCGoA4yLGYtDsSGQZUMOXsfilqpP/GG9O2C5Z40P9Dc3OobsNaimCzo7VuWd47HqG7lQ
         pl3eYuC/F6aMi1cFdKIlJYCMwzr3c6sjkMPPUbqYCBFpIG82lK8+KjCt4HBtfdfwMRny
         GNU28UQd/oxAZ7VdbmFrwXBFxuwmvMld0M22OC9av7R6TS5MqW2yh0iHDSr5UrL7M+jw
         /ylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=frfitOFXox86XEifRvZU8CHfdOpsMURa7f2gjVq2U28=;
        b=rktBsOTLKrd5zfNd9AQRxWfSXpCX/CEBbc3nS2Wlw4Km7L0Av2RYHS+Hrc99VCbvBY
         lETa7FJeOFnAA6OVbOoRTgnp45WYJVWY0FjCA+9ofHnrQzV9VQfBoncNAOigFKlqoXzC
         3QW523MQ7nw4oo+TPD2ppamdmDVzFP7Jt5hSmi/8H6bo1aMhGp0o2ocA32vpRgQgoakF
         B7/U6ifh447zLv3aQ9F9WmQEGipFMVLbD9N+Ey36bWP7EBrIzfcR4mc27vkecwAZBWZg
         b4bXdW5T9HtNtpLKhcfoPVQIPnVuJjbBoR7PJvevb8oqXxxPqlcVYnxlMLyCvkY7CSCm
         NSlA==
X-Gm-Message-State: APjAAAXigqkRsVwlP2isjCJ4lBi/OYdP4P9T4vP0V88XIjx0va299gxG
        GEQSrDsRlfoP0pLx6PJP+QM=
X-Google-Smtp-Source: APXvYqy5b4i4DNfRHydf+m6nmbdF5HggBHGwaG5kMgg6NU4ZOf720NShyORmng4qsE7dxslJkWlUdQ==
X-Received: by 2002:a37:e10f:: with SMTP id c15mr8958157qkm.331.1581306007417;
        Sun, 09 Feb 2020 19:40:07 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id h4sm5471601qtp.24.2020.02.09.19.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Feb 2020 19:40:06 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5C3B921F34;
        Sun,  9 Feb 2020 22:40:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 09 Feb 2020 22:40:05 -0500
X-ME-Sender: <xms:kNBAXhWsLdcLV5cUxDW5opGAKDs4sQWXvOnfHGzIRHTVpVekWHC-Mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedriedtgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhephffvufffkffoggfgsedtkeer
    tdertddtnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesgh
    hmrghilhdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphephedv
    rdduheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithih
    qdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrih
    hlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:kNBAXuCj-GPfaTSVhcn-B_H330oKSgKg0IrD60tUjHS2ufrJ1Z-Z6w>
    <xmx:kNBAXkpRd1EKS-4cdLOqnj_ek9htrQ-5dxXYJnao9cLe2w0nHJTGDQ>
    <xmx:kNBAXq00Y7ybEDx318PH8LWF-N9dEWx-qj7i8iGU4pqSp90_wXT9Bg>
    <xmx:ldBAXtdqqKvhaiNWE0B3vSM1N5p0ryPyzeJ3sxIRtCk4o3Zk4K5SHCwsHr8>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id A8C6730606FB;
        Sun,  9 Feb 2020 22:39:59 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v3 0/3] PCI: hv: Generify pci-hyperv.c
Date:   Mon, 10 Feb 2020 11:39:50 +0800
Message-Id: <20200210033953.99692-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi,

This is the first part for virtual PCI support of Hyper-V guest on
ARM64. The whole patchset doesn't have any functional change, but only
refactors the pci-hyperv.c code to make it more arch-independent.

Previous version:
v1: https://lore.kernel.org/lkml/20200121015713.69691-1-boqun.feng@gmail.com/
v2: https://lore.kernel.org/linux-arm-kernel/20200203050313.69247-1-boqun.feng@gmail.com/

Changes since v2:

*	Rebased on 5.6-rc1

*	Reword commit logs as per Andrew's suggestion.

*	It makes more sense to have a generic interface to set the whole
	msi_entry rather than only the "address" field. So change
	hv_set_msi_address_from_desc() to hv_set_msi_entry_from_desc().
	Additionally, make it an inline function as per the suggestion
	of Andrew and Thomas.

*	Add the missing comment saying the partition_id of
	hv_retarget_device_interrupt must be self.

*	Add the explanation for why "__packed" is needed for TLFS
	structures.

I've done compile and boot test of this patchset, also done some tests
with a pass-through NVMe device.

Suggestions and comments are welcome!

Regards,
Boqun

Boqun Feng (3):
  PCI: hv: Move hypercall related definitions into tlfs header
  PCI: hv: Move retarget related structures into tlfs header
  PCI: hv: Introduce hv_msi_entry

 arch/x86/include/asm/hyperv-tlfs.h  | 41 +++++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h     |  8 ++++++
 drivers/pci/controller/pci-hyperv.c | 43 ++---------------------------
 3 files changed, 52 insertions(+), 40 deletions(-)

-- 
2.24.1

