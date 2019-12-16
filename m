Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEDDC11FC09
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Dec 2019 01:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfLPATe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 15 Dec 2019 19:19:34 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36747 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfLPATd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 15 Dec 2019 19:19:33 -0500
Received: by mail-qk1-f194.google.com with SMTP id a203so2879665qkc.3;
        Sun, 15 Dec 2019 16:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZ6sGO0KS0Q8EYVwWz/tNENQC8GnXFZ6xRDHj7knL74=;
        b=Gmb45a2redl2v2Psqc9UmK5BWjcPglzmbzjDpsikHLbmggLKdOVorJeLzaOihAp93n
         dZuMPP9Yq0XhR4kkhOpXSkhSDgDY7Q1xUpGZhMf6Ogg+p7xlsNEqI8pOq07smNJIb729
         KRa4FwyruYu+W4RNN1PJgXm4h6Ulv+MJjNPQcDIV0FZh4+eA8lE6SlNe6p65GE7u3Z6k
         Wa+wg8XDsBh++bc/vo63jVSfEKICDmwU/S4INp786dJO2HHJnWsMRwktN9Y0UajVgbpm
         NrNsEFU0hxV8nLsegKRlsf3oghWVDY2nCi+m+2Fp1dRlscQL+URlyVJ1jR+XgzFXJbZM
         L3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZ6sGO0KS0Q8EYVwWz/tNENQC8GnXFZ6xRDHj7knL74=;
        b=RnErxtQUu6V8GQqcCT9cxw1Dzbfxy9Zw7qMz5LihiSqjC/2S6X5kVf8A4Y+u5ZfTrA
         niQFRWlZ6l55nxfTQuAVStRW6/vlP7gb30g0xVtsXAkgRpIq3tPxI3029ni0ZNUOAxVx
         luDeucZEPdigHlD6Q72Lo8/mPBNuUEvwwQYdlFXRhsb9uV8XfYgoDuQCL4u0KH6lawFB
         CpRLVpznKRwoLDW9okRfoTzH0dsilPI3/ZDd2ogC4GEaW+Ml3MlTmvlFQrJquCyhbU27
         gQyLovPDUyGBUR+3TapqVNMQ6iUDyLll/g4Qcu4yETn8vesjlF1dG9Mlh3rJd9EgBvdb
         Sg5A==
X-Gm-Message-State: APjAAAUJqh3LZLZTq5fdoQ53OmGLG4QRwumxoUMXEKbNBZ/x2z+LAALj
        tdOIBOzpXPI15skFakkhJ24=
X-Google-Smtp-Source: APXvYqzAQwy89lyacoeuw+asSDBQYlTp0vqfLPII18paqb1S/uBBbW6TqUEv6w6/z3AIjjLrHyaopg==
X-Received: by 2002:a37:48f:: with SMTP id 137mr24677846qke.25.1576455572728;
        Sun, 15 Dec 2019 16:19:32 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id e2sm5376739qkl.3.2019.12.15.16.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Dec 2019 16:19:31 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7111D22430;
        Sun, 15 Dec 2019 19:19:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 15 Dec 2019 19:19:30 -0500
X-ME-Sender: <xms:kc32XeNibvP_au8cm_jiN6rThl2eefciU1Jc-App3cBtSjKNtAWevA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtgedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjughrpefhvffufffkofgggfestdek
    redtredttdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgse
    hgmhgrihhlrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhu
    sgdrtghomhenucfkphephedvrdduheehrdduuddurdejudenucfrrghrrghmpehmrghilh
    hfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieel
    vdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtg
    homhesfhhigihmvgdrnhgrmhgvnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:kc32Xdl8_zahWOQvooHUe9tKxDScPH3OeodcADOCpBCp0dUmiJjnvQ>
    <xmx:kc32XQbukJFCvrLL7M4nc72CTroIKyNCxbhWdtmCCe5vP3l91CwIyQ>
    <xmx:kc32XTTHwezsupdARHAEkG3utLJ_lpz0EFhC-pw3X_mCxe6pmXP0Eg>
    <xmx:ks32XdWhDOQlVK8lfpDMef_v7K-YnFb-v4AwmCwl5TJhn4VnUW0LfBRLVg8>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 992E780062;
        Sun, 15 Dec 2019 19:19:28 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        xen-devel@lists.xenproject.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC 0/6] vDSO support for Hyper-V guest on ARM64
Date:   Mon, 16 Dec 2019 08:19:16 +0800
Message-Id: <20191216001922.23008-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi,

This is the RFC patchset for vDSO support in ARM64 Hyper-V guest. To
test it, Michael's ARM64 support patchset:

	https://lore.kernel.org/linux-arm-kernel/1570129355-16005-1-git-send-email-mikelley@microsoft.com/

is needed.

Similar as x86, Hyper-V on ARM64 use a TSC page for guests to read
the virtualized hardware timer, this TSC page is read-only for the
guests, so could be used for vDSO data page. And the vDSO (userspace)
code could use the same code for timer reading as kernel, since
they read the same TSC page.

This patchset therefore extends ARM64's __vsdo_init() to allow multiple
data pages and introduces the vclock_mode concept similar to x86 to
allow different platforms (bare-metal, Hyper-V, etc.) to switch to
different __arch_get_hw_counter() implementations. The rest of this
patchset does the necessary setup for Hyper-V guests: mapping tsc page,
enabling userspace to read cntvct, etc. to enable vDSO.

This patchset consists of 6 patches:

patch #1 allows hv_get_raw_timer() definition to be overridden for
userspace and kernel to share the same hv_read_tsc_page() definition.

patch #2 extends ARM64 to support multiple vDSO data pages.

patch #3 introduces vclock_mode similiar to x86 to allow different
__arch_get_hw_counter() implementations for different clocksources.

patch #4 maps Hyper-V TSC page into vDSO data page.

patch #5 allows userspace to read cntvct, so that userspace can
efficiently read the clocksource.

patch #6 enables the vDSO for ARM64 Hyper-V guest.

The whole patchset is based on v5.5-rc1 plus Michael's ARM64 support
patchset, and I've done a few tests with:

	https://github.com/nlynch-mentor/vdsotest

Comments and suggestions are welcome!

Regards,
Boqun
