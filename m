Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3685B150108
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Feb 2020 06:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgBCFDX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 Feb 2020 00:03:23 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33810 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgBCFDX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 Feb 2020 00:03:23 -0500
Received: by mail-qt1-f196.google.com with SMTP id h12so10520246qtu.1;
        Sun, 02 Feb 2020 21:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PWETuN1Ct/aBktiJB2sFTwNGzVs9/Rhblhe4P3oaRJY=;
        b=HkuwH2bub7iIvO57E0i9lDHUF3m+LwVNRVnbSdehpOMJ+PDBp0xVO3m0rG1ykfB5FU
         B7K3kVzledfBK17Mz5U+DPvWX1uJ0XWN9QpePcYnui0zfLUz9kLPU8Qn+oraz1LtjgSU
         AbfXOOxCFhifOISWKDh2xaQ0+qISmretXlYVTHbpVGksN8+2nsi7PFXtmsxWKaV2G927
         ViaAZLe/Ogu1KTKFcdPiqwvuH1dCng+FdGSf/iBgWOog8c60qKymxzGADt9f5dEfbzzv
         tDov8kA2Sb9hYLx/IMKWtJIeVRK10k76i3tioZX0JelH/PwsfBfNFkgdO9AaTgF0KfRQ
         j1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PWETuN1Ct/aBktiJB2sFTwNGzVs9/Rhblhe4P3oaRJY=;
        b=LwHiaQSa65Vw6FW8TlpE9M4WGoVgAF64qLkRKc249kDC49JxRvTPOiySRqXQuq3qrz
         6GWQPS7yprsKJZ8p7bBqgJNyCUqfGBMjpqG9tINyRr9x8+1TthTGJpf6J2KEJcce4VeM
         Vo/Xc+fGYRkz9wlcztjFqZcyzAYMw+4coO6nyu0518mG9F5gSsxYY3DbV4FH3buL3fQp
         n2ZPdC01NA1dhS/5sz4bDi1rC0uXezy1nqlvCMWXRl8j71p7B8TdwpQuBuMGhqUdH5c0
         NKX9Yo6eoE23Ys9+QN3/sSwsBfhFDan51R2mf+UMY/9nX2XA84CB+C0z3z91hyDp3pjl
         Jyxw==
X-Gm-Message-State: APjAAAWTXRY04UihLQJSXg+vqC9oRGrhLQ4CTISvhGECXnGKR8/orVE/
        sUeDYQVhilDk1pFfkBouh2A=
X-Google-Smtp-Source: APXvYqx5jpsXp9AeJcxrEs21tUX1LfSm/Td+nyy+2Xg93XES6+FgF0WKPll2zf0C6SmJAwoxK/g+wA==
X-Received: by 2002:ac8:108:: with SMTP id e8mr22244723qtg.101.1580706202246;
        Sun, 02 Feb 2020 21:03:22 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id v2sm9435343qto.73.2020.02.02.21.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Feb 2020 21:03:21 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 54C3E21EC3;
        Mon,  3 Feb 2020 00:03:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 03 Feb 2020 00:03:18 -0500
X-ME-Sender: <xms:lKk3XnS7TAJMSrraTFkuhbT-Xmy7nggDlkHu41dzguP_BhJxkHmxdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrgeeigdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhephffvufffkffoggfgsedtkeer
    tdertddtnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesgh
    hmrghilhdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphephedv
    rdduheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithih
    qdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrih
    hlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:lKk3Xt8KCi63j6F2Q-uEdywfZMtbCYGspogt7A7kyJcxsh8a7SGNuw>
    <xmx:lKk3XtOFZkqp6zCJmR4qgUpZUE0RJYje7Ha-ylVJLiSj5nvnwICY2w>
    <xmx:lKk3XgHciIXfgh-o06VN2x4mhgIqpffW0PapUfy3hukGfyQGoj5zjA>
    <xmx:lqk3XoXgRmlF_qzXVCzXkAVoNLIf1u3j_wDK2sABnOmyYXVNXgDx5DSmm2U>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5119D328005E;
        Mon,  3 Feb 2020 00:03:16 -0500 (EST)
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
Subject: [PATCH v2 0/3] PCI: hv: Generify pci-hyperv.c
Date:   Mon,  3 Feb 2020 13:03:10 +0800
Message-Id: <20200203050313.69247-1-boqun.feng@gmail.com>
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

Changes since v1:

*	Reword the commit log and adjust the title as per Bjorn's
	suggestion

*	Split patch #2 into two patches (one for moving and one for
	adding new structure) as per Bjorn's suggestion

*	Remove unnecesarry #if guard as per Vitaly's suggestion.

*	Add explanation for adding hv_set_msi_address_from_desc().

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
 arch/x86/include/asm/mshyperv.h     |  5 ++++
 drivers/pci/controller/pci-hyperv.c | 44 +++--------------------------
 3 files changed, 50 insertions(+), 40 deletions(-)

-- 
2.24.1

