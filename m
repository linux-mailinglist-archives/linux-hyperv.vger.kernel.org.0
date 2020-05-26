Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189E81B1343
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2020 19:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgDTRjb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 20 Apr 2020 13:39:31 -0400
Received: from mail-mw2nam12on2124.outbound.protection.outlook.com ([40.107.244.124]:36000
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725784AbgDTRja (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Apr 2020 13:39:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0kEVAU+26MikcVPIGUY7d9QkILx4cSTzoKSpShkPVzNKpw1YXZHh6vdwV7Pqr78oOPRtSZcRRIv++SdwRYgOBqHmP77Mwy5vz3u80GhzizhFBAmpzp7GCP5M1JSZ9LLOjN5wFbkyQvGBxx1G3QNpetJAA6vGz9S3mOufLGHaqr+Zbu+Ct2KtxOxWV2usmHFB+faUMUwGAkpi9sfSZO83dtmKggd7FhBbrPoaVqTGMSvGrKtslN18zOE7YLTn1/8kc7o2oE1QX/waeRYx1vxeiOtGtjVs/0MNPSYQ6jDZGtipix6uF5zQb7a+8Od/sUHAiMC89ksh8yiKWkfPZTm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHgI8OCcfCsswcCzMtNkQV8cRXz9+UcWflwB8c/Elrw=;
 b=dQUu/xcfwA1n9/+G1f5N3NaXys7awFhZSMjoHdBNeI1dgHD4HKxtLIRi0OglyOSOUHo80YyqDiZSmK+mWuTvPDkbAyi1g4ojFWDlR+BPCYN48enHtw6MpfeOgqhkcW7fB60aOweLrVOhlvSS9is4f1Kt9hTIQlEttT3kqIx4haCoNHigFZA8PeHkAh4qeb8MjfTuCq5dILXSGyU/WfbHWJAVqjkquN0fcIw3aLXmED7WRyxNVVpM6gIgbJZYsIukaFsrUerQ7WLrFo55XnbWufwM8bieFD/bjCJuxFA+CSXu1vY6wF4WHABB/9yho973CiclDdG072Sk7cmpdaT28A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHgI8OCcfCsswcCzMtNkQV8cRXz9+UcWflwB8c/Elrw=;
 b=EQQZkakz8WgHueynn3oQX/ptSaAVv8ZilF7AU/dHT5Wmq/WbrQ7ycgW9kH/fcjhh2TUMV2DFmGuQbjeItFDupADL9ShM+ek+9DvXnuvkRwhNxkQFJ9d8uqAeMzmipr8zwh4L0hFulGS3GVk2WL+wLiKYYnMm7ULUWHwEgzS4ckc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
Received: from BN6PR21MB0178.namprd21.prod.outlook.com (2603:10b6:404:94::12)
 by BN6PR21MB0691.namprd21.prod.outlook.com (2603:10b6:404:11b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.2; Mon, 20 Apr
 2020 17:39:26 +0000
Received: from BN6PR21MB0178.namprd21.prod.outlook.com
 ([fe80::a97c:360c:9ed2:12ec]) by BN6PR21MB0178.namprd21.prod.outlook.com
 ([fe80::a97c:360c:9ed2:12ec%11]) with mapi id 15.20.2958.001; Mon, 20 Apr
 2020 17:39:26 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 0/4] Split hyperv-tlfs.h into generic and arch specific files
Date:   Mon, 20 Apr 2020 10:38:34 -0700
Message-Id: <20200420173838.24672-1-mikelley@microsoft.com>
X-Mailer: git-send-email 2.18.2
Content-Type: text/plain
X-ClientProxiedBy: MWHPR08CA0047.namprd08.prod.outlook.com
 (2603:10b6:300:c0::21) To BN6PR21MB0178.namprd21.prod.outlook.com
 (2603:10b6:404:94::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from MHKdev.corp.microsoft.com (131.107.160.236) by MWHPR08CA0047.namprd08.prod.outlook.com (2603:10b6:300:c0::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 17:39:24 +0000
X-Mailer: git-send-email 2.18.2
X-Originating-IP: [131.107.160.236]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 462032ab-83aa-4e45-e10d-08d7e551c53d
X-MS-TrafficTypeDiagnostic: BN6PR21MB0691:|BN6PR21MB0691:|BN6PR21MB0691:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR21MB0691B8BB8652C0C92C74420BD7D40@BN6PR21MB0691.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR21MB0178.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(7416002)(66556008)(66946007)(66476007)(6486002)(16526019)(36756003)(6666004)(1076003)(186003)(7696005)(52116002)(86362001)(26005)(5660300002)(4326008)(2616005)(10290500003)(8676002)(956004)(316002)(478600001)(2906002)(82960400001)(82950400001)(81156014)(8936002)(107886003)(41533002)(921003);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1HPYSp8nQKro/B+hcKDEOcq3sfeU4IHPqru9HIzdqKTTC8sSnP4uAHGVff1cgt/wi3TNob2WnlfaC9Umk1pWY9/okD3+LBJXH7Tks2ytVu8r7XcKmaX/rvRME4P2xzkCHo1YljcloXMq/0N1GZrNEjwo7pIkfg4MU+B7x+yTESq1iz948Pg2SG+Nd5onWGx5GShBzeVEJ49/wQZwYuqJvamNmzXI9xjNZzGZ82h9RwNcHDdn5wTBqLuh+LeESxFr5WUate2Wfs9wy3fToSE2rlckUQGODykMW49bZWOnS7hwYgg319FQWEW05BrP+M2OR4O0rjJnCZWU5PxhEhTc9+gL5SoiLKHTwWGdqu78AJNTDZBQ71obdma2W+agR8TYFO4VnSoVqPA5Y27JKalXDr3218f1aV5eGEdukEoxWN1PytLT11pb26jDRVRc7tCo6SHM3AtjfKfyA2nmQWdwVry8oACcg4U1eO3QsBIzHKbon2+6Tyah21X/lsA72sPG
X-MS-Exchange-AntiSpam-MessageData: slsrXF1biAjL3nvSrReTmmvKQEipGJQ8kESguvFpeS0XPiwDOzBz6rx3Zdvi/2z8ZQYJ8WHrfi5Qo3+g1+aXq3XOOk4JL75BpGiGkqQp4eORYZtkoExuSuX4yVrHEXme2FA4EzCvYfKpq9Zhmsmv89+KKky3BAHm4p4+v3SIl7LT47zhT9NXdbfeWrWMFVcQpjLSxJzI0txTRHF3ncOoDTVaSVZDaakB1sUF1jvOx+hC4i3CgRJ51+bYkmZ97AfjvIsopOrOeuyir65x+r0euHpSmpm9YmDv+wI5kSxP6UBSzuFwJrI3ErvURf98KgUACq/pLLXmFsWZYP3xjIdN1wiUA9D1mV91apNuXy4YMCARcoIgEefPieKuXTpj1avOGkVDcsEkfFloezAArAs7jzEh1c2OgkRHEA+P1jSnLqgukzoxfovjBxQ5ru7zLRNzPe2TvAxD7PdHrgxR6Y+Dbk23sTp2d3bKnJrYcpZYExm/QoxGj5nLktzT60uUOmFvNzq/t0rF72nXlq/6Su1HbS9wxxfD20sXHKCPLvxvYnTsIdJphuubQwuBUQSShG9pVfjIPlYgo0eOoUO/PcD3SgDFIeekkDYzB1fS8TT3NpRWgS/J/Fkogti9Y5iPRrcnNNpQ+ebu4ZSX1hj9NS98FkltDAcPnCc9UtDcwXtybDXkjlMB0T2TflaPT5pB26/grngg2DZfSTxWo2W5U8L77GtKpqtAkwV/YIBL+pdCIoASvcXjCe2EwEBPm5fs+D/PrxJOvg5Z01cEHK3diQreH0h4hth8YvHiYQi5xtEJA69JZbNHBWFr6esBvfmjq+mx
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 462032ab-83aa-4e45-e10d-08d7e551c53d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 17:39:26.2991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRwAK6aedeQAWHA+anZYm831+mWyZjPPM1uw6R4BEgMt7QR1pzFN6jBlbg/HkhOZOzV3XnBBjArg6TlWxnPGaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0691
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This series splits hyperv-tlfs.h into architecture independent and
architecture specific files so that the arch independent portion can
be shared between the x86/x64 and ARM64 code for Hyper-V.  While the
Hyper-V team has not released a version of the TLFS document that
clearly specifies which portions of the interface are arch independent,
we can make a fairly good assessment based on implementation work done
to support Linux guests on Hyper-V on ARM64, and on private communication
with the Hyper-V team.  Definitions are considered arch independent if
they are implemented by Hyper-V on both architectures (x86/x64 and ARM64),
even if they are currently needed by Linux code only on one architecture.

Many definitions in hyperv-tlfs.h have historically contained "X64" in the
name, which doesn't make sense for architecture independent definitions.
While many of the occurrences of "X64" have already been removed, some
still remain in definitions that should be arch independent. The
split removes the "X64" from the definitions so that the arch
independent hyper-tlfs.h has no occurrences of "X64". However, to
keep this patch set separate from a wider change in the names, aliases
are added in the x86/x64 specific hyperv-tlfs.h so that existing code
continues to compile.  The definitions can be fixed throughout the code
in a more incremental fashion in separate patches, and then the aliases
can be removed.

Where it is not clear if definitions are arch independent, they have been
kept in the x86/x64 specific file. The Hyper-V team is aiming to have a
version of the TLFS document covering ARM64 by the end of calendar 2020,
so additional definitions may be moved into the arch independent portion
after the new TLFS document is released.

The first two patches in the series clean up the existing hyperv-tlfs.h
file a bit by removing duplicate or unnecessary definitions so they are
not propagated across the split. The third patch does the split, and the
fourth patch adds new definitions that are needed on ARM64 but are generic.

These changes have no functional impact.

Michael Kelley (4):
  KVM: x86: hyperv: Remove duplicate definitions of Reference TSC Page
  x86/hyperv: Remove HV_PROCESSOR_POWER_STATE #defines
  x86/hyperv: Split hyperv-tlfs.h into arch dependent and independent
    files
  asm-generic/hyperv: Add definitions for Get/SetVpRegister hypercalls

 arch/x86/include/asm/hyperv-tlfs.h | 472 +++--------------------------
 arch/x86/include/asm/kvm_host.h    |   2 +-
 arch/x86/kvm/hyperv.c              |   4 +-
 include/asm-generic/hyperv-tlfs.h  | 470 ++++++++++++++++++++++++++++
 4 files changed, 509 insertions(+), 439 deletions(-)
 create mode 100644 include/asm-generic/hyperv-tlfs.h

-- 
2.18.2

