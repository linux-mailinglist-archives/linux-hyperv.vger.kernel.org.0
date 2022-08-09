Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D1D58DC3F
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Aug 2022 18:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbiHIQkM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 9 Aug 2022 12:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236704AbiHIQkL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 9 Aug 2022 12:40:11 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3EC1138
        for <linux-hyperv@vger.kernel.org>; Tue,  9 Aug 2022 09:40:08 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id h28so11250346pfq.11
        for <linux-hyperv@vger.kernel.org>; Tue, 09 Aug 2022 09:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exotanium.io; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=3sBlxY+3kNumjlphJhxHleDEePvjVO5i9LlHakf3nps=;
        b=QxmUQiXoZr5OS9JY7U6LD2GSDW42X2eiBWKkfOCJpwv2ZPJGxTef5HECk8SUeajE1u
         WHPNS1cqcbqIwMh5v7n/LtDIgjoUXgcckLyyiCPOgrcNb0eO7jHGdN2d4D6BhOBri5SM
         gwjRKFB2ldTXCujf+6ufh34q6BuDiAHDVpeHuP09cMcA5GqF48FLIfn4s6s55G9qw8K2
         jVyTltlSE67JBudQpzoaLi7RCqFvmavr72GdJvSZRr5e4AW+gQJAOXStzya5V28u1Irc
         3/gPWMwUyzs2lc/Pyu7Zw1KxcMDo00qt14xWGbx/FNye7SUy2awdqUwe8tO/wgL1r57F
         Bjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=3sBlxY+3kNumjlphJhxHleDEePvjVO5i9LlHakf3nps=;
        b=rPY2jZHau5TMC7r8RpEwu3uzpAMZdw5xmkrSwEwYTIOZiXXbxT13AK2l7Y3J8Y8r0l
         1EJW3NCQXbCdqgTUWC1NuhzKJW9BNRT4M2w7zs2mQz+Av8vmP4dJuBytQhQ0Ee40AmwF
         Z1v96Z7ENn1yYWOQj54m429GhJ7SziWZIRGiqL1GNm0cJk+odSZB8C0LnQEx7Pk/+D9J
         GaCibtjz08cJ3WugDCUnrUUCzBLsZNWfj1+gbLNk7LX2ft+IFxrkzkmxZNFq5SV67HoV
         Vgd/FuHad5ILNd59uutSeqOJ9KsBCUgK92/PBqUftw6cL+wc3sots1x2dm3qnOp/tDGR
         lX1g==
X-Gm-Message-State: ACgBeo12SHvQwgSw90NorE4fUVddO04FiMGwkbW93HDiZbUdKgb2GPUG
        sgW04WsJf/y2Ez8iv4jjNkclRoJyp9+NJg==
X-Google-Smtp-Source: AA6agR5EVWm/UzI0IQzlVzwqrxzVzKJx3xWgL+DogoSXSzWd0b3GJuVY6yKqLxiJR57r+jpHbdREdQ==
X-Received: by 2002:a63:191f:0:b0:41c:e4a0:1e1d with SMTP id z31-20020a63191f000000b0041ce4a01e1dmr19886067pgl.618.1660063207772;
        Tue, 09 Aug 2022 09:40:07 -0700 (PDT)
Received: from smtpclient.apple ([146.196.44.223])
        by smtp.gmail.com with ESMTPSA id 189-20020a6218c6000000b0052ddaffbcc1sm131823pfy.30.2022.08.09.09.40.06
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Aug 2022 09:40:07 -0700 (PDT)
From:   Anish Gupta <anish@exotanium.io>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Booting Xen dom0 on Hyper-V
Message-Id: <43091FDA-F0E9-42CE-8B15-A57F3B0C5B4A@exotanium.io>
Date:   Tue, 9 Aug 2022 22:10:03 +0530
To:     linux-hyperv@vger.kernel.org
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello all,
I am new to Azure/Hyper-V environment and trying to boot Xen PV.  Dom0 =
Linux on Xen doesn=E2=80=99t detect hv_vmbus and boot fails. I get the =
same result even with Xen HYPERV_GUEST config. Here is the console logs =
with latest Xen 4.15.3 and Linux 5.18:

Loading Xen 4.15.3 ...
Loading Linux 5.18.7+ ...
Loading initial ramdisk ...
 Xen 4.15.3
(XEN) Xen version 4.15.3 =
(root@i2ltiotchnquhby5irpcvxfz2h.xx.internal.cloudapp.net) (gcc (GCC) =
4.8.5 20150623 (Red Hat 4.8.5-44)) debug=3Dn Mon Aug  8 17:48:08 UTC =
2022
(XEN) Latest ChangeSet: Mon Jun 27 15:16:56 2022 +0200 git:cc3329f
(XEN) build-id: 25b7db08246b91bfd5e2302898263ae47cda7473
(XEN) Bootloader: GRUB 2.02~beta2
(XEN) Command line: placeholder dom0_mem=3D4096M,max:4096M =
com1=3D115200,8n1 console=3Dcom1,vga dom0_vcpus_pin=3Dtrue =
dom0_max_vcpus=3D4 loglvl=3Dall guest_loglvl=3Dall noreboot=3Dtrue
(XEN) Xen image load base address: 0
(XEN) Video information:
(XEN)  VGA is text mode 80x25, font 8x16
(XEN)  VBE/DDC methods: none; EDID transfer time: 0 seconds
(XEN)  EDID info not retrieved because no DDC retrieval method detected
(XEN) Disc information:
(XEN)  Found 1 MBR signatures
(XEN)  Found 1 EDD information structures
(XEN) CPU Vendor: Intel, Family 6 (0x6), Model 106 (0x6a), Stepping 6 =
(raw 000606a6)
(XEN) Xen-e820 RAM map:
(XEN)  [0000000000000000, 000000000009fbff] (usable)
(XEN)  [000000000009fc00, 000000000009ffff] (reserved)
(XEN)  [00000000000e0000, 00000000000fffff] (reserved)
(XEN)  [0000000000100000, 000000003ffeffff] (usable)
(XEN)  [000000003fff0000, 000000003fffefff] (ACPI data)
(XEN)  [000000003ffff000, 000000003fffffff] (ACPI NVS)
(XEN)  [0000000100000000, 0000000fdfffffff] (usable)
(XEN)  [0000001000000000, 00000010dfffffff] (usable)
=E2=80=A6.
(XEN) System RAM: 65535MB (67108412kB)
=E2=80=A6.
<<< Linux booting >>>
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] Xen: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] Xen: [mem 0x000000000009fc00-0x00000000000fffff] reserved
[    0.000000] Xen: [mem 0x0000000000100000-0x000000003ffeffff] usable
[    0.000000] Xen: [mem 0x000000003fff0000-0x000000003fffefff] ACPI =
data
[    0.000000] Xen: [mem 0x000000003ffff000-0x000000003fffffff] ACPI NVS
[    0.000000] Xen: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] Xen: [mem 0x00000000fee00000-0x00000000feefffff] reserved
[    0.000000] Xen: [mem 0x0000000100000000-0x00000001c0070fff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.3 present.
[    0.000000] DMI: Microsoft Corporation Virtual Machine/Virtual =
Machine, BIOS 090008  12/07/2018
[    0.000000] Hypervisor detected: Xen PV <<<
=E2=80=A6
[  197.060965] dracut-initqueue[311]: Warning: Could not boot.
[  197.067020] dracut-initqueue[311]: Warning: =
/dev/disk/by-uuid/c8396182-9335-4bf7-a963-f14e85f41f23 does not exist
         Starting Setup Virtual Console...
[  OK  ] Started Setup Virtual Console.
         Starting Dracut Emergency Shell...
Warning: /dev/disk/by-uuid/c8396182-9335-4bf7-a963-f14e85f41f23 does not =
exist

Generating "/run/initramfs/rdsosreport.txt"


Entering emergency mode. Exit the shell to continue.
Type "journalctl" to view system logs.
You might want to save "/run/initramfs/rdsosreport.txt" to a USB stick =
or /boot
after mounting them and attach it to a bug report.


dracut:/#=20


As an experiment I did force load hv_vmbus but then hit a page fault. I =
will really appreciate guidance in getting it working.=20

Was Xen PV ever supported in any version of Xen + Linux on =
Azure/Hyper-V?

Thanks in advance for your help!

Regards,
Anish=
